module Formbuilder
  module Views
    class EntryDl < Erector::Widget

      needs :entry, :form, show_blind: false

      def content
        dl(class: 'entry-dl') {
          response_fields.each do |rf|
            value = @entry.response_value(rf)

            dt {
              text rf.label
              blind_label if rf.blind?
              admin_only_label if rf.admin_only?
            }

            dd {
              if (x = rf.render_entry(value, entry: @entry))
                rawtext x
              else
                no_response
              end
            }
          end
        }
      end

      private
      def blind_label
        text ' '
        span.label 'Blind'
      end

      def admin_only_label
        text ' '
        span.label 'Admin only'
      end

      def no_response
        span 'No response', class: 'no-response'
      end

      def response_fields
        return_array = @form.response_fields.reject { |rf| !rf.input_field }
        return_array.reject! { |rf| rf.blind? } unless @show_blind
        return_array
      end

    end
  end
end
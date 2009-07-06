require "#{File.dirname(__FILE__)}/collection"

# http://www.desimcadam.com/archives/8
Array.class_eval do
  def paginate(options = {})
    raise ArgumentError, "parameter hash expected (got #{options.inspect})" unless Hash === options
    per_page = options[:per_page] || 30
    WillPaginate::Collection.create(
        options[:page] || 1,
        per_page,
        options[:first_page] || per_page,
        options[:total_entries] || self.length
    ) { |pager|
      pager.replace self[pager.offset, pager.per_page].to_a
    }
  end
end

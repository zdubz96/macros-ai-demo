class MacrosController < ActionController::Base
  def display_form
    render({ :template => "macro_templates/new_form" })
  end

  def calculate
    @uploaded_file = params[:image]
    @description  = params[:description]
    @data_url=DataURI.convert(@uploaded_file)

    c=OpenAI::Chat.new
    c.system("You are an expert nutritionist. Estimate macronutrients (Carbs, protein,fat), in grams and total calories")
    c.user(@description, image:@uploaded_file)

    @response=c.assistant!
    render({ :template => "macro_templates/results" })
  end
end

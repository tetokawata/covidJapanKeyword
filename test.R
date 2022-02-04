
pacman::p_load(
  "tidyverse",
  "quanteda",
  "quanteda.textplots"
)


raw <- read_csv("data/LiteratureListcsv.csv")

rawEnglish <- raw[str_sub(raw$著者名のよみ, 1, 1) == "ん", ]

corp <- corpus(rawEnglish, text_field = "論文タイトル")

token <- tokens(corp, remove_numbers = TRUE, remove_punct = TRUE) |>
  tokens_remove(stopwords("en"))

dfm <- dfm(token) |>
  dfm_wordstem()

df <- convert(dfm, "data.frame")

textplot_wordcloud(dfm,
  min_count = 6, random_order = FALSE, rotation = 0.25,
  color = RColorBrewer::brewer.pal(8, "Dark2")
)

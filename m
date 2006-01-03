Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWACNc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWACNc5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWACNcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:32:23 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:28677 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932347AbWACNZf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:35 -0500
Subject: [PATCH 02/26] kconfig: fixup after Lindent
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:25 +0100
Message-Id: <11362947252884@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: 1132433780 +0100

Readability are more important then the 80 coloumn limit, so fold
several lines to greatly improve readability.
Also keep return type on same line as function definition.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/lxdialog/checklist.c |   99 +++++++++++++-----------------------------
 scripts/lxdialog/dialog.h    |    3 -
 scripts/lxdialog/inputbox.c  |   49 ++++++---------------
 scripts/lxdialog/menubox.c   |   83 +++++++++++------------------------
 scripts/lxdialog/msgbox.c    |    5 +-
 scripts/lxdialog/textbox.c   |   93 ++++++++++++++-------------------------
 scripts/lxdialog/util.c      |    2 -
 scripts/lxdialog/yesno.c     |    3 -
 8 files changed, 108 insertions(+), 229 deletions(-)

dec69da856653772d7ee7b2f98dc69da27274a22
diff --git a/scripts/lxdialog/checklist.c b/scripts/lxdialog/checklist.c
index 1857c53..ae40a2b 100644
--- a/scripts/lxdialog/checklist.c
+++ b/scripts/lxdialog/checklist.c
@@ -28,8 +28,8 @@ static int list_width, check_x, item_x, 
 /*
  * Print list item
  */
-static void
-print_item(WINDOW * win, const char *item, int status, int choice, int selected)
+static void print_item(WINDOW * win, const char *item, int status, int choice,
+		       int selected)
 {
 	int i;
 
@@ -59,8 +59,7 @@ print_item(WINDOW * win, const char *ite
 /*
  * Print the scroll indicators.
  */
-static void
-print_arrows(WINDOW * win, int choice, int item_no, int scroll,
+static void print_arrows(WINDOW * win, int choice, int item_no, int scroll,
 	     int y, int x, int height)
 {
 	wmove(win, y, x);
@@ -112,10 +111,9 @@ static void print_buttons(WINDOW * dialo
  * Display a dialog box with a list of options that can be turned on or off
  * The `flag' parameter is used to select between radiolist and checklist.
  */
-int
-dialog_checklist(const char *title, const char *prompt, int height, int width,
-		 int list_height, int item_no, const char *const *items,
-		 int flag)
+int dialog_checklist(const char *title, const char *prompt, int height,
+		     int width, int list_height, int item_no,
+		     const char *const *items, int flag)
 {
 	int i, x, y, box_x, box_y;
 	int key = 0, button = 0, choice = 0, scroll = 0, max_choice, *status;
@@ -183,15 +181,14 @@ dialog_checklist(const char *title, cons
 	box_x = (width - list_width) / 2 - 1;
 
 	/* create new window for the list */
-	list =
-	    subwin(dialog, list_height, list_width, y + box_y + 1,
-		   x + box_x + 1);
+	list = subwin(dialog, list_height, list_width, y + box_y + 1,
+	              x + box_x + 1);
 
 	keypad(list, TRUE);
 
 	/* draw a box around the list items */
 	draw_box(dialog, box_y, box_x, list_height + 2, list_width + 2,
-		 menubox_border_attr, menubox_attr);
+	         menubox_border_attr, menubox_attr);
 
 	/* Find length of longest item in order to center checklist */
 	check_x = 0;
@@ -238,24 +235,18 @@ dialog_checklist(const char *title, cons
 					/* Scroll list down */
 					if (list_height > 1) {
 						/* De-highlight current first item */
-						print_item(list,
-							   items[scroll * 3 +
-								 1],
-							   status[scroll], 0,
-							   FALSE);
+						print_item(list, items[scroll * 3 + 1],
+							   status[scroll], 0, FALSE);
 						scrollok(list, TRUE);
 						wscrl(list, -1);
 						scrollok(list, FALSE);
 					}
 					scroll--;
-					print_item(list, items[scroll * 3 + 1],
-						   status[scroll], 0, TRUE);
+					print_item(list, items[scroll * 3 + 1], status[scroll], 0, TRUE);
 					wnoutrefresh(list);
 
 					print_arrows(dialog, choice, item_no,
-						     scroll, box_y,
-						     box_x + check_x + 5,
-						     list_height);
+						     scroll, box_y, box_x + check_x + 5, list_height);
 
 					wrefresh(dialog);
 
@@ -269,32 +260,20 @@ dialog_checklist(const char *title, cons
 					/* Scroll list up */
 					if (list_height > 1) {
 						/* De-highlight current last item before scrolling up */
-						print_item(list,
-							   items[(scroll +
-								  max_choice -
-								  1) * 3 + 1],
-							   status[scroll +
-								  max_choice -
-								  1],
-							   max_choice - 1,
-							   FALSE);
+						print_item(list, items[(scroll + max_choice - 1) * 3 + 1],
+							   status[scroll + max_choice - 1],
+							   max_choice - 1, FALSE);
 						scrollok(list, TRUE);
 						wscrl(list, 1);
 						scrollok(list, FALSE);
 					}
 					scroll++;
-					print_item(list,
-						   items[(scroll + max_choice -
-							  1) * 3 + 1],
-						   status[scroll + max_choice -
-							  1], max_choice - 1,
-						   TRUE);
+					print_item(list, items[(scroll + max_choice - 1) * 3 + 1],
+						   status[scroll + max_choice - 1], max_choice - 1, TRUE);
 					wnoutrefresh(list);
 
 					print_arrows(dialog, choice, item_no,
-						     scroll, box_y,
-						     box_x + check_x + 5,
-						     list_height);
+						     scroll, box_y, box_x + check_x + 5, list_height);
 
 					wrefresh(dialog);
 
@@ -304,16 +283,12 @@ dialog_checklist(const char *title, cons
 			}
 			if (i != choice) {
 				/* De-highlight current item */
-				print_item(list,
-					   items[(scroll + choice) * 3 + 1],
-					   status[scroll + choice], choice,
-					   FALSE);
+				print_item(list, items[(scroll + choice) * 3 + 1],
+					   status[scroll + choice], choice, FALSE);
 				/* Highlight new item */
 				choice = i;
-				print_item(list,
-					   items[(scroll + choice) * 3 + 1],
-					   status[scroll + choice], choice,
-					   TRUE);
+				print_item(list, items[(scroll + choice) * 3 + 1],
+					   status[scroll + choice], choice, TRUE);
 				wnoutrefresh(list);
 				wrefresh(dialog);
 			}
@@ -342,28 +317,18 @@ dialog_checklist(const char *title, cons
 		case '\n':
 			if (!button) {
 				if (flag == FLAG_CHECK) {
-					status[scroll + choice] =
-					    !status[scroll + choice];
+					status[scroll + choice] = !status[scroll + choice];
 					wmove(list, choice, check_x);
 					wattrset(list, check_selected_attr);
-					wprintw(list, "[%c]",
-						status[scroll +
-						       choice] ? 'X' : ' ');
+					wprintw(list, "[%c]", status[scroll + choice] ? 'X' : ' ');
 				} else {
 					if (!status[scroll + choice]) {
 						for (i = 0; i < item_no; i++)
 							status[i] = 0;
 						status[scroll + choice] = 1;
 						for (i = 0; i < max_choice; i++)
-							print_item(list,
-								   items[(scroll
-									  +
-									  i) *
-									 3 + 1],
-								   status[scroll
-									  + i],
-								   i,
-								   i == choice);
+							print_item(list, items[(scroll + i) * 3 + 1],
+								   status[scroll + i], i, i == choice);
 					}
 				}
 				wnoutrefresh(list);
@@ -372,19 +337,15 @@ dialog_checklist(const char *title, cons
 				for (i = 0; i < item_no; i++) {
 					if (status[i]) {
 						if (flag == FLAG_CHECK) {
-							fprintf(stderr,
-								"\"%s\" ",
-								items[i * 3]);
+							fprintf(stderr, "\"%s\" ", items[i * 3]);
 						} else {
-							fprintf(stderr, "%s",
-								items[i * 3]);
+							fprintf(stderr, "%s", items[i * 3]);
 						}
 
 					}
 				}
 			} else
-				fprintf(stderr, "%s",
-					items[(scroll + choice) * 3]);
+				fprintf(stderr, "%s", items[(scroll + choice) * 3]);
 			delwin(dialog);
 			free(status);
 			return button;
diff --git a/scripts/lxdialog/dialog.h b/scripts/lxdialog/dialog.h
index c86801f..3cf3d35 100644
--- a/scripts/lxdialog/dialog.h
+++ b/scripts/lxdialog/dialog.h
@@ -1,4 +1,3 @@
-
 /*
  *  dialog.h -- common declarations for all dialog modules
  *
@@ -87,7 +86,7 @@
 #define ACS_DARROW 'v'
 #endif
 
-/* 
+/*
  * Attribute names
  */
 #define screen_attr                   attributes[0]
diff --git a/scripts/lxdialog/inputbox.c b/scripts/lxdialog/inputbox.c
index 9e96915..bc135c7 100644
--- a/scripts/lxdialog/inputbox.c
+++ b/scripts/lxdialog/inputbox.c
@@ -41,9 +41,8 @@ static void print_buttons(WINDOW * dialo
 /*
  * Display a dialog box for inputing a string
  */
-int
-dialog_inputbox(const char *title, const char *prompt, int height, int width,
-		const char *init)
+int dialog_inputbox(const char *title, const char *prompt, int height, int width,
+                    const char *init)
 {
 	int i, x, y, box_y, box_x, box_width;
 	int input_x = 0, scroll = 0, key = 0, button = -1;
@@ -90,8 +89,7 @@ dialog_inputbox(const char *title, const
 	getyx(dialog, y, x);
 	box_y = y + 2;
 	box_x = (width - box_width) / 2;
-	draw_box(dialog, y + 1, box_x - 1, 3, box_width + 2,
-		 border_attr, dialog_attr);
+	draw_box(dialog, y + 1, box_x - 1, 3, box_width + 2, border_attr, dialog_attr);
 
 	print_buttons(dialog, height, width, 0);
 
@@ -111,8 +109,9 @@ dialog_inputbox(const char *title, const
 		input_x = box_width - 1;
 		for (i = 0; i < box_width - 1; i++)
 			waddch(dialog, instr[scroll + i]);
-	} else
+	} else {
 		waddstr(dialog, instr);
+	}
 
 	wmove(dialog, box_y, box_x + input_x);
 
@@ -136,26 +135,17 @@ dialog_inputbox(const char *title, const
 				if (input_x || scroll) {
 					wattrset(dialog, inputbox_attr);
 					if (!input_x) {
-						scroll =
-						    scroll <
-						    box_width - 1 ? 0 : scroll -
-						    (box_width - 1);
+						scroll = scroll < box_width - 1 ? 0 : scroll - (box_width - 1);
 						wmove(dialog, box_y, box_x);
 						for (i = 0; i < box_width; i++)
 							waddch(dialog,
-							       instr[scroll +
-								     input_x +
-								     i] ?
-							       instr[scroll +
-								     input_x +
-								     i] : ' ');
-						input_x =
-						    strlen(instr) - scroll;
+							       instr[scroll + input_x + i] ?
+							       instr[scroll + input_x + i] : ' ');
+						input_x = strlen(instr) - scroll;
 					} else
 						input_x--;
 					instr[scroll + input_x] = '\0';
-					mvwaddch(dialog, box_y, input_x + box_x,
-						 ' ');
+					mvwaddch(dialog, box_y, input_x + box_x, ' ');
 					wmove(dialog, box_y, input_x + box_x);
 					wrefresh(dialog);
 				}
@@ -165,23 +155,14 @@ dialog_inputbox(const char *title, const
 					if (scroll + input_x < MAX_LEN) {
 						wattrset(dialog, inputbox_attr);
 						instr[scroll + input_x] = key;
-						instr[scroll + input_x + 1] =
-						    '\0';
+						instr[scroll + input_x + 1] = '\0';
 						if (input_x == box_width - 1) {
 							scroll++;
-							wmove(dialog, box_y,
-							      box_x);
-							for (i = 0;
-							     i < box_width - 1;
-							     i++)
-								waddch(dialog,
-								       instr
-								       [scroll +
-									i]);
+							wmove(dialog, box_y, box_x);
+							for (i = 0; i < box_width - 1; i++)
+								waddch(dialog, instr [scroll + i]);
 						} else {
-							wmove(dialog, box_y,
-							      input_x++ +
-							      box_x);
+							wmove(dialog, box_y, input_x++ + box_x);
 							waddch(dialog, key);
 						}
 						wrefresh(dialog);
diff --git a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
index 083f13d..260cc4d 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -63,8 +63,8 @@ static int menu_width, item_x;
 /*
  * Print menu item
  */
-static void
-print_item(WINDOW * win, const char *item, int choice, int selected, int hotkey)
+static void print_item(WINDOW * win, const char *item, int choice,
+		       int selected, int hotkey)
 {
 	int j;
 	char menu_item[menu_width + 1];
@@ -100,8 +100,8 @@ print_item(WINDOW * win, const char *ite
 /*
  * Print the scroll indicators.
  */
-static void
-print_arrows(WINDOW * win, int item_no, int scroll, int y, int x, int height)
+static void print_arrows(WINDOW * win, int item_no, int scroll, int y, int x,
+			 int height)
 {
 	int cur_y, cur_x;
 
@@ -158,10 +158,9 @@ static void print_buttons(WINDOW * win, 
 /*
  * Display a menu for choosing among a number of options
  */
-int
-dialog_menu(const char *title, const char *prompt, int height, int width,
-	    int menu_height, const char *current, int item_no,
-	    const char *const *items)
+int dialog_menu(const char *title, const char *prompt, int height, int width,
+                int menu_height, const char *current, int item_no,
+                const char *const *items)
 {
 	int i, j, x, y, box_x, box_y;
 	int key = 0, button = 0, scroll = 0, choice = 0, first_item =
@@ -283,20 +282,14 @@ dialog_menu(const char *title, const cha
 			i = max_choice;
 		else {
 			for (i = choice + 1; i < max_choice; i++) {
-				j = first_alpha(items[(scroll + i) * 2 + 1],
-						"YyNnMmHh");
-				if (key ==
-				    tolower(items[(scroll + i) * 2 + 1][j]))
+				j = first_alpha(items[(scroll + i) * 2 + 1], "YyNnMmHh");
+				if (key == tolower(items[(scroll + i) * 2 + 1][j]))
 					break;
 			}
 			if (i == max_choice)
 				for (i = 0; i < max_choice; i++) {
-					j = first_alpha(items
-							[(scroll + i) * 2 + 1],
-							"YyNnMmHh");
-					if (key ==
-					    tolower(items[(scroll + i) * 2 + 1]
-						    [j]))
+					j = first_alpha(items [(scroll + i) * 2 + 1], "YyNnMmHh");
+					if (key == tolower(items[(scroll + i) * 2 + 1][j]))
 						break;
 				}
 		}
@@ -319,24 +312,19 @@ dialog_menu(const char *title, const cha
 
 					scroll--;
 
-					print_item(menu, items[scroll * 2 + 1],
-						   0, FALSE,
-						   (items[scroll * 2][0] !=
-						    ':'));
+					print_item(menu, items[scroll * 2 + 1], 0, FALSE,
+						   (items[scroll * 2][0] != ':'));
 				} else
 					choice = MAX(choice - 1, 0);
 
 			} else if (key == KEY_DOWN || key == '+') {
 
 				print_item(menu,
-					   items[(scroll + choice) * 2 + 1],
-					   choice, FALSE,
-					   (items[(scroll + choice) * 2][0] !=
-					    ':'));
+					   items[(scroll + choice) * 2 + 1], choice, FALSE,
+					   (items[(scroll + choice) * 2][0] != ':'));
 
 				if ((choice > max_choice - 3) &&
-				    (scroll + max_choice < item_no)
-				    ) {
+				    (scroll + max_choice < item_no)) {
 					/* Scroll menu up */
 					scrollok(menu, TRUE);
 					wscrl(menu, 1);
@@ -344,16 +332,11 @@ dialog_menu(const char *title, const cha
 
 					scroll++;
 
-					print_item(menu,
-						   items[(scroll + max_choice -
-							  1) * 2 + 1],
+					print_item(menu, items[(scroll + max_choice - 1) * 2 + 1],
 						   max_choice - 1, FALSE,
-						   (items
-						    [(scroll + max_choice -
-						      1) * 2][0] != ':'));
+						   (items [(scroll + max_choice - 1) * 2][0] != ':'));
 				} else
-					choice =
-					    MIN(choice + 1, max_choice - 1);
+					choice = MIN(choice + 1, max_choice - 1);
 
 			} else if (key == KEY_PPAGE) {
 				scrollok(menu, TRUE);
@@ -361,11 +344,8 @@ dialog_menu(const char *title, const cha
 					if (scroll > 0) {
 						wscrl(menu, -1);
 						scroll--;
-						print_item(menu,
-							   items[scroll * 2 +
-								 1], 0, FALSE,
-							   (items[scroll * 2][0]
-							    != ':'));
+						print_item(menu, items[scroll * 2 + 1], 0, FALSE,
+							   (items[scroll * 2][0] != ':'));
 					} else {
 						if (choice > 0)
 							choice--;
@@ -380,17 +360,9 @@ dialog_menu(const char *title, const cha
 						wscrl(menu, 1);
 						scrollok(menu, FALSE);
 						scroll++;
-						print_item(menu,
-							   items[(scroll +
-								  max_choice -
-								  1) * 2 + 1],
-							   max_choice - 1,
-							   FALSE,
-							   (items
-							    [(scroll +
-							      max_choice -
-							      1) * 2][0] !=
-							    ':'));
+						print_item(menu, items[(scroll + max_choice - 1) * 2 + 1],
+							   max_choice - 1, FALSE,
+							   (items [(scroll + max_choice - 1) * 2][0] != ':'));
 					} else {
 						if (choice + 1 < max_choice)
 							choice++;
@@ -401,8 +373,7 @@ dialog_menu(const char *title, const cha
 				choice = i;
 
 			print_item(menu, items[(scroll + choice) * 2 + 1],
-				   choice, TRUE,
-				   (items[(scroll + choice) * 2][0] != ':'));
+				   choice, TRUE, (items[(scroll + choice) * 2][0] != ':'));
 
 			print_arrows(dialog, item_no, scroll,
 				     box_y, box_x + item_x + 1, menu_height);
@@ -460,9 +431,7 @@ dialog_menu(const char *title, const cha
 				fprintf(stderr, "%s \"%s\"\n",
 					items[(scroll + choice) * 2],
 					items[(scroll + choice) * 2 + 1] +
-					first_alpha(items
-						    [(scroll + choice) * 2 + 1],
-						    ""));
+					first_alpha(items [(scroll + choice) * 2 + 1], ""));
 			else
 				fprintf(stderr, "%s\n",
 					items[(scroll + choice) * 2]);
diff --git a/scripts/lxdialog/msgbox.c b/scripts/lxdialog/msgbox.c
index 76f358c..b394057 100644
--- a/scripts/lxdialog/msgbox.c
+++ b/scripts/lxdialog/msgbox.c
@@ -25,9 +25,8 @@
  * Display a message box. Program will pause and display an "OK" button
  * if the parameter 'pause' is non-zero.
  */
-int
-dialog_msgbox(const char *title, const char *prompt, int height, int width,
-	      int pause)
+int dialog_msgbox(const char *title, const char *prompt, int height, int width,
+                  int pause)
 {
 	int i, x, y, key = 0;
 	WINDOW *dialog;
diff --git a/scripts/lxdialog/textbox.c b/scripts/lxdialog/textbox.c
index d6e7f2a..fa8d92e 100644
--- a/scripts/lxdialog/textbox.c
+++ b/scripts/lxdialog/textbox.c
@@ -46,30 +46,26 @@ int dialog_textbox(const char *title, co
 	/* Open input file for reading */
 	if ((fd = open(file, O_RDONLY)) == -1) {
 		endwin();
-		fprintf(stderr,
-			"\nCan't open input file in dialog_textbox().\n");
+		fprintf(stderr, "\nCan't open input file in dialog_textbox().\n");
 		exit(-1);
 	}
 	/* Get file size. Actually, 'file_size' is the real file size - 1,
 	   since it's only the last byte offset from the beginning */
 	if ((file_size = lseek(fd, 0, SEEK_END)) == -1) {
 		endwin();
-		fprintf(stderr,
-			"\nError getting file size in dialog_textbox().\n");
+		fprintf(stderr, "\nError getting file size in dialog_textbox().\n");
 		exit(-1);
 	}
 	/* Restore file pointer to beginning of file after getting file size */
 	if (lseek(fd, 0, SEEK_SET) == -1) {
 		endwin();
-		fprintf(stderr,
-			"\nError moving file pointer in dialog_textbox().\n");
+		fprintf(stderr, "\nError moving file pointer in dialog_textbox().\n");
 		exit(-1);
 	}
 	/* Allocate space for read buffer */
 	if ((buf = malloc(BUF_SIZE + 1)) == NULL) {
 		endwin();
-		fprintf(stderr,
-			"\nCan't allocate memory in dialog_textbox().\n");
+		fprintf(stderr, "\nCan't allocate memory in dialog_textbox().\n");
 		exit(-1);
 	}
 	if ((bytes_read = read(fd, buf, BUF_SIZE)) == -1) {
@@ -150,23 +146,20 @@ int dialog_textbox(const char *title, co
 				/* First page not in buffer? */
 				if ((fpos = lseek(fd, 0, SEEK_CUR)) == -1) {
 					endwin();
-					fprintf(stderr,
-						"\nError moving file pointer in dialog_textbox().\n");
+					fprintf(stderr, "\nError moving file pointer in dialog_textbox().\n");
 					exit(-1);
 				}
 				if (fpos > bytes_read) {	/* Yes, we have to read it in */
 					if (lseek(fd, 0, SEEK_SET) == -1) {
 						endwin();
-						fprintf(stderr,
-							"\nError moving file pointer in "
-							"dialog_textbox().\n");
+						fprintf(stderr, "\nError moving file pointer in "
+							        "dialog_textbox().\n");
 						exit(-1);
 					}
 					if ((bytes_read =
 					     read(fd, buf, BUF_SIZE)) == -1) {
 						endwin();
-						fprintf(stderr,
-							"\nError reading file in dialog_textbox().\n");
+						fprintf(stderr, "\nError reading file in dialog_textbox().\n");
 						exit(-1);
 					}
 					buf[bytes_read] = '\0';
@@ -185,22 +178,19 @@ int dialog_textbox(const char *title, co
 			/* Last page not in buffer? */
 			if ((fpos = lseek(fd, 0, SEEK_CUR)) == -1) {
 				endwin();
-				fprintf(stderr,
-					"\nError moving file pointer in dialog_textbox().\n");
+				fprintf(stderr, "\nError moving file pointer in dialog_textbox().\n");
 				exit(-1);
 			}
 			if (fpos < file_size) {	/* Yes, we have to read it in */
 				if (lseek(fd, -BUF_SIZE, SEEK_END) == -1) {
 					endwin();
-					fprintf(stderr,
-						"\nError moving file pointer in dialog_textbox().\n");
+					fprintf(stderr, "\nError moving file pointer in dialog_textbox().\n");
 					exit(-1);
 				}
 				if ((bytes_read =
 				     read(fd, buf, BUF_SIZE)) == -1) {
 					endwin();
-					fprintf(stderr,
-						"\nError reading file in dialog_textbox().\n");
+					fprintf(stderr, "\nError reading file in dialog_textbox().\n");
 					exit(-1);
 				}
 				buf[bytes_read] = '\0';
@@ -342,9 +332,8 @@ static void back_lines(int n)
 		if (page == buf) {
 			if ((fpos = lseek(fd, 0, SEEK_CUR)) == -1) {
 				endwin();
-				fprintf(stderr,
-					"\nError moving file pointer in "
-					"back_lines().\n");
+				fprintf(stderr, "\nError moving file pointer in "
+					        "back_lines().\n");
 				exit(-1);
 			}
 			if (fpos > bytes_read) {	/* Not beginning of file yet */
@@ -358,21 +347,16 @@ static void back_lines(int n)
 					/* No, move less then */
 					if (lseek(fd, 0, SEEK_SET) == -1) {
 						endwin();
-						fprintf(stderr,
-							"\nError moving file pointer in "
-							"back_lines().\n");
+						fprintf(stderr, "\nError moving file pointer in "
+						                "back_lines().\n");
 						exit(-1);
 					}
 					page = buf + fpos - bytes_read;
 				} else {	/* Move backward BUF_SIZE/2 bytes */
-					if (lseek
-					    (fd, -(BUF_SIZE / 2 + bytes_read),
-					     SEEK_CUR)
-					    == -1) {
+					if (lseek (fd, -(BUF_SIZE / 2 + bytes_read), SEEK_CUR) == -1) {
 						endwin();
-						fprintf(stderr,
-							"\nError moving file pointer "
-							"in back_lines().\n");
+						fprintf(stderr, "\nError moving file pointer "
+						                "in back_lines().\n");
 						exit(-1);
 					}
 					page = buf + BUF_SIZE / 2;
@@ -380,8 +364,7 @@ static void back_lines(int n)
 				if ((bytes_read =
 				     read(fd, buf, BUF_SIZE)) == -1) {
 					endwin();
-					fprintf(stderr,
-						"\nError reading file in back_lines().\n");
+					fprintf(stderr, "\nError reading file in back_lines().\n");
 					exit(-1);
 				}
 				buf[bytes_read] = '\0';
@@ -403,33 +386,25 @@ static void back_lines(int n)
 			if (page == buf) {
 				if ((fpos = lseek(fd, 0, SEEK_CUR)) == -1) {
 					endwin();
-					fprintf(stderr,
-						"\nError moving file pointer in back_lines().\n");
+					fprintf(stderr, "\nError moving file pointer in back_lines().\n");
 					exit(-1);
 				}
 				if (fpos > bytes_read) {
 					/* Really possible to move backward BUF_SIZE/2 bytes? */
 					if (fpos < BUF_SIZE / 2 + bytes_read) {
 						/* No, move less then */
-						if (lseek(fd, 0, SEEK_SET) ==
-						    -1) {
+						if (lseek(fd, 0, SEEK_SET) == -1) {
 							endwin();
-							fprintf(stderr,
-								"\nError moving file pointer "
-								"in back_lines().\n");
+							fprintf(stderr, "\nError moving file pointer "
+							                "in back_lines().\n");
 							exit(-1);
 						}
 						page = buf + fpos - bytes_read;
 					} else {	/* Move backward BUF_SIZE/2 bytes */
-						if (lseek
-						    (fd,
-						     -(BUF_SIZE / 2 +
-						       bytes_read),
-						     SEEK_CUR) == -1) {
+						if (lseek (fd, -(BUF_SIZE / 2 + bytes_read), SEEK_CUR) == -1) {
 							endwin();
-							fprintf(stderr,
-								"\nError moving file pointer"
-								" in back_lines().\n");
+							fprintf(stderr, "\nError moving file pointer"
+							                " in back_lines().\n");
 							exit(-1);
 						}
 						page = buf + BUF_SIZE / 2;
@@ -437,9 +412,8 @@ static void back_lines(int n)
 					if ((bytes_read =
 					     read(fd, buf, BUF_SIZE)) == -1) {
 						endwin();
-						fprintf(stderr,
-							"\nError reading file in "
-							"back_lines().\n");
+						fprintf(stderr, "\nError reading file in "
+						                "back_lines().\n");
 						exit(-1);
 					}
 					buf[bytes_read] = '\0';
@@ -513,9 +487,8 @@ static char *get_line(void)
 			/* Either end of file or end of buffer reached */
 			if ((fpos = lseek(fd, 0, SEEK_CUR)) == -1) {
 				endwin();
-				fprintf(stderr,
-					"\nError moving file pointer in "
-					"get_line().\n");
+				fprintf(stderr, "\nError moving file pointer in "
+				                "get_line().\n");
 				exit(-1);
 			}
 			if (fpos < file_size) {	/* Not end of file yet */
@@ -524,8 +497,7 @@ static char *get_line(void)
 				if ((bytes_read =
 				     read(fd, buf, BUF_SIZE)) == -1) {
 					endwin();
-					fprintf(stderr,
-						"\nError reading file in get_line().\n");
+					fprintf(stderr, "\nError reading file in get_line().\n");
 					exit(-1);
 				}
 				buf[bytes_read] = '\0';
@@ -561,8 +533,7 @@ static void print_position(WINDOW * win,
 
 	if ((fpos = lseek(fd, 0, SEEK_CUR)) == -1) {
 		endwin();
-		fprintf(stderr,
-			"\nError moving file pointer in print_position().\n");
+		fprintf(stderr, "\nError moving file pointer in print_position().\n");
 		exit(-1);
 	}
 	wattrset(win, position_indicator_attr);
diff --git a/scripts/lxdialog/util.c b/scripts/lxdialog/util.c
index 232b32c..1f84809 100644
--- a/scripts/lxdialog/util.c
+++ b/scripts/lxdialog/util.c
@@ -28,7 +28,7 @@ const char *backtitle = NULL;
 
 const char *dialog_result;
 
-/* 
+/*
  * Attribute values, default is for mono display
  */
 chtype attributes[] = {
diff --git a/scripts/lxdialog/yesno.c b/scripts/lxdialog/yesno.c
index dffd5af..84f3e8e 100644
--- a/scripts/lxdialog/yesno.c
+++ b/scripts/lxdialog/yesno.c
@@ -96,8 +96,7 @@ int dialog_yesno(const char *title, cons
 		case TAB:
 		case KEY_LEFT:
 		case KEY_RIGHT:
-			button = ((key == KEY_LEFT ? --button : ++button) < 0)
-			    ? 1 : (button > 1 ? 0 : button);
+			button = ((key == KEY_LEFT ? --button : ++button) < 0) ? 1 : (button > 1 ? 0 : button);
 
 			print_buttons(dialog, height, width, button);
 			wrefresh(dialog);
-- 
1.0.6


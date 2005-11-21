Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbVKUWiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVKUWiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVKUWiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:38:11 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:12565 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751183AbVKUWiJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:38:09 -0500
Date: Mon, 21 Nov 2005 23:38:14 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: [1/7] kconfig: fixup after Lindent
Message-ID: <20051121223814.GB19157@mars.ravnborg.org>
References: <20051121223702.GA19157@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121223702.GA19157@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    kconfig: fixup after Lindent
    
    Readability are more important then the 80 coloumn limit, so fold
    several lines to greatly improve readability.
    Also keep return type on same line as function definition.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/lxdialog/checklist.c b/scripts/lxdialog/checklist.c
index 1857c53..ae40a2b 100644
--- a/scripts/lxdialog/checklist.c
+++ b/scripts/lxdialog/checklist.c
@@ -26,12 +26,12 @@
 static int list_width, check_x, item_x, checkflag;
 
 /*
  * Print list item
  */
-static void
-print_item(WINDOW * win, const char *item, int status, int choice, int selected)
+static void print_item(WINDOW * win, const char *item, int status, int choice,
+		       int selected)
 {
 	int i;
 
 	/* Clear 'residue' of last item */
 	wattrset(win, menubox_attr);
@@ -57,12 +57,11 @@ print_item(WINDOW * win, const char *ite
 }
 
 /*
  * Print the scroll indicators.
  */
-static void
-print_arrows(WINDOW * win, int choice, int item_no, int scroll,
+static void print_arrows(WINDOW * win, int choice, int item_no, int scroll,
 	     int y, int x, int height)
 {
 	wmove(win, y, x);
 
 	if (scroll > 0) {
@@ -110,14 +109,13 @@ static void print_buttons(WINDOW * dialo
 
 /*
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
 	WINDOW *dialog, *list;
 
@@ -181,19 +179,18 @@ dialog_checklist(const char *title, cons
 	list_width = width - 6;
 	box_y = height - list_height - 5;
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
 	for (i = 0; i < item_no; i++)
 		check_x = MAX(check_x, +strlen(items[i * 3 + 1]) + 4);
@@ -236,28 +233,22 @@ dialog_checklist(const char *title, cons
 					if (!scroll)
 						continue;
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
 
 					continue;	/* wait for another key press */
 				} else
@@ -267,55 +258,39 @@ dialog_checklist(const char *title, cons
 					if (scroll + choice >= item_no - 1)
 						continue;
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
 
 					continue;	/* wait for another key press */
 				} else
 					i = choice + 1;
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
 			continue;	/* wait for another key press */
 		}
@@ -340,53 +315,39 @@ dialog_checklist(const char *title, cons
 		case 's':
 		case ' ':
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
 				wrefresh(dialog);
 
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
 		case 'X':
 		case 'x':
diff --git a/scripts/lxdialog/dialog.h b/scripts/lxdialog/dialog.h
index c86801f..3cf3d35 100644
--- a/scripts/lxdialog/dialog.h
+++ b/scripts/lxdialog/dialog.h
@@ -1,6 +1,5 @@
-
 /*
  *  dialog.h -- common declarations for all dialog modules
  *
  *  AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
  *
@@ -85,11 +84,11 @@
 #endif
 #ifndef ACS_DARROW
 #define ACS_DARROW 'v'
 #endif
 
-/* 
+/*
  * Attribute names
  */
 #define screen_attr                   attributes[0]
 #define shadow_attr                   attributes[1]
 #define dialog_attr                   attributes[2]
diff --git a/scripts/lxdialog/inputbox.c b/scripts/lxdialog/inputbox.c
index 9e96915..bc135c7 100644
--- a/scripts/lxdialog/inputbox.c
+++ b/scripts/lxdialog/inputbox.c
@@ -39,13 +39,12 @@ static void print_buttons(WINDOW * dialo
 }
 
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
 	char *instr = dialog_input_result;
 	WINDOW *dialog;
@@ -88,12 +87,11 @@ dialog_inputbox(const char *title, const
 	/* Draw the input field box */
 	box_width = width - 6;
 	getyx(dialog, y, x);
 	box_y = y + 2;
 	box_x = (width - box_width) / 2;
-	draw_box(dialog, y + 1, box_x - 1, 3, box_width + 2,
-		 border_attr, dialog_attr);
+	draw_box(dialog, y + 1, box_x - 1, 3, box_width + 2, border_attr, dialog_attr);
 
 	print_buttons(dialog, height, width, 0);
 
 	/* Set up the initial value */
 	wmove(dialog, box_y, box_x);
@@ -109,12 +107,13 @@ dialog_inputbox(const char *title, const
 	if (input_x >= box_width) {
 		scroll = input_x - box_width + 1;
 		input_x = box_width - 1;
 		for (i = 0; i < box_width - 1; i++)
 			waddch(dialog, instr[scroll + i]);
-	} else
+	} else {
 		waddstr(dialog, instr);
+	}
 
 	wmove(dialog, box_y, box_x + input_x);
 
 	wrefresh(dialog);
 
@@ -134,56 +133,38 @@ dialog_inputbox(const char *title, const
 			case KEY_BACKSPACE:
 			case 127:
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
 				continue;
 			default:
 				if (key < 0x100 && isprint(key)) {
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
 					} else
 						flash();	/* Alarm user about overflow */
diff --git a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
index 083f13d..260cc4d 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -61,12 +61,12 @@
 static int menu_width, item_x;
 
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
 
 	strncpy(menu_item, item, menu_width);
@@ -98,12 +98,12 @@ print_item(WINDOW * win, const char *ite
 }
 
 /*
  * Print the scroll indicators.
  */
-static void
-print_arrows(WINDOW * win, int item_no, int scroll, int y, int x, int height)
+static void print_arrows(WINDOW * win, int item_no, int scroll, int y, int x,
+			 int height)
 {
 	int cur_y, cur_x;
 
 	getyx(win, cur_y, cur_x);
 
@@ -156,14 +156,13 @@ static void print_buttons(WINDOW * win, 
 }
 
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
 	    0, max_choice;
 	WINDOW *dialog, *menu;
@@ -281,24 +280,18 @@ dialog_menu(const char *title, const cha
 
 		if (strchr("ynmh", key))
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
 
 		if (i < max_choice ||
@@ -317,57 +310,44 @@ dialog_menu(const char *title, const cha
 					wscrl(menu, -1);
 					scrollok(menu, FALSE);
 
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
 					scrollok(menu, FALSE);
 
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
 				for (i = 0; (i < max_choice); i++) {
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
 					}
 				}
@@ -378,33 +358,24 @@ dialog_menu(const char *title, const cha
 					if (scroll + max_choice < item_no) {
 						scrollok(menu, TRUE);
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
 					}
 				}
 
 			} else
 				choice = i;
 
 			print_item(menu, items[(scroll + choice) * 2 + 1],
-				   choice, TRUE,
-				   (items[(scroll + choice) * 2][0] != ':'));
+				   choice, TRUE, (items[(scroll + choice) * 2][0] != ':'));
 
 			print_arrows(dialog, item_no, scroll,
 				     box_y, box_x + item_x + 1, menu_height);
 
 			wnoutrefresh(dialog);
@@ -458,13 +429,11 @@ dialog_menu(const char *title, const cha
 			delwin(dialog);
 			if (button == 2)
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
 
 			remove("lxdialog.scrltmp");
diff --git a/scripts/lxdialog/msgbox.c b/scripts/lxdialog/msgbox.c
index 76f358c..b394057 100644
--- a/scripts/lxdialog/msgbox.c
+++ b/scripts/lxdialog/msgbox.c
@@ -23,13 +23,12 @@
 
 /*
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
 
 	/* center dialog box on screen */
diff --git a/scripts/lxdialog/textbox.c b/scripts/lxdialog/textbox.c
index d6e7f2a..fa8d92e 100644
--- a/scripts/lxdialog/textbox.c
+++ b/scripts/lxdialog/textbox.c
@@ -44,34 +44,30 @@ int dialog_textbox(const char *title, co
 	search_term[0] = '\0';	/* no search term entered yet */
 
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
 		endwin();
 		fprintf(stderr, "\nError reading file in dialog_textbox().\n");
@@ -148,27 +144,24 @@ int dialog_textbox(const char *title, co
 			if (!begin_reached) {
 				begin_reached = 1;
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
 				}
 				page = buf;
@@ -183,26 +176,23 @@ int dialog_textbox(const char *title, co
 
 			end_reached = 1;
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
 			}
 			page = buf + bytes_read;
@@ -340,13 +330,12 @@ static void back_lines(int n)
 	if (!end_reached) {
 		/* Either beginning of buffer or beginning of file reached? */
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
 				/* We've reached beginning of buffer, but not beginning of
 				   file yet, so read previous part of file into buffer.
@@ -356,34 +345,28 @@ static void back_lines(int n)
 				/* Really possible to move backward BUF_SIZE/2 bytes? */
 				if (fpos < BUF_SIZE / 2 + bytes_read) {
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
 				}
 				if ((bytes_read =
 				     read(fd, buf, BUF_SIZE)) == -1) {
 					endwin();
-					fprintf(stderr,
-						"\nError reading file in back_lines().\n");
+					fprintf(stderr, "\nError reading file in back_lines().\n");
 					exit(-1);
 				}
 				buf[bytes_read] = '\0';
 			} else {	/* Beginning of file reached */
 				begin_reached = 1;
@@ -401,47 +384,38 @@ static void back_lines(int n)
 	for (i = 0; i < n; i++)
 		do {
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
 					}
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
 				} else {	/* Beginning of file reached */
 					begin_reached = 1;
@@ -511,23 +485,21 @@ static char *get_line(void)
 	while (*page != '\n') {
 		if (*page == '\0') {
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
 				/* We've reached end of buffer, but not end of file yet,
 				   so read next part of file into buffer */
 				if ((bytes_read =
 				     read(fd, buf, BUF_SIZE)) == -1) {
 					endwin();
-					fprintf(stderr,
-						"\nError reading file in get_line().\n");
+					fprintf(stderr, "\nError reading file in get_line().\n");
 					exit(-1);
 				}
 				buf[bytes_read] = '\0';
 				page = buf;
 			} else {
@@ -559,12 +531,11 @@ static void print_position(WINDOW * win,
 {
 	int fpos, percent;
 
 	if ((fpos = lseek(fd, 0, SEEK_CUR)) == -1) {
 		endwin();
-		fprintf(stderr,
-			"\nError moving file pointer in print_position().\n");
+		fprintf(stderr, "\nError moving file pointer in print_position().\n");
 		exit(-1);
 	}
 	wattrset(win, position_indicator_attr);
 	wbkgdset(win, position_indicator_attr & A_COLOR);
 	percent = !file_size ?
diff --git a/scripts/lxdialog/util.c b/scripts/lxdialog/util.c
index 232b32c..1f84809 100644
--- a/scripts/lxdialog/util.c
+++ b/scripts/lxdialog/util.c
@@ -26,11 +26,11 @@ bool use_colors = 1;
 
 const char *backtitle = NULL;
 
 const char *dialog_result;
 
-/* 
+/*
  * Attribute values, default is for mono display
  */
 chtype attributes[] = {
 	A_NORMAL,		/* screen_attr */
 	A_NORMAL,		/* shadow_attr */
diff --git a/scripts/lxdialog/yesno.c b/scripts/lxdialog/yesno.c
index dffd5af..84f3e8e 100644
--- a/scripts/lxdialog/yesno.c
+++ b/scripts/lxdialog/yesno.c
@@ -94,12 +94,11 @@ int dialog_yesno(const char *title, cons
 			return 1;
 
 		case TAB:
 		case KEY_LEFT:
 		case KEY_RIGHT:
-			button = ((key == KEY_LEFT ? --button : ++button) < 0)
-			    ? 1 : (button > 1 ? 0 : button);
+			button = ((key == KEY_LEFT ? --button : ++button) < 0) ? 1 : (button > 1 ? 0 : button);
 
 			print_buttons(dialog, height, width, button);
 			wrefresh(dialog);
 			break;
 		case ' ':

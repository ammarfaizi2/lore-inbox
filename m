Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWG3Qfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWG3Qfb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWG3Qfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:35:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:27171 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932355AbWG3Qf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:35:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hosj7SJfitNJD9hCEve7MRqVDVd5BuyWZGc2PRA7PHn8uh0FDnKDl1gegk1DGP7Ry5Om1qJVQuUO/qY9x0Eopc0dwy2+yWspCoZqYrXHif28rwLlqExNbrPRplygndm40ki47SoG7Foh6SEQ6JVJZ9MV+r7mK/m3nayQ9wCnH/w=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] making the kernel -Wshadow clean - fix lxdialog
Date: Sun, 30 Jul 2006 18:36:30 +0200
User-Agent: KMail/1.9.3
References: <200607301830.01659.jesper.juhl@gmail.com>
In-Reply-To: <200607301830.01659.jesper.juhl@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301836.30331.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a bunch of -Wshadow warnings from scripts/kconfig/lxdialog/


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

 scripts/kconfig/lxdialog/checklist.c |   70 ++++++++++-----------
 scripts/kconfig/lxdialog/dialog.h    |    6 -
 scripts/kconfig/lxdialog/inputbox.c  |   38 +++++------
 scripts/kconfig/lxdialog/menubox.c   |   82 ++++++++++++-------------
 scripts/kconfig/lxdialog/msgbox.c    |    4 -
 scripts/kconfig/lxdialog/util.c      |   20 +++---
 6 files changed, 110 insertions(+), 110 deletions(-)

diff -upr linux-2.6.18-rc2-orig/scripts/kconfig/lxdialog/checklist.c linux-2.6.18-rc2/scripts/kconfig/lxdialog/checklist.c
--- linux-2.6.18-rc2-orig/scripts/kconfig/lxdialog/checklist.c	2006-07-18 18:47:19.000000000 +0200
+++ linux-2.6.18-rc2/scripts/kconfig/lxdialog/checklist.c	2006-07-18 20:25:07.000000000 +0200
@@ -56,12 +56,12 @@ static void print_item(WINDOW * win, con
 /*
  * Print the scroll indicators.
  */
-static void print_arrows(WINDOW * win, int choice, int item_no, int scroll,
+static void print_arrows(WINDOW * win, int choice, int item_no, int scrolling,
 	     int y, int x, int height)
 {
 	wmove(win, y, x);
 
-	if (scroll > 0) {
+	if (scrolling > 0) {
 		wattrset(win, uarrow_attr);
 		waddch(win, ACS_UARROW);
 		waddstr(win, "(-)");
@@ -76,7 +76,7 @@ static void print_arrows(WINDOW * win, i
 	y = y + height + 1;
 	wmove(win, y, x);
 
-	if ((height < item_no) && (scroll + choice < item_no - 1)) {
+	if ((height < item_no) && (scrolling + choice < item_no - 1)) {
 		wattrset(win, darrow_attr);
 		waddch(win, ACS_DARROW);
 		waddstr(win, "(+)");
@@ -113,7 +113,7 @@ int dialog_checklist(const char *title, 
 		     const char *const *items)
 {
 	int i, x, y, box_x, box_y;
-	int key = 0, button = 0, choice = 0, scroll = 0, max_choice, *status;
+	int key = 0, button = 0, choice = 0, scrolling = 0, max_choice, *status;
 	WINDOW *dialog, *list;
 
 	/* Allocate space for storing item on/off status */
@@ -181,20 +181,20 @@ int dialog_checklist(const char *title, 
 	item_x = check_x + 4;
 
 	if (choice >= list_height) {
-		scroll = choice - list_height + 1;
-		choice -= scroll;
+		scrolling = choice - list_height + 1;
+		choice -= scrolling;
 	}
 
 	/* Print the list */
 	for (i = 0; i < max_choice; i++) {
 		if (i != choice)
-			print_item(list, items[(scroll + i) * 3 + 1],
-				   status[i + scroll], i, 0);
+			print_item(list, items[(scrolling + i) * 3 + 1],
+				   status[i + scrolling], i, 0);
 	}
-	print_item(list, items[(scroll + choice) * 3 + 1],
-		   status[choice + scroll], choice, 1);
+	print_item(list, items[(scrolling + choice) * 3 + 1],
+		   status[choice + scrolling], choice, 1);
 
-	print_arrows(dialog, choice, item_no, scroll,
+	print_arrows(dialog, choice, item_no, scrolling,
 		     box_y, box_x + check_x + 5, list_height);
 
 	print_buttons(dialog, height, width, 0);
@@ -208,28 +208,28 @@ int dialog_checklist(const char *title, 
 
 		for (i = 0; i < max_choice; i++)
 			if (toupper(key) ==
-			    toupper(items[(scroll + i) * 3 + 1][0]))
+			    toupper(items[(scrolling + i) * 3 + 1][0]))
 				break;
 
 		if (i < max_choice || key == KEY_UP || key == KEY_DOWN ||
 		    key == '+' || key == '-') {
 			if (key == KEY_UP || key == '-') {
 				if (!choice) {
-					if (!scroll)
+					if (!scrolling)
 						continue;
 					/* Scroll list down */
 					if (list_height > 1) {
 						/* De-highlight current first item */
-						print_item(list, items[scroll * 3 + 1],
-							   status[scroll], 0, FALSE);
+						print_item(list, items[scrolling * 3 + 1],
+							   status[scrolling], 0, FALSE);
 						scrollok(list, TRUE);
 						wscrl(list, -1);
 						scrollok(list, FALSE);
 					}
-					scroll--;
-					print_item(list, items[scroll * 3 + 1], status[scroll], 0, TRUE);
+					scrolling--;
+					print_item(list, items[scrolling * 3 + 1], status[scrolling], 0, TRUE);
 					print_arrows(dialog, choice, item_no,
-						     scroll, box_y, box_x + check_x + 5, list_height);
+						     scrolling, box_y, box_x + check_x + 5, list_height);
 
 					wnoutrefresh(dialog);
 					wrefresh(list);
@@ -239,24 +239,24 @@ int dialog_checklist(const char *title, 
 					i = choice - 1;
 			} else if (key == KEY_DOWN || key == '+') {
 				if (choice == max_choice - 1) {
-					if (scroll + choice >= item_no - 1)
+					if (scrolling + choice >= item_no - 1)
 						continue;
 					/* Scroll list up */
 					if (list_height > 1) {
 						/* De-highlight current last item before scrolling up */
-						print_item(list, items[(scroll + max_choice - 1) * 3 + 1],
-							   status[scroll + max_choice - 1],
+						print_item(list, items[(scrolling + max_choice - 1) * 3 + 1],
+							   status[scrolling + max_choice - 1],
 							   max_choice - 1, FALSE);
 						scrollok(list, TRUE);
 						wscrl(list, 1);
 						scrollok(list, FALSE);
 					}
-					scroll++;
-					print_item(list, items[(scroll + max_choice - 1) * 3 + 1],
-						   status[scroll + max_choice - 1], max_choice - 1, TRUE);
+					scrolling++;
+					print_item(list, items[(scrolling + max_choice - 1) * 3 + 1],
+						   status[scrolling + max_choice - 1], max_choice - 1, TRUE);
 
 					print_arrows(dialog, choice, item_no,
-						     scroll, box_y, box_x + check_x + 5, list_height);
+						     scrolling, box_y, box_x + check_x + 5, list_height);
 
 					wnoutrefresh(dialog);
 					wrefresh(list);
@@ -267,12 +267,12 @@ int dialog_checklist(const char *title, 
 			}
 			if (i != choice) {
 				/* De-highlight current item */
-				print_item(list, items[(scroll + choice) * 3 + 1],
-					   status[scroll + choice], choice, FALSE);
+				print_item(list, items[(scrolling + choice) * 3 + 1],
+					   status[scrolling + choice], choice, FALSE);
 				/* Highlight new item */
 				choice = i;
-				print_item(list, items[(scroll + choice) * 3 + 1],
-					   status[scroll + choice], choice, TRUE);
+				print_item(list, items[(scrolling + choice) * 3 + 1],
+					   status[scrolling + choice], choice, TRUE);
 				wnoutrefresh(dialog);
 				wrefresh(list);
 			}
@@ -282,7 +282,7 @@ int dialog_checklist(const char *title, 
 		case 'H':
 		case 'h':
 		case '?':
-			fprintf(stderr, "%s", items[(scroll + choice) * 3]);
+			fprintf(stderr, "%s", items[(scrolling + choice) * 3]);
 			delwin(dialog);
 			free(status);
 			return 1;
@@ -300,13 +300,13 @@ int dialog_checklist(const char *title, 
 		case ' ':
 		case '\n':
 			if (!button) {
-				if (!status[scroll + choice]) {
+				if (!status[scrolling + choice]) {
 					for (i = 0; i < item_no; i++)
 						status[i] = 0;
-					status[scroll + choice] = 1;
+					status[scrolling + choice] = 1;
 					for (i = 0; i < max_choice; i++)
-						print_item(list, items[(scroll + i) * 3 + 1],
-							   status[scroll + i], i, i == choice);
+						print_item(list, items[(scrolling + i) * 3 + 1],
+							   status[scrolling + i], i, i == choice);
 				}
 				wnoutrefresh(dialog);
 				wrefresh(list);
@@ -315,7 +315,7 @@ int dialog_checklist(const char *title, 
 					if (status[i])
 						fprintf(stderr, "%s", items[i * 3]);
 			} else
-				fprintf(stderr, "%s", items[(scroll + choice) * 3]);
+				fprintf(stderr, "%s", items[(scrolling + choice) * 3]);
 			delwin(dialog);
 			free(status);
 			return button;
diff -upr linux-2.6.18-rc2-orig/scripts/kconfig/lxdialog/dialog.h linux-2.6.18-rc2/scripts/kconfig/lxdialog/dialog.h
--- linux-2.6.18-rc2-orig/scripts/kconfig/lxdialog/dialog.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc2/scripts/kconfig/lxdialog/dialog.h	2006-07-18 20:25:07.000000000 +0200
@@ -146,14 +146,14 @@ void color_setup(void);
 void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x);
 void print_button(WINDOW * win, const char *label, int y, int x, int selected);
 void print_title(WINDOW *dialog, const char *title, int width);
-void draw_box(WINDOW * win, int y, int x, int height, int width, chtype box,
-	      chtype border);
+void draw_box(WINDOW * win, int y, int x, int height, int width, chtype the_box,
+	      chtype the_border);
 void draw_shadow(WINDOW * win, int y, int x, int height, int width);
 
 int first_alpha(const char *string, const char *exempt);
 int dialog_yesno(const char *title, const char *prompt, int height, int width);
 int dialog_msgbox(const char *title, const char *prompt, int height,
-		  int width, int pause);
+		  int width, int delay);
 int dialog_textbox(const char *title, const char *file, int height, int width);
 int dialog_menu(const char *title, const char *prompt, int height, int width,
 		int menu_height, const char *choice, int item_no,
diff -upr linux-2.6.18-rc2-orig/scripts/kconfig/lxdialog/inputbox.c linux-2.6.18-rc2/scripts/kconfig/lxdialog/inputbox.c
--- linux-2.6.18-rc2-orig/scripts/kconfig/lxdialog/inputbox.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc2/scripts/kconfig/lxdialog/inputbox.c	2006-07-18 20:25:07.000000000 +0200
@@ -45,8 +45,8 @@ int dialog_inputbox(const char *title, c
                     const char *init)
 {
 	int i, x, y, box_y, box_x, box_width;
-	int input_x = 0, scroll = 0, key = 0, button = -1;
-	char *instr = dialog_input_result;
+	int input_x = 0, scrolling = 0, key = 0, button = -1;
+	char *in_str = dialog_input_result;
 	WINDOW *dialog;
 
 	/* center dialog box on screen */
@@ -85,19 +85,19 @@ int dialog_inputbox(const char *title, c
 	wattrset(dialog, inputbox_attr);
 
 	if (!init)
-		instr[0] = '\0';
+		in_str[0] = '\0';
 	else
-		strcpy(instr, init);
+		strcpy(in_str, init);
 
-	input_x = strlen(instr);
+	input_x = strlen(in_str);
 
 	if (input_x >= box_width) {
-		scroll = input_x - box_width + 1;
+		scrolling = input_x - box_width + 1;
 		input_x = box_width - 1;
 		for (i = 0; i < box_width - 1; i++)
-			waddch(dialog, instr[scroll + i]);
+			waddch(dialog, in_str[scrolling + i]);
 	} else {
-		waddstr(dialog, instr);
+		waddstr(dialog, in_str);
 	}
 
 	wmove(dialog, box_y, box_x + input_x);
@@ -119,19 +119,19 @@ int dialog_inputbox(const char *title, c
 				continue;
 			case KEY_BACKSPACE:
 			case 127:
-				if (input_x || scroll) {
+				if (input_x || scrolling) {
 					wattrset(dialog, inputbox_attr);
 					if (!input_x) {
-						scroll = scroll < box_width - 1 ? 0 : scroll - (box_width - 1);
+						scrolling = scrolling < box_width - 1 ? 0 : scrolling - (box_width - 1);
 						wmove(dialog, box_y, box_x);
 						for (i = 0; i < box_width; i++)
 							waddch(dialog,
-							       instr[scroll + input_x + i] ?
-							       instr[scroll + input_x + i] : ' ');
-						input_x = strlen(instr) - scroll;
+							       in_str[scrolling + input_x + i] ?
+							       in_str[scrolling + input_x + i] : ' ');
+						input_x = strlen(in_str) - scrolling;
 					} else
 						input_x--;
-					instr[scroll + input_x] = '\0';
+					in_str[scrolling + input_x] = '\0';
 					mvwaddch(dialog, box_y, input_x + box_x, ' ');
 					wmove(dialog, box_y, input_x + box_x);
 					wrefresh(dialog);
@@ -139,15 +139,15 @@ int dialog_inputbox(const char *title, c
 				continue;
 			default:
 				if (key < 0x100 && isprint(key)) {
-					if (scroll + input_x < MAX_LEN) {
+					if (scrolling + input_x < MAX_LEN) {
 						wattrset(dialog, inputbox_attr);
-						instr[scroll + input_x] = key;
-						instr[scroll + input_x + 1] = '\0';
+						in_str[scrolling + input_x] = key;
+						in_str[scrolling + input_x + 1] = '\0';
 						if (input_x == box_width - 1) {
-							scroll++;
+							scrolling++;
 							wmove(dialog, box_y, box_x);
 							for (i = 0; i < box_width - 1; i++)
-								waddch(dialog, instr [scroll + i]);
+								waddch(dialog, in_str[scrolling + i]);
 						} else {
 							wmove(dialog, box_y, input_x++ + box_x);
 							waddch(dialog, key);
diff -upr linux-2.6.18-rc2-orig/scripts/kconfig/lxdialog/menubox.c linux-2.6.18-rc2/scripts/kconfig/lxdialog/menubox.c
--- linux-2.6.18-rc2-orig/scripts/kconfig/lxdialog/menubox.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc2/scripts/kconfig/lxdialog/menubox.c	2006-07-18 20:25:07.000000000 +0200
@@ -107,7 +107,7 @@ do {\
 /*
  * Print the scroll indicators.
  */
-static void print_arrows(WINDOW * win, int item_no, int scroll, int y, int x,
+static void print_arrows(WINDOW * win, int item_no, int scrolling, int y, int x,
 			 int height)
 {
 	int cur_y, cur_x;
@@ -132,7 +132,7 @@ static void print_arrows(WINDOW * win, i
 	wmove(win, y, x);
 	wrefresh(win);
 
-	if ((height < item_no) && (scroll + height < item_no)) {
+	if ((height < item_no) && (scrolling + height < item_no)) {
 		wattrset(win, darrow_attr);
 		waddch(win, ACS_DARROW);
 		waddstr(win, "(+)");
@@ -165,13 +165,13 @@ static void print_buttons(WINDOW * win, 
 }
 
 /* scroll up n lines (n may be negative) */
-static void do_scroll(WINDOW *win, int *scroll, int n)
+static void do_scroll(WINDOW *win, int *scrolling, int n)
 {
 	/* Scroll menu up */
 	scrollok(win, TRUE);
 	wscrl(win, n);
 	scrollok(win, FALSE);
-	*scroll = *scroll + n;
+	*scrolling = *scrolling + n;
 	wrefresh(win);
 }
 
@@ -183,7 +183,7 @@ int dialog_menu(const char *title, const
                 const char *const *items)
 {
 	int i, j, x, y, box_x, box_y;
-	int key = 0, button = 0, scroll = 0, choice = 0;
+	int key = 0, button = 0, scrolling = 0, choice = 0;
 	int first_item =  0, max_choice;
 	WINDOW *dialog, *menu;
 	FILE *f;
@@ -235,14 +235,14 @@ int dialog_menu(const char *title, const
 
 	/* get the scroll info from the temp file */
 	if ((f = fopen("lxdialog.scrltmp", "r")) != NULL) {
-		if ((fscanf(f, "%d\n", &scroll) == 1) && (scroll <= choice) &&
-		    (scroll + max_choice > choice) && (scroll >= 0) &&
-		    (scroll + max_choice <= item_no)) {
-			first_item = scroll;
-			choice = choice - scroll;
+		if ((fscanf(f, "%d\n", &scrolling) == 1) && (scrolling <= choice) &&
+		    (scrolling + max_choice > choice) && (scrolling >= 0) &&
+		    (scrolling + max_choice <= item_no)) {
+			first_item = scrolling;
+			choice = choice - scrolling;
 			fclose(f);
 		} else {
-			scroll = 0;
+			scrolling = 0;
 			remove("lxdialog.scrltmp");
 			fclose(f);
 			f = NULL;
@@ -250,10 +250,10 @@ int dialog_menu(const char *title, const
 	}
 	if ((choice >= max_choice) || (f == NULL && choice >= max_choice / 2)) {
 		if (choice >= item_no - max_choice / 2)
-			scroll = first_item = item_no - max_choice;
+			scrolling = first_item = item_no - max_choice;
 		else
-			scroll = first_item = choice - max_choice / 2;
-		choice = choice - scroll;
+			scrolling = first_item = choice - max_choice / 2;
+		choice = choice - scrolling;
 	}
 
 	/* Print the menu */
@@ -263,7 +263,7 @@ int dialog_menu(const char *title, const
 
 	wnoutrefresh(menu);
 
-	print_arrows(dialog, item_no, scroll,
+	print_arrows(dialog, item_no, scrolling,
 		     box_y, box_x + item_x + 1, menu_height);
 
 	print_buttons(dialog, height, width, 0);
@@ -280,14 +280,14 @@ int dialog_menu(const char *title, const
 			i = max_choice;
 		else {
 			for (i = choice + 1; i < max_choice; i++) {
-				j = first_alpha(items[(scroll + i) * 2 + 1], "YyNnMmHh");
-				if (key == tolower(items[(scroll + i) * 2 + 1][j]))
+				j = first_alpha(items[(scrolling + i) * 2 + 1], "YyNnMmHh");
+				if (key == tolower(items[(scrolling + i) * 2 + 1][j]))
 					break;
 			}
 			if (i == max_choice)
 				for (i = 0; i < max_choice; i++) {
-					j = first_alpha(items [(scroll + i) * 2 + 1], "YyNnMmHh");
-					if (key == tolower(items[(scroll + i) * 2 + 1][j]))
+					j = first_alpha(items [(scrolling + i) * 2 + 1], "YyNnMmHh");
+					if (key == tolower(items[(scrolling + i) * 2 + 1][j]))
 						break;
 				}
 		}
@@ -297,26 +297,26 @@ int dialog_menu(const char *title, const
 		    key == '-' || key == '+' ||
 		    key == KEY_PPAGE || key == KEY_NPAGE) {
 			/* Remove highligt of current item */
-			print_item(scroll + choice, choice, FALSE);
+			print_item(scrolling + choice, choice, FALSE);
 
 			if (key == KEY_UP || key == '-') {
-				if (choice < 2 && scroll) {
+				if (choice < 2 && scrolling) {
 					/* Scroll menu down */
-					do_scroll(menu, &scroll, -1);
+					do_scroll(menu, &scrolling, -1);
 
-					print_item(scroll, 0, FALSE);
+					print_item(scrolling, 0, FALSE);
 				} else
 					choice = MAX(choice - 1, 0);
 
 			} else if (key == KEY_DOWN || key == '+') {
-				print_item(scroll+choice, choice, FALSE);
+				print_item(scrolling+choice, choice, FALSE);
 
 				if ((choice > max_choice - 3) &&
-				    (scroll + max_choice < item_no)) {
+				    (scrolling + max_choice < item_no)) {
 					/* Scroll menu up */
-					do_scroll(menu, &scroll, 1);
+					do_scroll(menu, &scrolling, 1);
 
-					print_item(scroll+max_choice - 1,
+					print_item(scrolling+max_choice - 1,
 						   max_choice - 1, FALSE);
 				} else
 					choice = MIN(choice + 1, max_choice - 1);
@@ -324,9 +324,9 @@ int dialog_menu(const char *title, const
 			} else if (key == KEY_PPAGE) {
 				scrollok(menu, TRUE);
 				for (i = 0; (i < max_choice); i++) {
-					if (scroll > 0) {
-						do_scroll(menu, &scroll, -1);
-						print_item(scroll, 0, FALSE);
+					if (scrolling > 0) {
+						do_scroll(menu, &scrolling, -1);
+						print_item(scrolling, 0, FALSE);
 					} else {
 						if (choice > 0)
 							choice--;
@@ -335,9 +335,9 @@ int dialog_menu(const char *title, const
 
 			} else if (key == KEY_NPAGE) {
 				for (i = 0; (i < max_choice); i++) {
-					if (scroll + max_choice < item_no) {
-						do_scroll(menu, &scroll, 1);
-						print_item(scroll+max_choice-1,
+					if (scrolling + max_choice < item_no) {
+						do_scroll(menu, &scrolling, 1);
+						print_item(scrolling+max_choice-1,
 							   max_choice - 1, FALSE);
 					} else {
 						if (choice + 1 < max_choice)
@@ -347,9 +347,9 @@ int dialog_menu(const char *title, const
 			} else
 				choice = i;
 
-			print_item(scroll + choice, choice, TRUE);
+			print_item(scrolling + choice, choice, TRUE);
 
-			print_arrows(dialog, item_no, scroll,
+			print_arrows(dialog, item_no, scrolling,
 				     box_y, box_x + item_x + 1, menu_height);
 
 			wnoutrefresh(dialog);
@@ -376,11 +376,11 @@ int dialog_menu(const char *title, const
 		case '/':
 			/* save scroll info */
 			if ((f = fopen("lxdialog.scrltmp", "w")) != NULL) {
-				fprintf(f, "%d\n", scroll);
+				fprintf(f, "%d\n", scrolling);
 				fclose(f);
 			}
 			delwin(dialog);
-			fprintf(stderr, "%s\n", items[(scroll + choice) * 2]);
+			fprintf(stderr, "%s\n", items[(scrolling + choice) * 2]);
 			switch (key) {
 			case 's':
 				return 3;
@@ -403,12 +403,12 @@ int dialog_menu(const char *title, const
 			delwin(dialog);
 			if (button == 2)
 				fprintf(stderr, "%s \"%s\"\n",
-					items[(scroll + choice) * 2],
-					items[(scroll + choice) * 2 + 1] +
-					first_alpha(items [(scroll + choice) * 2 + 1], ""));
+					items[(scrolling + choice) * 2],
+					items[(scrolling + choice) * 2 + 1] +
+					first_alpha(items [(scrolling + choice) * 2 + 1], ""));
 			else
 				fprintf(stderr, "%s\n",
-					items[(scroll + choice) * 2]);
+					items[(scrolling + choice) * 2]);
 
 			remove("lxdialog.scrltmp");
 			return button;
diff -upr linux-2.6.18-rc2-orig/scripts/kconfig/lxdialog/msgbox.c linux-2.6.18-rc2/scripts/kconfig/lxdialog/msgbox.c
--- linux-2.6.18-rc2-orig/scripts/kconfig/lxdialog/msgbox.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc2/scripts/kconfig/lxdialog/msgbox.c	2006-07-18 20:25:07.000000000 +0200
@@ -26,7 +26,7 @@
  * if the parameter 'pause' is non-zero.
  */
 int dialog_msgbox(const char *title, const char *prompt, int height, int width,
-                  int pause)
+                  int delay)
 {
 	int i, x, y, key = 0;
 	WINDOW *dialog;
@@ -47,7 +47,7 @@ int dialog_msgbox(const char *title, con
 	wattrset(dialog, dialog_attr);
 	print_autowrap(dialog, prompt, width - 2, 1, 2);
 
-	if (pause) {
+	if (delay) {
 		wattrset(dialog, border_attr);
 		mvwaddch(dialog, height - 3, 0, ACS_LTEE);
 		for (i = 0; i < width - 2; i++)
diff -upr linux-2.6.18-rc2-orig/scripts/kconfig/lxdialog/util.c linux-2.6.18-rc2/scripts/kconfig/lxdialog/util.c
--- linux-2.6.18-rc2-orig/scripts/kconfig/lxdialog/util.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc2/scripts/kconfig/lxdialog/util.c	2006-07-18 20:25:07.000000000 +0200
@@ -288,7 +288,7 @@ void print_button(WINDOW * win, const ch
  */
 void
 draw_box(WINDOW * win, int y, int x, int height, int width,
-	 chtype box, chtype border)
+	 chtype the_box, chtype the_border)
 {
 	int i, j;
 
@@ -297,23 +297,23 @@ draw_box(WINDOW * win, int y, int x, int
 		wmove(win, y + i, x);
 		for (j = 0; j < width; j++)
 			if (!i && !j)
-				waddch(win, border | ACS_ULCORNER);
+				waddch(win, the_border | ACS_ULCORNER);
 			else if (i == height - 1 && !j)
-				waddch(win, border | ACS_LLCORNER);
+				waddch(win, the_border | ACS_LLCORNER);
 			else if (!i && j == width - 1)
-				waddch(win, box | ACS_URCORNER);
+				waddch(win, the_box | ACS_URCORNER);
 			else if (i == height - 1 && j == width - 1)
-				waddch(win, box | ACS_LRCORNER);
+				waddch(win, the_box | ACS_LRCORNER);
 			else if (!i)
-				waddch(win, border | ACS_HLINE);
+				waddch(win, the_border | ACS_HLINE);
 			else if (i == height - 1)
-				waddch(win, box | ACS_HLINE);
+				waddch(win, the_box | ACS_HLINE);
 			else if (!j)
-				waddch(win, border | ACS_VLINE);
+				waddch(win, the_border | ACS_VLINE);
 			else if (j == width - 1)
-				waddch(win, box | ACS_VLINE);
+				waddch(win, the_box | ACS_VLINE);
 			else
-				waddch(win, box | ' ');
+				waddch(win, the_box | ' ');
 	}
 }
 




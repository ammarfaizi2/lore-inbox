Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVKUWis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVKUWis (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVKUWir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:38:47 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:35661 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1751157AbVKUWiq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:38:46 -0500
Date: Mon, 21 Nov 2005 23:38:53 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: [2/7] kconfig: lxdialog is now sparse clean
Message-ID: <20051121223853.GC19157@mars.ravnborg.org>
References: <20051121223702.GA19157@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121223702.GA19157@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    kconfig: lxdialog is now sparse clean
    
    Replacing a gcc idiom with malloc and deleting an unused global
    variable made lxdialog sparse clean.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
index 260cc4d..ff3a617 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -65,11 +65,11 @@ static int menu_width, item_x;
  */
 static void print_item(WINDOW * win, const char *item, int choice,
 		       int selected, int hotkey)
 {
 	int j;
-	char menu_item[menu_width + 1];
+	char *menu_item = malloc(menu_width + 1);
 
 	strncpy(menu_item, item, menu_width);
 	menu_item[menu_width] = 0;
 	j = first_alpha(menu_item, "YyNnMmHh");
 
@@ -93,10 +93,11 @@ static void print_item(WINDOW * win, con
 	}
 	if (selected) {
 		wmove(win, choice, item_x + 1);
 		wrefresh(win);
 	}
+	free(menu_item);
 }
 
 /*
  * Print the scroll indicators.
  */
@@ -219,11 +220,11 @@ int dialog_menu(const char *title, const
 	draw_box(dialog, box_y, box_x, menu_height + 2, menu_width + 2,
 		 menubox_border_attr, menubox_attr);
 
 	/*
 	 * Find length of longest item in order to center menu.
-	 * Set 'choice' to default item. 
+	 * Set 'choice' to default item.
 	 */
 	item_x = 0;
 	for (i = 0; i < item_no; i++) {
 		item_x =
 		    MAX(item_x, MIN(menu_width, strlen(items[i * 2 + 1]) + 2));
diff --git a/scripts/lxdialog/util.c b/scripts/lxdialog/util.c
index 1f84809..ce41147 100644
--- a/scripts/lxdialog/util.c
+++ b/scripts/lxdialog/util.c
@@ -24,12 +24,10 @@
 /* use colors by default? */
 bool use_colors = 1;
 
 const char *backtitle = NULL;
 
-const char *dialog_result;
-
 /*
  * Attribute values, default is for mono display
  */
 chtype attributes[] = {
 	A_NORMAL,		/* screen_attr */

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTFAJ01 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 05:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbTFAJ01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 05:26:27 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.29]:56105 "EHLO
	mwinf0204.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262413AbTFAJ0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 05:26:24 -0400
Date: Sun, 1 Jun 2003 11:39:59 +0200
From: Romain Lievin <roms@tilp.info>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] gconfig bug fixes
Message-ID: <20030601093959.GB8990@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a patch which fix a bug reported by Nuno Tavares and another one.

Please apply, Romain.
==========================[ cut here ]=========================
diff -Naur linux-2.5.70/scripts/kconfig/gconf.c linux/scripts/kconfig/gconf.c
--- linux-2.5.70/scripts/kconfig/gconf.c	Mon May  5 01:53:41 2003
+++ linux/scripts/kconfig/gconf.c	Sun Jun  1 11:34:31 2003
@@ -836,6 +836,8 @@
 	gtk_widget_show(tree1_w);
 	gtk_window_get_default_size(GTK_WINDOW(main_wnd), &w, &h);
 	gtk_paned_set_position(GTK_PANED(hpaned), w / 2);
+	if (tree2)	
+		gtk_tree_store_clear(tree2);
 	display_list();
 }
 
@@ -922,8 +924,10 @@
 		config_changed = TRUE;
 		if (view_mode == FULL_VIEW)
 			update_tree(&rootmenu, NULL);
-		else if (view_mode == SPLIT_VIEW)
+		else if (view_mode == SPLIT_VIEW) {
 			update_tree(current, NULL);
+			display_list();
+		}
 		else if (view_mode == SINGLE_VIEW)
 			display_tree_part();	//fixme: keep exp/coll
 		break;
@@ -949,8 +953,10 @@
 	sym_set_tristate_value(menu->sym, newval);
 	if (view_mode == FULL_VIEW)
 		update_tree(&rootmenu, NULL);
-	else if (view_mode == SPLIT_VIEW)
+	else if (view_mode == SPLIT_VIEW) {
 		update_tree(current, NULL);
+		display_list();
+	}
 	else if (view_mode == SINGLE_VIEW)
 		display_tree_part();	//fixme: keep exp/coll
 }
@@ -1036,7 +1042,7 @@
 		ptype = menu->prompt ? menu->prompt->type : P_UNKNOWN;
 
 		if (((ptype == P_MENU) || (ptype == P_ROOTMENU)) &&
-		    (view_mode == SINGLE_VIEW) && (col == COL_OPTION)) {
+		    (view_mode != FULL_VIEW) && (col == COL_OPTION)) {
 			// goes down into menu
 			current = menu;
 			display_tree_part();
@@ -1525,8 +1531,6 @@
 /* Display the list in the left frame (split view) */
 static void display_list(void)
 {
-	if (tree2)
-		gtk_tree_store_clear(tree2);
 	if (tree1)
 		gtk_tree_store_clear(tree1);
 
========================[ here ]=============================
-- 
Romain Lievin, aka 'roms'  	<roms@tilp.info>
The TiLP project is on 		<http://www.ti-lpg.org>
"Linux, y'a moins bien mais c'est plus cher !"















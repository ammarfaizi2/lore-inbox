Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbUAEUeu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUAEUeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:34:50 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:32194 "EHLO
	mwinf0304.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265182AbUAEUer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:34:47 -0500
Date: Mon, 5 Jan 2004 21:34:44 +0100
From: Romain Lievin <romain@rlievin.dyndns.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Buddy Lucas <b.lucas@ohra.nl>, Roman Zippel <zippel@linux-m68k.org>
Subject: [PATCH] gconfig segfaults & compile error fix
Message-ID: <20040105203444.GA2201@rlievin.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fix a segfault problem (Roman Zippel) as well as some compile warnings (Buddy Lucas).

Patch was against 2.6.0.

Thanks, Romain.
======================[ cut here ]=========================
diff -Naur linux-2.6.0/scripts/kconfig/gconf.c linux/scripts/kconfig/gconf.c
--- linux-2.6.0/scripts/kconfig/gconf.c	2003-12-18 03:59:41.000000000 +0100
+++ linux/scripts/kconfig/gconf.c	2003-12-24 15:31:06.000000000 +0100
@@ -1,7 +1,7 @@
 /* Hey EMACS -*- linux-c -*- */
 /*
  *
- * Copyright (C) 2002-2003 Romain Lievin <roms@lpg.ticalc.org>
+ * Copyright (C) 2002-2003 Romain Lievin <roms@tilp.info>
  * Released under the terms of the GNU GPL v2.0.
  *
  */
@@ -1047,6 +1047,8 @@
 		return FALSE;
 
 	gtk_tree_model_get_iter(model2, &iter, path);
+	if(!gtk_tree_store_iter_is_valid(model2, &iter))
+		return FALSE;
 	gtk_tree_model_get(model2, &iter, COL_MENU, &menu, -1);
 
 	col = column2index(column);
@@ -1172,7 +1174,7 @@
 
 	gtk_widget_realize(tree2_w);
 	gtk_tree_view_set_cursor(view, path, NULL, FALSE);
-	gtk_widget_grab_focus(GTK_TREE_VIEW(tree2_w));
+	gtk_widget_grab_focus(tree2_w);
 
 	return FALSE;
 }
@@ -1401,7 +1403,6 @@
 	struct symbol *sym;
 	struct property *prop;
 	struct menu *menu1, *menu2;
-	static GtkTreePath *path = NULL;
 
 	if (src == &rootmenu)
 		indent = 1;
@@ -1526,7 +1527,7 @@
 		if (((menu != &rootmenu) && !(menu->flags & MENU_ROOT)) ||
 		    (view_mode == FULL_VIEW)
 		    || (view_mode == SPLIT_VIEW))*/
-		if ((view_mode == SINGLE_VIEW) && (menu->flags & MENU_ROOT) 
+		if (((view_mode == SINGLE_VIEW) && (menu->flags & MENU_ROOT)) 
 		|| (view_mode == FULL_VIEW) || (view_mode == SPLIT_VIEW)) {
 			indent++;
 			display_tree(child);

-- 
Romain Li�vin (roms):         <roms@tilp.info>
Web site:                     http://tilp.info
"Linux, y'a moins bien mais c'est plus cher !"







Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbUL3XzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbUL3XzV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 18:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUL3Xxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 18:53:48 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:39001 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261761AbUL3Xw7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 18:52:59 -0500
Date: Fri, 31 Dec 2004 00:53:09 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: kconfig: help includes dependency information
Message-ID: <20041230235309.GD9450@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org
References: <20041230235146.GA9450@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041230235146.GA9450@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/31 00:43:45+01:00 sam@mars.ravnborg.org 
#   kconfig: help includes dependency information
#   
#   When selecting help on a menu item display
#   "depends on:"
#   "selects:"
#   "selected by:"
#   
#   Only relevant headlines are displayed - so if no "selects:" appear then this menu
#   does not select a specific symbol.
#   Loosly based on a patch by: Cal Peake <cp@absolutedigital.net>
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/kconfig/mconf.c
#   2004/12/31 00:43:27+01:00 sam@mars.ravnborg.org +5 -5
#   display
#   "depends on:"
#   "selects:"
#   "selected by:"
#   
#   information when selecting help on a menu
# 
diff -Nru a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
--- a/scripts/kconfig/mconf.c	2004-12-31 00:46:29 +01:00
+++ b/scripts/kconfig/mconf.c	2004-12-31 00:46:29 +01:00
@@ -732,17 +732,17 @@
 static void show_help(struct menu *menu)
 {
 	const char *help;
-	char *helptext;
 	struct symbol *sym = menu->sym;
 
 	help = sym->help;
 	if (!help)
 		help = nohelp_text;
 	if (sym->name) {
-		helptext = malloc(strlen(sym->name) + strlen(help) + 16);
-		sprintf(helptext, "CONFIG_%s:\n\n%s", sym->name, help);
-		show_helptext(menu_get_prompt(menu), helptext);
-		free(helptext);
+		struct gstr str = str_init();
+		str_printf(&str, "CONFIG_%s:\n\n%s", sym->name, help);
+		show_expr(menu, &str);
+		show_helptext(menu_get_prompt(menu), str_get(&str));
+		str_del(&str);
 	} else
 		show_helptext(menu_get_prompt(menu), help);
 }

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbUL3XxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbUL3XxW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 18:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbUL3XxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 18:53:21 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:39224 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261767AbUL3Xwe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 18:52:34 -0500
Date: Fri, 31 Dec 2004 00:52:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: kconfig: remove noise from show_expr
Message-ID: <20041230235245.GC9450@mars.ravnborg.org>
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
#   2004/12/31 00:36:09+01:00 sam@mars.ravnborg.org 
#   kconfig: remove noise from show_expr
#   
#   This makes readout more compact when searching for specific symbols
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/kconfig/mconf.c
#   2004/12/31 00:35:50+01:00 sam@mars.ravnborg.org +7 -17
#   avoid printing empty information in show_expr
#   increase buffer size in str_printf - people write that big text blocks
# 
diff -Nru a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
--- a/scripts/kconfig/mconf.c	2004-12-31 00:45:40 +01:00
+++ b/scripts/kconfig/mconf.c	2004-12-31 00:45:40 +01:00
@@ -147,7 +147,7 @@
 static void str_printf(struct gstr *gs, const char *fmt, ...)
 {
 	va_list ap;
-	char s[1024];
+	char s[4096];
 	va_start(ap, fmt);
 	vsnprintf(s, sizeof(s), fmt, ap);
 	str_add(gs, s);
@@ -347,34 +347,24 @@
 
 static void show_expr(struct menu *menu, struct gstr *gs)
 {
-	bool hit = false;
-	str_add(gs, "Depends:\n ");
 	if (menu->prompt->visible.expr) {
-		if (!hit)
-			hit = true;
+		str_add(gs, "\ndepends on:\n ");
 		expr_str(menu->prompt->visible.expr, gs);
 	}
-	if (!hit)
-		str_add(gs, "None");
 	if (menu->sym) {
 		struct property *prop;
-		hit = false;
-		str_add(gs, "\nSelects:\n ");
+		bool hit = false;
 		for_all_properties(menu->sym, prop, P_SELECT) {
-			if (!hit)
+			if (!hit) {
+				str_add(gs, "\nselects:\n ");
 				hit = true;
+			}
 			expr_str(prop->expr, gs);
 		}
-		if (!hit)
-			str_add(gs, "None");
-		hit = false;
-		str_add(gs, "\nSelected by:\n ");
 		if (menu->sym->rev_dep.expr) {
-			hit = true;
+			str_add(gs, "\nselected by:\n ");
 			expr_str(menu->sym->rev_dep.expr, gs);
 		}
-		if (!hit)
-			str_add(gs, "None");
 	}
 }
 

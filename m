Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWDIP0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWDIP0w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWDIP0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:26:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:28330 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750766AbWDIP0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:26:51 -0400
Date: Sun, 9 Apr 2006 17:26:50 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/19] kconfig: revert conf behaviour change
Message-ID: <Pine.LNX.4.64.0604091726430.23112@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After the last patch fixed the real problem, revert this needless behaviour
change of conf, which only hid the real problem.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/conf.c |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

Index: linux-2.6-git/scripts/kconfig/conf.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/conf.c
+++ linux-2.6-git/scripts/kconfig/conf.c
@@ -63,20 +63,6 @@ static void check_stdin(void)
 	}
 }
 
-static char *fgets_check_stream(char *s, int size, FILE *stream)
-{
-	char *ret = fgets(s, size, stream);
-
-	if (ret == NULL && feof(stream)) {
-		printf(_("aborted!\n\n"));
-		printf(_("Console input is closed. "));
-		printf(_("Run 'make oldconfig' to update configuration.\n\n"));
-		exit(1);
-	}
-
-	return ret;
-}
-
 static void conf_askvalue(struct symbol *sym, const char *def)
 {
 	enum symbol_type type = sym_get_type(sym);
@@ -114,7 +100,7 @@ static void conf_askvalue(struct symbol 
 		check_stdin();
 	case ask_all:
 		fflush(stdout);
-		fgets_check_stream(line, 128, stdin);
+		fgets(line, 128, stdin);
 		return;
 	case set_default:
 		printf("%s\n", def);
@@ -369,7 +355,7 @@ static int conf_choice(struct menu *menu
 			check_stdin();
 		case ask_all:
 			fflush(stdout);
-			fgets_check_stream(line, 128, stdin);
+			fgets(line, 128, stdin);
 			strip(line);
 			if (line[0] == '?') {
 				printf("\n%s\n", menu->sym->help ?

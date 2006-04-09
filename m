Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWDIP20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWDIP20 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWDIP20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:28:26 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:31402 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750778AbWDIP2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:28:16 -0400
Date: Sun, 9 Apr 2006 17:28:15 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 7/19] kconfig: remove SYMBOL_{YES,MOD,NO}
Message-ID: <Pine.LNX.4.64.0604091728080.23132@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The SYMBOL_{YES,MOD,NO} are not really used anymore (they were more used
be the cml1 converter), so just remove them.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/expr.c   |    3 ++-
 scripts/kconfig/expr.h   |    5 +----
 scripts/kconfig/gconf.c  |    6 ------
 scripts/kconfig/symbol.c |    6 +++---
 4 files changed, 6 insertions(+), 14 deletions(-)

Index: linux-2.6-git/scripts/kconfig/expr.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/expr.c
+++ linux-2.6-git/scripts/kconfig/expr.c
@@ -145,7 +145,8 @@ static void __expr_eliminate_eq(enum exp
 		return;
 	}
 	if (e1->type == E_SYMBOL && e2->type == E_SYMBOL &&
-	    e1->left.sym == e2->left.sym && (e1->left.sym->flags & (SYMBOL_YES|SYMBOL_NO)))
+	    e1->left.sym == e2->left.sym &&
+	    (e1->left.sym == &symbol_yes || e1->left.sym == &symbol_no))
 		return;
 	if (!expr_eq(e1, e2))
 		return;
Index: linux-2.6-git/scripts/kconfig/expr.h
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/expr.h
+++ linux-2.6-git/scripts/kconfig/expr.h
@@ -78,10 +78,7 @@ struct symbol {
 
 #define for_all_symbols(i, sym) for (i = 0; i < 257; i++) for (sym = symbol_hash[i]; sym; sym = sym->next) if (sym->type != S_OTHER)
 
-#define SYMBOL_YES		0x0001
-#define SYMBOL_MOD		0x0002
-#define SYMBOL_NO		0x0004
-#define SYMBOL_CONST		0x0007
+#define SYMBOL_CONST		0x0001
 #define SYMBOL_CHECK		0x0008
 #define SYMBOL_CHOICE		0x0010
 #define SYMBOL_CHOICEVAL	0x0020
Index: linux-2.6-git/scripts/kconfig/gconf.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/gconf.c
+++ linux-2.6-git/scripts/kconfig/gconf.c
@@ -114,12 +114,6 @@ const char *dbg_print_flags(int val)
 
 	bzero(buf, 256);
 
-	if (val & SYMBOL_YES)
-		strcat(buf, "yes/");
-	if (val & SYMBOL_MOD)
-		strcat(buf, "mod/");
-	if (val & SYMBOL_NO)
-		strcat(buf, "no/");
 	if (val & SYMBOL_CONST)
 		strcat(buf, "const/");
 	if (val & SYMBOL_CHECK)
Index: linux-2.6-git/scripts/kconfig/symbol.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/symbol.c
+++ linux-2.6-git/scripts/kconfig/symbol.c
@@ -15,15 +15,15 @@
 struct symbol symbol_yes = {
 	.name = "y",
 	.curr = { "y", yes },
-	.flags = SYMBOL_YES|SYMBOL_VALID,
+	.flags = SYMBOL_CONST|SYMBOL_VALID,
 }, symbol_mod = {
 	.name = "m",
 	.curr = { "m", mod },
-	.flags = SYMBOL_MOD|SYMBOL_VALID,
+	.flags = SYMBOL_CONST|SYMBOL_VALID,
 }, symbol_no = {
 	.name = "n",
 	.curr = { "n", no },
-	.flags = SYMBOL_NO|SYMBOL_VALID,
+	.flags = SYMBOL_CONST|SYMBOL_VALID,
 }, symbol_empty = {
 	.name = "",
 	.curr = { "", no },

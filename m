Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbSL0KfL>; Fri, 27 Dec 2002 05:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbSL0KfL>; Fri, 27 Dec 2002 05:35:11 -0500
Received: from dp.samba.org ([66.70.73.150]:52367 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264863AbSL0KfK>;
	Fri, 27 Dec 2002 05:35:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, trivial@rustcorp.com.au
Subject: [PATCH] Trivial patch for module.c: Strtab by sh_link field.
Date: Fri, 27 Dec 2002 21:23:11 +1100
Message-Id: <20021227104328.079A62C052@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ This is Richard being nitpicky, but it's worth keeping him happy 8) ]

Name: Strtab by sh_link field.
From: Richard Henderson <rth@twiddle.net>
Status: Trivial

D: The strtab section is supposed to be found using the symtab's
D: sh_link field, not by name.

===== kernel/module.c 1.32 vs edited =====
--- 1.32/kernel/module.c	Thu Dec 19 18:19:53 2002
+++ edited/kernel/module.c	Thu Dec 26 12:44:00 2002
@@ -1010,6 +979,9 @@
 			/* Internal symbols */
 			DEBUGP("Symbol table in section %u\n", i);
 			symindex = i;
+			/* Strings */
+			strindex = sechdrs[i].sh_link;
+			DEBUGP("String table found in section %u\n", strindex);
 		} else if (strcmp(secstrings+sechdrs[i].sh_name,
 				  ".gnu.linkonce.modname") == 0) {
 			/* This module's name */
@@ -1024,11 +1000,6 @@
 			/* Exported symbols. */
 			DEBUGP("EXPORT table in section %u\n", i);
 			exportindex = i;
-		} else if (strcmp(secstrings + sechdrs[i].sh_name, ".strtab")
-			   == 0) {
-			/* Strings */
-			DEBUGP("String table found in section %u\n", i);
-			strindex = i;
 		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__param")
 			   == 0) {
 			/* Setup parameter info */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

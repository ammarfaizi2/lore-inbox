Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267447AbSLSC0G>; Wed, 18 Dec 2002 21:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267471AbSLSC0G>; Wed, 18 Dec 2002 21:26:06 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:3487 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267447AbSLSC0F>; Wed, 18 Dec 2002 21:26:05 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Make some symbol exports conditional on CONFIG_MMU
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20021219023359.E6D573706@mcspd15.ucom.lsi.nec.co.jp>
Date: Thu, 19 Dec 2002 11:33:59 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few symbols are only defined when CONFIG_MMU=y, but are exported
(by kernel/ksyms.c) unconditionally.  This patch makes them conditional.

diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/kernel/ksyms.c kernel/ksyms.c
--- ../orig/linux-2.5.52-uc0/kernel/ksyms.c	2002-12-16 12:53:59.000000000 +0900
+++ kernel/ksyms.c	2002-12-17 17:23:49.000000000 +0900
@@ -327,7 +327,9 @@
 /* for stackable file systems (lofs, wrapfs, cryptfs, etc.) */
 EXPORT_SYMBOL(default_llseek);
 EXPORT_SYMBOL(dentry_open);
+#ifdef CONFIG_MMU
 EXPORT_SYMBOL(filemap_nopage);
+#endif
 EXPORT_SYMBOL(filemap_fdatawrite);
 EXPORT_SYMBOL(filemap_fdatawait);
 EXPORT_SYMBOL(lock_page);
@@ -523,7 +525,9 @@
 EXPORT_SYMBOL(single_release);
 
 /* Program loader interfaces */
+#ifdef CONFIG_MMU
 EXPORT_SYMBOL(setup_arg_pages);
+#endif
 EXPORT_SYMBOL(copy_strings_kernel);
 EXPORT_SYMBOL(do_execve);
 EXPORT_SYMBOL(flush_old_exec);

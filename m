Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbSLII4N>; Mon, 9 Dec 2002 03:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264890AbSLII4G>; Mon, 9 Dec 2002 03:56:06 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:56476 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264739AbSLIIyp>; Mon, 9 Dec 2002 03:54:45 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Make some symbol exports conditional on CONFIG_MMU
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20021209090211.1D2E23703@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon,  9 Dec 2002 18:02:11 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few symbols are only defined when CONFIG_MMU=y, but are exported
(by kernel/ksyms.c) unconditionally.  This patch makes them conditional.

diff -ruN -X../cludes ../orig/linux-2.5.50-uc0/kernel/ksyms.c kernel/ksyms.c
--- ../orig/linux-2.5.50-uc0/kernel/ksyms.c	2002-11-28 10:25:09.000000000 +0900
+++ kernel/ksyms.c	2002-11-28 15:01:41.000000000 +0900
@@ -324,7 +324,9 @@
 /* for stackable file systems (lofs, wrapfs, cryptfs, etc.) */
 EXPORT_SYMBOL(default_llseek);
 EXPORT_SYMBOL(dentry_open);
+#ifdef CONFIG_MMU
 EXPORT_SYMBOL(filemap_nopage);
+#endif
 EXPORT_SYMBOL(filemap_fdatawrite);
 EXPORT_SYMBOL(filemap_fdatawait);
 EXPORT_SYMBOL(lock_page);
@@ -525,7 +527,9 @@
 EXPORT_SYMBOL(single_release);
 
 /* Program loader interfaces */
+#ifdef CONFIG_MMU
 EXPORT_SYMBOL(setup_arg_pages);
+#endif
 EXPORT_SYMBOL(copy_strings_kernel);
 EXPORT_SYMBOL(do_execve);
 EXPORT_SYMBOL(flush_old_exec);

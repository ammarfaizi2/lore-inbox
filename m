Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSHOFAl>; Thu, 15 Aug 2002 01:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSHOFAl>; Thu, 15 Aug 2002 01:00:41 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:30218 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id <S316569AbSHOFAl>; Thu, 15 Aug 2002 01:00:41 -0400
Date: Wed, 14 Aug 2002 23:43:48 -0500 (CDT)
Message-Id: <200208150443.g7F4hms72462@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Marcelo.Tosatti@sullivan.realtime.net (marcelo@conectiva.com.br)
Cc: trivial@rustcorp.com.au, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Simplify vt.c ifdef for sys_ioperm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Several architectures defined sys_ioperm but don't actually implement it:

arch/m68k/kernel/sys_m68k.c: sys_ioperm return -ENOSYS
arch/sparc/kernel/setup.c: sys_ioperm return -EIO
arch/ppc/kernel/syscalls.c: sys_ioperm printk(KERN_ERR ...) return -EIO

(vs current 2.4 bk  -- 2.4.20-pre2+)

===== drivers/char/vt.c 1.10 vs edited =====
--- 1.10/drivers/char/vt.c	Tue Aug  6 09:42:07 2002
+++ edited/drivers/char/vt.c	Wed Aug 14 23:09:20 2002
@@ -481,7 +481,7 @@
 		ucval = keyboard_type;
 		goto setchar;
 
-#if defined(__i386__) || defined(__mc68000__) || defined(__ppc__) || defined(__sparc__)
+#if defined(CONFIG_X86)
 		/*
 		 * These cannot be implemented on any machine that implements
 		 * ioperm() in user level (such as Alpha PCs).

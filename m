Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSHTJGN>; Tue, 20 Aug 2002 05:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316662AbSHTJGJ>; Tue, 20 Aug 2002 05:06:09 -0400
Received: from dp.samba.org ([66.70.73.150]:37021 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S316675AbSHTJGG>;
	Tue, 20 Aug 2002 05:06:06 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: davem@vger.kernel.org, paulus@samba.org, marcelo@conectiva.com.br,
       geert@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Simplify vt.c ifdef for sys_ioperm
Date: Tue, 20 Aug 2002 19:06:59 +1000
Message-Id: <20020820041036.4805C2C4AC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Looks right.  Marcelo pelase apply. ]
From:  Milton Miller <miltonm@bga.com>

  
  Several architectures defined sys_ioperm but don't actually implement it:
  
  arch/m68k/kernel/sys_m68k.c: sys_ioperm return -ENOSYS
  arch/sparc/kernel/setup.c: sys_ioperm return -EIO
  arch/ppc/kernel/syscalls.c: sys_ioperm printk(KERN_ERR ...) return -EIO
  
  (vs current 2.4 bk  -- 2.4.20-pre2+)
  
  ===== drivers/char/vt.c 1.10 vs edited =====

--- trivial-2.4.20-pre4/drivers/char/vt.c.orig	2002-08-20 18:01:05.000000000 +1000
+++ trivial-2.4.20-pre4/drivers/char/vt.c	2002-08-20 18:01:05.000000000 +1000
@@ -481,7 +481,7 @@
 		ucval = keyboard_type;
 		goto setchar;
 
-#if defined(__i386__) || defined(__mc68000__) || defined(__ppc__) || defined(__sparc__)
+#if defined(CONFIG_X86)
 		/*
 		 * These cannot be implemented on any machine that implements
 		 * ioperm() in user level (such as Alpha PCs).
-- 
  Don't blame me: the Monkey is driving
  File: Milton Miller <miltonm@bga.com>: [PATCH] Simplify vt.c ifdef for sys_ioperm

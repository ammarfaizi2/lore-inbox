Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVBHQaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVBHQaE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVBHQaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:30:04 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:36360 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261578AbVBHQ3c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:29:32 -0500
Message-Id: <200502081829.j18ITAs0003968@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Blaisorblade <blaisorblade@yahoo.it>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG report] UML linux-2.6 latest BK doesn't compile 
In-Reply-To: Your message of "Tue, 08 Feb 2005 10:09:55 GMT."
             <1107857395.15872.2.camel@imp.csi.cam.ac.uk> 
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Feb 2005 13:29:09 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aia21@cam.ac.uk said:
> arch/um/kernel/exec_kern.c:59: undefined reference to `__bb_init_func'

The __bb_init_func export is to allow modules to be built with a gcov-enabled
UML.  I get a bunch of undefines in the module links when I get rid of it.

This is probably being too intimate with libc, and yours probably doesn't have
__bb_init_func.

Try the patch below and see if it helps.  Modules won't work, but you should
get a working UML.

				Jeff
Index: 2.6.10/arch/um/kernel/Makefile
===================================================================
--- 2.6.10.orig/arch/um/kernel/Makefile	2005-02-07 12:45:56.000000000 -0500
+++ 2.6.10/arch/um/kernel/Makefile	2005-02-08 10:23:31.000000000 -0500
@@ -15,7 +15,6 @@
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
-obj-$(CONFIG_GCOV)	+= gmon_syms.o
 obj-$(CONFIG_TTY_LOG)	+= tty_log.o
 obj-$(CONFIG_SYSCALL_DEBUG) += syscall_user.o
 
Index: 2.6.10/arch/um/kernel/gmon_syms.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/gmon_syms.c	2004-12-24 16:35:39.000000000 -0500
+++ 2.6.10/arch/um/kernel/gmon_syms.c	2003-09-15 09:40:47.000000000 -0400
@@ -1,20 +0,0 @@
-/* 
- * Copyright (C) 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include "linux/module.h"
-
-extern void __bb_init_func(void *);
-EXPORT_SYMBOL(__bb_init_func);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */


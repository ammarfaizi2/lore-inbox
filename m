Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWIYSfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWIYSfw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWIYSfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:35:52 -0400
Received: from [198.99.130.12] ([198.99.130.12]:50068 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751239AbWIYSfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:35:50 -0400
Message-Id: <200609251834.k8PIYYOa005036@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Paolo Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH 4/8] UML - Fix gcov support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Sep 2006 14:34:34 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make __bb_init_func weak in order to avoid a link failure with some libcs
and/or gccs.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/kernel/gmon_syms.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/gmon_syms.c	2006-09-11 11:14:48.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/gmon_syms.c	2006-09-11 11:28:21.000000000 -0400
@@ -5,7 +5,7 @@
 
 #include "linux/module.h"
 
-extern void __bb_init_func(void *);
+extern void __bb_init_func(void *)  __attribute__((weak));
 EXPORT_SYMBOL(__bb_init_func);
 
 /* This is defined (and referred to in profiling stub code) only by some GCC
@@ -21,14 +21,3 @@ EXPORT_SYMBOL(__gcov_init);
 
 extern void __gcov_merge_add(void *) __attribute__((weak));
 EXPORT_SYMBOL(__gcov_merge_add);
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


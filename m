Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVCJA32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVCJA32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVCJA1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:27:11 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:52750 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262576AbVCJARI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:17:08 -0500
Message-Id: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/9] UML - Export gcov symbol based on gcc version
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Mar 2005 21:16:02 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The init function called by gcc when gcov is enabled is __gcov_init or
__bb_init_func, depending on the gcc version.  Anton is using 3.3.4 and 
seeing __gcov_init.  I'm using 3.3.2 and seeing __bb_init_func, so we need
to close that gap a bit.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/gmon_syms.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/gmon_syms.c	2005-03-07 10:53:03.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/gmon_syms.c	2005-03-07 16:29:37.000000000 -0500
@@ -5,8 +5,14 @@
 
 #include "linux/module.h"
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 3) || \
+	(__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4)
+extern void __gcov_init(void *);
+EXPORT_SYMBOL(__gcov_init);
+#else
 extern void __bb_init_func(void *);
 EXPORT_SYMBOL(__bb_init_func);
+#endif
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.


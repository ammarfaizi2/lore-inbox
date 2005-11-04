Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbVKDWLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbVKDWLS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVKDWLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:11:18 -0500
Received: from verein.lst.de ([213.95.11.210]:3750 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751021AbVKDWLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:11:17 -0500
Date: Fri, 4 Nov 2005 23:11:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove ioctl32_handler_t
Message-ID: <20051104221112.GB9301@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures define and use this type in their compat_ioctl code,
but all of them can easily use the identical ioctl_trans_handler_t type
that is defined in common code.


Index: linux-2.6/arch/ia64/ia32/ia32_ioctl.c
===================================================================
--- linux-2.6.orig/arch/ia64/ia32/ia32_ioctl.c	2005-10-31 12:23:05.000000000 +0100
+++ linux-2.6/arch/ia64/ia32/ia32_ioctl.c	2005-11-01 17:30:53.000000000 +0100
@@ -29,10 +29,8 @@
 #define CODE
 #include "compat_ioctl.c"
 
-typedef int (* ioctl32_handler_t)(unsigned int, unsigned int, unsigned long, struct file *);
-
 #define COMPATIBLE_IOCTL(cmd)		HANDLE_IOCTL((cmd),sys_ioctl)
-#define HANDLE_IOCTL(cmd,handler)	{ (cmd), (ioctl32_handler_t)(handler), NULL },
+#define HANDLE_IOCTL(cmd,handler)	{ (cmd), (ioctl_trans_handler_t)(handler), NULL },
 #define IOCTL_TABLE_START \
 	struct ioctl_trans ioctl_start[] = {
 #define IOCTL_TABLE_END \
Index: linux-2.6/arch/mips/kernel/ioctl32.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/ioctl32.c	2005-10-31 12:23:11.000000000 +0100
+++ linux-2.6/arch/mips/kernel/ioctl32.c	2005-11-01 17:31:23.000000000 +0100
@@ -26,10 +26,8 @@
 #define CODE
 #include "compat_ioctl.c"
 
-typedef int (* ioctl32_handler_t)(unsigned int, unsigned int, unsigned long, struct file *);
-
 #define COMPATIBLE_IOCTL(cmd)		HANDLE_IOCTL((cmd),sys_ioctl)
-#define HANDLE_IOCTL(cmd,handler)	{ (cmd), (ioctl32_handler_t)(handler), NULL },
+#define HANDLE_IOCTL(cmd,handler)	{ (cmd), (ioctl_trans_handler_t)(handler), NULL },
 #define IOCTL_TABLE_START \
 	struct ioctl_trans ioctl_start[] = {
 #define IOCTL_TABLE_END \
Index: linux-2.6/arch/sparc64/kernel/ioctl32.c
===================================================================
--- linux-2.6.orig/arch/sparc64/kernel/ioctl32.c	2005-10-31 13:15:49.000000000 +0100
+++ linux-2.6/arch/sparc64/kernel/ioctl32.c	2005-11-01 17:31:36.000000000 +0100
@@ -462,10 +462,8 @@
 
 #endif
 
-typedef int (* ioctl32_handler_t)(unsigned int, unsigned int, unsigned long, struct file *);
-
 #define COMPATIBLE_IOCTL(cmd)		HANDLE_IOCTL((cmd),sys_ioctl)
-#define HANDLE_IOCTL(cmd,handler)	{ (cmd), (ioctl32_handler_t)(handler), NULL },
+#define HANDLE_IOCTL(cmd,handler)	{ (cmd), (ioctl_trans_handler_t)(handler), NULL },
 #define IOCTL_TABLE_START \
 	struct ioctl_trans ioctl_start[] = {
 #define IOCTL_TABLE_END \

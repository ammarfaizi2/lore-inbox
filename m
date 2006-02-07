Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbWBGCWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWBGCWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 21:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWBGCWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 21:22:48 -0500
Received: from [198.99.130.12] ([198.99.130.12]:15083 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964937AbWBGCWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 21:22:47 -0500
Message-Id: <200602070223.k172NpJa009654@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/8] UML - Define jmpbuf access constants
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Feb 2006 21:23:51 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With newer libcs, the JB_* macros (which we shouldn't be using anyway, 
probably) go away.  This patch defines them if setjmp.h doesn't.  It'd
be nice to have a real way to do this, as sysrq-t requires a way to
get registers from out-of-context threads, which we store in jmpbufs.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/sys-i386/registers.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/os-Linux/sys-i386/registers.c	2006-02-06 17:34:36.000000000 -0500
@@ -127,6 +127,12 @@ void get_safe_registers(unsigned long *r
 	memcpy(regs, exec_regs, HOST_FRAME_SIZE * sizeof(unsigned long));
 }
 
+#ifndef JB_PC
+#define JB_PC 5
+#define JB_SP 4
+#define JB_BP 3
+#endif
+
 void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
 {
 	struct __jmp_buf_tag *jmpbuf = buffer;
Index: linux-2.6.15/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/sys-x86_64/registers.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/os-Linux/sys-x86_64/registers.c	2006-02-06 17:34:36.000000000 -0500
@@ -75,6 +75,12 @@ void get_safe_registers(unsigned long *r
 	memcpy(regs, exec_regs, HOST_FRAME_SIZE * sizeof(unsigned long));
 }
 
+#ifndef JB_PC
+#define JB_PC 7
+#define JB_RSP 6
+#define JB_RBP 1
+#endif
+
 void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
 {
 	struct __jmp_buf_tag *jmpbuf = buffer;


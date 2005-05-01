Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbVEAVSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVEAVSb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbVEAVSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:18:30 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:19731 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262677AbVEAVSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:23 -0400
Message-Id: <200505012112.j41LCZSO016434@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/22] UML - Fix a ptrace call
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:12:35 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes write_ldt_entry to treat userspace_pid as an array.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/sys-i386/ldt.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-i386/ldt.c	2005-04-13 18:20:01.000000000 -0400
+++ linux-2.6.11/arch/um/sys-i386/ldt.c	2005-04-13 18:20:27.000000000 -0400
@@ -25,7 +25,7 @@
 #endif
 
 #ifdef CONFIG_MODE_SKAS
-extern int userspace_pid;
+extern int userspace_pid[];
 
 #include "skas_ptrace.h"
 
@@ -56,7 +56,8 @@
 	ldt = ((struct ptrace_ldt) { .func	= func,
 				     .ptr	= buf,
 				     .bytecount = bytecount });
-	res = ptrace(PTRACE_LDT, userspace_pid, 0, (unsigned long) &ldt);
+#warning Need to look up userspace_pid by cpu
+	res = ptrace(PTRACE_LDT, userspace_pid[0], 0, (unsigned long) &ldt);
 	if(res < 0)
 		goto out;
 


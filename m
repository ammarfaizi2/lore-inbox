Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbULCTfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbULCTfV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbULCTcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:32:11 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:27652
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262465AbULCTa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:30:29 -0500
Message-Id: <200412032146.iB3LkOZW004740@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: [PATCH] UML - Remove bogus __NR_sigreturn check
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:46:24 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before Bodo's signal fixes and my signal delivery rework, it was possible for
a process to execute UML code by running the default signal restorer.  This
is no longer possible, so this check can be removed from the sanity test for
UML accidentally tracing itself.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/tt/syscall_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/syscall_user.c	2004-12-03 12:46:55.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/syscall_user.c	2004-12-03 12:50:39.000000000 -0500
@@ -57,8 +57,7 @@
 
 	UPT_SYSCALL_NR(TASK_REGS(task)) = PT_SYSCALL_NR(proc_regs);
 
-	if((syscall != __NR_sigreturn) &&
-	   ((unsigned long *) PT_IP(proc_regs) >= &_stext) && 
+	if(((unsigned long *) PT_IP(proc_regs) >= &_stext) && 
 	   ((unsigned long *) PT_IP(proc_regs) <= &_etext))
 		tracer_panic("I'm tracing myself and I can't get out");
 


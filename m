Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVCGSPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVCGSPU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 13:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVCGSLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 13:11:43 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:3589 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261205AbVCGSIk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 13:08:40 -0500
Message-Id: <200503072038.j27Kcrbc004008@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 14/16] UML - Fix a compile failure
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 15:38:53 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a UML/x86_64 warning (and build failure if CONFIG_MODE_TT is disabled).

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/sys-x86_64/ptrace_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-x86_64/ptrace_user.c	2005-03-05 12:07:33.000000000 -0500
+++ linux-2.6.11/arch/um/sys-x86_64/ptrace_user.c	2005-03-05 12:23:46.000000000 -0500
@@ -42,23 +42,12 @@
 void arch_leave_kernel(void *task, int pid)
 {
 #ifdef UM_USER_CS
-	if(ptrace(PTRACE_POKEUSER, pid, CS, UM_USER_CS) < 0)
-		tracer_panic("POKEUSER CS failed");
+        if(ptrace(PTRACE_POKEUSER, pid, CS, UM_USER_CS) < 0)
+                printk("POKEUSR CS failed");
 #endif
 
-	if(ptrace(PTRACE_POKEUSER, pid, DS, __USER_DS) < 0)
-		tracer_panic("POKEUSER DS failed");
-	if(ptrace(PTRACE_POKEUSER, pid, ES, __USER_DS) < 0)
-		tracer_panic("POKEUSER ES failed");
+        if(ptrace(PTRACE_POKEUSER, pid, DS, __USER_DS) < 0)
+                printk("POKEUSR DS failed");
+        if(ptrace(PTRACE_POKEUSER, pid, ES, __USER_DS) < 0)
+                printk("POKEUSR ES failed");
 }
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


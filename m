Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbUKLX62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbUKLX62 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbUKLX4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:56:52 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:24836
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262717AbUKLXsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:48:23 -0500
Message-Id: <200411130200.iAD20lpT005859@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/11] - UML - don't rule out syscall_nr == 0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Nov 2004 21:00:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser - Change the valid system call numbers to reflect the 
possibility that we could have __NR_restart_syscall.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/skas/process.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/skas/process.c	2004-11-12 13:24:54.000000000 -0500
+++ 2.6.9/arch/um/kernel/skas/process.c	2004-11-12 13:34:34.000000000 -0500
@@ -64,7 +64,7 @@
 
 	syscall_nr = PT_SYSCALL_NR(regs->skas.regs);
 	UPT_SYSCALL_NR(regs) = syscall_nr;
-	if(syscall_nr < 1){
+	if(syscall_nr < 0){
 		relay_signal(SIGTRAP, regs);
 		return;
 	}
Index: 2.6.9/arch/um/kernel/tt/syscall_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/syscall_user.c	2004-11-12 13:24:54.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/syscall_user.c	2004-11-12 18:05:29.000000000 -0500
@@ -63,7 +63,8 @@
 	regs = TASK_REGS(task);
 	UPT_SYSCALL_NR(regs) = syscall;
 
-	if(syscall < 1) return(0);
+	if(syscall < 0)
+		return(0);
 
 	if((syscall != __NR_sigreturn) &&
 	   ((unsigned long *) PT_IP(proc_regs) >= &_stext) && 


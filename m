Return-Path: <linux-kernel-owner+w=401wt.eu-S1750922AbXAICNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbXAICNe (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 21:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbXAICNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 21:13:11 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:44487 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbXAICLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 21:11:55 -0500
Message-Id: <200701090205.l0925lx1024391@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/7] UML - Remove unused variable and function
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jan 2007 21:05:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_index and next_syscall_index turn out not to be used.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/include/kern_util.h |    1 -
 arch/um/kernel/syscall.c    |   16 ----------------
 2 files changed, 17 deletions(-)

Index: linux-2.6.18-mm/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/kern_util.h	2007-01-08 16:15:33.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/kern_util.h	2007-01-08 16:29:07.000000000 -0500
@@ -61,7 +61,6 @@ extern int set_signals(int enable);
 extern void force_sigbus(void);
 extern int pid_to_processor_id(int pid);
 extern void deliver_signals(void *t);
-extern int next_syscall_index(int max);
 extern int next_trap_index(int max);
 extern void default_idle(void);
 extern void finish_fork(void);
Index: linux-2.6.18-mm/arch/um/kernel/syscall.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/syscall.c	2006-12-29 12:20:14.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/syscall.c	2007-01-08 16:29:14.000000000 -0500
@@ -149,22 +149,6 @@ long sys_olduname(struct oldold_utsname 
 	return error;
 }
 
-DEFINE_SPINLOCK(syscall_lock);
-
-static int syscall_index = 0;
-
-int next_syscall_index(int limit)
-{
-	int ret;
-
-	spin_lock(&syscall_lock);
-	ret = syscall_index;
-	if(++syscall_index == limit)
-		syscall_index = 0;
-	spin_unlock(&syscall_lock);
-	return(ret);
-}
-
 int kernel_execve(const char *filename, char *const argv[], char *const envp[])
 {
 	mm_segment_t fs;


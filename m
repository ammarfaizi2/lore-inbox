Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVCGTKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVCGTKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVCGTJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:09:47 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:4358 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261251AbVCGTHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:07:42 -0500
Message-Id: <200503072038.j27Kcjbc003998@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 12/16] UML - Remove useless sys_mount wrapper
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 15:38:45 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

um_mount did nothing but turn around and call sys_mount with the same 
arguments.  This makes it useless code, and it has been duly removed.
Index: linux-2.6.11/arch/um/kernel/sys_call_table.c

Signed-off-by: Jeff Dike <jdike@addtoit.com>

===================================================================
--- linux-2.6.11.orig/arch/um/kernel/sys_call_table.c	2005-03-05 12:07:32.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/sys_call_table.c	2005-03-05 12:19:52.000000000 -0500
@@ -31,7 +31,6 @@
 extern syscall_handler_t sys_fork;
 extern syscall_handler_t sys_execve;
 extern syscall_handler_t um_time;
-extern syscall_handler_t um_mount;
 extern syscall_handler_t um_stime;
 extern syscall_handler_t sys_pipe;
 extern syscall_handler_t sys_olduname;
@@ -77,7 +76,7 @@
 	[ __NR_lchown ] = (syscall_handler_t *) sys_lchown16,
 	[ __NR_lseek ] = (syscall_handler_t *) sys_lseek,
 	[ __NR_getpid ] = (syscall_handler_t *) sys_getpid,
-	[ __NR_mount ] = um_mount,
+	[ __NR_mount ] = (syscall_handler_t *) sys_mount,
 	[ __NR_setuid ] = (syscall_handler_t *) sys_setuid16,
 	[ __NR_getuid ] = (syscall_handler_t *) sys_getuid16,
  	[ __NR_ptrace ] = (syscall_handler_t *) sys_ptrace,
Index: linux-2.6.11/arch/um/kernel/syscall_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/syscall_kern.c	2005-03-05 12:18:28.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/syscall_kern.c	2005-03-05 12:19:52.000000000 -0500
@@ -27,12 +27,6 @@
 /*  Unlocked, I don't care if this is a bit off */
 int nsyscalls = 0;
 
-long um_mount(char __user * dev_name, char __user * dir_name,
-	      char __user * type, unsigned long new_flags, void __user * data)
-{
-	return(sys_mount(dev_name, dir_name, type, new_flags, data));
-}
-
 long sys_fork(void)
 {
 	long ret;


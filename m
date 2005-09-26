Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVIZMh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVIZMh5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVIZMh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:37:57 -0400
Received: from verein.lst.de ([213.95.11.210]:30596 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932110AbVIZMh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:37:56 -0400
Date: Mon, 26 Sep 2005 14:37:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] adjust parisc sys_ptrace prototype
Message-ID: <20050926123750.GA25496@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the pid argument a long as on every other arcihtecture.  Despite
pid_t beeing a 32bit type even on 64bit parisc this is not an ABI change
due to the parisc calling conventions.  And even if it did it wouldn't
matter too much because 64bit userspace on parisc is in an embrionic
stage.

Acked-by: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/parisc/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/ptrace.c	2005-09-20 23:57:49.000000000 +0200
+++ linux-2.6/arch/parisc/kernel/ptrace.c	2005-09-21 11:31:34.000000000 +0200
@@ -78,7 +78,7 @@
 	pa_psw(child)->l = 0;
 }
 
-long sys_ptrace(long request, pid_t pid, long addr, long data)
+long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	long ret;
Index: linux-2.6/include/asm-parisc/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-parisc/unistd.h	2005-09-20 23:57:49.000000000 +0200
+++ linux-2.6/include/asm-parisc/unistd.h	2005-09-21 11:35:23.000000000 +0200
@@ -1005,7 +1005,6 @@
 		struct pt_regs *regs);
 int sys_vfork(struct pt_regs *regs);
 int sys_pipe(int *fildes);
-long sys_ptrace(long request, pid_t pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,


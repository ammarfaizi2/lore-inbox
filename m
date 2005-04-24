Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVDXSWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVDXSWj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 14:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVDXSVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 14:21:49 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:2979 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262363AbVDXSUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 14:20:19 -0400
Subject: [patch 5/6] uml: inline empty proc
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sun, 24 Apr 2005 20:10:07 +0200
Message-Id: <20050424181007.5680155D01@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cleanup: make an inline of this empty proc.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/kernel/process_kern.c      |    4 ----
 linux-2.6.12-paolo/include/asm-um/processor-generic.h |    6 +++++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff -puN include/asm-um/processor-generic.h~uml-inline-empty include/asm-um/processor-generic.h
--- linux-2.6.12/include/asm-um/processor-generic.h~uml-inline-empty	2005-04-24 19:32:18.000000000 +0200
+++ linux-2.6.12-paolo/include/asm-um/processor-generic.h	2005-04-24 19:32:18.000000000 +0200
@@ -89,7 +89,11 @@ extern struct task_struct *alloc_task_st
 extern void release_thread(struct task_struct *);
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 extern void dump_thread(struct pt_regs *regs, struct user *u);
-extern void prepare_to_copy(struct task_struct *tsk);
+
+static inline void prepare_to_copy(struct task_struct *tsk)
+{
+}
+
 
 extern unsigned long thread_saved_pc(struct task_struct *t);
 
diff -puN arch/um/kernel/process_kern.c~uml-inline-empty arch/um/kernel/process_kern.c
--- linux-2.6.12/arch/um/kernel/process_kern.c~uml-inline-empty	2005-04-24 19:32:18.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/process_kern.c	2005-04-24 19:32:18.000000000 +0200
@@ -161,10 +161,6 @@ void *get_current(void)
 	return(current);
 }
 
-void prepare_to_copy(struct task_struct *tsk)
-{
-}
-
 int copy_thread(int nr, unsigned long clone_flags, unsigned long sp,
 		unsigned long stack_top, struct task_struct * p, 
 		struct pt_regs *regs)
_

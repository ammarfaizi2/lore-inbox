Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270138AbTGZOme (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272541AbTGZOd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:33:57 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:19732 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S272500AbTGZOcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:25 -0400
Date: Sat, 26 Jul 2003 16:51:28 +0200
Message-Id: <200307261451.h6QEpSB9002274@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k do_fork()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Update for changed do_fork() semantics in 2.5.70

--- linux-2.6.x/arch/m68k/kernel/process.c	Thu Feb 13 17:01:13 2003
+++ linux-m68k-2.6.x/arch/m68k/kernel/process.c	Wed May 28 17:34:58 2003
@@ -202,24 +202,19 @@
 
 asmlinkage int m68k_fork(struct pt_regs *regs)
 {
-	struct task_struct *p;
-	p = do_fork(SIGCHLD, rdusp(), regs, 0, NULL, NULL);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+	return do_fork(SIGCHLD, rdusp(), regs, 0, NULL, NULL);
 }
 
 asmlinkage int m68k_vfork(struct pt_regs *regs)
 {
-	struct task_struct *p;
-	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, rdusp(), regs, 0, NULL,
-		    NULL);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, rdusp(), regs, 0,
+		       NULL, NULL);
 }
 
 asmlinkage int m68k_clone(struct pt_regs *regs)
 {
 	unsigned long clone_flags;
 	unsigned long newsp;
-	struct task_struct *p;
 	int *parent_tidptr, *child_tidptr;
 
 	/* syscall2 puts clone_flags in d1 and usp in d2 */
@@ -229,9 +224,8 @@
 	child_tidptr = (int *)regs->d4;
 	if (!newsp)
 		newsp = rdusp();
-	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, regs, 0,
-		    parent_tidptr, child_tidptr);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+	return do_fork(clone_flags & ~CLONE_IDLETASK, newsp, regs, 0,
+		       parent_tidptr, child_tidptr);
 }
 
 int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

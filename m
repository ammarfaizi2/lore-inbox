Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293209AbSB1WUI>; Thu, 28 Feb 2002 17:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293517AbSB1WSD>; Thu, 28 Feb 2002 17:18:03 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47113 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S310166AbSB1WO0>; Thu, 28 Feb 2002 17:14:26 -0500
Date: Thu, 28 Feb 2002 23:11:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: asmlinkage FASTCALL
Message-ID: <20020228221119.GA8434@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Well, asmlinkage is "__attribute__ regparm(0)", while fastcall is
"__attribute__ regparm(3)". If you mix them on gcc 3.1, you get nice
miscompilation. That should be fixed.

Index: arch/i386/kernel/signal.c
===================================================================
RCS file: /cvs/Repository/linux/arch/i386/kernel/signal.c,v
retrieving revision 1.3
diff -u -u -r1.3 signal.c
--- arch/i386/kernel/signal.c	2001/10/16 23:40:31	1.3
+++ arch/i386/kernel/signal.c	2002/02/28 22:11:41
@@ -28,7 +28,7 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-asmlinkage int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
+int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
 
 int copy_siginfo_to_user(siginfo_t *to, siginfo_t *from)
 {
Index: arch/i386/kernel/vm86.c
===================================================================
RCS file: /cvs/Repository/linux/arch/i386/kernel/vm86.c,v
retrieving revision 1.2
diff -u -u -r1.2 vm86.c
--- arch/i386/kernel/vm86.c	2001/07/21 13:03:51	1.2
+++ arch/i386/kernel/vm86.c	2002/02/28 22:11:41
@@ -62,7 +62,7 @@
         ( (unsigned)( & (((struct kernel_vm86_regs *)0)->VM86_REGS_PART2) ) )
 #define VM86_REGS_SIZE2 (sizeof(struct kernel_vm86_regs) - VM86_REGS_SIZE1)
 
-asmlinkage struct pt_regs * FASTCALL(save_v86_state(struct kernel_vm86_regs * regs));
+struct pt_regs * FASTCALL(save_v86_state(struct kernel_vm86_regs * regs));
 struct pt_regs * save_v86_state(struct kernel_vm86_regs * regs)
 {
 	struct tss_struct *tss;
Index: arch/s390/kernel/signal.c
===================================================================
RCS file: /cvs/Repository/linux/arch/s390/kernel/signal.c,v
retrieving revision 1.4
diff -u -u -r1.4 signal.c
--- arch/s390/kernel/signal.c	2001/10/24 23:58:45	1.4
+++ arch/s390/kernel/signal.c	2002/02/28 22:11:44
@@ -47,7 +47,7 @@
 	struct ucontext uc;
 } rt_sigframe;
 
-asmlinkage int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
+int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
 
 int copy_siginfo_to_user(siginfo_t *to, siginfo_t *from)
 {
Index: arch/s390x/kernel/signal.c
===================================================================
RCS file: /cvs/Repository/linux/arch/s390x/kernel/signal.c,v
retrieving revision 1.4
diff -u -u -r1.4 signal.c
--- arch/s390x/kernel/signal.c	2001/10/24 23:58:47	1.4
+++ arch/s390x/kernel/signal.c	2002/02/28 22:11:44
@@ -47,7 +47,7 @@
 	struct ucontext uc;
 } rt_sigframe;
 
-asmlinkage int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
+int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
 
 int copy_siginfo_to_user(siginfo_t *to, siginfo_t *from)
 {

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

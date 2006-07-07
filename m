Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWGGAko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWGGAko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWGGAj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:39:57 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:57539 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751114AbWGGAeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:34:15 -0400
Message-Id: <200607070033.k670Xevv008697@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 8/19] UML - ifdef a mode-specific function
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:40 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uml_idle_timer is tt-mode only, so ifdef it as such to make it easier
to spot when tt mode is killed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/kern_util.h
+++ linux-2.6.17/arch/um/include/kern_util.h
@@ -72,7 +72,6 @@ extern void init_flush_vm(void);
 extern void *syscall_sp(void *t);
 extern void syscall_trace(union uml_pt_regs *regs, int entryexit);
 extern int hz(void);
-extern void uml_idle_timer(void);
 extern unsigned int do_IRQ(int irq, union uml_pt_regs *regs);
 extern int external_pid(void *t);
 extern void interrupt_end(void);
Index: linux-2.6.17/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/time.c
+++ linux-2.6.17/arch/um/os-Linux/time.c
@@ -66,6 +66,7 @@ void switch_timers(int to_real)
 		       errno);
 }
 
+#ifdef UML_CONFIG_MODE_TT
 void uml_idle_timer(void)
 {
 	if(signal(SIGVTALRM, SIG_IGN) == SIG_ERR)
@@ -75,6 +76,7 @@ void uml_idle_timer(void)
 		    SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
 	set_interval(ITIMER_REAL);
 }
+#endif
 
 unsigned long long os_nsecs(void)
 {


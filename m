Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWHBT7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWHBT7M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWHBT7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:59:12 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:4996 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932210AbWHBT66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:58:58 -0400
Message-Id: <200608021958.k72JwMmp006002@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/4] UML - Remove unused variable
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Aug 2006 15:58:22 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

timer_irq_inited was useless, so it is removed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-rc2-mm1/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/include/kern_util.h	2006-08-02 15:53:09.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/include/kern_util.h	2006-08-02 15:53:42.000000000 -0400
@@ -27,7 +27,6 @@ extern int ncpus;
 extern char *linux_prog;
 extern char *gdb_init;
 extern int kmalloc_ok;
-extern int timer_irq_inited;
 extern int jail;
 extern int nsyscalls;
 
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/signal.c	2006-08-02 15:53:39.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/signal.c	2006-08-02 15:53:42.000000000 -0400
@@ -55,15 +55,8 @@ void sig_handler(int sig, struct sigcont
 	set_signals(enabled);
 }
 
-extern int timer_irq_inited;
-
 static void real_alarm_handler(int sig, struct sigcontext *sc)
 {
-	if(!timer_irq_inited){
-		signals_enabled = 1;
-		return;
-	}
-
 	if(sig == SIGALRM)
 		switch_timers(0);
 
Index: linux-2.6.18-rc2-mm1/arch/um/kernel/time.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/kernel/time.c	2006-08-02 15:53:41.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/kernel/time.c	2006-08-02 15:53:42.000000000 -0400
@@ -35,9 +35,6 @@ unsigned long long sched_clock(void)
 	return (unsigned long long)jiffies_64 * (1000000000 / HZ);
 }
 
-/* Changed at early boot */
-int timer_irq_inited = 0;
-
 static unsigned long long prev_nsecs;
 #ifdef CONFIG_UML_REAL_TIME_CLOCK
 static long long delta;   		/* Deviation per interval */
@@ -116,8 +113,6 @@ static void register_timer(void)
 		printk(KERN_ERR "register_timer : request_irq failed - "
 		       "errno = %d\n", -err);
 
-	timer_irq_inited = 1;
-
 	err = set_interval(1);
 	if(err != 0)
 		printk(KERN_ERR "register_timer : set_interval failed - "


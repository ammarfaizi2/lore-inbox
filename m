Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbTENETW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 00:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTENETW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 00:19:22 -0400
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139]:47346 "EHLO
	heavens.murgatroid.com") by vger.kernel.org with ESMTP
	id S261184AbTENETU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 00:19:20 -0400
Date: Tue, 13 May 2003 21:32:07 -0700
From: Christopher Hoover <ch@murgatroid.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.68 FUTEX support should be optional
Message-ID: <20030513213157.A1063@heavens.murgatroid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not everyone needs futex support, so it should be optional.  This is
needed for small platforms.

-ch
mailto:ch(at)murgatroid.com
mailto:ch(at)hpl.hp.com

diff -X dontdiff.txt -Naurp linux-2.5.68-rmk1/kernel/Makefile linux-2.5.68-rmk1-ceiva1/kernel/Makefile
--- linux-2.5.68-rmk1/kernel/Makefile	2003-04-19 19:48:55.000000000 -0700
+++ linux-2.5.68-rmk1-ceiva1/kernel/Makefile	2003-05-13 20:58:54.000000000 -0700
@@ -5,9 +5,10 @@
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o workqueue.o futex.o pid.o \
+	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
 
+obj-$(CONFIG_FUTEXT) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
 obj-$(CONFIG_UID16) += uid16.o
diff -X dontdiff.txt -Naurp linux-2.5.68-rmk1/kernel/sys.c linux-2.5.68-rmk1-ceiva1/kernel/sys.c
--- linux-2.5.68-rmk1/kernel/sys.c	2003-04-19 19:48:51.000000000 -0700
+++ linux-2.5.68-rmk1-ceiva1/kernel/sys.c	2003-05-13 21:06:02.000000000 -0700
@@ -226,6 +226,7 @@ cond_syscall(sys_shutdown)
 cond_syscall(sys_sendmsg)
 cond_syscall(sys_recvmsg)
 cond_syscall(sys_socketcall)
+cond_syscall(sys_futex)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
diff -X dontdiff.txt -Naurp linux-2.5.68-rmk1/init/Kconfig linux-2.5.68-rmk1-ceiva1/init/Kconfig
--- linux-2.5.68-rmk1/init/Kconfig	2003-04-19 19:50:38.000000000 -0700
+++ linux-2.5.68-rmk1-ceiva1/init/Kconfig	2003-05-13 21:25:39.000000000 -0700
@@ -108,8 +108,14 @@ config LOG_BUF_SHIFT
 		     13 =>  8 KB
 		     12 =>  4 KB
 
-endmenu
 
+config FUTEX
+       bool "Futex support"
+       default y
+       ---help---
+       Say Y if you want support for Fast Userspace Mutexes (Futexes).
+
+endmenu
 
 menu "Loadable module support"
 

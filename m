Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbTGAFcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 01:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTGAFcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 01:32:18 -0400
Received: from dp.samba.org ([66.70.73.150]:62597 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265974AbTGAFcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 01:32:13 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] Get rid of __syscall_count.
Date: Tue, 01 Jul 2003 15:36:25 +1000
Message-Id: <20030701054635.A2D532C0B1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply, unless someone has plans for this field.

Noone seems to use __syscall_count.  Remove the field from i386
irq_cpustat_t struct, and the generic accessor macros.

Because some archs have hardcoded asm references to offsets in this
structure, I haven't touched non-x86, but doing so is usually
trivial.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Remove unused __syscall_count from irq_stat struct.
Author: Rusty Russell
Status: Tested on 2.5.73-bk8

D: Noone seems to use __syscall_count.  Remove the field from i386
D: irq_cpustat_t struct, and the generic accessor macros.
D: 
D: Because some archs have hardcoded asm references to offsets in this
D: structure, I haven't touched non-x86, but doing so is usually
D: trivial.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2143-linux-2.5.73-bk8/include/asm-i386/hardirq.h .2143-linux-2.5.73-bk8.updated/include/asm-i386/hardirq.h
--- .2143-linux-2.5.73-bk8/include/asm-i386/hardirq.h	2003-04-08 11:14:55.000000000 +1000
+++ .2143-linux-2.5.73-bk8.updated/include/asm-i386/hardirq.h	2003-07-01 13:49:21.000000000 +1000
@@ -7,7 +7,6 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
 	unsigned long idle_timestamp;
 	unsigned int __nmi_count;	/* arch dependent */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2143-linux-2.5.73-bk8/include/linux/irq_cpustat.h .2143-linux-2.5.73-bk8.updated/include/linux/irq_cpustat.h
--- .2143-linux-2.5.73-bk8/include/linux/irq_cpustat.h	2003-06-15 11:30:08.000000000 +1000
+++ .2143-linux-2.5.73-bk8.updated/include/linux/irq_cpustat.h	2003-07-01 13:48:58.000000000 +1000
@@ -29,8 +29,6 @@ extern irq_cpustat_t irq_stat[];		/* def
   /* arch independent irq_stat fields */
 #define softirq_pending(cpu)	__IRQ_STAT((cpu), __softirq_pending)
 #define local_softirq_pending()	softirq_pending(smp_processor_id())
-#define syscall_count(cpu)	__IRQ_STAT((cpu), __syscall_count)
-#define local_syscall_count()	syscall_count(smp_processor_id())
 #define ksoftirqd_task(cpu)	__IRQ_STAT((cpu), __ksoftirqd_task)
 #define local_ksoftirqd_task()	ksoftirqd_task(smp_processor_id())
 

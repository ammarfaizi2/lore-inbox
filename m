Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265537AbTGCHyG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 03:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbTGCHyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 03:54:05 -0400
Received: from dp.samba.org ([66.70.73.150]:30445 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265537AbTGCHyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 03:54:02 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Remove unused __syscall_count from irq_cpustat_t. 
In-reply-to: Your message of "Thu, 03 Jul 2003 00:38:06 MST."
             <Pine.LNX.4.44.0307030035420.8776-100000@home.osdl.org> 
Date: Thu, 03 Jul 2003 18:08:02 +1000
Message-Id: <20030703080829.2EB7F2C0CB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0307030035420.8776-100000@home.osdl.org> you write:
> 
> On Thu, 3 Jul 2003, Rusty Russell wrote:
> >
> > Linus, please apply.  Small diff overlap with previous patch, and next
> > patch.
> 
> This arrived in the wrong order, and because it was dependent on another 
> patch, and there was no explicit ordering, it didn't apply.

As ordered, here is 1/4:

Noone seems to use __syscall_count.  Remove the field from i386
irq_cpustat_t struct, and the generic accessor macros.

Because some archs have hardcoded asm references to offsets in this
structure, I haven't touched non-x86, but doing so is usually
trivial.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Remove unused __syscall_count from irq_stat struct.
Author: Rusty Russell
Status: Tested on 2.5.74

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
 

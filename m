Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSHaFRp>; Sat, 31 Aug 2002 01:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316199AbSHaFRo>; Sat, 31 Aug 2002 01:17:44 -0400
Received: from dp.samba.org ([66.70.73.150]:29323 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S316088AbSHaFRo>;
	Sat, 31 Aug 2002 01:17:44 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.32-smph 
In-reply-to: Your message of "Fri, 30 Aug 2002 22:39:15 +0100."
             <E17ktU3-00035O-00@flint.arm.linux.org.uk> 
Date: Sat, 31 Aug 2002 15:21:24 +1000
Message-Id: <20020831002231.196252C095@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E17ktU3-00035O-00@flint.arm.linux.org.uk> you write:
> This patch appears not to be in 2.5.32, but applies cleanly.
> 
> Use of cpu_online on UP causes the following warnings:
> 
> page_alloc.c:555: warning: statement with no effect
> proc_misc.c:297: warning: statement with no effect
> proc_misc.c:313: warning: statement with no effect
> dev.c:1824: warning: statement with no effect
> 
> This patch fixes these warnings.

I prefer this fix, which also adds cpu_possible(i) for UP.

Name: cpu_possible for UP
Author: Rusty Russell
Status: Trivial

D: This patch defines cpu_possible() for non-SMP.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.32/include/linux/smp.h working-2.5.32-cpu-possible/include/linux/smp.h
--- linux-2.5.32/include/linux/smp.h	2002-08-28 09:29:53.000000000 +1000
+++ working-2.5.32-cpu-possible/include/linux/smp.h	2002-08-29 15:30:49.000000000 +1000
@@ -94,9 +94,10 @@ int cpu_up(unsigned int cpu);
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
 #define cpu_online_map				1
-#define cpu_online(cpu)				({ cpu; 1; })
+#define cpu_online(cpu)				({ BUG_ON((cpu) != 0); 1; })
 #define num_online_cpus()			1
 #define num_booting_cpus()			1
+#define cpu_possible(i)				({ BUG_ON((cpu) != 0); 1; })
 
 struct notifier_block;
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319115AbSH2GtZ>; Thu, 29 Aug 2002 02:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319116AbSH2GtZ>; Thu, 29 Aug 2002 02:49:25 -0400
Received: from dp.samba.org ([66.70.73.150]:57261 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319115AbSH2GtX>;
	Thu, 29 Aug 2002 02:49:23 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.5.32-mm1 
In-reply-to: Your message of "Wed, 28 Aug 2002 19:54:24 MST."
             <3D6D8CE0.D454ED66@zip.com.au> 
Date: Thu, 29 Aug 2002 16:19:27 +1000
Message-Id: <20020829015407.816FA2C0E3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D6D8CE0.D454ED66@zip.com.au> you write:
> I just deleted the cpu_possible() test - changed it to loop
> across NR_CPUS.

Still, it's a good idea to have a UP version, and fix that naked
reference to "cpu" in cpu_online() which just makes me damn nervous.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

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
 

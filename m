Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSIACvI>; Sat, 31 Aug 2002 22:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSIACvI>; Sat, 31 Aug 2002 22:51:08 -0400
Received: from dp.samba.org ([66.70.73.150]:59056 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S312590AbSIACvI>;
	Sat, 31 Aug 2002 22:51:08 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Milton D. Miller II" <miltonm@realtime.net>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.5.32-mm1 
In-reply-to: Your message of "Sat, 31 Aug 2002 03:24:43 EST."
             <200208310824.g7V8OhK11791@sullivan.realtime.net> 
Date: Sun, 01 Sep 2002 12:54:01 +1000
Message-Id: <20020831215556.898752C06A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200208310824.g7V8OhK11791@sullivan.realtime.net> you write:
> 
> In your patch, you have:
> 
> +#define cpu_possible(i)				({ BUG_ON((cpu) != 0); 
1; })
> 
> 
> Shouldn't the cpu match the i in the arg list?

Err.. no, I was just checking how many people read my patches.

Linus, please apply,
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
+#define cpu_possible(cpu)				({ BUG_ON((cpu) != 0); 1; })
 
 struct notifier_block;
 

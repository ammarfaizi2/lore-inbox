Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314394AbSDWB7H>; Mon, 22 Apr 2002 21:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315009AbSDWB7G>; Mon, 22 Apr 2002 21:59:06 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:55566 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314394AbSDWB7F>; Mon, 22 Apr 2002 21:59:05 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.9 per-cpu-areas ONCE AND FOR ALL
Date: Tue, 23 Apr 2002 12:02:13 +1000
Message-Id: <E16zpdF-00026Y-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the correct patch.  Do NOT apply any lesser imitations!

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.9/init/main.c working-2.5.9-percpu/init/main.c
--- linux-2.5.9/init/main.c	Tue Apr 23 11:39:40 2002
+++ working-2.5.9-percpu/init/main.c	Tue Apr 23 12:00:14 2002
@@ -274,12 +274,7 @@
 static inline void setup_per_cpu_areas(void)
 {
 }
-
-static inline void setup_per_cpu_areas(void)
-{
-}
-
-#else
+#else /* CONFIG_SMP... */
 
 #ifdef __GENERIC_PER_CPU
 unsigned long __per_cpu_offset[NR_CPUS];
@@ -315,7 +310,7 @@
 	smp_commence();
 }
 
-#endif
+#endif /* CONFIG_SMP */
 
 /*
  * We need to finalize in a non-__init function or else race conditions

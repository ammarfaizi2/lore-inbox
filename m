Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbTISIep (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 04:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbTISIep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 04:34:45 -0400
Received: from hydra.colinet.de ([194.231.113.36]:52102 "EHLO hydra.colinet.de")
	by vger.kernel.org with ESMTP id S261432AbTISIen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 04:34:43 -0400
Date: Fri, 19 Sep 2003 11:28:31 +0200 (CEST)
From: "T. Weyergraf" <kirk@colinet.de>
Subject: [PATCH] 2.6.0-test5 Alpha/SMP build fix
To: linux-kernel@vger.kernel.org
cc: rth@twiddle.net, kirk@colinet.de
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E1A0HZG-0007f7-00@hydra.colinet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the following patch fixes the build of 2.6.0-test5 on Alpha/SMP.
It is trivial and has been forwarded to $MAINTAINER.


Regards,
Thomas Weyergraf


diff -Naur linux-2.6.0-test5/arch/alpha/kernel/setup.c linux-2.6.0-test5-kirk1/arch/alpha/kernel/setup.c
--- linux-2.6.0-test5/arch/alpha/kernel/setup.c	2003-09-08 21:49:54.000000000 +0200
+++ linux-2.6.0-test5-kirk1/arch/alpha/kernel/setup.c	2003-09-19 09:09:03.000000000 +0200
@@ -1203,7 +1203,7 @@
 		       platform_string(), nr_processors);
 
 #ifdef CONFIG_SMP
-	seq_printf(f, "cpus active\t\t: %d\n"
+    seq_printf(f, "cpus active\t\t: %ld\n"
 		      "cpu active mask\t\t: %016lx\n",
 		       num_online_cpus(), cpu_present_mask);
 #endif
diff -Naur linux-2.6.0-test5/arch/alpha/kernel/smp.c linux-2.6.0-test5-kirk1/arch/alpha/kernel/smp.c
--- linux-2.6.0-test5/arch/alpha/kernel/smp.c	2003-09-08 21:49:58.000000000 +0200
+++ linux-2.6.0-test5-kirk1/arch/alpha/kernel/smp.c	2003-09-19 09:09:30.000000000 +0200
@@ -597,7 +597,7 @@
 		if (cpu_online(cpu))
 			bogosum += cpu_data[cpu].loops_per_jiffy;
 	
-	printk(KERN_INFO "SMP: Total of %d processors activated "
+	printk(KERN_INFO "SMP: Total of %ld processors activated "
 	       "(%lu.%02lu BogoMIPS).\n",
 	       num_online_cpus(), 
 	       (bogosum + 2500) / (500000/HZ),
diff -Naur linux-2.6.0-test5/include/asm-alpha/smp.h linux-2.6.0-test5-kirk1/include/asm-alpha/smp.h
--- linux-2.6.0-test5/include/asm-alpha/smp.h	2003-09-08 21:50:28.000000000 +0200
+++ linux-2.6.0-test5-kirk1/include/asm-alpha/smp.h	2003-09-19 09:09:41.000000000 +0200
@@ -46,7 +46,7 @@
 #define smp_processor_id()	(current_thread_info()->cpu)
 
 extern cpumask_t cpu_present_mask;
-extern cpumask_t long cpu_online_map;
+extern cpumask_t cpu_online_map;
 extern int smp_num_cpus;
 
 #define cpu_possible(cpu)	cpu_isset(cpu, cpu_present_mask)


--  
Thomas Weyergraf                                     kirk@colinet.de
Funny IA64 Opcode Dept: ( see arch/ia64/lib/memset.S )
"br.ret.spnt.few" - got back from getting beer, did not spend a lot.


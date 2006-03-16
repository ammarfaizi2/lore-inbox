Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWCPDf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWCPDf0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWCPDf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:35:26 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:56746 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932309AbWCPDfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:35:25 -0500
Date: Thu, 16 Mar 2006 12:34:13 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [14/19] s390
Message-Id: <20060316123413.0beb2dac.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: linux-2.6.16-rc6-mm1/arch/s390/kernel/smp.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/s390/kernel/smp.c
+++ linux-2.6.16-rc6-mm1/arch/s390/kernel/smp.c
@@ -799,7 +799,7 @@ void __init smp_prepare_cpus(unsigned in
          */
 	print_cpu_info(&S390_lowcore.cpu_data);
 
-        for_each_cpu(i) {
+        for_each_possible_cpu(i) {
 		lowcore_ptr[i] = (struct _lowcore *)
 			__get_free_pages(GFP_KERNEL|GFP_DMA, 
 					sizeof(void*) == 8 ? 1 : 0);
@@ -829,7 +829,7 @@ void __init smp_prepare_cpus(unsigned in
 #endif
 	set_prefix((u32)(unsigned long) lowcore_ptr[smp_processor_id()]);
 
-	for_each_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		if (cpu != smp_processor_id())
 			smp_create_idle(cpu);
 }
@@ -866,7 +866,7 @@ static int __init topology_init(void)
 	int cpu;
 	int ret;
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		ret = register_cpu(&per_cpu(cpu_devices, cpu), cpu, NULL);
 		if (ret)
 			printk(KERN_WARNING "topology_init: register_cpu %d "
Index: linux-2.6.16-rc6-mm1/include/asm-s390/percpu.h
===================================================================
--- linux-2.6.16-rc6-mm1.orig/include/asm-s390/percpu.h
+++ linux-2.6.16-rc6-mm1/include/asm-s390/percpu.h
@@ -46,7 +46,7 @@ extern unsigned long __per_cpu_offset[NR
 #define percpu_modcopy(pcpudst, src, size)			\
 do {								\
 	unsigned int __i;					\
-	for_each_cpu(__i)					\
+	for_each_possible_cpu(__i)				\
 		memcpy((pcpudst)+__per_cpu_offset[__i],		\
 		       (src), (size));				\
 } while (0)

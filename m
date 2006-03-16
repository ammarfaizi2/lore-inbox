Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWCPDiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWCPDiM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWCPDiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:38:12 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:57260 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932341AbWCPDiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:38:11 -0500
Date: Thu, 16 Mar 2006 12:36:33 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [17/19] sparc64
Message-Id: <20060316123633.1db77d53.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu.
for sparc64.

 arch/sparc64/kernel/pci_sun4v.c |    2 +-
 arch/sparc64/kernel/setup.c     |    2 +-
 arch/sparc64/kernel/smp.c       |    6 +++---
 include/asm-sparc64/percpu.h    |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc6-mm1/arch/sparc64/kernel/smp.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/sparc64/kernel/smp.c
+++ linux-2.6.16-rc6-mm1/arch/sparc64/kernel/smp.c
@@ -1278,7 +1278,7 @@ int setup_profiling_timer(unsigned int m
 		return -EINVAL;
 
 	spin_lock_irqsave(&prof_setup_lock, flags);
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		prof_multiplier(i) = multiplier;
 	current_tick_offset = (timer_tick_offset / multiplier);
 	spin_unlock_irqrestore(&prof_setup_lock, flags);
@@ -1305,12 +1305,12 @@ void __init smp_prepare_cpus(unsigned in
 		}
 	}
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		if (tlb_type == hypervisor) {
 			int j;
 
 			/* XXX get this mapping from machine description */
-			for_each_cpu(j) {
+			for_each_possible_cpu(j) {
 				if ((j >> 2) == (i >> 2))
 					cpu_set(j, cpu_sibling_map[i]);
 			}
Index: linux-2.6.16-rc6-mm1/arch/sparc64/kernel/pci_sun4v.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/sparc64/kernel/pci_sun4v.c
+++ linux-2.6.16-rc6-mm1/arch/sparc64/kernel/pci_sun4v.c
@@ -1092,7 +1092,7 @@ void sun4v_pci_init(int node, char *mode
 		}
 	}
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		unsigned long page = get_zeroed_page(GFP_ATOMIC);
 
 		if (!page)
Index: linux-2.6.16-rc6-mm1/arch/sparc64/kernel/setup.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/sparc64/kernel/setup.c
+++ linux-2.6.16-rc6-mm1/arch/sparc64/kernel/setup.c
@@ -535,7 +535,7 @@ static int __init topology_init(void)
 	while (!cpu_find_by_instance(ncpus_probed, NULL, NULL))
 		ncpus_probed++;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		struct cpu *p = kzalloc(sizeof(*p), GFP_KERNEL);
 		if (p) {
 			register_cpu(p, i, NULL);
Index: linux-2.6.16-rc6-mm1/include/asm-sparc64/percpu.h
===================================================================
--- linux-2.6.16-rc6-mm1.orig/include/asm-sparc64/percpu.h
+++ linux-2.6.16-rc6-mm1/include/asm-sparc64/percpu.h
@@ -26,7 +26,7 @@ register unsigned long __local_per_cpu_o
 #define percpu_modcopy(pcpudst, src, size)			\
 do {								\
 	unsigned int __i;					\
-	for_each_cpu(__i)					\
+	for_each_possible_cpu(__i)				\
 		memcpy((pcpudst)+__per_cpu_offset(__i),		\
 		       (src), (size));				\
 } while (0)

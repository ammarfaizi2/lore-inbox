Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266419AbTGEVum (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 17:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266422AbTGEVum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 17:50:42 -0400
Received: from c180224.adsl.hansenet.de ([213.39.180.224]:23752 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S266419AbTGEVul
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 17:50:41 -0400
To: akpm@osdl.org
Subject: [PATCH] Fix compilation of apm.c due to cpumask conversion
Cc: linux-kernel@vger.kernel.org
Message-Id: <E19Yv9U-0004Qa-00@sfhq.hn.org>
From: Jan Dittmer <jdittmer@sfhq.hn.org>
Date: Sun, 06 Jul 2003 00:05:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This converts i386/kernel/apm.c to cpumask_t (applies also to mm2)

Thanks,

Jan

--- linux-mm/arch/i386/kernel/apm.c	Thu Jul  3 14:49:29 2003
+++ 2.5.74-mm1/arch/i386/kernel/apm.c	Sat Jul  5 23:52:59 2003
@@ -508,16 +508,16 @@
  
 #ifdef CONFIG_SMP
 
-static unsigned long apm_save_cpus(void)
+static cpumask_t apm_save_cpus(void)
 {
-	unsigned long x = current->cpus_allowed;
+	cpumask_t x = current->cpus_allowed;
 	/* Some bioses don't like being called from CPU != 0 */
-	set_cpus_allowed(current, 1UL << 0);
+	set_cpus_allowed(current, cpumask_of_cpu(0));
 	BUG_ON(smp_processor_id() != 0);
 	return x;
 }
 
-static inline void apm_restore_cpus(unsigned long mask)
+static inline void apm_restore_cpus(cpumask_t mask)
 {
 	set_cpus_allowed(current, mask);
 }
@@ -593,7 +593,7 @@
 {
 	APM_DECL_SEGS
 	unsigned long		flags;
-	unsigned long		cpus;
+	cpumask_t		cpus;
 	int			cpu;
 	struct desc_struct	save_desc_40;
 
@@ -635,7 +635,7 @@
 	u8			error;
 	APM_DECL_SEGS
 	unsigned long		flags;
-	unsigned long		cpus;
+	cpumask_t		cpus;
 	int			cpu;
 	struct desc_struct	save_desc_40;
 
@@ -913,7 +913,7 @@
 	 */
 #ifdef CONFIG_SMP
 	/* Some bioses don't like being called from CPU != 0 */
-	set_cpus_allowed(current, 1UL << 0);
+	set_cpus_allowed(current, cpumask_of_cpu(0));
 	BUG_ON(smp_processor_id() != 0);
 #endif
 	if (apm_info.realmode_power_off)
@@ -1704,7 +1704,7 @@
 	 * Some bioses don't like being called from CPU != 0.
 	 * Method suggested by Ingo Molnar.
 	 */
-	set_cpus_allowed(current, 1UL << 0);
+	set_cpus_allowed(current, cpumask_of_cpu(0));
 	BUG_ON(smp_processor_id() != 0);
 #endif
 

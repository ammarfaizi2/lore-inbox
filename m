Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVANVjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVANVjf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVANViz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:38:55 -0500
Received: from fmr24.intel.com ([143.183.121.16]:2247 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262058AbVANVgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:36:10 -0500
Date: Fri, 14 Jan 2005 13:36:02 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [Patch] x86: use cpumask_t instead of unsigned long
Message-ID: <20050114133602.A13523@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current code can lead to corruption. Please apply the fix.

thanks,
suresh
--

Use cpumask_t instead of unsigned long.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>


diff -Nru linux-2.6.10/arch/i386/kernel/cpu/common.c linux-cpumask/arch/i386/kernel/cpu/common.c
--- linux-2.6.10/arch/i386/kernel/cpu/common.c	2004-12-24 13:33:50.000000000 -0800
+++ linux-cpumask/arch/i386/kernel/cpu/common.c	2005-01-14 11:45:39.876089160 -0800
@@ -455,7 +455,7 @@
 		printk("\n");
 }
 
-unsigned long cpu_initialized __initdata = 0;
+cpumask_t cpu_initialized __initdata = CPU_MASK_NONE;
 
 /* This is hacky. :)
  * We're emulating future behavior.
@@ -509,7 +509,7 @@
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
 
-	if (test_and_set_bit(cpu, &cpu_initialized)) {
+	if (cpu_test_and_set(cpu, cpu_initialized)) {
 		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
 		for (;;) local_irq_enable();
 	}

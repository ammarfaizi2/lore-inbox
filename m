Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbUKSAXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbUKSAXS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 19:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUKSAVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 19:21:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41738 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261211AbUKSATU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 19:19:20 -0500
Date: Fri, 19 Nov 2004 01:19:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: davidm@hpl.hp.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] IA64 irq.c: remove CONFIG_X86 code
Message-ID: <20041119001915.GL4943@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see hos this code could ever be used.

Am I correct or did I miss something?


diffstat output:
 arch/ia64/kernel/irq.c |   33 ---------------------------------
 1 files changed, 33 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.10-rc2-mm2-full/arch/ia64/kernel/irq.c.old	2004-11-19 01:14:22.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/arch/ia64/kernel/irq.c	2004-11-19 01:16:31.000000000 +0100
@@ -132,23 +132,7 @@
  * each architecture has to answer this themselves, it doesn't deserve
  * a generic callback i think.
  */
-#ifdef CONFIG_X86
-	printk(KERN_ERR "unexpected IRQ trap at vector %02x\n", irq);
-#ifdef CONFIG_X86_LOCAL_APIC
-	/*
-	 * Currently unexpected vectors happen only on SMP and APIC.
-	 * We _must_ ack these because every local APIC has only N
-	 * irq slots per priority level, and a 'hanging, unacked' IRQ
-	 * holds up an irq slot - in excessive cases (when multiple
-	 * unexpected vectors occur) that might lock up the APIC
-	 * completely.
-	 */
-	ack_APIC_irq();
-#endif
-#endif
-#ifdef CONFIG_IA64
 	printk(KERN_ERR "Unexpected irq vector 0x%x on CPU %u!\n", irq, smp_processor_id());
-#endif
 }
 
 /* startup is the same as "enable", shutdown is same as "disable" */
@@ -166,11 +150,6 @@
 };
 
 atomic_t irq_err_count;
-#ifdef CONFIG_X86_IO_APIC
-#ifdef APIC_MISMATCH_DEBUG
-atomic_t irq_mis_count;
-#endif
-#endif
 
 /*
  * Generic, controller-independent functions:
@@ -220,19 +199,7 @@
 			if (cpu_online(j))
 				seq_printf(p, "%10u ", nmi_count(j));
 		seq_putc(p, '\n');
-#ifdef CONFIG_X86_LOCAL_APIC
-		seq_puts(p, "LOC: ");
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);
-		seq_putc(p, '\n');
-#endif
 		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
-#ifdef CONFIG_X86_IO_APIC
-#ifdef APIC_MISMATCH_DEBUG
-		seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
-#endif
-#endif
 	}
 	return 0;
 }

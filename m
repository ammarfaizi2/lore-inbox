Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVAUKkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVAUKkd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 05:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVAUKkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 05:40:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5650 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262333AbVAUKjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 05:39:32 -0500
Date: Fri, 21 Jan 2005 11:39:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] unexport *flush_tlb_all
Message-ID: <20050121103926.GJ3209@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

flush_tlb_all was exported on i386 for a DRM usage - that was removed
in 2003.

I haven't found any modular usage of *flush_tlb_all in the kernel.

This patch was tested only on i386, please report if I missed a modular 
usage on other architectures.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/alpha/kernel/alpha_ksyms.c  |    1 -
 arch/i386/kernel/i386_ksyms.c    |    1 -
 arch/ia64/kernel/smp.c           |    1 -
 arch/ia64/mm/tlb.c               |    1 -
 arch/m32r/kernel/m32r_ksyms.c    |    1 -
 arch/x86_64/kernel/x8664_ksyms.c |    1 -
 6 files changed, 6 deletions(-)

--- linux-2.6.11-rc1-mm2-full/arch/i386/kernel/i386_ksyms.c.old	2005-01-21 11:23:26.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/i386/kernel/i386_ksyms.c	2005-01-21 11:25:59.000000000 +0100
@@ -144,7 +144,6 @@
 
 /* TLB flushing */
 EXPORT_SYMBOL(flush_tlb_page);
-EXPORT_SYMBOL_GPL(flush_tlb_all);
 #endif
 
 #ifdef CONFIG_X86_IO_APIC
--- linux-2.6.11-rc1-mm2-full/arch/ia64/kernel/smp.c.old	2005-01-21 11:26:20.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/ia64/kernel/smp.c	2005-01-21 11:26:55.000000000 +0100
@@ -227,7 +227,6 @@
 {
 	on_each_cpu((void (*)(void *))local_flush_tlb_all, NULL, 1, 1);
 }
-EXPORT_SYMBOL(smp_flush_tlb_all);
 
 void
 smp_flush_tlb_mm (struct mm_struct *mm)
--- linux-2.6.11-rc1-mm2-full/arch/ia64/mm/tlb.c.old	2005-01-21 11:27:34.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/ia64/mm/tlb.c	2005-01-21 11:27:42.000000000 +0100
@@ -127,7 +127,6 @@
 	local_irq_restore(flags);
 	ia64_srlz_i();			/* srlz.i implies srlz.d */
 }
-EXPORT_SYMBOL(local_flush_tlb_all);
 
 void
 flush_tlb_range (struct vm_area_struct *vma, unsigned long start, unsigned long end)
--- linux-2.6.11-rc1-mm2-full/arch/alpha/kernel/alpha_ksyms.c.old	2005-01-21 11:27:49.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/alpha/kernel/alpha_ksyms.c	2005-01-21 11:27:54.000000000 +0100
@@ -176,7 +176,6 @@
 
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(synchronize_irq);
-EXPORT_SYMBOL(flush_tlb_all);
 EXPORT_SYMBOL(flush_tlb_mm);
 EXPORT_SYMBOL(flush_tlb_range);
 EXPORT_SYMBOL(flush_tlb_page);
--- linux-2.6.11-rc1-mm2-full/arch/m32r/kernel/m32r_ksyms.c.old	2005-01-21 11:28:01.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/m32r/kernel/m32r_ksyms.c	2005-01-21 11:28:06.000000000 +0100
@@ -76,7 +76,6 @@
 
 /* TLB flushing */
 EXPORT_SYMBOL(smp_flush_tlb_page);
-EXPORT_SYMBOL_GPL(smp_flush_tlb_all);
 #endif
 
 /* compiler generated symbol */
--- linux-2.6.11-rc1-mm2-full/arch/x86_64/kernel/x8664_ksyms.c.old	2005-01-21 11:28:13.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/x86_64/kernel/x8664_ksyms.c	2005-01-21 11:28:18.000000000 +0100
@@ -218,7 +218,6 @@
 
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(flush_tlb_page);
-EXPORT_SYMBOL_GPL(flush_tlb_all);
 #endif
 
 EXPORT_SYMBOL(cpu_khz);

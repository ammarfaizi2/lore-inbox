Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVAVJoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVAVJoM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 04:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVAVJoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 04:44:12 -0500
Received: from ozlabs.org ([203.10.76.45]:36996 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261234AbVAVJoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 04:44:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16882.8276.537404.194554@cargo.ozlabs.ibm.com>
Date: Sat, 22 Jan 2005 20:43:48 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: anton@samba.org, nathanl@austin.ibm.com
Subject: [PATCH] PPC64 sparse fixes for cpu feature constants
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is originally from Nathan Lynch <nathanl@austin.ibm.com>.

Sparse gives a warning "constant ... is so big it is long" for every
expression where we check bits in the cur_cpu_spec->cpu_features
value.  This patch removes the warnings by using the ASM_CONST macro.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/include/asm-ppc64/cacheflush.h test/include/asm-ppc64/cacheflush.h
--- linux-2.5/include/asm-ppc64/cacheflush.h	2004-05-31 19:02:01.000000000 +1000
+++ test/include/asm-ppc64/cacheflush.h	2005-01-22 20:13:46.000000000 +1100
@@ -40,7 +40,7 @@
 
 static inline void flush_icache_range(unsigned long start, unsigned long stop)
 {
-	if (!(cur_cpu_spec->cpu_features & ASM_CONST(CPU_FTR_COHERENT_ICACHE)))
+	if (!(cur_cpu_spec->cpu_features & CPU_FTR_COHERENT_ICACHE))
 		__flush_icache_range(start, stop);
 }
 
diff -urN linux-2.5/include/asm-ppc64/cputable.h test/include/asm-ppc64/cputable.h
--- linux-2.5/include/asm-ppc64/cputable.h	2004-06-28 14:30:55.000000000 +1000
+++ test/include/asm-ppc64/cputable.h	2005-01-22 20:13:46.000000000 +1100
@@ -16,6 +16,7 @@
 #define __ASM_PPC_CPUTABLE_H
 
 #include <linux/config.h>
+#include <asm/page.h> /* for ASM_CONST */
 
 /* Exposed to userland CPU features - Must match ppc32 definitions */
 #define PPC_FEATURE_32			0x80000000
@@ -103,38 +104,38 @@
 /* CPU kernel features */
 
 /* Retain the 32b definitions for the time being - use bottom half of word */
-#define CPU_FTR_SPLIT_ID_CACHE		0x0000000000000001
-#define CPU_FTR_L2CR			0x0000000000000002
-#define CPU_FTR_SPEC7450		0x0000000000000004
-#define CPU_FTR_ALTIVEC			0x0000000000000008
-#define CPU_FTR_TAU			0x0000000000000010
-#define CPU_FTR_CAN_DOZE		0x0000000000000020
-#define CPU_FTR_USE_TB			0x0000000000000040
-#define CPU_FTR_604_PERF_MON		0x0000000000000080
-#define CPU_FTR_601			0x0000000000000100
-#define CPU_FTR_HPTE_TABLE		0x0000000000000200
-#define CPU_FTR_CAN_NAP			0x0000000000000400
-#define CPU_FTR_L3CR			0x0000000000000800
-#define CPU_FTR_L3_DISABLE_NAP		0x0000000000001000
-#define CPU_FTR_NAP_DISABLE_L2_PR	0x0000000000002000
-#define CPU_FTR_DUAL_PLL_750FX		0x0000000000004000
+#define CPU_FTR_SPLIT_ID_CACHE		ASM_CONST(0x0000000000000001)
+#define CPU_FTR_L2CR			ASM_CONST(0x0000000000000002)
+#define CPU_FTR_SPEC7450		ASM_CONST(0x0000000000000004)
+#define CPU_FTR_ALTIVEC			ASM_CONST(0x0000000000000008)
+#define CPU_FTR_TAU			ASM_CONST(0x0000000000000010)
+#define CPU_FTR_CAN_DOZE		ASM_CONST(0x0000000000000020)
+#define CPU_FTR_USE_TB			ASM_CONST(0x0000000000000040)
+#define CPU_FTR_604_PERF_MON		ASM_CONST(0x0000000000000080)
+#define CPU_FTR_601			ASM_CONST(0x0000000000000100)
+#define CPU_FTR_HPTE_TABLE		ASM_CONST(0x0000000000000200)
+#define CPU_FTR_CAN_NAP			ASM_CONST(0x0000000000000400)
+#define CPU_FTR_L3CR			ASM_CONST(0x0000000000000800)
+#define CPU_FTR_L3_DISABLE_NAP		ASM_CONST(0x0000000000001000)
+#define CPU_FTR_NAP_DISABLE_L2_PR	ASM_CONST(0x0000000000002000)
+#define CPU_FTR_DUAL_PLL_750FX		ASM_CONST(0x0000000000004000)
 
 /* Add the 64b processor unique features in the top half of the word */
-#define CPU_FTR_SLB           		0x0000000100000000
-#define CPU_FTR_16M_PAGE      		0x0000000200000000
-#define CPU_FTR_TLBIEL         		0x0000000400000000
-#define CPU_FTR_NOEXECUTE     		0x0000000800000000
-#define CPU_FTR_NODSISRALIGN  		0x0000001000000000
-#define CPU_FTR_IABR  			0x0000002000000000
-#define CPU_FTR_MMCRA  			0x0000004000000000
-#define CPU_FTR_PMC8  			0x0000008000000000
-#define CPU_FTR_SMT  			0x0000010000000000
-#define CPU_FTR_COHERENT_ICACHE  	0x0000020000000000
-#define CPU_FTR_LOCKLESS_TLBIE		0x0000040000000000
-#define CPU_FTR_MMCRA_SIHV		0x0000080000000000
+#define CPU_FTR_SLB           		ASM_CONST(0x0000000100000000)
+#define CPU_FTR_16M_PAGE      		ASM_CONST(0x0000000200000000)
+#define CPU_FTR_TLBIEL         		ASM_CONST(0x0000000400000000)
+#define CPU_FTR_NOEXECUTE     		ASM_CONST(0x0000000800000000)
+#define CPU_FTR_NODSISRALIGN  		ASM_CONST(0x0000001000000000)
+#define CPU_FTR_IABR  			ASM_CONST(0x0000002000000000)
+#define CPU_FTR_MMCRA  			ASM_CONST(0x0000004000000000)
+#define CPU_FTR_PMC8  			ASM_CONST(0x0000008000000000)
+#define CPU_FTR_SMT  			ASM_CONST(0x0000010000000000)
+#define CPU_FTR_COHERENT_ICACHE  	ASM_CONST(0x0000020000000000)
+#define CPU_FTR_LOCKLESS_TLBIE		ASM_CONST(0x0000040000000000)
+#define CPU_FTR_MMCRA_SIHV		ASM_CONST(0x0000080000000000)
 
 /* Platform firmware features */
-#define FW_FTR_                         0x0000000000000001
+#define FW_FTR_				ASM_CONST(0x0000000000000001)
 
 #ifndef __ASSEMBLY__
 #define COMMON_USER_PPC64	(PPC_FEATURE_32 | PPC_FEATURE_64 | \
diff -urN linux-2.5/include/asm-ppc64/mmu_context.h test/include/asm-ppc64/mmu_context.h
--- linux-2.5/include/asm-ppc64/mmu_context.h	2004-10-04 13:31:02.000000000 +1000
+++ test/include/asm-ppc64/mmu_context.h	2005-01-22 20:17:08.000000000 +1100
@@ -51,14 +51,6 @@
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 			     struct task_struct *tsk)
 {
-#ifdef CONFIG_ALTIVEC
-	asm volatile (
- BEGIN_FTR_SECTION
-	"dssall;\n"
- END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	 : : );
-#endif /* CONFIG_ALTIVEC */
-
 	if (!cpu_isset(smp_processor_id(), next->cpu_vm_mask))
 		cpu_set(smp_processor_id(), next->cpu_vm_mask);
 
@@ -66,6 +58,11 @@
 	if (prev == next)
 		return;
 
+#ifdef CONFIG_ALTIVEC
+	if (cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC)
+		asm volatile ("dssall");
+#endif /* CONFIG_ALTIVEC */
+
 	if (cur_cpu_spec->cpu_features & CPU_FTR_SLB)
 		switch_slb(tsk, next);
 	else

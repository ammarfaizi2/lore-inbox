Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbTDVNfn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 09:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTDVNfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 09:35:43 -0400
Received: from ns.suse.de ([213.95.15.193]:47372 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263138AbTDVNfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 09:35:39 -0400
Date: Tue, 22 Apr 2003 15:47:39 +0200
From: Olaf Hering <olh@suse.de>
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.21-rc1 doesn't build on ppc (6xx/pmac)
Message-ID: <20030422134739.GA7934@suse.de>
References: <16037.17599.400349.292447@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16037.17599.400349.292447@gargle.gargle.HOWL>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Apr 22, mikpe@csd.uu.se wrote:

> arch/ppc/kernel/head.o(__ftr_fixup+0x60): undefined reference to `CPU_FTR_HAS_HIGH_BATS'
> arch/ppc/kernel/head.o(__ftr_fixup+0x64): undefined reference to `CPU_FTR_HAS_HIGH_BATS'
> arch/ppc/kernel/kernel.o: In function `sys_call_table':
> arch/ppc/kernel/kernel.o(.data+0x330c): undefined reference to `__setup_cpu_7450'
> arch/ppc/kernel/kernel.o(.data+0x332c): undefined reference to `__setup_cpu_7450'
> arch/ppc/kernel/kernel.o(.data+0x334c): undefined reference to `__setup_cpu_7450'
> arch/ppc/kernel/kernel.o(.data+0x336c): undefined reference to `__setup_cpu_7455'
> arch/ppc/kernel/kernel.o(.data+0x338c): undefined reference to `__setup_cpu_7455'
> arch/ppc/kernel/kernel.o(.data+0x33ac): undefined reference to `__setup_cpu_7455'
> make: *** [vmlinux] Error 1


diff -purNX /home/olaf/kernel_exclude.txt kaputteslinuxdingens/arch/ppc/kernel/cputable.c linux-2.4.21-pre7-cset-1.1100-to-1.1116/arch/ppc/kernel/cputable.c
--- kaputteslinuxdingens/arch/ppc/kernel/cputable.c	Mon Apr 21 21:28:04 2003
+++ linux-2.4.21-pre7-cset-1.1100-to-1.1116/arch/ppc/kernel/cputable.c	Mon Apr 21 20:46:17 2003
@@ -26,8 +26,7 @@ extern void __setup_cpu_750cx(unsigned l
 extern void __setup_cpu_750fx(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
 extern void __setup_cpu_7400(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
 extern void __setup_cpu_7410(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-extern void __setup_cpu_7450(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-extern void __setup_cpu_7455(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
+extern void __setup_cpu_745x(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
 extern void __setup_cpu_power3(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
 extern void __setup_cpu_power4(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
 extern void __setup_cpu_8xx(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
@@ -154,7 +153,7 @@ struct cpu_spec	cpu_specs[] = {
     	0xffff0000, 0x70000000, "750FX",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
-	CPU_FTR_DUAL_PLL_750FX,
+	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS,
 	COMMON_PPC,
 	32, 32,
 	__setup_cpu_750fx
@@ -201,7 +200,7 @@ struct cpu_spec	cpu_specs[] = {
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
-	__setup_cpu_7450
+	__setup_cpu_745x
     },
     {	/* 7450 2.1 */
     	0xffffffff, 0x80000201, "7450",
@@ -211,7 +210,7 @@ struct cpu_spec	cpu_specs[] = {
 	CPU_FTR_L3_DISABLE_NAP,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
-	__setup_cpu_7450
+	__setup_cpu_745x
     },
     {	/* 7450 2.3 and newer */
     	0xffff0000, 0x80000000, "7450",
@@ -220,35 +219,46 @@ struct cpu_spec	cpu_specs[] = {
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
-	__setup_cpu_7450
+	__setup_cpu_745x
     },
     {	/* 7455 rev 1.x */
     	0xffffff00, 0x80010100, "7455",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
-	__setup_cpu_7455
+	__setup_cpu_745x
     },
     {	/* 7455 rev 2.0 */
     	0xffffffff, 0x80010200, "7455",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_L3_DISABLE_NAP,
+	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_HAS_HIGH_BATS,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
-	__setup_cpu_7455
+	__setup_cpu_745x
     },
     {	/* 7455 others */
     	0xffff0000, 0x80010000, "7455",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+	CPU_FTR_HAS_HIGH_BATS,
+	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
+	32, 32,
+	__setup_cpu_745x
+    },
+    {	/* 7457 */
+    	0xffff0000, 0x80020000, "7457",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
+	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+	CPU_FTR_HAS_HIGH_BATS,
 	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
 	32, 32,
-	__setup_cpu_7455
+	__setup_cpu_745x
     },
     {	/* 82xx (8240, 8245, 8260 are all 603e cores) */
 	0x7fff0000, 0x00810000, "82xx",
diff -purNX /home/olaf/kernel_exclude.txt kaputteslinuxdingens/arch/ppc/kernel/i8259.c linux-2.4.21-pre7-cset-1.1100-to-1.1116/arch/ppc/kernel/i8259.c
--- kaputteslinuxdingens/arch/ppc/kernel/i8259.c	Mon Apr 21 21:28:04 2003
+++ linux-2.4.21-pre7-cset-1.1100-to-1.1116/arch/ppc/kernel/i8259.c	Mon Apr 21 21:24:33 2003
@@ -141,6 +141,7 @@ struct hw_interrupt_type i8259_pic = {
 	NULL
 };
 
+#if 0 /* Do not request these before the host bridge resource have been setup */
 static struct resource pic1_iores = {
 	"8259 (master)", 0x20, 0x21, IORESOURCE_BUSY
 };
@@ -152,6 +153,7 @@ static struct resource pic2_iores = {
 static struct resource pic_edgectrl_iores = {
 	"8259 edge control", 0x4d0, 0x4d1, IORESOURCE_BUSY
 };
+#endif
 
 void __init i8259_init(unsigned long intack_addr)
 {
diff -purNX /home/olaf/kernel_exclude.txt kaputteslinuxdingens/include/asm-ppc/cputable.h linux-2.4.21-pre7-cset-1.1100-to-1.1116/include/asm-ppc/cputable.h
--- kaputteslinuxdingens/include/asm-ppc/cputable.h	Mon Apr 21 21:28:09 2003
+++ linux-2.4.21-pre7-cset-1.1100-to-1.1116/include/asm-ppc/cputable.h	Mon Apr 21 21:09:57 2003
@@ -74,6 +74,7 @@ extern struct cpu_spec		*cur_cpu_spec[];
 #define CPU_FTR_NAP_DISABLE_L2_PR	0x00002000
 #define CPU_FTR_DUAL_PLL_750FX		0x00004000
 #define CPU_FTR_NO_DPM			0x00008000
+#define CPU_FTR_HAS_HIGH_BATS		0x00010000
 
 #ifdef __ASSEMBLY__
 
@@ -94,6 +95,6 @@ extern struct cpu_spec		*cur_cpu_spec[];
 
 #endif /* __ASSEMBLY__ */
 
-#endif /* __ASM_PPC_CPUTABLE_H */
 #endif /* __KERNEL__ */
+#endif /* __ASM_PPC_CPUTABLE_H */
 

-- 
USB is for mice, FireWire is for men!

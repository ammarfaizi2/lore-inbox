Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSKREdA>; Sun, 17 Nov 2002 23:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbSKREdA>; Sun, 17 Nov 2002 23:33:00 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:18838
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261448AbSKREc6>; Sun, 17 Nov 2002 23:32:58 -0500
Date: Sun, 17 Nov 2002 23:43:20 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ian Morgan <imorgan@webcon.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@suse.de>
Subject: [PATCH][2.4-AC] sync 2.4 asm-i386/cpufeature.h to 2.5.47
In-Reply-To: <Pine.LNX.4.44.0211171530420.12883-100000@light.webcon.net>
Message-ID: <Pine.LNX.4.44.0211172042290.1538-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian this should fix your compilation problem.
Alan, Dave this applies clean to 2.4.19 vanilla too.

Index: linux-2.4.20-rc1-ac4/include/asm-i386/cpufeature.h
===================================================================
RCS file: /build/cvsroot/linux-2.4.20-rc1-ac4/include/asm-i386/cpufeature.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cpufeature.h
--- linux-2.4.20-rc1-ac4/include/asm-i386/cpufeature.h	18 Nov 2002 01:38:42 -0000	1.1.1.1
+++ linux-2.4.20-rc1-ac4/include/asm-i386/cpufeature.h	18 Nov 2002 03:00:46 -0000
@@ -47,6 +47,7 @@
 /* AMD-defined CPU features, CPUID level 0x80000001, word 1 */
 /* Don't duplicate feature flags which are redundant with Intel! */
 #define X86_FEATURE_SYSCALL	(1*32+11) /* SYSCALL/SYSRET */
+#define X86_FEATURE_MP		(1*32+19) /* MP Capable. */
 #define X86_FEATURE_MMXEXT	(1*32+22) /* AMD MMX extensions */
 #define X86_FEATURE_LM		(1*32+29) /* Long Mode (x86-64) */
 #define X86_FEATURE_3DNOWEXT	(1*32+30) /* AMD 3DNow! extensions */
@@ -63,6 +64,28 @@
 #define X86_FEATURE_K6_MTRR	(3*32+ 1) /* AMD K6 nonstandard MTRRs */
 #define X86_FEATURE_CYRIX_ARR	(3*32+ 2) /* Cyrix ARRs (= MTRRs) */
 #define X86_FEATURE_CENTAUR_MCR	(3*32+ 3) /* Centaur MCRs (= MTRRs) */
+
+
+#define cpu_has(c, bit)		test_bit(bit, (c)->x86_capability)
+#define boot_cpu_has(bit)	test_bit(bit, boot_cpu_data.x86_capability)
+
+#define cpu_has_fpu		boot_cpu_has(X86_FEATURE_FPU)
+#define cpu_has_vme		boot_cpu_has(X86_FEATURE_VME)
+#define cpu_has_de		boot_cpu_has(X86_FEATURE_DE)
+#define cpu_has_pse		boot_cpu_has(X86_FEATURE_PSE)
+#define cpu_has_tsc		boot_cpu_has(X86_FEATURE_TSC)
+#define cpu_has_pae		boot_cpu_has(X86_FEATURE_PAE)
+#define cpu_has_pge		boot_cpu_has(X86_FEATURE_PGE)
+#define cpu_has_apic		boot_cpu_has(X86_FEATURE_APIC)
+#define cpu_has_mtrr		boot_cpu_has(X86_FEATURE_MTRR)
+#define cpu_has_mmx		boot_cpu_has(X86_FEATURE_MMX)
+#define cpu_has_fxsr		boot_cpu_has(X86_FEATURE_FXSR)
+#define cpu_has_xmm		boot_cpu_has(X86_FEATURE_XMM)
+#define cpu_has_ht		boot_cpu_has(X86_FEATURE_HT)
+#define cpu_has_mp		boot_cpu_has(X86_FEATURE_MP)
+#define cpu_has_k6_mtrr		boot_cpu_has(X86_FEATURE_K6_MTRR)
+#define cpu_has_cyrix_arr	boot_cpu_has(X86_FEATURE_CYRIX_ARR)
+#define cpu_has_centaur_mcr	boot_cpu_has(X86_FEATURE_CENTAUR_MCR)
 
 #endif /* __ASM_I386_CPUFEATURE_H */
 
Index: linux-2.4.20-rc1-ac4/include/asm-i386/processor.h
===================================================================
RCS file: /build/cvsroot/linux-2.4.20-rc1-ac4/include/asm-i386/processor.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 processor.h
--- linux-2.4.20-rc1-ac4/include/asm-i386/processor.h	18 Nov 2002 01:38:41 -0000	1.1.1.1
+++ linux-2.4.20-rc1-ac4/include/asm-i386/processor.h	18 Nov 2002 03:04:53 -0000
@@ -81,17 +81,6 @@
 #define current_cpu_data boot_cpu_data
 #endif
 
-#define cpu_has_pge	(test_bit(X86_FEATURE_PGE,  boot_cpu_data.x86_capability))
-#define cpu_has_pse	(test_bit(X86_FEATURE_PSE,  boot_cpu_data.x86_capability))
-#define cpu_has_pae	(test_bit(X86_FEATURE_PAE,  boot_cpu_data.x86_capability))
-#define cpu_has_tsc	(test_bit(X86_FEATURE_TSC,  boot_cpu_data.x86_capability))
-#define cpu_has_de	(test_bit(X86_FEATURE_DE,   boot_cpu_data.x86_capability))
-#define cpu_has_vme	(test_bit(X86_FEATURE_VME,  boot_cpu_data.x86_capability))
-#define cpu_has_fxsr	(test_bit(X86_FEATURE_FXSR, boot_cpu_data.x86_capability))
-#define cpu_has_xmm	(test_bit(X86_FEATURE_XMM,  boot_cpu_data.x86_capability))
-#define cpu_has_fpu	(test_bit(X86_FEATURE_FPU,  boot_cpu_data.x86_capability))
-#define cpu_has_apic	(test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability))
-
 extern char ignore_irq13;
 
 extern void identify_cpu(struct cpuinfo_x86 *);





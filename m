Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUHMUdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUHMUdN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 16:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267586AbUHMUat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 16:30:49 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:35341 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S267466AbUHMU3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 16:29:20 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] [ix86,x86_64] cpu features.
Date: Fri, 13 Aug 2004 22:29:14 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <2sMat-61I-43@gated-at.bofh.it> <200408131902.46553.pluto@pld-linux.org> <20040813201410.GA35817@muc.de>
In-Reply-To: <20040813201410.GA35817@muc.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aSSHBuSVmFA6AcR"
Message-Id: <200408132229.15004.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_aSSHBuSVmFA6AcR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_aSSHBuSVmFA6AcR
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.8-cpu_feature.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.8-cpu_feature.patch"

--- linux-2.6.8-rc4/arch/i386/kernel/cpu/proc.c.orig	2004-08-10 04:23:46.000000000 +0200
+++ linux-2.6.8-rc4/arch/i386/kernel/cpu/proc.c	2004-08-13 16:48:53.971370504 +0200
@@ -44,8 +44,8 @@
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
 		/* Intel-defined (#2) */
-		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "tm2",
-		"est", NULL, "cid", NULL, NULL, NULL, NULL, NULL,
+		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "est",
+		"tm2", NULL, "cid", NULL, NULL, NULL, "xtpr", NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
--- linux-2.6.8-rc4/arch/x86_64/kernel/setup.c.orig	2004-08-10 04:22:11.000000000 +0200
+++ linux-2.6.8-rc4/arch/x86_64/kernel/setup.c	2004-08-13 16:59:14.729001000 +0200
@@ -1042,8 +1042,8 @@
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
 		/* Intel-defined (#2) */
-		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "tm2",
-		"est", NULL, "cid", NULL, NULL, "cmpxchg16b", NULL, NULL,
+		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "est",
+		"tm2", NULL, "cid", NULL, NULL, "cx16", "xtpr", NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 	};
--- linux-2.6.8-rc4/include/asm-i386/cpufeature.h.orig	2004-08-10 04:23:22.000000000 +0200
+++ linux-2.6.8-rc4/include/asm-i386/cpufeature.h	2004-08-13 16:49:19.439498760 +0200
@@ -71,9 +71,13 @@
 #define X86_FEATURE_P4		(3*32+ 7) /* P4 */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
-#define X86_FEATURE_EST		(4*32+ 7) /* Enhanced SpeedStep */
+#define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
 #define X86_FEATURE_MWAIT	(4*32+ 3) /* Monitor/Mwait support */
-
+#define X86_FEATURE_DSCPL	(4*32+ 4) /* CPL Qualified Debug Store */
+#define X86_FEATURE_EST		(4*32+ 7) /* Enhanced SpeedStep */
+#define X86_FEATURE_TM2		(4*32+ 8) /* Thermal Monitor 2 */
+#define X86_FEATURE_CID		(4*32+10) /* Context ID */
+#define X86_FEATURE_XTPR	(4*32+14) /* Send Task Priority Messages */
 
 /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
 #define X86_FEATURE_XSTORE	(5*32+ 2) /* on-CPU RNG present (xstore insn) */
@@ -93,13 +97,14 @@
 #define cpu_has_tsc		boot_cpu_has(X86_FEATURE_TSC)
 #define cpu_has_pae		boot_cpu_has(X86_FEATURE_PAE)
 #define cpu_has_pge		boot_cpu_has(X86_FEATURE_PGE)
-#define cpu_has_sse2		boot_cpu_has(X86_FEATURE_XMM2)
 #define cpu_has_apic		boot_cpu_has(X86_FEATURE_APIC)
 #define cpu_has_sep		boot_cpu_has(X86_FEATURE_SEP)
 #define cpu_has_mtrr		boot_cpu_has(X86_FEATURE_MTRR)
 #define cpu_has_mmx		boot_cpu_has(X86_FEATURE_MMX)
 #define cpu_has_fxsr		boot_cpu_has(X86_FEATURE_FXSR)
 #define cpu_has_xmm		boot_cpu_has(X86_FEATURE_XMM)
+#define cpu_has_xmm2		boot_cpu_has(X86_FEATURE_XMM2)
+#define cpu_has_xmm3		boot_cpu_has(X86_FEATURE_XMM3)
 #define cpu_has_ht		boot_cpu_has(X86_FEATURE_HT)
 #define cpu_has_mp		boot_cpu_has(X86_FEATURE_MP)
 #define cpu_has_nx		boot_cpu_has(X86_FEATURE_NX)
--- linux-2.6.8-rc4/include/asm-x86_64/cpufeature.h.orig	2004-08-10 04:23:13.000000000 +0200
+++ linux-2.6.8-rc4/include/asm-x86_64/cpufeature.h	2004-08-13 16:53:48.776553304 +0200
@@ -63,8 +63,14 @@
 #define X86_FEATURE_K8_C	(3*32+ 4) /* C stepping K8 */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
-#define X86_FEATURE_EST		(4*32+ 7) /* Enhanced SpeedStep */
+#define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
 #define X86_FEATURE_MWAIT	(4*32+ 3) /* Monitor/Mwait support */
+#define X86_FEATURE_DSCPL	(4*32+ 4) /* CPL Qualified Debug Store */
+#define X86_FEATURE_EST		(4*32+ 7) /* Enhanced SpeedStep */
+#define X86_FEATURE_TM2		(4*32+ 8) /* Thermal Monitor 2 */
+#define X86_FEATURE_CID		(4*32+10) /* Context ID */
+#define X86_FEATURE_CX16	(4*32+13) /* CMPXCHG16B */
+#define X86_FEATURE_XTPR	(4*32+14) /* Send Task Priority Messages */
 
 #define cpu_has(c, bit)                test_bit(bit, (c)->x86_capability)
 #define boot_cpu_has(bit)      test_bit(bit, boot_cpu_data.x86_capability)
@@ -81,6 +87,8 @@
 #define cpu_has_mmx            1
 #define cpu_has_fxsr           1
 #define cpu_has_xmm            1
+#define cpu_has_xmm2           1
+#define cpu_has_xmm3           boot_cpu_has(X86_FEATURE_XMM3)
 #define cpu_has_ht             boot_cpu_has(X86_FEATURE_HT)
 #define cpu_has_mp             1 /* XXX */
 #define cpu_has_k6_mtrr        0

--Boundary-00=_aSSHBuSVmFA6AcR--

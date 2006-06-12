Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWFLFzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWFLFzP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 01:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWFLFzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 01:55:15 -0400
Received: from maxipes.logix.cz ([217.11.251.249]:13986 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S1750913AbWFLFzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 01:55:14 -0400
X-Mailbox-Line: From mludvig@rumburak.home.logix.cz Mon Jun 12 17:18:35 2006
Message-Id: <20060612051738.609636000@rumburak.home.logix.cz>
User-Agent: quilt/0.44-15
Date: Mon, 12 Jun 2006 17:17:38 +1200
From: michal@logix.cz
To: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] VIA C7 CPU flags
Content-Disposition: inline; filename=esther-cpuinfo.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New CPU flags for next generation of crypto engine as
found in VIA C7 processors.

Signed-off-by: Michal Ludvig <michal@logix.cz>

Index: linux-2.6.17-rc6/arch/i386/kernel/cpu/proc.c
===================================================================
--- linux-2.6.17-rc6.orig/arch/i386/kernel/cpu/proc.c
+++ linux-2.6.17-rc6/arch/i386/kernel/cpu/proc.c
@@ -52,7 +52,7 @@ static int show_cpuinfo(struct seq_file 
 
 		/* VIA/Cyrix/Centaur-defined */
 		NULL, NULL, "rng", "rng_en", NULL, NULL, "ace", "ace_en",
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+		"ace2", "ace2_en", "phe", "phe_en", "pmm", "pmm_en", NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
Index: linux-2.6.17-rc6/include/asm-i386/cpufeature.h
===================================================================
--- linux-2.6.17-rc6.orig/include/asm-i386/cpufeature.h
+++ linux-2.6.17-rc6/include/asm-i386/cpufeature.h
@@ -88,6 +88,12 @@
 #define X86_FEATURE_XSTORE_EN	(5*32+ 3) /* on-CPU RNG enabled */
 #define X86_FEATURE_XCRYPT	(5*32+ 6) /* on-CPU crypto (xcrypt insn) */
 #define X86_FEATURE_XCRYPT_EN	(5*32+ 7) /* on-CPU crypto enabled */
+#define X86_FEATURE_ACE2	(5*32+ 8) /* Advanced Cryptography Engine v2 */
+#define X86_FEATURE_ACE2_EN	(5*32+ 9) /* ACE v2 enabled */
+#define X86_FEATURE_PHE		(5*32+ 10) /* PadLock Hash Engine */
+#define X86_FEATURE_PHE_EN	(5*32+ 11) /* PHE enabled */
+#define X86_FEATURE_PMM		(5*32+ 12) /* PadLock Montgomery Multiplier */
+#define X86_FEATURE_PMM_EN	(5*32+ 13) /* PMM enabled */
 
 /* More extended AMD flags: CPUID level 0x80000001, ecx, word 6 */
 #define X86_FEATURE_LAHF_LM	(6*32+ 0) /* LAHF/SAHF in long mode */
@@ -121,6 +127,12 @@
 #define cpu_has_xstore_enabled	boot_cpu_has(X86_FEATURE_XSTORE_EN)
 #define cpu_has_xcrypt		boot_cpu_has(X86_FEATURE_XCRYPT)
 #define cpu_has_xcrypt_enabled	boot_cpu_has(X86_FEATURE_XCRYPT_EN)
+#define cpu_has_ace2		boot_cpu_has(X86_FEATURE_ACE2)
+#define cpu_has_ace2_enabled	boot_cpu_has(X86_FEATURE_ACE2_EN)
+#define cpu_has_phe		boot_cpu_has(X86_FEATURE_PHE)
+#define cpu_has_phe_enabled	boot_cpu_has(X86_FEATURE_PHE_EN)
+#define cpu_has_pmm		boot_cpu_has(X86_FEATURE_PMM)
+#define cpu_has_pmm_enabled	boot_cpu_has(X86_FEATURE_PMM_EN)
 
 #endif /* __ASM_I386_CPUFEATURE_H */
 


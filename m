Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbUKIGHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUKIGHZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 01:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUKIGAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 01:00:23 -0500
Received: from motgate8.mot.com ([129.188.136.8]:28409 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S261397AbUKIFkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:40:02 -0500
Date: Mon, 8 Nov 2004 23:39:55 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: akpm@osdl.org
cc: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Add performance counters to cpu_spec
Message-ID: <Pine.LNX.4.61.0411082332090.13565@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Adds the number of performance monitor counters each PowerPC processor has 
to the cpu table.  Makes oprofile support a bit cleaner since we dont need 
a case statement on processor version to determine the number of counters.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c	2004-11-08 21:02:51 -06:00
+++ b/arch/ppc/kernel/cputable.c	2004-11-08 21:02:51 -06:00
@@ -82,6 +82,7 @@
  	CPU_FTR_601 | CPU_FTR_HPTE_TABLE,
  	COMMON_PPC | PPC_FEATURE_601_INSTR | PPC_FEATURE_UNIFIED_CACHE,
  	32, 32,
+	0,
  	__setup_cpu_601
      },
      {	/* 603 */
@@ -91,6 +92,7 @@
      	CPU_FTR_MAYBE_CAN_NAP,
  	COMMON_PPC,
      	32, 32,
+	0,
  	__setup_cpu_603
      },
      {	/* 603e */
@@ -100,6 +102,7 @@
      	CPU_FTR_MAYBE_CAN_NAP,
  	COMMON_PPC,
  	32, 32,
+	0,
  	__setup_cpu_603
      },
      {	/* 603ev */
@@ -109,6 +112,7 @@
      	CPU_FTR_MAYBE_CAN_NAP,
  	COMMON_PPC,
  	32, 32,
+	0,
  	__setup_cpu_603
      },
      {	/* 604 */
@@ -118,6 +122,7 @@
  	CPU_FTR_HPTE_TABLE,
  	COMMON_PPC,
  	32, 32,
+	2,
  	__setup_cpu_604
      },
      {	/* 604e */
@@ -127,6 +132,7 @@
  	CPU_FTR_HPTE_TABLE,
  	COMMON_PPC,
  	32, 32,
+	4,
  	__setup_cpu_604
      },
      {	/* 604r */
@@ -136,6 +142,7 @@
  	CPU_FTR_HPTE_TABLE,
  	COMMON_PPC,
  	32, 32,
+	4,
  	__setup_cpu_604
      },
      {	/* 604ev */
@@ -145,6 +152,7 @@
  	CPU_FTR_HPTE_TABLE,
  	COMMON_PPC,
  	32, 32,
+	4,
  	__setup_cpu_604
      },
      {	/* 740/750 (0x4202, don't support TAU ?) */
@@ -154,6 +162,7 @@
  	CPU_FTR_L2CR | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
  	COMMON_PPC,
  	32, 32,
+	4,
  	__setup_cpu_750
      },
      {	/* 745/755 */
@@ -163,6 +172,7 @@
  	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
  	COMMON_PPC,
  	32, 32,
+	4,
  	__setup_cpu_750
      },
      {	/* 750CX (80100 and 8010x?) */
@@ -172,6 +182,7 @@
  	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
  	COMMON_PPC,
  	32, 32,
+	4,
  	__setup_cpu_750cx
      },
      {	/* 750CX (82201 and 82202) */
@@ -181,6 +192,7 @@
  	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
  	COMMON_PPC,
  	32, 32,
+	4,
  	__setup_cpu_750cx
      },
      {	/* 750CXe (82214) */
@@ -190,6 +202,7 @@
  	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
  	COMMON_PPC,
  	32, 32,
+	4,
  	__setup_cpu_750cx
      },
      {	/* 750FX rev 1.x */
@@ -200,6 +213,7 @@
  	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM,
  	COMMON_PPC,
  	32, 32,
+	4,
  	__setup_cpu_750
      },
      {	/* 750FX rev 2.0 must disable HID0[DPM] */
@@ -210,6 +224,7 @@
  	CPU_FTR_NO_DPM,
  	COMMON_PPC,
  	32, 32,
+	4,
  	__setup_cpu_750
      },
      {	/* 750FX (All revs except 2.0) */
@@ -220,6 +235,7 @@
  	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS,
  	COMMON_PPC,
  	32, 32,
+	4,
  	__setup_cpu_750fx
      },
      {	/* 750GX */
@@ -229,6 +245,7 @@
  	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS,
  	COMMON_PPC,
  	32, 32,
+	4,
  	__setup_cpu_750fx
      },
      {	/* 740/750 (L2CR bit need fixup for 740) */
@@ -238,6 +255,7 @@
  	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
  	COMMON_PPC,
  	32, 32,
+	4,
  	__setup_cpu_750
      },
      {	/* 7400 rev 1.1 ? (no TAU) */
@@ -248,6 +266,7 @@
  	CPU_FTR_MAYBE_CAN_NAP,
  	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
  	32, 32,
+	4,
  	__setup_cpu_7400
      },
      {	/* 7400 */
@@ -258,6 +277,7 @@
  	CPU_FTR_MAYBE_CAN_NAP,
  	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
  	32, 32,
+	4,
  	__setup_cpu_7400
      },
      {	/* 7410 */
@@ -268,6 +288,7 @@
  	CPU_FTR_MAYBE_CAN_NAP,
  	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
  	32, 32,
+	4,
  	__setup_cpu_7410
      },
      {	/* 7450 2.0 - no doze/nap */
@@ -278,6 +299,7 @@
  	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NEED_COHERENT,
  	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
  	32, 32,
+	6,
  	__setup_cpu_745x
      },
      {	/* 7450 2.1 */
@@ -289,6 +311,7 @@
  	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_NEED_COHERENT,
  	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
  	32, 32,
+	6,
  	__setup_cpu_745x
      },
      {	/* 7450 2.3 and newer */
@@ -300,6 +323,7 @@
  	CPU_FTR_NEED_COHERENT,
  	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
  	32, 32,
+	6,
  	__setup_cpu_745x
      },
      {	/* 7455 rev 1.x */
@@ -311,6 +335,7 @@
  	CPU_FTR_NEED_COHERENT,
  	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
  	32, 32,
+	6,
  	__setup_cpu_745x
      },
      {	/* 7455 rev 2.0 */
@@ -322,6 +347,7 @@
  	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS,
  	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
  	32, 32,
+	6,
  	__setup_cpu_745x
      },
      {	/* 7455 others */
@@ -333,6 +359,7 @@
  	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
  	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
  	32, 32,
+	6,
  	__setup_cpu_745x
      },
      {	/* 7447/7457 Rev 1.0 */
@@ -344,6 +371,7 @@
  	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
  	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
  	32, 32,
+	6,
  	__setup_cpu_745x
      },
      {	/* 7447/7457 Rev 1.1 */
@@ -355,6 +383,7 @@
  	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
  	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
  	32, 32,
+	6,
  	__setup_cpu_745x
      },
      {	/* 7447/7457 Rev 1.2 and later */
@@ -366,6 +395,7 @@
  	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
  	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
  	32, 32,
+	6,
  	__setup_cpu_745x
      },
      {	/* 7447A */
@@ -377,6 +407,7 @@
  	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
  	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
  	32, 32,
+	6,
  	__setup_cpu_745x
      },
      {	/* 82xx (8240, 8245, 8260 are all 603e cores) */
@@ -385,6 +416,7 @@
  	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB,
  	COMMON_PPC,
  	32, 32,
+	0,
  	__setup_cpu_603
      },
      {	/* All G2_LE (603e core, plus some) have the same pvr */
@@ -393,6 +425,7 @@
  	CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
  	COMMON_PPC,
  	32, 32,
+	0,
  	__setup_cpu_603
      },
      {	/* default match, we assume split I/D cache & TB (non-601)... */
@@ -401,6 +434,7 @@
      	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
  	COMMON_PPC,
  	32, 32,
+	0,
  	__setup_cpu_generic
      },
  #endif /* CLASSIC_PPC */
@@ -411,6 +445,7 @@
      	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
      	COMMON_PPC | PPC_FEATURE_64,
  	128, 128,
+	8,
  	__setup_cpu_power3
      },
      {	/* Power3+ */
@@ -419,6 +454,7 @@
      	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
      	COMMON_PPC | PPC_FEATURE_64,
  	128, 128,
+	8,
  	__setup_cpu_power3
      },
  	{	/* I-star */
@@ -427,6 +463,7 @@
  		CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
  		COMMON_PPC | PPC_FEATURE_64,
  		128, 128,
+		8,
  		__setup_cpu_power3
  	},
  	{	/* S-star */
@@ -435,6 +472,7 @@
  		CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
  		COMMON_PPC | PPC_FEATURE_64,
  		128, 128,
+		8,
  		__setup_cpu_power3
  	},
  #endif /* CONFIG_PPC64BRIDGE */
@@ -445,6 +483,7 @@
      	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
      	COMMON_PPC | PPC_FEATURE_64,
  	128, 128,
+	8,
  	__setup_cpu_power4
      },
      {	/* PPC970 */
@@ -454,6 +493,7 @@
  	CPU_FTR_ALTIVEC_COMP | CPU_FTR_MAYBE_CAN_NAP,
  	COMMON_PPC | PPC_FEATURE_64 | PPC_FEATURE_ALTIVEC_COMP,
  	128, 128,
+	8,
  	__setup_cpu_ppc970
      },
      {	/* PPC970FX */
@@ -463,6 +503,7 @@
  	CPU_FTR_ALTIVEC_COMP | CPU_FTR_MAYBE_CAN_NAP,
  	COMMON_PPC | PPC_FEATURE_64 | PPC_FEATURE_ALTIVEC_COMP,
  	128, 128,
+	8,
  	__setup_cpu_ppc970
      },
  #endif /* CONFIG_POWER4 */
@@ -474,6 +515,7 @@
      	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
      	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
   	16, 16,
+	0,
  	__setup_cpu_8xx	/* Empty */
      },
  #endif /* CONFIG_8xx */
@@ -483,6 +525,7 @@
      	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
      	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
  	16, 16,
+	0,
  	0, /*__setup_cpu_403 */
      },
      {	/* 403GCX */
@@ -490,6 +533,7 @@
      	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
      	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
  	16, 16,
+	0,
  	0, /*__setup_cpu_403 */
      },
      {	/* 403G ?? */
@@ -497,6 +541,7 @@
      	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
      	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
  	16, 16,
+	0,
  	0, /*__setup_cpu_403 */
      },
      {	/* 405GP */
@@ -504,6 +549,7 @@
      	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
      	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
  	32, 32,
+	0,
  	0, /*__setup_cpu_405 */
      },
      {	/* STB 03xxx */
@@ -511,6 +557,7 @@
      	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
      	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
  	32, 32,
+	0,
  	0, /*__setup_cpu_405 */
      },
      {	/* STB 04xxx */
@@ -518,6 +565,7 @@
      	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
      	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
  	32, 32,
+	0,
  	0, /*__setup_cpu_405 */
      },
      {	/* NP405L */
@@ -525,6 +573,7 @@
      	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
      	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
  	32, 32,
+	0,
  	0, /*__setup_cpu_405 */
      },
      {	/* NP4GS3 */
@@ -532,6 +581,7 @@
      	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
      	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
  	32, 32,
+	0,
  	0, /*__setup_cpu_405 */
      },
      {   /* NP405H */
@@ -539,6 +589,7 @@
          CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
          PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
          32, 32,
+	0,
          0, /*__setup_cpu_405 */
       },
       {	/* 405GPr */
@@ -546,6 +597,7 @@
      	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
      	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
  	32, 32,
+	0,
  	0, /*__setup_cpu_405 */
      },
      {   /* STBx25xx */
@@ -553,6 +605,7 @@
          CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
          PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
          32, 32,
+	0,
          0, /*__setup_cpu_405 */
       },
       {	/* 405LP */
@@ -560,6 +613,7 @@
      	CPU_FTR_SPLIT_ID_CACHE |  CPU_FTR_USE_TB,
      	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
  	32, 32,
+	0,
  	0, /*__setup_cpu_405 */
       },
       {	/* Xilinx Virtex-II Pro  */
@@ -567,6 +621,7 @@
  	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
  	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
  	32, 32,
+	0,
  	0, /*__setup_cpu_405 */
       },

@@ -577,6 +632,7 @@
          CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
          PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
          32, 32,
+	0,
          0, /*__setup_cpu_440 */
      },
      { /* 440GP Rev. C */
@@ -584,6 +640,7 @@
          CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
          PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
          32, 32,
+	0,
          0, /*__setup_cpu_440 */
      },
      { /* 440GX Rev. A */
@@ -591,6 +648,7 @@
          CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
          PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
          32, 32,
+	0,
          0, /*__setup_cpu_440 */
      },
      { /* 440GX Rev. B */
@@ -598,6 +656,7 @@
          CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
          PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
          32, 32,
+	0,
          0, /*__setup_cpu_440 */
      },
      { /* 440GX Rev. C */
@@ -605,6 +664,7 @@
          CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
          PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
          32, 32,
+	0,
          0, /*__setup_cpu_440 */
      },
  #endif /* CONFIG_44x */
@@ -615,6 +675,7 @@
          CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
          PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
          32, 32,
+	4,
          0, /*__setup_cpu_e500 */
      },
  #endif
@@ -624,6 +685,7 @@
  	CPU_FTR_COMMON,
      	PPC_FEATURE_32,
  	32, 32,
+	0,
  	0,
      }
  #endif /* !CLASSIC_PPC */
diff -Nru a/include/asm-ppc/cputable.h b/include/asm-ppc/cputable.h
--- a/include/asm-ppc/cputable.h	2004-11-08 21:02:51 -06:00
+++ b/include/asm-ppc/cputable.h	2004-11-08 21:02:51 -06:00
@@ -46,6 +46,9 @@
  	unsigned int	icache_bsize;
  	unsigned int	dcache_bsize;

+	/* number of performace monitor counters */
+	unsigned int	num_pmcs;
+
  	/* this is called to initialize various CPU bits like L1 cache,
  	 * BHT, SPD, etc... from head.S before branching to identify_machine
  	 */


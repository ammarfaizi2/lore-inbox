Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263636AbUEEIEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbUEEIEa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 04:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263670AbUEEIEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 04:04:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:8624 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263636AbUEEIEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 04:04:22 -0400
Subject: [PATCH] ppc32: pmac support update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1083743962.19140.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 May 2004 17:59:23 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds some initial support for the latest model of iBook G4
(still need some work on the clock chip at least and some radeonfb
updates that I'll send later along with other fixes for this driver).

It also removes a useless delay and fixes detection of the airport
card on the "Windtunnel" class desktop G4 machines.

Please apply,
Ben.

diff -urN linux-2.5/arch/ppc/kernel/cputable.c linuxppc-2.5-benh/arch/ppc/kernel/cputable.c
--- linux-2.5/arch/ppc/kernel/cputable.c	2004-05-03 09:29:08.000000000 +1000
+++ linuxppc-2.5-benh/arch/ppc/kernel/cputable.c	2004-05-04 14:34:46.000000000 +1000
@@ -323,6 +323,17 @@
 	32, 32,
 	__setup_cpu_745x
     },
+    {	/* 7447A */
+    	0xffff0000, 0x80030000, "7447A",
+	CPU_FTR_COMMON |
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
+	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+	CPU_FTR_HAS_HIGH_BATS,
+	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+	32, 32,
+	__setup_cpu_745x
+    },
     {	/* 82xx (8240, 8245, 8260 are all 603e cores) */
 	0x7fff0000, 0x00810000, "82xx",
 	CPU_FTR_COMMON |
diff -urN linux-2.5/arch/ppc/platforms/pmac_feature.c linuxppc-2.5-benh/arch/ppc/platforms/pmac_feature.c
--- linux-2.5/arch/ppc/platforms/pmac_feature.c	2004-05-03 09:29:08.000000000 +1000
+++ linuxppc-2.5-benh/arch/ppc/platforms/pmac_feature.c	2004-05-04 14:34:45.000000000 +1000
@@ -578,7 +578,6 @@
 
 	/* Let things settle */
 	(void)MACIO_IN32(HEATHROW_FCR);
-	mdelay(1);
 }
 
 static void __pmac
@@ -2102,7 +2101,7 @@
 		0,
 	},
 	{	"PowerMac3,6",			"PowerMac G4 Windtunnel",
-		PMAC_TYPE_WINDTUNNEL,		rackmac_features,
+		PMAC_TYPE_WINDTUNNEL,		core99_features,
 		0,
 	},
 	{	"PowerBook5,1",			"PowerBook G4 17\"",
@@ -2129,6 +2128,10 @@
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
+	{	"PowerBook6,5",			"iBook G4",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
 #else /* CONFIG_POWER4 */
 	{	"PowerMac7,2",			"PowerMac G5",
 		PMAC_TYPE_POWERMAC_G5,		g5_features,



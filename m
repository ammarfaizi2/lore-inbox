Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVADL7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVADL7k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 06:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVADL7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 06:59:40 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:1504 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261378AbVADL6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 06:58:14 -0500
Date: Tue, 4 Jan 2005 22:58:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64: use c99 initializers
Message-Id: <20050104225809.4b265440.sfr@canb.auug.org.au>
In-Reply-To: <20050104154319.505b1197.sfr@canb.auug.org.au>
References: <20050104145356.4d5333dd.sfr@canb.auug.org.au>
	<20050104150410.199b132e.sfr@canb.auug.org.au>
	<20050104150833.5d3f3722.sfr@canb.auug.org.au>
	<20050104151229.521e8083.sfr@canb.auug.org.au>
	<20050104151906.6e50f1d2.sfr@canb.auug.org.au>
	<20050104152340.67219ccf.sfr@canb.auug.org.au>
	<20050104152705.6030abc5.sfr@canb.auug.org.au>
	<20050104153102.67284491.sfr@canb.auug.org.au>
	<20050104153445.3777e689.sfr@canb.auug.org.au>
	<20050104153740.56622b4f.sfr@canb.auug.org.au>
	<20050104154025.63a1b9fb.sfr@canb.auug.org.au>
	<20050104154319.505b1197.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__4_Jan_2005_22_58_09_+1100_25FyCpIeJ=c0dlzw"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__4_Jan_2005_22_58_09_+1100_25FyCpIeJ=c0dlzw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch is just more clean up in the ppc64 arch.  It uses c99
initializers for various iSeries structures that are used to pass
information to the hypervisor.  Also itLpNaca is not used by any code that
could be in a module, so don't export it.

Built and booted.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Please apply.

P.S. for the StudlyCaps brigade, changing these is on my To Do list. :-)
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-sfr.11/arch/ppc64/kernel/LparData.c linus-bk-sfr.12/arch/ppc64/kernel/LparData.c
--- linus-bk-sfr.11/arch/ppc64/kernel/LparData.c	2004-12-13 15:01:55.000000000 +1100
+++ linus-bk-sfr.12/arch/ppc64/kernel/LparData.c	2005-01-04 18:18:37.000000000 +1100
@@ -41,24 +41,22 @@
  */
 
 struct HvReleaseData hvReleaseData = {
-	0xc8a5d9c4,	/* desc = "HvRD" ebcdic */
-	sizeof(struct HvReleaseData),
-	offsetof(struct naca_struct, xItVpdAreas),
-	&naca,		/* 64-bit Naca address */
-	0x6000,		/* offset of LparMap within loadarea (see head.S) */
-	0,
-	1,		/* tags inactive       */
-	0,		/* 64 bit              */
-	0,		/* shared processors   */
-	0,		/* HMT allowed         */
-	6,		/* TEMP: This allows non-GA driver */
-	4,		/* We are v5r2m0               */
-	3,		/* Min supported PLIC = v5r1m0 */
-	3,		/* Min usable PLIC   = v5r1m0 */
-	{ 0xd3, 0x89, 0x95, 0xa4, /* "Linux 2.4   "*/
-	  0xa7, 0x40, 0xf2, 0x4b,
-	  0xf4, 0x4b, 0xf6, 0xf4 },
-	{0}  
+	.xDesc = 0xc8a5d9c4,	/* "HvRD" ebcdic */
+	.xSize = sizeof(struct HvReleaseData),
+	.xVpdAreasPtrOffset = offsetof(struct naca_struct, xItVpdAreas),
+	.xSlicNacaAddr = &naca,		/* 64-bit Naca address */
+	.xMsNucDataOffset = 0x6000,	/* offset of LparMap within loadarea (see head.S) */
+	.xTagsMode = 1,			/* tags inactive       */
+	.xAddressSize = 0,		/* 64 bit              */
+	.xNoSharedProcs = 0,		/* shared processors   */
+	.xNoHMT = 0,			/* HMT allowed         */
+	.xRsvd2 = 6,			/* TEMP: This allows non-GA driver */
+	.xVrmIndex = 4,			/* We are v5r2m0               */
+	.xMinSupportedPlicVrmIndex = 3,		/* v5r1m0 */
+	.xMinCompatablePlicVrmIndex = 3,	/* v5r1m0 */
+	.xVrmName = { 0xd3, 0x89, 0x95, 0xa4,	/* "Linux 2.4.64" ebcdic */
+		0xa7, 0x40, 0xf2, 0x4b,
+		0xf4, 0x4b, 0xf6, 0xf4 },
 };
 
 extern void SystemReset_Iseries(void);
@@ -80,26 +78,33 @@
 extern void InstructionAccessSLB_Iseries(void);
 	
 struct ItLpNaca itLpNaca = {
-	0xd397d581,	/* desc = "LpNa" ebcdic */
-	0x0400,		/* size of ItLpNaca     */
-	0x0300, 19,	/* offset to int array, # ents */
-	0, 0, 0,	/* Part # of primary, serv, me */
-	0, 0x100,	/* # of LP queues, offset */
-	0, 0, 0,	/* Piranha stuff */
-	{ 0,0,0,0,0 },	/* reserved */
-	0,0,0,0,0,0,0,	/* stuff    */
-	{ 0,0,0,0,0 },	/* reserved */
-	0,		/* reserved */
-	0,		/* VRM index of PLIC */
-	0, 0,		/* min supported, compat SLIC */
-	0,		/* 64-bit addr of load area   */
-	0,		/* chunks for load area  */
-	0, 0,		/* PASE mask, seg table  */
-	{ 0 },		/* 64 reserved bytes  */
-	{ 0 }, 		/* 128 reserved bytes */
-	{ 0 }, 		/* Old LP Queue       */
-	{ 0 }, 		/* 384 reserved bytes */
-	{
+	.xDesc = 0xd397d581,		/* "LpNa" ebcdic */
+	.xSize = 0x0400,		/* size of ItLpNaca */
+	.xIntHdlrOffset = 0x0300,	/* offset to int array */
+	.xMaxIntHdlrEntries = 19,	/* # ents */
+	.xPrimaryLpIndex = 0,		/* Part # of primary */
+	.xServiceLpIndex = 0,		/* Part # of serv */
+	.xLpIndex = 0,			/* Part # of me */
+	.xMaxLpQueues = 0,		/* # of LP queues */
+	.xLpQueueOffset = 0x100,	/* offset of start of LP queues */
+	.xPirEnvironMode = 0,		/* Piranha stuff */
+	.xPirConsoleMode = 0,
+	.xPirDasdMode = 0,
+	.xLparInstalled = 0,
+	.xSysPartitioned = 0,
+	.xHwSyncedTBs = 0,
+	.xIntProcUtilHmt = 0,
+	.xSpVpdFormat = 0,
+	.xIntProcRatio = 0,
+	.xPlicVrmIndex = 0,		/* VRM index of PLIC */
+	.xMinSupportedSlicVrmInd = 0,	/* min supported SLIC */
+	.xMinCompatableSlicVrmInd = 0,	/* min compat SLIC */
+	.xLoadAreaAddr = 0,		/* 64-bit addr of load area */
+	.xLoadAreaChunks = 0,		/* chunks for load area */
+	.xPaseSysCallCRMask = 0,	/* PASE mask */
+	.xSlicSegmentTablePtr = 0,	/* seg table */
+	.xOldLpQueue = { 0 }, 		/* Old LP Queue */
+	.xInterruptHdlr = {
 		(u64)SystemReset_Iseries,	/* 0x100 System Reset */
 		(u64)MachineCheck_Iseries,	/* 0x200 Machine Check */
 		(u64)DataAccess_Iseries,	/* 0x300 Data Access */
@@ -153,10 +158,8 @@
 u64    xRecoveryLogBuffer[32] __attribute__((__section__(".data")));
 
 struct SpCommArea xSpCommArea = {
-	0xE2D7C3C2,
-	1,
-	{0},
-	0, 0, 0, 0, {0}
+	.xDesc = 0xE2D7C3C2,
+	.xFormat = 1,
 };
 
 /* The LparMap data is now located at offset 0x6000 in head.S
@@ -168,22 +171,21 @@
  * offset into the Naca of the pointer to the ItVpdAreas.
  */
 struct ItVpdAreas itVpdAreas = {
-	0xc9a3e5c1,	/* "ItVA" */
-	sizeof( struct ItVpdAreas ),
-	0, 0,
-	26,		/* # VPD array entries */
-	10,		/* # DMA array entries */
-	NR_CPUS*2, maxPhysicalProcessors,	/* Max logical, physical procs */
-	offsetof(struct ItVpdAreas,xPlicDmaToks),/* offset to DMA toks */
-	offsetof(struct ItVpdAreas,xSlicVpdAdrs),/* offset to VPD addrs */
-	offsetof(struct ItVpdAreas,xPlicDmaLens),/* offset to DMA lens */
-	offsetof(struct ItVpdAreas,xSlicVpdLens),/* offset to VPD lens */
-	0,		/* max slot labels */
-	1,		/* max LP queues */
-	{0}, {0},	/* reserved */
-	{0},		/* DMA lengths */
-	{0},		/* DMA tokens */
-	{		/* VPD lengths */
+	.xSlicDesc = 0xc9a3e5c1,		/* "ItVA" */
+	.xSlicSize = sizeof(struct ItVpdAreas),
+	.xSlicVpdEntries = ItVpdMaxEntries,	/* # VPD array entries */
+	.xSlicDmaEntries = ItDmaMaxEntries,	/* # DMA array entries */
+	.xSlicMaxLogicalProcs = NR_CPUS * 2,	/* Max logical procs */
+	.xSlicMaxPhysicalProcs = maxPhysicalProcessors,	/* Max physical procs */
+	.xSlicDmaToksOffset = offsetof(struct ItVpdAreas, xPlicDmaToks),
+	.xSlicVpdAdrsOffset = offsetof(struct ItVpdAreas, xSlicVpdAdrs),
+	.xSlicDmaLensOffset = offsetof(struct ItVpdAreas, xPlicDmaLens),
+	.xSlicVpdLensOffset = offsetof(struct ItVpdAreas, xSlicVpdLens),
+	.xSlicMaxSlotLabels = 0,		/* max slot labels */
+	.xSlicMaxLpQueues = 1,			/* max LP queues */
+	.xPlicDmaLens = { 0 },			/* DMA lengths */
+	.xPlicDmaToks = { 0 },			/* DMA tokens */
+	.xSlicVpdLens = {			/* VPD lengths */
 	        0,0,0,		        /*  0 - 2 */
 		sizeof(xItExtVpdPanel), /*       3 Extended VPD   */
 		sizeof(struct paca_struct),	/*       4 length of Paca  */
@@ -201,7 +203,7 @@
 		sizeof(struct ItLpQueue),/*     23 length of Lp Queue */
 		0,0			/* 24 - 25 */
 		},
-	{			/* VPD addresses */
+	.xSlicVpdAdrs = {			/* VPD addresses */
 		0,0,0,  		/*	 0 -  2 */
 		&xItExtVpdPanel,        /*       3 Extended VPD */
 		&paca[0],		/*       4 first Paca */
diff -ruN linus-bk-sfr.11/arch/ppc64/kernel/ppc_ksyms.c linus-bk-sfr.12/arch/ppc64/kernel/ppc_ksyms.c
--- linus-bk-sfr.11/arch/ppc64/kernel/ppc_ksyms.c	2004-12-31 14:52:14.000000000 +1100
+++ linus-bk-sfr.12/arch/ppc64/kernel/ppc_ksyms.c	2005-01-04 18:07:42.000000000 +1100
@@ -68,9 +68,6 @@
 EXPORT_SYMBOL(__down_interruptible);
 EXPORT_SYMBOL(__up);
 EXPORT_SYMBOL(__down);
-#ifdef CONFIG_PPC_ISERIES
-EXPORT_SYMBOL(itLpNaca);
-#endif
 
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_generic);

--Signature=_Tue__4_Jan_2005_22_58_09_+1100_25FyCpIeJ=c0dlzw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2oTW4CJfqux9a+8RAutwAJ9QzzXjBdiBH6TK+UJrX3pt2M0rJACfR7JZ
H1oYekCSxgcP2AyPcnvxggM=
=+LwB
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Jan_2005_22_58_09_+1100_25FyCpIeJ=c0dlzw--

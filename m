Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVAJG2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVAJG2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 01:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAJG2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 01:28:43 -0500
Received: from ozlabs.org ([203.10.76.45]:59279 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262097AbVAJG2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 01:28:40 -0500
Date: Tue, 11 Jan 2005 05:00:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PPC64] Rename perf counter register #defines
Message-ID: <20050110180004.GC22101@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

This patch makes some cleanups to the #defines for various fields in
the MMCR0 performance monitor control register.  Specifically, the
names of a couple of bits are changed so that: a) they are a bit less
cumbersomely long and b) they match the names used in the hardware
documentation.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/include/asm-ppc64/processor.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/processor.h	2005-01-10 16:51:10.625391320 +1100
+++ working-2.6/include/asm-ppc64/processor.h	2005-01-10 16:51:28.771295712 +1100
@@ -331,8 +331,8 @@
 #define   MMCR0_FCECE	0x02000000UL /* freeze counters on enabled condition or event */
 /* time base exception enable */
 #define   MMCR0_TBEE	0x00400000UL /* time base exception enable */
-#define   MMCR0_PMC1INTCONTROL	0x00008000UL /* PMC1 count enable*/
-#define   MMCR0_PMCNINTCONTROL	0x00004000UL /* PMCn count enable*/
+#define   MMCR0_PMC1CE	0x00008000UL /* PMC1 count enable*/
+#define   MMCR0_PMCjCE	0x00004000UL /* PMCj count enable*/
 #define   MMCR0_TRIGGER	0x00002000UL /* TRIGGER enable */
 #define   MMCR0_PMAO	0x00000080UL /* performance monitor alert has occurred, set to 0 after handling exception */
 #define   MMCR0_SHRFC	0x00000040UL /* SHRre freeze conditions between threads */
Index: working-2.6/arch/ppc64/oprofile/op_model_rs64.c
===================================================================
--- working-2.6.orig/arch/ppc64/oprofile/op_model_rs64.c	2005-01-10 16:51:10.625391320 +1100
+++ working-2.6/arch/ppc64/oprofile/op_model_rs64.c	2005-01-10 16:51:28.772295560 +1100
@@ -119,7 +119,7 @@
 
 	mmcr0 |= MMCR0_FCM1|MMCR0_PMXE|MMCR0_FCECE;
 	/* Only applies to POWER3, but should be safe on RS64 */
-	mmcr0 |= MMCR0_PMC1INTCONTROL|MMCR0_PMCNINTCONTROL;
+	mmcr0 |= MMCR0_PMC1CE|MMCR0_PMCjCE;
 	mtspr(SPRN_MMCR0, mmcr0);
 
 	dbg("setup on cpu %d, mmcr0 %lx\n", smp_processor_id(),
Index: working-2.6/arch/ppc64/oprofile/op_model_power4.c
===================================================================
--- working-2.6.orig/arch/ppc64/oprofile/op_model_power4.c	2005-01-10 16:51:10.626391168 +1100
+++ working-2.6/arch/ppc64/oprofile/op_model_power4.c	2005-01-10 16:51:28.772295560 +1100
@@ -97,7 +97,7 @@
 	mtspr(SPRN_MMCR0, mmcr0);
 
 	mmcr0 |= MMCR0_FCM1|MMCR0_PMXE|MMCR0_FCECE;
-	mmcr0 |= MMCR0_PMC1INTCONTROL|MMCR0_PMCNINTCONTROL;
+	mmcr0 |= MMCR0_PMC1CE|MMCR0_PMCjCE;
 	mtspr(SPRN_MMCR0, mmcr0);
 
 	mtspr(SPRN_MMCR1, mmcr1_val);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson

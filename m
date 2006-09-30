Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWI3In4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWI3In4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWI3Inz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:43:55 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:48055 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751157AbWI3Inw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:43:52 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 4] x86-64: Calgary IOMMU: print PCI bus numbers in hex
X-Mercurial-Node: 28658cf477bc8c6adc5a5335363a4d1428f58273
Message-Id: <28658cf477bc8c6adc5a.1159605809@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1159605808@rhun.haifa.ibm.com>
Date: Sat, 30 Sep 2006 11:43:29 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@kudzu.us, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       muli@il.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1 files changed, 4 insertions(+), 4 deletions(-)
arch/x86_64/kernel/pci-calgary.c |    8 ++++----


# HG changeset patch
# User Muli Ben-Yehuda <muli@il.ibm.com>
# Date 1159604172 -10800
# Node ID 28658cf477bc8c6adc5a5335363a4d1428f58273
# Parent  585e6c1736a2a8b419ae9b8dc5055ee8774ba57f
x86-64: Calgary IOMMU: print PCI bus numbers in hex

From: Jon Mason <jdmason@kudzu.us>

Make the references to the bus number in hex instead of decimal, as
that is the way that lspci prints out the bus numbers.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>

diff -r 585e6c1736a2 -r 28658cf477bc arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Sat Sep 30 11:13:54 2006 +0300
+++ b/arch/x86_64/kernel/pci-calgary.c	Sat Sep 30 11:16:12 2006 +0300
@@ -715,7 +715,7 @@ static void calgary_watchdog(unsigned lo
 
 	/* If no error, the agent ID in the CSR is not valid */
 	if (val32 & CSR_AGENT_MASK) {
-		printk(KERN_EMERG "calgary_watchdog: DMA error on bus %d, "
+		printk(KERN_EMERG "calgary_watchdog: DMA error on PHB %#x, "
 				  "CSR = %#x\n", dev->bus->number, val32);
 		writel(0, target);
 
@@ -749,7 +749,7 @@ static void __init calgary_enable_transl
 	val32 = be32_to_cpu(readl(target));
 	val32 |= PHB_TCE_ENABLE | PHB_DAC_DISABLE | PHB_MCSR_ENABLE;
 
-	printk(KERN_INFO "Calgary: enabling translation on PHB %d\n", busnum);
+	printk(KERN_INFO "Calgary: enabling translation on PHB %#x\n", busnum);
 	printk(KERN_INFO "Calgary: errant DMAs will now be prevented on this "
 	       "bus.\n");
 
@@ -779,7 +779,7 @@ static void __init calgary_disable_trans
 	val32 = be32_to_cpu(readl(target));
 	val32 &= ~(PHB_TCE_ENABLE | PHB_DAC_DISABLE | PHB_MCSR_ENABLE);
 
-	printk(KERN_INFO "Calgary: disabling translation on PHB %d!\n", busnum);
+	printk(KERN_INFO "Calgary: disabling translation on PHB %#x!\n", busnum);
 	writel(cpu_to_be32(val32), target);
 	readl(target); /* flush */
 
@@ -1053,7 +1053,7 @@ static int __init calgary_parse_options(
 
 			if (bridge < MAX_PHB_BUS_NUM) {
 				printk(KERN_INFO "Calgary: disabling "
-				       "translation for PHB 0x%x\n", bridge);
+				       "translation for PHB %#x\n", bridge);
 				bus_info[bridge].translation_disabled = 1;
 			}
 		}

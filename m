Return-Path: <linux-kernel-owner+w=401wt.eu-S1751384AbXAFOHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbXAFOHR (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 09:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbXAFOHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 09:07:17 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:37099 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbXAFOHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 09:07:16 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 6 Jan 2007 15:07:05 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [rfc PATCH 2.6] ieee1394: ohci1394: drop pcmcia-cs compatibility code
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Message-ID: <tkrat.8dd8e7989e4ad9da@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#ifdef PCMCIA is only true if compiled inside pcmcia-cs, isn't it?

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/ohci1394.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: linux/drivers/ieee1394/ohci1394.c
===================================================================
--- linux.orig/drivers/ieee1394/ohci1394.c
+++ linux/drivers/ieee1394/ohci1394.c
@@ -3281,14 +3281,11 @@ static int __devinit ohci1394_pci_probe(
 		PRINT(KERN_WARNING, "PCI resource length of 0x%llx too small!",
 		      (unsigned long long)pci_resource_len(dev, 0));
 
-	/* Seems PCMCIA handles this internally. Not sure why. Seems
-	 * pretty bogus to force a driver to special case this.  */
-#ifndef PCMCIA
-	if (!request_mem_region (ohci_base, OHCI1394_REGISTER_SIZE, OHCI1394_DRIVER_NAME))
+	if (!request_mem_region(ohci_base, OHCI1394_REGISTER_SIZE,
+				OHCI1394_DRIVER_NAME))
 		FAIL(-ENOMEM, "MMIO resource (0x%llx - 0x%llx) unavailable",
 			(unsigned long long)ohci_base,
 			(unsigned long long)ohci_base + OHCI1394_REGISTER_SIZE);
-#endif
 	ohci->init_state = OHCI_INIT_HAVE_MEM_REGION;
 
 	ohci->registers = ioremap(ohci_base, OHCI1394_REGISTER_SIZE);
@@ -3509,10 +3506,8 @@ static void ohci1394_pci_remove(struct p
 		iounmap(ohci->registers);
 
 	case OHCI_INIT_HAVE_MEM_REGION:
-#ifndef PCMCIA
 		release_mem_region(pci_resource_start(ohci->dev, 0),
 				   OHCI1394_REGISTER_SIZE);
-#endif
 
 #ifdef CONFIG_PPC_PMAC
 	/* On UniNorth, power down the cable and turn off the chip clock

-- 
Stefan Richter
-=====-=-=== ---= --==-
http://arcgraph.de/sr/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266226AbTGDW7A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 18:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbTGDW7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 18:59:00 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:32272 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S266226AbTGDW51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 18:57:27 -0400
To: torvalds@osdl.org, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] [5/6] EISA support updates
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <wrpk7axvqv1.fsf@hina.wild-wind.fr.eu.org>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Sat, 05 Jul 2003 01:09:02 +0200
Message-ID: <wrpr855ubxt.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <wrpk7axvqv1.fsf@hina.wild-wind.fr.eu.org> (Marc Zyngier's
 message of "Sat, 05 Jul 2003 01:01:22 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCI-EISA bridge :

- Use parent bridge device dma_mask as default for each discovered
device.

	M.

diff -ruN linux-latest/drivers/eisa/pci_eisa.c linux-eisa/drivers/eisa/pci_eisa.c
--- linux-latest/drivers/eisa/pci_eisa.c	2003-07-04 09:39:31.000000000 +0200
+++ linux-eisa/drivers/eisa/pci_eisa.c	2003-07-04 09:40:43.000000000 +0200
@@ -20,7 +20,7 @@
 static struct eisa_root_device pci_eisa_root;
 
 static int __devinit pci_eisa_init (struct pci_dev *pdev,
-				  const struct pci_device_id *ent)
+				    const struct pci_device_id *ent)
 {
 	int rc;
 
@@ -35,6 +35,7 @@
 	pci_eisa_root.res	       = pdev->bus->resource[0];
 	pci_eisa_root.bus_base_addr    = pdev->bus->resource[0]->start;
 	pci_eisa_root.slots	       = EISA_MAX_SLOTS;
+	pci_eisa_root.dma_mask         = pdev->dma_mask;
 
 	if (eisa_root_register (&pci_eisa_root)) {
 		printk (KERN_ERR "pci_eisa : Could not register EISA root\n");

-- 
Places change, faces change. Life is so very strange.

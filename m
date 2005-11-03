Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbVKCAYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbVKCAYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbVKCAYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:24:41 -0500
Received: from fmr18.intel.com ([134.134.136.17]:20355 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030220AbVKCAYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:24:40 -0500
Subject: [patch 1/4] pci: store PCI_INTERRUPT_PIN in pci_dev
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: pcihpd-discuss@lists.sourceforge.net, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com,
       len.brown@intel.com
References: <20051103001540.365407000@whizzy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Nov 2005 16:24:32 -0800
Message-Id: <1130977472.8321.39.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
X-OriginalArrivalTime: 03 Nov 2005 00:24:33.0460 (UTC) FILETIME=[F6CA2740:01C5E00C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (patch-interrupt-pin)
Store the value of the INTERRUPT_PIN in the pci_dev structure
so that it can be retrieved later.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
 
 drivers/pci/probe.c |    1 +
 include/linux/pci.h |    1 +
 2 files changed, 2 insertions(+)

Index: linux-2.6.13/drivers/pci/probe.c
===================================================================
--- linux-2.6.13.orig/drivers/pci/probe.c
+++ linux-2.6.13/drivers/pci/probe.c
@@ -571,6 +571,7 @@ static void pci_read_irq(struct pci_dev 
 	unsigned char irq;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
+	dev->pin = irq;
 	if (irq)
 		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	dev->irq = irq;
Index: linux-2.6.13/include/linux/pci.h
===================================================================
--- linux-2.6.13.orig/include/linux/pci.h
+++ linux-2.6.13/include/linux/pci.h
@@ -98,6 +98,7 @@ struct pci_dev {
 	unsigned int	class;		/* 3 bytes: (base,sub,prog-if) */
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
 	u8		rom_base_reg;	/* which config register controls the ROM */
+	u8		pin;  		/* which interrupt pin this device uses */
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
 	u64		dma_mask;	/* Mask of the bits of bus address this

--

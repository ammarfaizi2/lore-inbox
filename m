Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbUKLXly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbUKLXly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbUKLXdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:33:00 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:51586 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262675AbUKLXWi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:38 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017193602@kroah.com>
Date: Fri, 12 Nov 2004 15:21:59 -0800
Message-Id: <11003017191779@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.15, 2004/11/12 14:09:00-08:00, hannal@us.ibm.com

[PATCH] pci_iommu.c: replace pci_find_device with pci_get_device

As pci_find_device is going away I've replaced it with pci_get_device.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/sparc64/kernel/pci_iommu.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/arch/sparc64/kernel/pci_iommu.c b/arch/sparc64/kernel/pci_iommu.c
--- a/arch/sparc64/kernel/pci_iommu.c	2004-11-12 15:10:12 -08:00
+++ b/arch/sparc64/kernel/pci_iommu.c	2004-11-12 15:10:12 -08:00
@@ -814,7 +814,7 @@
 	/* ALI sound chips generate 31-bits of DMA, a special register
 	 * determines what bit 31 is emitted as.
 	 */
-	ali_isa_bridge = pci_find_device(PCI_VENDOR_ID_AL,
+	ali_isa_bridge = pci_get_device(PCI_VENDOR_ID_AL,
 					 PCI_DEVICE_ID_AL_M1533,
 					 NULL);
 
@@ -824,6 +824,7 @@
 	else
 		val &= ~0x01;
 	pci_write_config_byte(ali_isa_bridge, 0x7e, val);
+	pci_dev_put(ali_isa_bridge);
 }
 
 int pci_dma_supported(struct pci_dev *pdev, u64 device_mask)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUJHWfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUJHWfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 18:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUJHWfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 18:35:34 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:2182 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266069AbUJHWf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 18:35:29 -0400
Date: Fri, 08 Oct 2004 15:35:28 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: greg@kroah.com, hannal@us.ibm.com, davem@davemloft.net, ecd@skynet.be,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org
Subject: [RFT 2.6] pci_iommu.c replace pci_find_device with pci_get_device
Message-ID: <84740000.1097274928@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As pci_find_device is going away I've replaced it with pci_get_device.
If someone with a Sparc64 system could test it I would appreciate it.
Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
---
diff -Nrup linux-2.6.9-rc3-mm3cln/arch/sparc64/kernel/pci_iommu.c linux-2.6.9-rc3-mm3patch3/arch/sparc64/kernel/pci_iommu.c
--- linux-2.6.9-rc3-mm3cln/arch/sparc64/kernel/pci_iommu.c	2004-09-29 20:03:56.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch3/arch/sparc64/kernel/pci_iommu.c	2004-10-08 15:23:37.585502792 -0700
@@ -814,7 +814,7 @@ static void ali_sound_dma_hack(struct pc
 	/* ALI sound chips generate 31-bits of DMA, a special register
 	 * determines what bit 31 is emitted as.
 	 */
-	ali_isa_bridge = pci_find_device(PCI_VENDOR_ID_AL,
+	ali_isa_bridge = pci_get_device(PCI_VENDOR_ID_AL,
 					 PCI_DEVICE_ID_AL_M1533,
 					 NULL);
 
@@ -824,6 +824,7 @@ static void ali_sound_dma_hack(struct pc
 	else
 		val &= ~0x01;
 	pci_write_config_byte(ali_isa_bridge, 0x7e, val);
+	pci_dev_put(ali_isa_bridge);
 }
 
 int pci_dma_supported(struct pci_dev *pdev, u64 device_mask)


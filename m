Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269534AbUJFXsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269534AbUJFXsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269547AbUJFXph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:45:37 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:41685 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269398AbUJFXmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:42:09 -0400
Date: Wed, 06 Oct 2004 16:42:42 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       hannal@us.ibm.com, paulus@samba.org
Subject: [PATCH 2.6] [3/12] k2.c replace pci_find_device with pci_get_device
Message-ID: <57450000.1097106162@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away I have replaced this call with pci_get_device.
If someone with a PPC system could verify it I would appreciate it.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

----
diff -Nrup linux-2.6.9-rc3-mm2cln/arch/ppc/platforms/k2.c linux-2.6.9-rc3-mm2patch/arch/ppc/platforms/k2.c
--- linux-2.6.9-rc3-mm2cln/arch/ppc/platforms/k2.c	2004-09-29 20:03:45.000000000 -0700
+++ linux-2.6.9-rc3-mm2patch/arch/ppc/platforms/k2.c	2004-10-06 16:33:25.278918216 -0700
@@ -116,7 +116,7 @@ void k2_pcibios_fixup(void)
 	/*
 	 * Enable DMA support on hdc
 	 */
-	ide_dev = pci_find_device(PCI_VENDOR_ID_AL,
+	ide_dev = pci_get_device(PCI_VENDOR_ID_AL,
 				  PCI_DEVICE_ID_AL_M5229, NULL);
 
 	if (ide_dev) {
@@ -126,6 +126,7 @@ void k2_pcibios_fixup(void)
 		ide_dma_base = pci_resource_start(ide_dev, 4);
 		outb(0x00, ide_dma_base + 0x2);
 		outb(0x20, ide_dma_base + 0xa);
+		pci_dev_put(ide_dev);
 	}
 #endif
 }




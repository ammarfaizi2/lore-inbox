Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269932AbUJGXrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269932AbUJGXrK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269945AbUJGXqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:46:17 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:56705 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269939AbUJGXkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:40:18 -0400
Date: Thu, 07 Oct 2004 16:40:48 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       hannal@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 2.6][11/12] prpmc750.c replace pci_find_device with pci_get_device
Message-ID: <35580000.1097192448@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away I've replaced it with pci_get_device.
If someone with a PPC system could test it I would appreciate it.

Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9-rc3-mm3cln/arch/ppc/platforms/prpmc750.c linux-2.6.9-rc3-mm3patch2/arch/ppc/platforms/prpmc750.c
--- linux-2.6.9-rc3-mm3cln/arch/ppc/platforms/prpmc750.c	2004-09-29 20:05:27.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch2/arch/ppc/platforms/prpmc750.c	2004-10-07 16:27:24.605503808 -0700
@@ -109,7 +109,7 @@ static void __init prpmc750_pcibios_fixu
 	 * resource subsystem doesn't fixup the
 	 * PCI mem resources on the CL5446.
 	 */
-	if ((dev = pci_find_device(PCI_VENDOR_ID_CIRRUS,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_CIRRUS,
 				   PCI_DEVICE_ID_CIRRUS_5446, 0))) {
 		dev->resource[0].start += PRPMC750_PCI_PHY_MEM_OFFSET;
 		dev->resource[0].end += PRPMC750_PCI_PHY_MEM_OFFSET;
@@ -121,6 +121,7 @@ static void __init prpmc750_pcibios_fixu
 		outb(0x0f, 0x3c4);
 		/* Set proper DRAM config */
 		outb(0xdf, 0x3c5);
+		pci_dev_put(dev);
 	}
 }
 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269547AbUJFXsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269547AbUJFXsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269540AbUJFXpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:45:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:7635 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269617AbUJFXmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:42:16 -0400
Date: Wed, 06 Oct 2004 16:42:41 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       hannal@us.ibm.com, paulus@samba.com
Subject: [PATCH 2.6] [4/12] lopec.c replace pci_find_device with pci_get_device
Message-ID: <57420000.1097106161@w-hlinder.beaverton.ibm.com>
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

diff -Nrup linux-2.6.9-rc3-mm2cln/arch/ppc/platforms/lopec.c linux-2.6.9-rc3-mm2patch2/arch/ppc/platforms/lopec.c
--- linux-2.6.9-rc3-mm2cln/arch/ppc/platforms/lopec.c	2004-09-29 20:04:57.000000000 -0700
+++ linux-2.6.9-rc3-mm2patch2/arch/ppc/platforms/lopec.c	2004-10-06 16:33:38.908846152 -0700
@@ -189,7 +189,7 @@ static unsigned long lopec_idedma_regbas
 static void
 lopec_ide_probe(void)
 {
-	struct pci_dev *dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+	struct pci_dev *dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 					      PCI_DEVICE_ID_WINBOND_82C105,
 					      NULL);
 	lopec_ide_ports_known = 1;
@@ -200,6 +200,7 @@ lopec_ide_probe(void)
 		lopec_ide_ctl_regbase[0] = dev->resource[1].start;
 		lopec_ide_ctl_regbase[1] = dev->resource[3].start;
 		lopec_idedma_regbase = dev->resource[4].start;
+		pci_dev_put(dev);
 	}
 }
 



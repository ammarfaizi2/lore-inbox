Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269946AbUJHACu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269946AbUJHACu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269923AbUJHAAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:00:34 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:11457 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269929AbUJGXnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:43:05 -0400
Date: Thu, 07 Oct 2004 16:43:36 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       hannal@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 2.6][12/12] sandpoint.c replace pci_find_device with pci_get_device
Message-ID: <36050000.1097192616@w-hlinder.beaverton.ibm.com>
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
diff -Nrup linux-2.6.9-rc3-mm3cln/arch/ppc/platforms/sandpoint.c linux-2.6.9-rc3-mm3patch3/arch/ppc/platforms/sandpoint.c
--- linux-2.6.9-rc3-mm3cln/arch/ppc/platforms/sandpoint.c	2004-09-29 20:06:04.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch3/arch/ppc/platforms/sandpoint.c	2004-10-07 16:36:52.946102904 -0700
@@ -531,7 +531,7 @@ static unsigned long	sandpoint_idedma_re
 static void
 sandpoint_ide_probe(void)
 {
-	struct pci_dev *pdev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+	struct pci_dev *pdev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 			PCI_DEVICE_ID_WINBOND_82C105, NULL);
 
 	if (pdev) {
@@ -540,6 +540,7 @@ sandpoint_ide_probe(void)
 		sandpoint_ide_ctl_regbase[0]=pdev->resource[1].start;
 		sandpoint_ide_ctl_regbase[1]=pdev->resource[3].start;
 		sandpoint_idedma_regbase=pdev->resource[4].start;
+		pci_dev_put(dev);
 	}
 
 	sandpoint_ide_ports_known = 1;


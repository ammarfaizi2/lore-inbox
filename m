Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268937AbUJTTGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268937AbUJTTGj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268984AbUJTSyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:54:37 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:34698 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S268995AbUJTSww
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:52:52 -0400
Date: Wed, 20 Oct 2004 11:53:01 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: Hanna Linder <hannal@us.ibm.com>, greg@kroah.com, davej@codemonkey.org.uk
Subject: [RFT 2.6] intel-mch-agp.c: replace pci_find_device with pci_get_device
Message-ID: <17860000.1098298381@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away soon I have converted this file to use
pci_get_device instead. I have compile tested it. If anyone has this hardware
and could test it that would be great.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
---

diff -Nrup linux-2.6.9cln/drivers/char/agp/intel-mch-agp.c linux-2.6.9patch3/drivers/char/agp/intel-mch-agp.c
--- linux-2.6.9cln/drivers/char/agp/intel-mch-agp.c	2004-10-18 16:35:52.000000000 -0700
+++ linux-2.6.9patch3/drivers/char/agp/intel-mch-agp.c	2004-10-18 17:23:22.000000000 -0700
@@ -470,9 +470,9 @@ static int find_i830(u16 device)
 {
 	struct pci_dev *i830_dev;
 
-	i830_dev = pci_find_device(PCI_VENDOR_ID_INTEL, device, NULL);
+	i830_dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, NULL);
 	if (i830_dev && PCI_FUNC(i830_dev->devfn) != 0) {
-		i830_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
+		i830_dev = pci_get_device(PCI_VENDOR_ID_INTEL,
 				device, i830_dev);
 	}
 
@@ -565,6 +565,7 @@ static void __devexit agp_intelmch_remov
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
+	pci_dev_put(pdev);
 	agp_remove_bridge(bridge);
 	agp_put_bridge(bridge);
 }


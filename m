Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269191AbUI2W2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269191AbUI2W2D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269148AbUI2W15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:27:57 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:47854 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S269150AbUI2W1T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:27:19 -0400
Date: Wed, 29 Sep 2004 15:28:20 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: kernel-janitors@lists.osdl.org, greg@kroah.com, hannal@us.ibm.com,
       kraxel@bytesex.org
Subject: [PATCH 2.6.9-rc2-mm4 zr36120.c][5/8] Convert pci_find_device to pci_dev_present
Message-ID: <19730000.1096496900@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The dev was not used from pci_find_device so it was acceptable to replace
with pci_dev_present. There was no need for it to be in a while loop originally.
Compile tested.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

diff -Nrup linux-2.6.9-rc2-mm4cln/drivers/media/video/zr36120.c linux-2.6.9-rc2-mm4patch/drivers/media/video/zr36120.c
--- linux-2.6.9-rc2-mm4cln/drivers/media/video/zr36120.c	2004-09-28 14:58:36.000000000 -0700
+++ linux-2.6.9-rc2-mm4patch/drivers/media/video/zr36120.c	2004-09-29 15:12:53.625518848 -0700
@@ -145,14 +145,16 @@ static struct { const char name[8]; uint
 static
 void __init handle_chipset(void)
 {
-	struct pci_dev *dev = NULL;
+	static struct pci_device_id intel_82437[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437) },
+		{ },
+	};
 
 	/* Just in case some nut set this to something dangerous */
 	if (triton1)
 		triton1 = ZORAN_VDC_TRICOM;
 
-	while ((dev = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437, dev)))
-	{
+	if (pci_dev_present(intel_82437)) {
 		printk(KERN_INFO "zoran: Host bridge 82437FX Triton PIIX\n");
 		triton1 = ZORAN_VDC_TRICOM;
 	}


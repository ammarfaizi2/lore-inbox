Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268998AbUI2Uyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268998AbUI2Uyl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269029AbUI2Uyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:54:41 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:46582 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268998AbUI2UyT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:54:19 -0400
Date: Wed, 29 Sep 2004 13:55:22 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: kernel-janitors@lists.osdl.org, greg@kroah.com, hannal@us.ibm.com,
       kraxel@bytesex.org
Subject: [PATCH 2.6.9-rc2-mm4 bttv-driver.c][4/8] convert pci_find_device to pci_dev_present
Message-ID: <15470000.1096491322@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away need to replace it. This file did not use the dev returned
from pci_find_device so is replaceable by pci_dev_present. I was not able to test it
as I do not have the hardware.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

diff -Nrup linux-2.6.9-rc2-mm4cln/drivers/media/video/bttv-driver.c linux-2.6.9-rc2-mm4patch/drivers/media/video/bttv-driver.c
--- linux-2.6.9-rc2-mm4cln/drivers/media/video/bttv-driver.c	2004-09-28 14:58:35.000000000 -0700
+++ linux-2.6.9-rc2-mm4patch/drivers/media/video/bttv-driver.c	2004-09-29 13:08:59.369697520 -0700
@@ -4012,6 +4012,10 @@ static int bttv_init_module(void)
 {
 	int rc;
 	bttv_num = 0;
+	static struct pci_device_id cx2388x[] {
+		{ PCI_DEVICE(0x14f1, 0x8800) },
+		{ },
+	};
 
 	printk(KERN_INFO "bttv: driver version %d.%d.%d loaded\n",
 	       (BTTV_VERSION_CODE >> 16) & 0xff,
@@ -4036,7 +4040,7 @@ static int bttv_init_module(void)
 	rc = pci_module_init(&bttv_pci_driver);
 	if (-ENODEV == rc) {
 		/* plenty of people trying to use bttv for the cx2388x ... */
-		if (NULL != pci_find_device(0x14f1, 0x8800, NULL))
+		if (pci_dev_present(cx2388x))
 			printk("bttv doesn't support your Conexant 2388x card.\n");
 	}
 	return rc;


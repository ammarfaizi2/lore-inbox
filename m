Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269196AbUI2XtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269196AbUI2XtW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269207AbUI2XtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:49:22 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:64659 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S269196AbUI2XtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:49:07 -0400
Date: Wed, 29 Sep 2004 16:50:14 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: kernel-janitors@lists.osdl.org, greg@kroah.com, vandrove@vc.cvut.cz
Subject: [PATCH 2.6.9-rc2-mm4 matroxfb_base.c][7/8] Replace pci_find_device with pci_dev_present
Message-ID: <26940000.1096501814@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away it is being replace with pci_dev_present (since the
dev is not used). I have compiled tested this.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---

diff -Nrup linux-2.6.9-rc2-mm4cln/drivers/video/matrox/matroxfb_base.c linux-2.6.9-rc2-mm4patch/drivers/video/matrox/matroxfb_base.c
--- linux-2.6.9-rc2-mm4cln/drivers/video/matrox/matroxfb_base.c	2004-09-28 14:59:07.000000000 -0700
+++ linux-2.6.9-rc2-mm4patch/drivers/video/matrox/matroxfb_base.c	2004-09-29 16:18:33.000000000 -0700
@@ -1578,6 +1578,11 @@ static int initMatrox2(WPMINFO struct bo
 	unsigned int memsize;
 	int err;
 
+	static struct pci_device_id intel_82437[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437) },
+		{ },
+	};
+
 	DBG(__FUNCTION__)
 
 	/* set default values... */
@@ -1682,7 +1687,7 @@ static int initMatrox2(WPMINFO struct bo
 		mga_option |= MX_OPTION_BSWAP;
                 /* disable palette snooping */
                 cmd &= ~PCI_COMMAND_VGA_PALETTE;
-		if (pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437, NULL)) {
+		if (pci_dev_present(intel_82437)) {
 			if (!(mga_option & 0x20000000) && !ACCESS_FBINFO(devflags.nopciretry)) {
 				printk(KERN_WARNING "matroxfb: Disabling PCI retries due to i82437 present\n");
 			}




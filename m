Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422644AbWJPPay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbWJPPay (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWJPPay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:30:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34502 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422644AbWJPPay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:30:54 -0400
Subject: [PATCH] igafb: switch to pci_get API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 16:57:24 +0100
Message-Id: <1161014244.24237.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/drivers/video/igafb.c linux-2.6.19-rc1-mm1/drivers/video/igafb.c
--- linux.vanilla-2.6.19-rc1-mm1/drivers/video/igafb.c	2006-10-13 15:06:57.000000000 +0100
+++ linux-2.6.19-rc1-mm1/drivers/video/igafb.c	2006-10-13 17:21:18.000000000 +0100
@@ -384,19 +384,21 @@
         if (!con_is_present())
                 return -ENXIO;
 
-        pdev = pci_find_device(PCI_VENDOR_ID_INTERG, 
+        pdev = pci_get_device(PCI_VENDOR_ID_INTERG, 
                                PCI_DEVICE_ID_INTERG_1682, 0);
 	if (pdev == NULL) {
 		/*
 		 * XXX We tried to use cyber2000fb.c for IGS 2000.
 		 * But it does not initialize the chip in JavaStation-E, alas.
 		 */
-        	pdev = pci_find_device(PCI_VENDOR_ID_INTERG, 0x2000, 0);
+        	pdev = pci_get_device(PCI_VENDOR_ID_INTERG, 0x2000, 0);
         	if(pdev == NULL) {
         	        return -ENXIO;
 		}
 		iga2000 = 1;
 	}
+	/* We leak a reference here but as it cannot be unloaded this is
+	   fine. If you write unload code remember to free it in unload */
 	
 	size = sizeof(struct fb_info) + sizeof(struct iga_par) + sizeof(u32)*16;
 


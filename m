Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269943AbUJHAR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269943AbUJHAR3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269899AbUJGXAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:00:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:40659 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269900AbUJGWuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:50:02 -0400
Date: Thu, 07 Oct 2004 15:50:24 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       hannal@us.ibm.com
Subject: [PATCH 2.6] [6/12] mcpn765.c replace pci_find_device with pci_get_device
Message-ID: <30170000.1097189424@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away I've replaced it with pci_get_device and pci_dev_put.
If someone with a PPC system could test it I would appreciate it.

Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---

diff -Nrup linux-2.6.9-rc3-mm2cln/arch/ppc/platforms/mcpn765.c linux-2.6.9-rc3-mm2patch/arch/ppc/platforms/mcpn765.c
--- linux-2.6.9-rc3-mm2cln/arch/ppc/platforms/mcpn765.c	2004-09-29 20:05:19.000000000 -0700
+++ linux-2.6.9-rc3-mm2patch/arch/ppc/platforms/mcpn765.c	2004-10-07 15:28:14.297232704 -0700
@@ -185,7 +185,7 @@ mcpn765_setup_via_82c586b(void)
 	struct pci_dev	*dev;
 	u_char		c;
 
-	if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
 				   PCI_DEVICE_ID_VIA_82C586_0,
 				   NULL)) == NULL) {
 		printk("No VIA ISA bridge found\n");
@@ -209,8 +209,8 @@ mcpn765_setup_via_82c586b(void)
 	pci_write_config_dword(dev, 0x54, 0);
 	pci_write_config_byte(dev, 0x58, 0);
 
-
-	if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+	pci_dev_put(dev);
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
 				   PCI_DEVICE_ID_VIA_82C586_1,
 				   NULL)) == NULL) {
 		printk("No VIA ISA bridge found\n");
@@ -225,6 +225,7 @@ mcpn765_setup_via_82c586b(void)
 	pci_read_config_byte(dev, 0x40, &c);
 	c |= 0x03;
 	pci_write_config_byte(dev, 0x40, c);
+	pci_dev_put(dev);
 
 	return;
 }


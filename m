Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269034AbUIMXmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269034AbUIMXmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 19:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268980AbUIMXmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 19:42:46 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:50371 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269040AbUIMXlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 19:41:03 -0400
Date: Mon, 13 Sep 2004 16:37:23 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: rth@twiddle.net, ink@jurassic.park.msu.ru
cc: linux-kernel@vger.kernel.org, greg@kroah.com, wli@holomorphy.com,
       hannal@us.ibm.com
Subject: [RFT 2.6.9-rc1 alpha sys_sio.c] [2/2] convert pci_find_device to pci_get_device
Message-ID: <806430000.1095118643@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a very simple patch to convert pci_find_device call to pci_get_device.
As I don't have an alpha box or cross compiler could someone (wli- wink wink)
please verify it compiles and doesn't break anything, thanks a lot.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

diff -Nrup linux-2.6.9-rc1/arch/alpha/kernel/sys_sio.c linux-2.6.9-rc1-alpha/arch/alpha/kernel/sys_sio.c
--- linux-2.6.9-rc1/arch/alpha/kernel/sys_sio.c	2004-08-13 22:36:12.000000000 -0700
+++ linux-2.6.9-rc1-alpha/arch/alpha/kernel/sys_sio.c	2004-09-13 16:04:58.135130904 -0700
@@ -105,7 +105,7 @@ sio_collect_irq_levels(void)
 	struct pci_dev *dev = NULL;
 
 	/* Iterate through the devices, collecting IRQ levels.  */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		if ((dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) &&
 		    (dev->class >> 8 != PCI_CLASS_BRIDGE_PCMCIA))
 			continue;
@@ -229,7 +229,7 @@ alphabook1_init_pci(void)
 	 */
 
 	dev = NULL;
-	while ((dev = pci_find_device(PCI_VENDOR_ID_NCR, PCI_ANY_ID, dev))) {
+	while ((dev = pci_get_device(PCI_VENDOR_ID_NCR, PCI_ANY_ID, dev))) {
                 if (dev->device == PCI_DEVICE_ID_NCR_53C810
 		    || dev->device == PCI_DEVICE_ID_NCR_53C815
 		    || dev->device == PCI_DEVICE_ID_NCR_53C820



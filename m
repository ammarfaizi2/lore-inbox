Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269048AbUIMXkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269048AbUIMXkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 19:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269040AbUIMXkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 19:40:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:13530 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S269048AbUIMXkf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 19:40:35 -0400
Date: Mon, 13 Sep 2004 16:37:13 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: rth@twiddle.net, ink@jurassic.park.msu.ru
cc: linux-kernel@vger.kernel.org, greg@kroah.com, wli@holomorphy.com,
       hannal@us.ibm.com
Subject: [RFT 2.6.9-rc1 alpha sys_alcor.c] [1/2] convert pci_find_device to pci_get_device
Message-ID: <806400000.1095118633@w-hlinder.beaverton.ibm.com>
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

Signed-off-by: Hanna Linder  <hannal@us.ibm.com>
----------

diff -Nrup linux-2.6.9-rc1/arch/alpha/kernel/sys_alcor.c linux-2.6.9-rc1-alpha/arch/alpha/kernel/sys_alcor.c
--- linux-2.6.9-rc1/arch/alpha/kernel/sys_alcor.c	2004-08-13 22:38:08.000000000 -0700
+++ linux-2.6.9-rc1-alpha/arch/alpha/kernel/sys_alcor.c	2004-09-10 11:33:06.000000000 -0700
@@ -254,7 +254,7 @@ alcor_init_pci(void)
 	 * motherboard, by looking for a 21040 TULIP in slot 6, which is
 	 * built into XLT and BRET/MAVERICK, but not available on ALCOR.
 	 */
-	dev = pci_find_device(PCI_VENDOR_ID_DEC,
+	dev = pci_get_device(PCI_VENDOR_ID_DEC,
 			      PCI_DEVICE_ID_DEC_TULIP,
 			      NULL);
 	if (dev && dev->devfn == PCI_DEVFN(6,0)) {
@@ -262,6 +262,7 @@ alcor_init_pci(void)
 		printk(KERN_INFO "%s: Detected AS500 or XLT motherboard.\n",
 		       __FUNCTION__);
 	}
+	pci_dev_put(dev);
 }
 
 



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268760AbUI2SOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268760AbUI2SOa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 14:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268767AbUI2SOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 14:14:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:51098 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S268760AbUI2SO1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 14:14:27 -0400
Date: Wed, 29 Sep 2004 11:15:24 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: kernel-janitors@lists.osdl.org, hannal@us.ibm.com, greg@kroah.com
Subject: [PATCH 2.6.9-rc2-mm4 scx200_wdt.c] [1/8] Patch to replace pci_find_device with pci_dev_present
Message-ID: <77800000.1096481724@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch to replace the soon to be defunct pci_find_device with the
new function pci_dev_present. I found 8 .c files (outside of /drivers/net)
that used pci_find_device without the dev it returned. therefore it
was replaceable with the new function.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

diff -Nrup linux-2.6.9-rc2-mm4cln/drivers/char/watchdog/scx200_wdt.c linux-2.6.9-rc2-mm4patch/drivers/char/watchdog/scx200_wdt.c
--- linux-2.6.9-rc2-mm4cln/drivers/char/watchdog/scx200_wdt.c	2004-09-12 22:32:55.000000000 -0700
+++ linux-2.6.9-rc2-mm4patch/drivers/char/watchdog/scx200_wdt.c	2004-09-29 11:07:03.836301112 -0700
@@ -217,6 +217,11 @@ static struct miscdevice scx200_wdt_misc
 static int __init scx200_wdt_init(void)
 {
 	int r;
+	static struct pci_device_id ns_sc[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_BRIDGE) },
+		{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SC1100_BRIDGE) },
+		{ },
+	};
 
 	printk(KERN_DEBUG NAME ": NatSemi SCx200 Watchdog Driver\n");
 
@@ -224,12 +229,7 @@ static int __init scx200_wdt_init(void)
 	 * First check that this really is a NatSemi SCx200 CPU or a Geode
 	 * SC1100 processor
 	 */
-	if ((pci_find_device(PCI_VENDOR_ID_NS,
-			     PCI_DEVICE_ID_NS_SCx200_BRIDGE,
-			     NULL)) == NULL
-	    && (pci_find_device(PCI_VENDOR_ID_NS,
-				PCI_DEVICE_ID_NS_SC1100_BRIDGE,
-				NULL)) == NULL)
+	if (!pci_dev_present(ns_sc))
 		return -ENODEV;
 
 	/* More sanity checks, verify that the configuration block is there */


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbUKMB4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbUKMB4X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 20:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUKLXbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:31:55 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:30605 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262677AbUKLXWj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:39 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1100301717158@kroah.com>
Date: Fri, 12 Nov 2004 15:21:57 -0800
Message-Id: <11003017173408@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.66.21, 2004/11/10 16:45:21-08:00, hannal@us.ibm.com

[PATCH] scx200_wdt.c: replace pci_find_device with pci_dev_present

Patch to replace the soon to be defunct pci_find_device with the
new function pci_dev_present. I found 8 .c files (outside of /drivers/net)
that used pci_find_device without the dev it returned. therefore it
was replaceable with the new function.


Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/char/watchdog/scx200_wdt.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


diff -Nru a/drivers/char/watchdog/scx200_wdt.c b/drivers/char/watchdog/scx200_wdt.c
--- a/drivers/char/watchdog/scx200_wdt.c	2004-11-12 15:12:19 -08:00
+++ b/drivers/char/watchdog/scx200_wdt.c	2004-11-12 15:12:19 -08:00
@@ -217,6 +217,11 @@
 static int __init scx200_wdt_init(void)
 {
 	int r;
+	static struct pci_device_id ns_sc[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_BRIDGE) },
+		{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SC1100_BRIDGE) },
+		{ },
+	};
 
 	printk(KERN_DEBUG NAME ": NatSemi SCx200 Watchdog Driver\n");
 
@@ -224,12 +229,7 @@
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


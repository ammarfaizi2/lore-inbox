Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbUKLXlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbUKLXlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbUKLXjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:39:47 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:26765 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262670AbUKLXWf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:35 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1100301720747@kroah.com>
Date: Fri, 12 Nov 2004 15:22:00 -0800
Message-Id: <11003017203252@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.23, 2004/11/12 14:11:49-08:00, hannal@us.ibm.com

[PATCH] pmac_pci.c: replace pci_find_device with pci_get_device

As pci_find_device is going away I've replaced it with pci_get_device.


Signed-off-by: Hanna Linder <hannal@us.ibm.com>


 arch/ppc/platforms/pmac_pci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/arch/ppc/platforms/pmac_pci.c b/arch/ppc/platforms/pmac_pci.c
--- a/arch/ppc/platforms/pmac_pci.c	2004-11-12 15:09:11 -08:00
+++ b/arch/ppc/platforms/pmac_pci.c	2004-11-12 15:09:11 -08:00
@@ -889,7 +889,7 @@
 	 * should find the device node and apply the interrupt
 	 * obtained from the OF device-tree
 	 */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		struct device_node *node;
 		node = pci_device_to_OF_node(dev);
 		/* this is the node, see if it has interrupts */
@@ -989,7 +989,7 @@
 	 *
 	 * -- BenH
 	 */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		if ((dev->class >> 16) == PCI_BASE_CLASS_STORAGE)
 			pci_enable_device(dev);
 	}


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbUKLXlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbUKLXlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbUKLXkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:40:18 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:27875 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262667AbUKLXWd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:33 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017203252@kroah.com>
Date: Fri, 12 Nov 2004 15:22:01 -0800
Message-Id: <1100301721392@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.24, 2004/11/12 14:12:11-08:00, hannal@us.ibm.com

[PATCH] pplus.c: replace pci_find_device with pci_get_device

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc/platforms/pplus.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)


diff -Nru a/arch/ppc/platforms/pplus.c b/arch/ppc/platforms/pplus.c
--- a/arch/ppc/platforms/pplus.c	2004-11-12 15:09:04 -08:00
+++ b/arch/ppc/platforms/pplus.c	2004-11-12 15:09:04 -08:00
@@ -359,7 +359,7 @@
 	 * Perform specific configuration for the Via Tech or
 	 * or Winbond PCI-ISA-Bridge part.
 	 */
-	if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
 				   PCI_DEVICE_ID_VIA_82C586_1, dev))) {
 		/*
 		 * PPCBUG does not set the enable bits
@@ -371,7 +371,7 @@
 		pci_write_config_byte(dev, 0x40, reg);
 	}
 
-	if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
 				   PCI_DEVICE_ID_VIA_82C586_2,
 				   dev)) && (dev->devfn = 0x5a)) {
 		/* Force correct USB interrupt */
@@ -379,7 +379,7 @@
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 	}
 
-	if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 				   PCI_DEVICE_ID_WINBOND_83C553, dev))) {
 		/* Clear PCI Interrupt Routing Control Register. */
 		short_reg = 0x0000;
@@ -389,7 +389,7 @@
 		pci_write_config_byte(dev, 0x43, reg);
 	}
 
-	if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 				   PCI_DEVICE_ID_WINBOND_82C105, dev))) {
 		/*
 		 * Disable LEGIRQ mode so PCI INTS are routed
@@ -401,6 +401,7 @@
 		dev->irq = 14;
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 	}
+	pci_dev_put(dev);
 }
 
 void __init pplus_set_VIA_IDE_legacy(void)


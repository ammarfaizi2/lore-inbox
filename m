Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267869AbUJLVk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267869AbUJLVk7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 17:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267881AbUJLVk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 17:40:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:51711 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S267869AbUJLVkx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 17:40:53 -0400
Date: Tue, 12 Oct 2004 14:40:58 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: sfeldma@pobox.com
cc: Hanna Linder <hannal@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>,
       benh@kernel.crashing.org, paulus@samba.org, greg@kroah.com
Subject: Re: [Kernel-janitors] [PATCH 2.6][9/12] pplus.c replace	pci_find_device with pci_get_device
Message-ID: <147050000.1097617258@w-hlinder.beaverton.ibm.com>
In-Reply-To: <1097341320.3903.3.camel@sfeldma-mobl2.dsl-verizon.net>
References: <33930000.1097191565@w-hlinder.beaverton.ibm.com> <1097341320.3903.3.camel@sfeldma-mobl2.dsl-verizon.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Saturday, October 09, 2004 10:02:01 AM -0700 Scott Feldman <sfeldma@pobox.com> wrote:
> 
> Missing cleanup at the bottom of func?

Here is the new patch:

diff -Nrup linux-2.6.9-rc4-mm1cln/arch/ppc/platforms/pplus.c linux-2.6.9-rc4-mm1patch/arch/ppc/platforms/pplus.c
--- linux-2.6.9-rc4-mm1cln/arch/ppc/platforms/pplus.c	2004-10-12 14:15:28.000000000 -0700
+++ linux-2.6.9-rc4-mm1patch/arch/ppc/platforms/pplus.c	2004-10-12 14:24:44.608410992 -0700
@@ -359,7 +359,7 @@ void __init pplus_pib_init(void)
 	 * Perform specific configuration for the Via Tech or
 	 * or Winbond PCI-ISA-Bridge part.
 	 */
-	if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
 				   PCI_DEVICE_ID_VIA_82C586_1, dev))) {
 		/*
 		 * PPCBUG does not set the enable bits
@@ -371,7 +371,7 @@ void __init pplus_pib_init(void)
 		pci_write_config_byte(dev, 0x40, reg);
 	}
 
-	if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
 				   PCI_DEVICE_ID_VIA_82C586_2,
 				   dev)) && (dev->devfn = 0x5a)) {
 		/* Force correct USB interrupt */
@@ -379,7 +379,7 @@ void __init pplus_pib_init(void)
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 	}
 
-	if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 				   PCI_DEVICE_ID_WINBOND_83C553, dev))) {
 		/* Clear PCI Interrupt Routing Control Register. */
 		short_reg = 0x0000;
@@ -389,7 +389,7 @@ void __init pplus_pib_init(void)
 		pci_write_config_byte(dev, 0x43, reg);
 	}
 
-	if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 				   PCI_DEVICE_ID_WINBOND_82C105, dev))) {
 		/*
 		 * Disable LEGIRQ mode so PCI INTS are routed
@@ -401,6 +401,7 @@ void __init pplus_pib_init(void)
 		dev->irq = 14;
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 	}
+	pci_dev_put(dev);
 }
 
 void __init pplus_set_VIA_IDE_legacy(void)


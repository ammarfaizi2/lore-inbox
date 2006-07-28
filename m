Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWG1NBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWG1NBE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWG1NBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:01:03 -0400
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:61118 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1030224AbWG1NBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:01:02 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.3
Subject: [PATCH] VIA IRQ quirk fixup only in XT_PIC mode Take 2
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: linux-kernel@vger.kernel.org
Cc: Daniel Drake <dsd@gentoo.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       greg@kroah.com, jeff@garzik.org, harmon@ksu.edu
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Jul 2006 14:01:01 +0100
Message-Id: <1154091662.7200.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this patch (now for 2.6.18-rc2) is more readable.

Thanks,
--
Sérgio M. B. 

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Scott J. Harmon" <harmon@ksu.edu>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
---
 quirks.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- linux-2.6.17.i686/drivers/pci/quirks.c.orig	2006-07-28 12:59:04.000000000 +0100
+++ linux-2.6.17.i686/drivers/pci/quirks.c	2006-07-28 13:26:49.000000000 +0100
@@ -648,11 +648,17 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
  *
  * Some of the on-chip devices are actually '586 devices' so they are
  * listed here.
+ * 
+ * if flags say that we have working apic(s), we don't need to quirk these
+ * devices
  */
 static void quirk_via_irq(struct pci_dev *dev)
 {
 	u8 irq, new_irq;
 
+	if ((smp_found_config && !skip_ioapic_setup && nr_ioapics) || cpu_has_apic)
+		return;
+
 	new_irq = dev->irq & 0xf;
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq != irq) {
@@ -662,13 +668,7 @@ static void quirk_via_irq(struct pci_dev
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
 
 /*
  * VIA VT82C598 has its device ID settable and many BIOSes





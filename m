Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVA1OyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVA1OyH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVA1OyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:54:07 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:47053 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261436AbVA1Oxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:53:53 -0500
Message-Id: <200501281453.j0SErn7w002778@d03av02.boulder.ibm.com>
Subject: [PATCH 1/1] pci: Add Citrine quirk
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, brking@us.ibm.com
From: brking@us.ibm.com
Date: Fri, 28 Jan 2005 08:53:47 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The IBM Citrine chipset has a feature that if PCI config register
0xA0 is read while DMAs are being performed to it, there is the possiblity
that the parity will be wrong on the PCI bus, causing a parity error and
a master abort. On this chipset, this register is simply a debug register
for the chip developers and the registers after it are not defined.
Patch sets cfg_size to 0xA0 to prevent this problem from being seen.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6.11-rc2-bk5-bjking1/drivers/pci/quirks.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

diff -puN drivers/pci/quirks.c~pci_citrine_quirk drivers/pci/quirks.c
--- linux-2.6.11-rc2-bk5/drivers/pci/quirks.c~pci_citrine_quirk	2005-01-27 16:51:28.000000000 -0600
+++ linux-2.6.11-rc2-bk5-bjking1/drivers/pci/quirks.c	2005-01-27 16:51:28.000000000 -0600
@@ -216,6 +216,16 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443BX_2, 	quirk_natoma );
 
 /*
+ *  This chip can cause PCI parity errors if config register 0xA0 is read
+ *  while DMAs are occurring.
+ */
+static void __devinit quirk_citrine(struct pci_dev *dev)
+{
+	dev->cfg_size = 0xA0;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CITRINE,	quirk_citrine );
+
+/*
  *  S3 868 and 968 chips report region size equal to 32M, but they decode 64M.
  *  If it's needed, re-allocate the region.
  */
_

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbVBCS7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbVBCS7W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVBCRwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:52:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:19112 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262650AbVBCRlZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:41:25 -0500
Cc: brking@us.ibm.com
Subject: [PATCH] pci: Add Citrine quirk
In-Reply-To: <11074524201252@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Feb 2005 09:40:21 -0800
Message-Id: <11074524211780@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2042, 2005/02/03 00:40:09-08:00, brking@us.ibm.com

[PATCH] pci: Add Citrine quirk

The IBM Citrine chipset has a feature that if PCI config register
0xA0 is read while DMAs are being performed to it, there is the possiblity
that the parity will be wrong on the PCI bus, causing a parity error and
a master abort. On this chipset, this register is simply a debug register
for the chip developers and the registers after it are not defined.
Patch sets cfg_size to 0xA0 to prevent this problem from being seen.

Signed-off-by: Brian King <brking@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/quirks.c |   10 ++++++++++
 1 files changed, 10 insertions(+)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-02-03 09:28:53 -08:00
+++ b/drivers/pci/quirks.c	2005-02-03 09:28:53 -08:00
@@ -216,6 +216,16 @@
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279157AbRKFMz0>; Tue, 6 Nov 2001 07:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279156AbRKFMzR>; Tue, 6 Nov 2001 07:55:17 -0500
Received: from ns.caldera.de ([212.34.180.1]:34462 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S277782AbRKFMzC>;
	Tue, 6 Nov 2001 07:55:02 -0500
Date: Tue, 6 Nov 2001 13:54:06 +0100
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: deanna_bonds@adaptec.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: dpt_i2o PCI devicetable
Message-ID: <20011106135406.A2352@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deanna, Alan,

This adds PCI device table to dpt_i2o.c which allows automatic module loading
for automatic module installers.

Unfortunately I don't have such a card, or I would have changed the code to
use the table.

Ciao, Marcus

Index: drivers/scsi/dpt_i2o.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/scsi/dpt_i2o.c,v
retrieving revision 1.11
diff -u -r1.11 dpt_i2o.c
--- drivers/scsi/dpt_i2o.c	2001/10/25 16:49:35	1.11
+++ drivers/scsi/dpt_i2o.c	2001/11/06 11:22:02
@@ -165,6 +165,13 @@
  *============================================================================
  */
 
+static struct pci_device_id dptids[] = {
+	{ PCI_DPT_VENDOR_ID, PCI_DPT_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{ PCI_DPT_VENDOR_ID, PCI_DPT_RAPTOR_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci,dptids);
+
 static int adpt_detect(Scsi_Host_Template* sht)
 {
 	struct pci_dev *pDev = NULL;

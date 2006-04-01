Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbWDAOq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWDAOq1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 09:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWDAOq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 09:46:27 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:12301 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751534AbWDAOq0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 09:46:26 -0500
Date: Sat, 1 Apr 2006 16:46:35 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH] PCI: Add PCI quirk for SMBus on the Asus A6VA notebook
Message-Id: <20060401164635.3a69bc24.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

The Asus A6VA notebook was reported to need a PCI quirk to unhide
the SMBus.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/pci/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.16-git.orig/drivers/pci/quirks.c	2006-03-31 09:37:17.000000000 +0200
+++ linux-2.6.16-git/drivers/pci/quirks.c	2006-03-31 23:30:45.000000000 +0200
@@ -921,6 +921,7 @@
 		if (dev->device == PCI_DEVICE_ID_INTEL_82915GM_HB) {
 			switch (dev->subsystem_device) {
 			case 0x1882: /* M6V notebook */
+			case 0x1977: /* A6VA notebook */
 				asus_hides_smbus = 1;
 			}
 		}
@@ -999,6 +1000,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc );
 
 static void __init asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
 {


-- 
Jean Delvare

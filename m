Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbVIFUje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbVIFUje (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbVIFUje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:39:34 -0400
Received: from outgoing-mail.its.caltech.edu ([131.215.239.19]:51047 "EHLO
	outgoing-mail.its.caltech.edu") by vger.kernel.org with ESMTP
	id S1750895AbVIFUjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:39:33 -0400
Date: Tue, 6 Sep 2005 13:39:32 -0700 (PDT)
From: Rumen Ivanov Zarev <rzarev@its.caltech.edu>
Message-Id: <200509062039.j86KdWMr014934@inky.its.caltech.edu>
To: gregkh@suse.de
Subject: [PATCH] PCI: Unhide SMBus on Compaq Evo N620c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch against 2.6.13 to unhide SMBus on Compaq Evo N620c laptop using
Intel 82855PM chipset.

Signed-off-by: Rumen Zarev <rzarev@caltech.edu>

--- linux-2.6.13/drivers/pci/quirks.c.orig	2005-09-05 23:36:49.213894072 +0300
+++ linux-2.6.13/drivers/pci/quirks.c	2005-09-05 23:42:15.391307568 +0300
@@ -850,6 +850,12 @@ static void __init asus_hides_smbus_host
                        case 0xC00C: /* Samsung P35 notebook */
                                asus_hides_smbus = 1;
                        }
+	} else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_COMPAQ)) {
+		if (dev->device == PCI_DEVICE_ID_INTEL_82855PM_HB)
+			switch(dev->subsystem_device) {
+			case 0x0058: /* Compaq Evo N620c */
+				asus_hides_smbus = 1;
+			}
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge );


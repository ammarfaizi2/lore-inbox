Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVBMTqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVBMTqX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 14:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVBMTqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 14:46:22 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:46865 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261235AbVBMTqS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 14:46:18 -0500
Date: Sun, 13 Feb 2005 20:46:39 +0100
From: Jean Delvare <khali@linux-fr.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Frans Pop <aragorn@tiscali.nl>
Subject: [PATCH 2.6] Add PCI quirk for SMBus on the Toshiba Satellite A40
Message-Id: <20050213204639.1f0b4a27.khali@linux-fr.org>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The Toshiba Satellite A40 laptop hides its SMBus device, much like a
number of Asus boards reputedly do. This prevents access to the LM90
hardware monitoring chip. This simple patch extends the PCI quirk used
for the Asus and HP systems to this Toshiba laptop.

Please consider for merge into the PCI subsystem,
thanks.

Signed-off-by: Frans Pop <aragorn@tiscali.nl>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux/drivers/pci/quirks.c.orig	2005-02-12 19:44:37.000000000 +0100
+++ linux/drivers/pci/quirks.c	2005-02-13 12:35:28.000000000 +0100
@@ -801,6 +801,12 @@
 			case 0x12bc: /* HP D330L */
 				asus_hides_smbus = 1;
 			}
+	} else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_TOSHIBA)) {
+		if (dev->device == PCI_DEVICE_ID_INTEL_82855GM_HB)
+			switch(dev->subsystem_device) {
+			case 0x0001: /* Toshiba Satellite A40 */
+				asus_hides_smbus = 1;
+			}
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge );


-- 
Jean Delvare

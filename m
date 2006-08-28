Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWH1Tn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWH1Tn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWH1Tn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:43:29 -0400
Received: from 83-216-141-215.markhi700.adsl.metronet.co.uk ([83.216.141.215]:33804
	"EHLO mx.hindley.org.uk") by vger.kernel.org with ESMTP
	id S1751393AbWH1Tn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:43:28 -0400
Date: Mon, 28 Aug 2006 20:43:25 +0100
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.17.9: Add VIA quirk fixup for VT8235 usb2
Message-ID: <20060828194325.GA10705@hindley.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Mark Hindley <mark@hindley.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch to add VIA PCI quirk for Enhanced/Extended USB on VT8235
southbridge. It is needed in order to use EHCI/USB 2.0 with ACPI.
Without it IRQs are not routed correctly, you get an "Unlink after
no-IRQ?" error and the device is unusable.

Signed-off-by: Mark Hindley <mark@hindley.org.uk>

---

I belive this could also be a fix for Bugzilla Bug 5835.


Mark

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d378478..c47ea21 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -655,6 +655,7 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_V
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, quirk_via_irq);
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irq);
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8235_USB_2, quirk_via_irq);
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 590dc6d..238be3f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1263,6 +1263,7 @@
 #define PCI_DEVICE_ID_VIA_8367_0	0x3099
 #define PCI_DEVICE_ID_VIA_8653_0	0x3101
 #define PCI_DEVICE_ID_VIA_8622		0x3102
+#define PCI_DEVICE_ID_VIA_8235_USB_2	0x3104
 #define PCI_DEVICE_ID_VIA_8233C_0	0x3109
 #define PCI_DEVICE_ID_VIA_8361		0x3112
 #define PCI_DEVICE_ID_VIA_XM266		0x3116

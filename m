Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVKULps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVKULps (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 06:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVKULps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 06:45:48 -0500
Received: from [85.8.13.51] ([85.8.13.51]:23966 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932194AbVKULpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 06:45:47 -0500
Message-ID: <4381B364.2020808@drzeus.cx>
Date: Mon, 21 Nov 2005 12:45:40 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [RFC] Secure Digital Host Controller PCI class
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a driver for the Secure Digital Host Controller
interface. This is a generic interface, so it uses a PCI class for
identification instead of vendor/device ids.

The class ID used is 0805 and the programming interface (correct term?)
indicates DMA capabilities. Greg, since you're the PCI maintainer,
perhaps you have the possibility of checking this ID?

The standard also dictates a register at offset 0x40 in PCI space. This
is a one byte register detailing the number of slots on the controller
and the first BAR to use.

The driver isn't ready yet (I'm aiming for 2.6.16) but this is the PCI
related patch I'd like committed further on:


diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -68,6 +68,7 @@
 #define PCI_CLASS_SYSTEM_TIMER         0x0802
 #define PCI_CLASS_SYSTEM_RTC           0x0803
 #define PCI_CLASS_SYSTEM_PCI_HOTPLUG   0x0804
+#define PCI_CLASS_SYSTEM_SDHCI         0x0805
 #define PCI_CLASS_SYSTEM_OTHER         0x0880

 #define PCI_BASE_CLASS_INPUT           0x09
diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
--- a/include/linux/pci_regs.h
+++ b/include/linux/pci_regs.h
@@ -108,6 +108,9 @@
 #define PCI_INTERRUPT_PIN      0x3d    /* 8 bits */
 #define PCI_MIN_GNT            0x3e    /* 8 bits */
 #define PCI_MAX_LAT            0x3f    /* 8 bits */
+#define PCI_SLOT_INFO          0x40    /* 8 bits */
+#define  PCI_SLOT_INFO_SLOTS(x)        ((x >> 4) & 7)
+#define  PCI_SLOT_INFO_FIRST_BAR_MASK  0x07

 /* Header type 1 (PCI-to-PCI bridges) */
 #define PCI_PRIMARY_BUS                0x18    /* Primary bus number */

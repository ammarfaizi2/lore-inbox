Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbVHJVhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbVHJVhc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 17:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbVHJVhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 17:37:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:6330 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030283AbVHJVhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 17:37:31 -0400
Subject: patch pci-cleanup-return-values-fix.patch added to gregkh-2.6 tree
To: stern@rowland.harvard.edu, greg@kroah.com, gregkh@suse.de,
       linux-kernel@vger.kernel.org
From: <gregkh@suse.de>
Date: Wed, 10 Aug 2005 14:37:14 -0700
In-Reply-To: <Pine.LNX.4.44L0.0508101516220.4485-100000@iolanthe.rowland.org>
Message-ID: <1E2yGB-8KD-00@press.kroah.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: PCI: Fix regression in pci_enable_device_bars

to my gregkh-2.6 tree.  Its filename is

     pci-cleanup-return-values-fix.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from stern@rowland.harvard.edu are

driver/driver-link-device-and-class.patch
pci/pci-cleanup-return-values-fix.patch
usb/usb-gadget-centrialize-numbers.patch
usb/usb-storage-fix-something.patch
usb/usb-storage-rearrange-stuff.patch
usb/usb-storage-01.patch
usb/usb-storage-02.patch
usb/usb-storage-03.patch
usb/usb-storage-05.patch
usb/usb-remove-URB_ASYNC_UNLINK.patch


>From stern@rowland.harvard.edu Wed Aug 10 12:21:39 2005
Date: Wed, 10 Aug 2005 15:18:44 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg KH <greg@kroah.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: PCI: Fix regression in pci_enable_device_bars
Message-ID: <Pine.LNX.4.44L0.0508101516220.4485-100000@iolanthe.rowland.org>

This patch (as552) fixes yet another small problem recently added.  If an
attempt to put a PCI device back into D0 fails because the device doesn't
support PCI PM, it shouldn't count as error.  Without this patch the UHCI
controllers on my Intel motherboard don't work.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/pci/pci.c	2005-08-10 14:23:35.000000000 -0700
+++ gregkh-2.6/drivers/pci/pci.c	2005-08-10 14:35:39.000000000 -0700
@@ -441,7 +441,7 @@
 	int err;
 
 	err = pci_set_power_state(dev, PCI_D0);
-	if (err)
+	if (err < 0 && err != -EIO)
 		return err;
 	err = pcibios_enable_device(dev, bars);
 	if (err < 0)

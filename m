Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268348AbUH2WVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268348AbUH2WVW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 18:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268347AbUH2WVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 18:21:22 -0400
Received: from mail.appliedminds.com ([65.104.119.58]:4492 "EHLO
	appliedminds.com") by vger.kernel.org with ESMTP id S268348AbUH2WVJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 18:21:09 -0400
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: binary
Mime-Version: 1.0
From: James Lamanna <jamesl@appliedminds.com>
To: linux-kernel@vger.kernel.org
Subject: Remove Phidget Blacklist if kernel driver is not selected
Reply-To: jamesl@appliedminds.com
X-Mailer: AtMail 4.0
X-Origin: 10.10.20.43
X-Uidl: 1093818066324905069
Date: Sun, 29 Aug 2004 15:21:06 -0700
Message-ID: <auto-000000530333@appliedminds.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (compile-tested not runtime tested yet)
is to remove the blacklisting of Phidgets 
if the PhidgetServo kernel driver is not included
in the kernel.
(Right now it gets rid of all Phidget Blacklists, as more
drivers are added I would expect they would be per-driver
segmented).

It gets quite annoying to have to patch recent kernels 
everytime to use userspace tools (libhid + libphidgets)
as opposed to using the kernel driver, which cannot be
used because of the HID blacklist.

I don't understand why a kernel driver for the
PhidgetServo was included in the kernel. Wasn't the
point of the HID layer to be able to present HID devices
to userspace so that kernel drivers don't have to be 
written for each and every device?
It seems to be that the way to control a fairly simple
device like the PhidgetServo is through userspace and
the kernel shouldn't be bothered with the device control
details.

-- James Lamanna

--- linux-2.6.8.1/drivers/usb/input/hid-core.c  2004-08-14 03:55:33.000000000 -0700
+++ linux-2.6.8.1-phidget/drivers/usb/input/hid-core.c  2004-08-29
14:53:36.037632992 -0700
@@ -1493,6 +1493,7 @@
        { USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_VOLITO, HID_QUIRK_IGNORE },
        { USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PTU, HID_QUIRK_IGNORE },

+#ifdef CONFIG_USB_PHIDGETSERVO
        { USB_VENDOR_ID_GLAB, USB_DEVICE_ID_4_PHIDGETSERVO_30, HID_QUIRK_IGNORE },
        { USB_VENDOR_ID_GLAB, USB_DEVICE_ID_1_PHIDGETSERVO_30, HID_QUIRK_IGNORE },
        { USB_VENDOR_ID_GLAB, USB_DEVICE_ID_8_8_8_IF_KIT, HID_QUIRK_IGNORE },
@@ -1501,6 +1502,7 @@

        { USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_4_PHIDGETSERVO_20,
HID_QUIRK_IGNORE },
        { USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20,
HID_QUIRK_IGNORE },
+#endif

        { USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM, HID_QUIRK_NOGET },
        { USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },




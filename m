Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVAZBln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVAZBln (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 20:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVAZBlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 20:41:31 -0500
Received: from sulu.mmm.com ([192.28.4.21]:7385 "EHLO torres4.mmm.com")
	by vger.kernel.org with ESMTP id S262045AbVAZBlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 20:41:16 -0500
Subject: Fw: How to submit device ID into hid blacklist.
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF0CB4FB74.DC0C23B0-ON86256F95.0009A35A-85256F95.000944BB@mmm.com>
From: dsuljic@mmm.com
Date: Tue, 25 Jan 2005 20:45:27 -0500
X-MIMETrack: Serialize by Router on US-Mail-22/US-Corporate/3M/US(Release 6.0.2CF1|June
 9, 2003) at 01/25/2005 07:45:28 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-Spam-Score: 1.028 (*) NO_REAL_NAME,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi,
I work for 3M Touch Systems (former MicroTouch) as software engineer and
our main product is touchscreen as input device.
Recently, we have released hid compliant devices (they work perfectly under
Windows OS), but Linux hid driver does not support us correctly. In kernel
2.4 hid driver recognizes our devices and tries to interpret events in best
manner, but since we are absolute pointing device it was a bit tricky with
hid mouse on same system. I kernel 2.6 hid core driver grubs our devices
but does not recognize us as hid device. So we decided, for now, to disable
hid driver of recognizing our hid devices.
My question is how can we submit changes to kernel tree.

Here is example of patch for kernel 2.6.10 hid-core.c:

--- drivers/usb/input/hid-core.c    2004-12-24 16:34:58.000000000 -0500
+++ drivers/usb/input/hid-core.c    2005-01-13 17:19:26.477523912 -0500
@@ -1469,6 +1469,12 @@
 #define USB_VENDOR_ID_DELORME            0x1163
 #define USB_DEVICE_ID_DELORME_EARTHMATE 0x0100

+#define USB_VENDOR_ID_MICROTOUCH   0x0596
+#define USB_DEVICE_ID_MICROTOUCH_SC_4_8  0x0100
+#define USB_DEVICE_ID_MICROTOUCH_SC_5    0x0102
+#define USB_DEVICE_ID_MICROTOUCH_NFI5    0x0200
+#define USB_DEVICE_ID_MICROTOUCH_DST     0x0300
+
 static struct hid_blacklist {
      __u16 idVendor;
      __u16 idProduct;
@@ -1559,6 +1565,10 @@

      { USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE,
HID_QUIRK_IGNORE },

+     { USB_VENDOR_ID_MICROTOUCH, USB_DEVICE_ID_MICROTOUCH_SC_4_8,
HID_QUIRK_IGNORE },
+     { USB_VENDOR_ID_MICROTOUCH, USB_DEVICE_ID_MICROTOUCH_SC_5,
HID_QUIRK_IGNORE },
+     { USB_VENDOR_ID_MICROTOUCH, USB_DEVICE_ID_MICROTOUCH_NFI5,
HID_QUIRK_IGNORE },
+     { USB_VENDOR_ID_MICROTOUCH, USB_DEVICE_ID_MICROTOUCH_DST,
HID_QUIRK_IGNORE },
      { 0, 0 }
 };

Best regards,

Damir Suljic
3M Touch Systems
3M Optical Systems Division
300 Griffin Brook Park Drive
Methuen, MA 01844
978-659-9386
dsuljic@mmm.com
www.3Mtouch.com
www.touchshowcase.com


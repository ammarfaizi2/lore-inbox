Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUB0VJr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUB0VJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:09:47 -0500
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:48092 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP id S263101AbUB0VJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:09:36 -0500
To: Ben Collins <bcollins@debian.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Using physical extents instead of logical ones for NEC USB HID
 gamepads
References: <86y8vcygar.fsf@notus.ireton.fremlin.de>
	<20031023001850.GB9808@phunnypharm.org>
	<87ptgolq69.fsf@bayu.ireton.fremlin.de>
From: John Fremlin <john@fremlin.de>
In-Reply-To: <87ptgolq69.fsf@bayu.ireton.fremlin.de> (John Fremlin's message
 of "Thu, 23 Oct 2003 01:05:02 +0000")
X-Home-Page: http://john.fremlin.de
Date: Fri, 27 Feb 2004 11:49:30 +0000
Message-ID: <87y8qo4u9h.fsf_-_@bayu.ireton.fremlin.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Security Through
 Obscurity, i386-debian-linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

This patch for 2.4.22 (which applied cleanly to 2.4.25-pre) adds the
ID 073e:0301 NEC, Inc. Game Pad to the list of quirky USB joypads which
mix up logical and physical extents.

Please apply as the joypad obviously does not work without it. I've
tested it.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=linux-2.4.22-nec-usb-badpad.patch

--- drivers/usb/hid-core.c.~1~	2003-09-03 10:27:13.000000000 +0000
+++ drivers/usb/hid-core.c	2003-10-23 00:57:04.000000000 +0000
@@ -1182,7 +1182,10 @@ void hid_init_reports(struct hid_device 
 #define USB_VENDOR_ID_MGE		0x0463
 #define USB_DEVICE_ID_MGE_UPS		0xffff
 #define USB_DEVICE_ID_MGE_UPS1		0x0001
- 
+
+#define USB_VENDOR_ID_NEC		0x073e
+#define USB_DEVICE_ID_NEC_USB_GAME_PAD	0x0301
+
 struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1237,6 +1240,7 @@ struct hid_blacklist {
 	{ USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_HIDDEV },
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS1, HID_QUIRK_HIDDEV },
+	{ USB_VENDOR_ID_NEC, USB_DEVICE_ID_NEC_USB_GAME_PAD, HID_QUIRK_BADPAD },
 	{ 0, 0 }
 };
 

--=-=-=--


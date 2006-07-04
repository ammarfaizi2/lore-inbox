Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWGDBgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWGDBgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 21:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWGDBgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 21:36:47 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:21395 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1751211AbWGDBgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 21:36:46 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: D-Link DUB-E100 Revision B1
Date: Tue, 4 Jul 2006 03:33:13 +0200
User-Agent: KMail/1.9.3
Cc: dhollis@davehollis.com, pchang23@sbcglobal.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZVcqEr2pyPkvqti"
Message-Id: <200607040333.13649.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ZVcqEr2pyPkvqti
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Looks like D-Link is getting into the funny "change the chipset but leave the 
product name the same" game again.

DUB-E100 cards up to Revision A4 work perfectly, Revision B1 doesn't work at 
all.

The patch I've attached has the beginnings of a fix; unfortunately this 
trivialty doesn't fix it fully -- with the patch, the module loads, the MAC 
address is detected correctly, the LEDs go on, but pings don't get through 
yet.

After loading the module, dmesg says
eth1: register 'asix' at usb-0000:00:10.3-5, ASIX AX88772 USB 2.0 Ethernet, 
00:80:c8:38:53:a7
usbcore: registered new driver asix
PM: Writing back config space on device 0000:00:0c.0 at offset b (was 3ed173b, 
writing 461025)
PM: Writing back config space on device 0000:00:0c.0 at offset 3 (was 0, 
writing 4010)
PM: Writing back config space on device 0000:00:0c.0 at offset 2 (was 2000000, 
writing 2000003)
PM: Writing back config space on device 0000:00:0c.0 at offset 1 (was 2b00000, 
writing 2b00006)
PM: Writing back config space on device 0000:00:0c.0 at offset 0 (was 3ed173b, 
writing 169c14e4)

Chances are it needs some more messing with the .data and/or .flags 
parameters.

--Boundary-00=_ZVcqEr2pyPkvqti
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.17-D-Link-E100-RevB.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.17-D-Link-E100-RevB.patch"

--- linux-2.6.17/drivers/usb/net/asix.c.ark	2006-06-30 02:21:07.000000000 +0200
+++ linux-2.6.17/drivers/usb/net/asix.c	2006-06-30 02:23:59.000000000 +0200
@@ -868,7 +868,7 @@
 	USB_DEVICE (0x0846, 0x1040),
 	.driver_info =  (unsigned long) &netgear_fa120_info,
 }, {
-	// DLink DUB-E100
+	// DLink DUB-E100, Revision A
 	USB_DEVICE (0x2001, 0x1a00),
 	.driver_info =  (unsigned long) &dlink_dub_e100_info,
 }, {
@@ -924,6 +924,10 @@
 	USB_DEVICE (0x1557, 0x7720),
 	.driver_info = (unsigned long) &ax88772_info,
-},
+}, {
+	// D-Link DUB-E100 Rev. B
+	USB_DEVICE (0x07d1, 0x3c05),
+	.driver_info = (unsigned long) &ax88772_info,
+},
 	{ },		// END
 };
 MODULE_DEVICE_TABLE(usb, products);

--Boundary-00=_ZVcqEr2pyPkvqti--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVAYAkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVAYAkP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVAYAcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:32:41 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:47851 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261735AbVAYAaS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:30:18 -0500
Cc: linux-kernel@vger.kernel.org, js@linuxtv.org
In-Reply-To: <11066130981300@linuxtv.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 25 Jan 2005 01:31:38 +0100
Message-Id: <11066130983536@linuxtv.org>
Mime-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
From: Johannes Stezenbach <js@linuxtv.org>
X-SA-Exim-Connect-IP: 217.86.181.249
Subject: [PATCH 1/4] follow USB __le16 changes
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] dibusb: follow USB changes (idVendor, idProduct, bcdDevice
  and bcdUSB fields are now __le16)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

diff -rupN linux-2.6.11-rc2-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c linux-2.6.11-rc2-mm1-dvb/drivers/media/dvb/dibusb/dvb-dibusb-core.c
--- linux-2.6.11-rc2-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-01-24 23:31:05.000000000 +0100
+++ linux-2.6.11-rc2-mm1-dvb/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-01-24 23:16:27.000000000 +0100
@@ -358,8 +360,8 @@ static struct dibusb_usb_device * dibusb
 	for (i = 0; i < sizeof(dibusb_devices)/sizeof(struct dibusb_usb_device); i++) {
 		for (j = 0; j < DIBUSB_ID_MAX_NUM && dibusb_devices[i].cold_ids[j] != NULL; j++) {
 			deb_info("check for cold %x %x\n",dibusb_devices[i].cold_ids[j]->idVendor, dibusb_devices[i].cold_ids[j]->idProduct);
-			if (dibusb_devices[i].cold_ids[j]->idVendor == udev->descriptor.idVendor &&
-				dibusb_devices[i].cold_ids[j]->idProduct == udev->descriptor.idProduct) {
+			if (dibusb_devices[i].cold_ids[j]->idVendor == le16_to_cpu(udev->descriptor.idVendor) &&
+				dibusb_devices[i].cold_ids[j]->idProduct == le16_to_cpu(udev->descriptor.idProduct)) {
 				*cold = 1;
 				return &dibusb_devices[i];
 			}
@@ -367,8 +369,8 @@ static struct dibusb_usb_device * dibusb
 
 		for (j = 0; j < DIBUSB_ID_MAX_NUM && dibusb_devices[i].warm_ids[j] != NULL; j++) {
 			deb_info("check for warm %x %x\n",dibusb_devices[i].warm_ids[j]->idVendor, dibusb_devices[i].warm_ids[j]->idProduct);
-			if (dibusb_devices[i].warm_ids[j]->idVendor == udev->descriptor.idVendor &&
-				dibusb_devices[i].warm_ids[j]->idProduct == udev->descriptor.idProduct) {
+			if (dibusb_devices[i].warm_ids[j]->idVendor == le16_to_cpu(udev->descriptor.idVendor) &&
+				dibusb_devices[i].warm_ids[j]->idProduct == le16_to_cpu(udev->descriptor.idProduct)) {
 				*cold = 0;
 				return &dibusb_devices[i];
 			}
@@ -391,7 +393,7 @@ static int dibusb_probe(struct usb_inter
 
 	if ((dibdev = dibusb_find_device(udev,&cold)) == NULL) {
 		err("something went very wrong, "
-				"unknown product ID: %.4x",udev->descriptor.idProduct);
+				"unknown product ID: %.4x",le16_to_cpu(udev->descriptor.idProduct));
 		return -ENODEV;
 	}
 	


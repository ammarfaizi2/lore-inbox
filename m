Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272537AbTG1BRo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272468AbTG1ADY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:03:24 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272741AbTG0W6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:54 -0400
Date: Sun, 27 Jul 2003 21:15:10 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272015.h6RKFAnE029719@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix invalid/illegal oddments in USB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/usb/misc/usbtest.c linux-2.6.0-test2-ac1/drivers/usb/misc/usbtest.c
--- linux-2.6.0-test2/drivers/usb/misc/usbtest.c	2003-07-27 19:56:28.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/usb/misc/usbtest.c	2003-07-27 20:30:56.000000000 +0100
@@ -471,7 +471,7 @@
 		 * they're ordered meaningfully in this array
 		 */
 		if (iface->altsetting [i].desc.bAlternateSetting != i) {
-			dbg ("%s, illegal alt [%d].bAltSetting = %d",
+			dbg ("%s, invalid alt [%d].bAltSetting = %d",
 					dev->id, i, 
 					iface->altsetting [i].desc
 						.bAlternateSetting);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/usb/net/usbnet.c linux-2.6.0-test2-ac1/drivers/usb/net/usbnet.c
--- linux-2.6.0-test2/drivers/usb/net/usbnet.c	2003-07-27 19:56:28.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/usb/net/usbnet.c	2003-07-23 16:46:49.000000000 +0100
@@ -890,7 +890,7 @@
 	le32_to_cpus (&header->packet_count);
 	if ((header->packet_count > GL_MAX_TRANSMIT_PACKETS)
 			|| (header->packet_count < 0)) {
-		dbg ("genelink: illegal received packet count %d",
+		dbg ("genelink: invalid received packet count %d",
 			header->packet_count);
 		return 0;
 	}
@@ -907,7 +907,7 @@
 
 		// this may be a broken packet
 		if (size > GL_MAX_PACKET_LEN) {
-			dbg ("genelink: illegal rx length %d", size);
+			dbg ("genelink: invalid rx length %d", size);
 			return 0;
 		}
 
@@ -943,7 +943,7 @@
 	skb_pull (skb, 4);
 
 	if (skb->len > GL_MAX_PACKET_LEN) {
-		dbg ("genelink: illegal rx length %d", skb->len);
+		dbg ("genelink: invalid rx length %d", skb->len);
 		return 0;
 	}
 	return 1;
@@ -2769,6 +2769,15 @@
 	.bInterfaceSubClass = 0x0a,
 	.bInterfaceProtocol = 0x00,
 	.driver_info =  (unsigned long) &zaurus_slc700_info,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+		 | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor               = 0x04DD,
+	.idProduct              = 0x9031,
+	.bInterfaceClass        = 0x02,
+	.bInterfaceSubClass     = 0x0a,
+	.bInterfaceProtocol     = 0x00,
+	.driver_info =  (unsigned long) &zaurus_sla300_info,
 },
 #endif
 

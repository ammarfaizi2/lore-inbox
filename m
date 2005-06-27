Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVF0NCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVF0NCh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVF0M47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:56:59 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:8677 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262049AbVF0MQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:24 -0400
Message-Id: <20050627121416.227724000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:34 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-artec-t1-tvbox-ids.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 34/51] dvb-usb: support Artect T1 with broken USB ids
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add #define for device with broken USB ids.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/dibusb-mb.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dibusb-mb.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-06-27 13:24:27.000000000 +0200
@@ -115,6 +115,12 @@ static struct usb_device_id dibusb_dib30
 /* 22 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_AN2235_WARM) },
 /* 23 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_COLD) },
 /* 24 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_WARM) },
+
+// #define DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
+
+#ifdef DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
+/* 25 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
+#endif
 			{ }		/* Terminating entry */
 };
 MODULE_DEVICE_TABLE (usb, dibusb_dib3000mb_table);
@@ -228,12 +234,22 @@ static struct dvb_usb_properties dibusb1
 		}
 	},
 
+#ifdef DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
+	.num_device_descs = 2,
+#else
 	.num_device_descs = 1,
+#endif
 	.devices = {
 		{	"Artec T1 USB1.1 TVBOX with AN2235",
 			{ &dibusb_dib3000mb_table[20], NULL },
 			{ &dibusb_dib3000mb_table[21], NULL },
 		},
+#ifdef DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
+		{	"Artec T1 USB1.1 TVBOX with AN2235 (faulty USB IDs)",
+			{ &dibusb_dib3000mb_table[25], NULL },
+			{ NULL },
+		},
+#endif
 	}
 };
 

--


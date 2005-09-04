Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVIDXn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVIDXn2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVIDXnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:43:03 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:48769 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932137AbVIDXau
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:50 -0400
Message-Id: <20050904232326.850589000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:27 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-device_init-return-device.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 28/54] usb: core: change dvb_usb_device_init() API
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Change the init call to optionally return the new dvb_usb_device directly.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/a800.c         |    2 +-
 drivers/media/dvb/dvb-usb/cxusb.c        |    2 +-
 drivers/media/dvb/dvb-usb/dibusb-mb.c    |    6 +++---
 drivers/media/dvb/dvb-usb/dibusb-mc.c    |    2 +-
 drivers/media/dvb/dvb-usb/digitv.c       |    2 +-
 drivers/media/dvb/dvb-usb/dtt200u.c      |    4 ++--
 drivers/media/dvb/dvb-usb/dvb-usb-ids.h  |    3 +++
 drivers/media/dvb/dvb-usb/dvb-usb-init.c |    7 ++++++-
 drivers/media/dvb/dvb-usb/dvb-usb.h      |    4 ++--
 drivers/media/dvb/dvb-usb/nova-t-usb2.c  |    2 +-
 drivers/media/dvb/dvb-usb/umt-010.c      |    2 +-
 drivers/media/dvb/dvb-usb/vp702x.c       |    2 +-
 drivers/media/dvb/dvb-usb/vp7045.c       |    2 +-
 13 files changed, 24 insertions(+), 16 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/a800.c	2005-09-04 23:30:21.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/a800.c	2005-09-04 23:32:19.000000000 +0200
@@ -90,7 +90,7 @@ static struct dvb_usb_properties a800_pr
 static int a800_probe(struct usb_interface *intf,
 		const struct usb_device_id *id)
 {
-	return dvb_usb_device_init(intf,&a800_properties,THIS_MODULE);
+	return dvb_usb_device_init(intf,&a800_properties,THIS_MODULE,NULL);
 }
 
 /* do not change the order of the ID table */
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-09-04 23:32:19.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-09-04 23:32:19.000000000 +0200
@@ -86,9 +86,9 @@ static struct dvb_usb_properties dibusb2
 static int dibusb_probe(struct usb_interface *intf,
 		const struct usb_device_id *id)
 {
-	if (dvb_usb_device_init(intf,&dibusb1_1_properties,THIS_MODULE) == 0 ||
-		dvb_usb_device_init(intf,&dibusb1_1_an2235_properties,THIS_MODULE) == 0 ||
-		dvb_usb_device_init(intf,&dibusb2_0b_properties,THIS_MODULE) == 0)
+	if (dvb_usb_device_init(intf,&dibusb1_1_properties,THIS_MODULE,NULL) == 0 ||
+		dvb_usb_device_init(intf,&dibusb1_1_an2235_properties,THIS_MODULE,NULL) == 0 ||
+		dvb_usb_device_init(intf,&dibusb2_0b_properties,THIS_MODULE,NULL) == 0)
 		return 0;
 
 	return -EINVAL;
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/dibusb-mc.c	2005-09-04 23:30:21.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/dibusb-mc.c	2005-09-04 23:32:19.000000000 +0200
@@ -20,7 +20,7 @@ static struct dvb_usb_properties dibusb_
 static int dibusb_mc_probe(struct usb_interface *intf,
 		const struct usb_device_id *id)
 {
-	return dvb_usb_device_init(intf,&dibusb_mc_properties,THIS_MODULE);
+	return dvb_usb_device_init(intf,&dibusb_mc_properties,THIS_MODULE,NULL);
 }
 
 /* do not change the order of the ID table */
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/dtt200u.c	2005-09-04 23:32:19.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/dtt200u.c	2005-09-04 23:32:19.000000000 +0200
@@ -98,8 +98,8 @@ static struct dvb_usb_properties wt220u_
 static int dtt200u_usb_probe(struct usb_interface *intf,
 		const struct usb_device_id *id)
 {
-	if (dvb_usb_device_init(intf,&dtt200u_properties,THIS_MODULE) == 0 ||
-		dvb_usb_device_init(intf,&wt220u_properties,THIS_MODULE) == 0)
+	if (dvb_usb_device_init(intf,&dtt200u_properties,THIS_MODULE,NULL) == 0 ||
+		dvb_usb_device_init(intf,&wt220u_properties,THIS_MODULE,NULL) == 0)
 		return 0;
 
 	return -ENODEV;
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/dvb-usb-ids.h	2005-09-04 23:32:19.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/dvb-usb-ids.h	2005-09-04 23:32:19.000000000 +0200
@@ -27,6 +27,7 @@
 #define USB_VID_KWORLD						0xeb2a
 #define USB_VID_KYE							0x0458
 #define USB_VID_MEDION						0x1660
+#define USB_VID_PINNACLE					0x2304
 #define USB_VID_VISIONPLUS					0x13d3
 #define USB_VID_TWINHAN						0x1822
 #define USB_VID_ULTIMA_ELECTRONIC			0x05d8
@@ -88,5 +89,7 @@
 #define USB_PID_MEDION_MD95700				0x0932
 #define USB_PID_KYE_DVB_T_COLD				0x701e
 #define USB_PID_KYE_DVB_T_WARM				0x701f
+#define USB_PID_PCTV_200E					0x020e
+#define USB_PID_PCTV_400E					0x020f
 
 #endif
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/dvb-usb-init.c	2005-09-04 23:32:19.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/dvb-usb-init.c	2005-09-04 23:32:19.000000000 +0200
@@ -128,7 +128,9 @@ static struct dvb_usb_device_description
 /*
  * USB
  */
-int dvb_usb_device_init(struct usb_interface *intf, struct dvb_usb_properties *props, struct module *owner)
+
+int dvb_usb_device_init(struct usb_interface *intf, struct dvb_usb_properties
+		*props, struct module *owner,struct dvb_usb_device **du)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct dvb_usb_device *d = NULL;
@@ -170,6 +172,9 @@ int dvb_usb_device_init(struct usb_inter
 
 		usb_set_intfdata(intf, d);
 
+		if (du != NULL)
+			*du = d;
+
 		ret = dvb_usb_init(d);
 	}
 
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/dvb-usb.h	2005-09-04 23:30:21.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/dvb-usb.h	2005-09-04 23:32:19.000000000 +0200
@@ -127,7 +127,7 @@ struct dvb_usb_device;
  *  helper functions.
  *
  * @urb: describes the kind of USB transfer used for MPEG2-TS-streaming.
- *  Currently only BULK is implemented
+ *  (BULK or ISOC)
  *
  * @num_device_descs: number of struct dvb_usb_device_description in @devices
  * @devices: array of struct dvb_usb_device_description compatibles with these
@@ -310,7 +310,7 @@ struct dvb_usb_device {
 	void *priv;
 };
 
-extern int dvb_usb_device_init(struct usb_interface *, struct dvb_usb_properties *, struct module *);
+extern int dvb_usb_device_init(struct usb_interface *, struct dvb_usb_properties *, struct module *, struct dvb_usb_device **);
 extern void dvb_usb_device_exit(struct usb_interface *);
 
 /* the generic read/write method for device control */
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/nova-t-usb2.c	2005-09-04 23:30:21.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/nova-t-usb2.c	2005-09-04 23:32:19.000000000 +0200
@@ -144,7 +144,7 @@ static struct dvb_usb_properties nova_t_
 static int nova_t_probe(struct usb_interface *intf,
 		const struct usb_device_id *id)
 {
-	return dvb_usb_device_init(intf,&nova_t_properties,THIS_MODULE);
+	return dvb_usb_device_init(intf,&nova_t_properties,THIS_MODULE,NULL);
 }
 
 /* do not change the order of the ID table */
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/umt-010.c	2005-09-04 23:30:21.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/umt-010.c	2005-09-04 23:32:19.000000000 +0200
@@ -77,7 +77,7 @@ static struct dvb_usb_properties umt_pro
 static int umt_probe(struct usb_interface *intf,
 		const struct usb_device_id *id)
 {
-	if (dvb_usb_device_init(intf,&umt_properties,THIS_MODULE) == 0)
+	if (dvb_usb_device_init(intf,&umt_properties,THIS_MODULE,NULL) == 0)
 		return 0;
 	return -EINVAL;
 }
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/vp702x.c	2005-09-04 23:32:19.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/vp702x.c	2005-09-04 23:32:19.000000000 +0200
@@ -197,7 +197,7 @@ static int vp702x_usb_probe(struct usb_i
 	usb_clear_halt(udev,usb_sndctrlpipe(udev,0));
 	usb_clear_halt(udev,usb_rcvctrlpipe(udev,0));
 
-	return dvb_usb_device_init(intf,&vp702x_properties,THIS_MODULE);
+	return dvb_usb_device_init(intf,&vp702x_properties,THIS_MODULE,NULL);
 }
 
 static struct usb_device_id vp702x_usb_table [] = {
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/vp7045.c	2005-09-04 23:30:21.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/vp7045.c	2005-09-04 23:32:19.000000000 +0200
@@ -199,7 +199,7 @@ static struct dvb_usb_properties vp7045_
 static int vp7045_usb_probe(struct usb_interface *intf,
 		const struct usb_device_id *id)
 {
-	return dvb_usb_device_init(intf,&vp7045_properties,THIS_MODULE);
+	return dvb_usb_device_init(intf,&vp7045_properties,THIS_MODULE,NULL);
 }
 
 static struct usb_device_id vp7045_usb_table [] = {
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/cxusb.c	2005-09-04 23:30:21.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/cxusb.c	2005-09-04 23:32:19.000000000 +0200
@@ -213,7 +213,7 @@ static struct dvb_usb_properties cxusb_p
 static int cxusb_probe(struct usb_interface *intf,
 		const struct usb_device_id *id)
 {
-	return dvb_usb_device_init(intf,&cxusb_properties,THIS_MODULE);
+	return dvb_usb_device_init(intf,&cxusb_properties,THIS_MODULE,NULL);
 }
 
 static struct usb_device_id cxusb_table [] = {
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/digitv.c	2005-09-04 23:32:12.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/digitv.c	2005-09-04 23:32:43.000000000 +0200
@@ -175,7 +175,7 @@ static struct dvb_usb_properties digitv_
 static int digitv_probe(struct usb_interface *intf,
 		const struct usb_device_id *id)
 {
-	return dvb_usb_device_init(intf,&digitv_properties,THIS_MODULE);
+	return dvb_usb_device_init(intf,&digitv_properties,THIS_MODULE,NULL);
 }
 
 static struct usb_device_id digitv_table [] = {

--


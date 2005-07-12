Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVGLJeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVGLJeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVGLJcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:32:15 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:10894 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261291AbVGLJbb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:31:31 -0400
Message-Id: <20050712010131.963522000@abc>
References: <20050712005934.981758000@abc>
Date: Tue, 12 Jul 2005 02:59:36 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-fix-typos.patch
X-SA-Exim-Connect-IP: 84.189.244.201
Subject: [DVB patch 1/3] usb: fix some typos
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>
corrected some typos.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/dvb-usb-dvb.c  |    2 +-
 drivers/media/dvb/dvb-usb/dvb-usb-init.c |    6 +++---
 drivers/media/dvb/dvb-usb/vp7045.c       |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/media/dvb/dvb-usb/dvb-usb-dvb.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/dvb/dvb-usb/dvb-usb-dvb.c	2005-07-12 02:47:58.000000000 +0200
+++ linux-2.6.13-rc2-mm1/drivers/media/dvb/dvb-usb/dvb-usb-dvb.c	2005-07-12 02:52:49.000000000 +0200
@@ -175,7 +175,7 @@ static int dvb_usb_fe_sleep(struct dvb_f
 int dvb_usb_fe_init(struct dvb_usb_device* d)
 {
 	if (d->props.frontend_attach == NULL) {
-		err("strange '%s' don't want to attach a frontend.",d->desc->name);
+		err("strange '%s' doesn't want to attach a frontend.",d->desc->name);
 		return 0;
 	}
 
Index: linux-2.6.13-rc2-mm1/drivers/media/dvb/dvb-usb/dvb-usb-init.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/dvb/dvb-usb/dvb-usb-init.c	2005-07-11 21:29:46.000000000 +0200
+++ linux-2.6.13-rc2-mm1/drivers/media/dvb/dvb-usb/dvb-usb-init.c	2005-07-12 02:52:49.000000000 +0200
@@ -51,17 +51,17 @@ static int dvb_usb_init(struct dvb_usb_d
 
 /* speed - when running at FULL speed we need a HW PID filter */
 	if (d->udev->speed == USB_SPEED_FULL && !(d->props.caps & DVB_USB_HAS_PID_FILTER)) {
-		err("This USB2.0 device cannot be run on a USB1.1 port. (it lacks a HW PID filter)");
+		err("This USB2.0 device cannot be run on a USB1.1 port. (it lacks a hardware PID filter)");
 		return -ENODEV;
 	}
 
 	if ((d->udev->speed == USB_SPEED_FULL && d->props.caps & DVB_USB_HAS_PID_FILTER) ||
 		(d->props.caps & DVB_USB_NEED_PID_FILTERING)) {
-		info("will use the device's hw PID filter.");
+		info("will use the device's hardware PID filter (table count: %d).",d->props.pid_filter_count);
 		d->pid_filtering = 1;
 		d->max_feed_count = d->props.pid_filter_count;
 	} else {
-		info("will pass the complete MPEG2 transport stream to the demuxer.");
+		info("will pass the complete MPEG2 transport stream to the software demuxer.");
 		d->pid_filtering = 0;
 		d->max_feed_count = 255;
 	}
Index: linux-2.6.13-rc2-mm1/drivers/media/dvb/dvb-usb/vp7045.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/dvb/dvb-usb/vp7045.c	2005-07-11 21:29:46.000000000 +0200
+++ linux-2.6.13-rc2-mm1/drivers/media/dvb/dvb-usb/vp7045.c	2005-07-12 02:52:49.000000000 +0200
@@ -128,7 +128,7 @@ static struct dvb_usb_rc_key vp7045_rc_k
 	{ 0x00, 0x0f, KEY_TEXT } /* Teletext */
 };
 
-static int vp7045_rc_query(struct dvb_usb_device *d, u32 *key_buf, int *state)
+static int vp7045_rc_query(struct dvb_usb_device *d, u32 *event, int *state)
 {
 	u8 key;
 	int i;
@@ -144,7 +144,7 @@ static int vp7045_rc_query(struct dvb_us
 	for (i = 0; i < sizeof(vp7045_rc_keys)/sizeof(struct dvb_usb_rc_key); i++)
 		if (vp7045_rc_keys[i].data == key) {
 			*state = REMOTE_KEY_PRESSED;
-			*key_buf = vp7045_rc_keys[i].event;
+			*event = vp7045_rc_keys[i].event;
 			break;
 		}
 	return 0;

--


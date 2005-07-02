Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVGBCHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVGBCHh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 22:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVGBBzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 21:55:47 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:11756 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261682AbVGBBzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 21:55:16 -0400
Message-Id: <20050702015618.229273000@abc>
References: <20050702015506.631451000@abc>
Date: Sat, 02 Jul 2005 03:55:07 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Hodgson <a.s.hodgson@gmail.com>,
       Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-a800-ir-and-timeout-fix.patch
X-SA-Exim-Connect-IP: 84.189.246.3
Subject: [DVB patch 1/8] usb: A800 rc and timeout fixes
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Hodgson <a.s.hodgson@gmail.com>

o add some remote control codes
o not using HZ for control_msg-timeout

Signed-off-by: Andrew Hodgson <a.s.hodgson@gmail.com>
Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/a800.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

Index: linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/a800.c
===================================================================
--- linux-2.6.13-rc1-mm1.orig/drivers/media/dvb/dvb-usb/a800.c	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/media/dvb/dvb-usb/a800.c	2005-07-02 03:22:25.000000000 +0200
@@ -61,6 +61,12 @@ static struct dvb_usb_rc_key a800_rc_key
 	{ 0x02, 0x00, KEY_LAST },        /* >>| / BLUE */
 	{ 0x02, 0x04, KEY_EPG },         /* EPG */
 	{ 0x02, 0x15, KEY_MENU },        /* MENU */
+
+	{ 0x03, 0x03, KEY_CHANNELUP },   /* CH UP */
+	{ 0x03, 0x02, KEY_CHANNELDOWN }, /* CH DOWN */
+	{ 0x03, 0x01, KEY_FIRST },       /* |<< / GREEN */
+	{ 0x03, 0x00, KEY_LAST },        /* >>| / BLUE */
+
 };
 
 int a800_rc_query(struct dvb_usb_device *d, u32 *event, int *state)
@@ -68,7 +74,7 @@ int a800_rc_query(struct dvb_usb_device 
 	u8 key[5];
 	if (usb_control_msg(d->udev,usb_rcvctrlpipe(d->udev,0),
 				0x04, USB_TYPE_VENDOR | USB_DIR_IN, 0, 0, key, 5,
-				2*HZ) != 5)
+				2000) != 5)
 		return -ENODEV;
 
 	/* call the universal NEC remote processor, to find out the key's state and event */

--


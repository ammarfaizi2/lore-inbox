Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTI2Vi7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbTI2Vi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:38:59 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:5804 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S263011AbTI2ViX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:38:23 -0400
From: Duncan Sands <baldrick@free.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 2.5] USB speedtouch: extra debug messages
Date: Mon, 29 Sep 2003 23:39:51 +0200
User-Agent: KMail/1.5.1
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309292339.51710.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 speedtch.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Tue Sep 30 00:11:41 2003
+++ b/drivers/usb/misc/speedtch.c	Tue Sep 30 00:11:41 2003
@@ -880,8 +880,10 @@
 		return -EINVAL;
 
 	/* only support AAL5 */
-	if ((vcc->qos.aal != ATM_AAL5) || (vcc->qos.rxtp.max_sdu < 0) || (vcc->qos.rxtp.max_sdu > ATM_MAX_AAL5_PDU))
+	if ((vcc->qos.aal != ATM_AAL5) || (vcc->qos.rxtp.max_sdu < 0) || (vcc->qos.rxtp.max_sdu > ATM_MAX_AAL5_PDU)) {
+		dbg ("udsl_atm_open: unsupported ATM type %d!", vcc->qos.aal);
 		return -EINVAL;
+	}
 
 	if (!instance->firmware_loaded) {
 		dbg ("udsl_atm_open: firmware not loaded!");
@@ -891,11 +893,13 @@
 	down (&instance->serialize); /* vs self, udsl_atm_close */
 
 	if (udsl_find_vcc (instance, vpi, vci)) {
+		dbg ("udsl_atm_open: %hd/%d already in use!", vpi, vci);
 		up (&instance->serialize);
 		return -EADDRINUSE;
 	}
 
 	if (!(new = kmalloc (sizeof (struct udsl_vcc_data), GFP_KERNEL))) {
+		dbg ("udsl_atm_open: no memory for vcc_data!");
 		up (&instance->serialize);
 		return -ENOMEM;
 	}
@@ -1220,7 +1224,7 @@
 
 	for (i = 0; i < num_rcv_urbs; i++)
 		if ((result = usb_unlink_urb (instance->receivers [i].urb)) < 0)
-			dbg ("udsl_usb_disconnect: usb_unlink_urb on receive urb %d returned %d", i, result);
+			dbg ("udsl_usb_disconnect: usb_unlink_urb on receive urb %d returned %d!", i, result);
 
 	/* wait for completion handlers to finish */
 	do {
@@ -1256,7 +1260,7 @@
 
 	for (i = 0; i < num_snd_urbs; i++)
 		if ((result = usb_unlink_urb (instance->senders [i].urb)) < 0)
-			dbg ("udsl_usb_disconnect: usb_unlink_urb on send urb %d returned %d", i, result);
+			dbg ("udsl_usb_disconnect: usb_unlink_urb on send urb %d returned %d!", i, result);
 
 	/* wait for completion handlers to finish */
 	do {

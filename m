Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267721AbTB1JFv>; Fri, 28 Feb 2003 04:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267731AbTB1JFv>; Fri, 28 Feb 2003 04:05:51 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:21987 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267721AbTB1JFr>; Fri, 28 Feb 2003 04:05:47 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB speedtouch: be firm when disconnected
Date: Fri, 28 Feb 2003 10:15:37 +0100
User-Agent: KMail/1.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302281015.37848.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just say -ENODEV


 speedtouch.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)


diff -Nru a/drivers/usb/misc/speedtouch.c b/drivers/usb/misc/speedtouch.c
--- a/drivers/usb/misc/speedtouch.c	Fri Feb 28 10:09:04 2003
+++ b/drivers/usb/misc/speedtouch.c	Fri Feb 28 10:09:04 2003
@@ -648,9 +648,9 @@
 
 	dbg ("udsl_atm_send called (skb 0x%p, len %u)", skb, skb->len);
 
-	if (!instance) {
-		dbg ("NULL instance!");
-		return -EINVAL;
+	if (!instance || !instance->usb_dev) {
+		dbg ("NULL data!");
+		return -ENODEV;
 	}
 
 	if (!instance->firmware_loaded)
@@ -701,6 +701,7 @@
 	tasklet_kill (&instance->send_tasklet);
 	dbg ("udsl_atm_dev_close: freeing instance");
 	kfree (instance);
+	dev->dev_data = NULL;
 }
 
 
@@ -776,8 +777,8 @@
 
 	dbg ("udsl_atm_open called");
 
-	if (!instance) {
-		dbg ("NULL instance!");
+	if (!instance || !instance->usb_dev) {
+		dbg ("NULL data!");
 		return -ENODEV;
 	}
 


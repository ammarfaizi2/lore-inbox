Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbTDWIi5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 04:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263216AbTDWIi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 04:38:57 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.27]:18923 "EHLO
	mwinf0402.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263214AbTDWIiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 04:38:54 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB speedtouch: crc optimization
Date: Wed, 23 Apr 2003 10:50:53 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tPlp+jxSwMrh+CN"
Message-Id: <200304231050.53630.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_tPlp+jxSwMrh+CN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 speedtch.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed Apr 23 10:48:07 2003
+++ b/drivers/usb/misc/speedtch.c	Wed Apr 23 10:48:07 2003
@@ -406,11 +406,12 @@
 **  encode  **
 *************/
 
+static const unsigned char zeros[ATM_CELL_PAYLOAD];
+
 static void udsl_groom_skb (struct atm_vcc *vcc, struct sk_buff *skb)
 {
 	struct udsl_control *ctrl = UDSL_SKB (skb);
-	unsigned int i, zero_padding;
-	unsigned char zero = 0;
+	unsigned int zero_padding;
 	u32 crc;
 
 	ctrl->atm_data.vcc = vcc;
@@ -436,8 +437,7 @@
 	ctrl->aal5_trailer [3] = skb->len;
 
 	crc = crc32_be (~0, skb->data, skb->len);
-	for (i = 0; i < zero_padding; i++)
-		crc = crc32_be (crc, &zero, 1);
+	crc = crc32_be (crc, zeros, zero_padding);
 	crc = crc32_be (crc, ctrl->aal5_trailer, 4);
 	crc = ~crc;
 


--Boundary-00=_tPlp+jxSwMrh+CN
Content-Type: text/x-diff;
  charset="us-ascii";
  name="send-2.4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="send-2.4.diff"

 speedtouch.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/usb/speedtouch.c b/drivers/usb/speedtouch.c
--- a/drivers/usb/speedtouch.c	Wed Apr 23 10:48:28 2003
+++ b/drivers/usb/speedtouch.c	Wed Apr 23 10:48:28 2003
@@ -406,11 +406,12 @@
 **  encode  **
 *************/
 
+static const unsigned char zeros[ATM_CELL_PAYLOAD];
+
 static void udsl_groom_skb (struct atm_vcc *vcc, struct sk_buff *skb)
 {
 	struct udsl_control *ctrl = UDSL_SKB (skb);
-	unsigned int i, zero_padding;
-	unsigned char zero = 0;
+	unsigned int zero_padding;
 	u32 crc;
 
 	ctrl->atm_data.vcc = vcc;
@@ -436,8 +437,7 @@
 	ctrl->aal5_trailer [3] = skb->len;
 
 	crc = crc32_be (~0, skb->data, skb->len);
-	for (i = 0; i < zero_padding; i++)
-		crc = crc32_be (crc, &zero, 1);
+	crc = crc32_be (crc, zeros, zero_padding);
 	crc = crc32_be (crc, ctrl->aal5_trailer, 4);
 	crc = ~crc;
 


--Boundary-00=_tPlp+jxSwMrh+CN
Content-Type: text/x-diff;
  charset="us-ascii";
  name="send-2.5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="send-2.5.diff"

 speedtch.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed Apr 23 10:48:07 2003
+++ b/drivers/usb/misc/speedtch.c	Wed Apr 23 10:48:07 2003
@@ -406,11 +406,12 @@
 **  encode  **
 *************/
 
+static const unsigned char zeros[ATM_CELL_PAYLOAD];
+
 static void udsl_groom_skb (struct atm_vcc *vcc, struct sk_buff *skb)
 {
 	struct udsl_control *ctrl = UDSL_SKB (skb);
-	unsigned int i, zero_padding;
-	unsigned char zero = 0;
+	unsigned int zero_padding;
 	u32 crc;
 
 	ctrl->atm_data.vcc = vcc;
@@ -436,8 +437,7 @@
 	ctrl->aal5_trailer [3] = skb->len;
 
 	crc = crc32_be (~0, skb->data, skb->len);
-	for (i = 0; i < zero_padding; i++)
-		crc = crc32_be (crc, &zero, 1);
+	crc = crc32_be (crc, zeros, zero_padding);
 	crc = crc32_be (crc, ctrl->aal5_trailer, 4);
 	crc = ~crc;
 


--Boundary-00=_tPlp+jxSwMrh+CN--

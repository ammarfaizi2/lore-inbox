Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbUCJMU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 07:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUCJMU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 07:20:28 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:1498 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262576AbUCJMU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 07:20:26 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 10 Mar 2004 12:47:26 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] bttv input update
Message-ID: <20040310114726.GA29785@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch adds infrared remote support for a few more bt878-based TV cards.

  Gerd

diff -up linux-2.6.4-rc3/drivers/media/video/ir-kbd-gpio.c linux/drivers/media/video/ir-kbd-gpio.c
--- linux-2.6.4-rc3/drivers/media/video/ir-kbd-gpio.c	2004-03-10 09:52:44.264872030 +0100
+++ linux/drivers/media/video/ir-kbd-gpio.c	2004-03-10 09:55:37.226323606 +0100
@@ -279,14 +279,18 @@ static int ir_probe(struct device *dev)
 	switch (sub->core->type) {
 	case BTTV_AVERMEDIA:
 	case BTTV_AVPHONE98:
+	case BTTV_AVERMEDIA98:
 		ir_codes         = ir_codes_avermedia;
 		ir->mask_keycode = 0xf80000;
 		ir->mask_keydown = 0x010000;
 		break;
-	case BTTV_WINFAST2000:
-		ir_codes         = winfast_codes;
-		ir->mask_keycode = 0x8f8;
-		break;
+
+	case BTTV_PXELVWPLTVPAK:
+		ir_codes         = ir_codes_pixelview;
+		ir->mask_keycode = 0x003e00;
+		ir->mask_keyup   = 0x010000;
+		ir->polling      = 50; // ms
+                break;
 	case BTTV_PV_BT878P_9B:
 	case BTTV_PV_BT878P_PLUS:
 		ir_codes         = ir_codes_pixelview;
@@ -294,6 +298,17 @@ static int ir_probe(struct device *dev)
 		ir->mask_keyup   = 0x008000;
 		ir->polling      = 50; // ms
                 break;
+
+	case BTTV_WINFAST2000:
+		ir_codes         = winfast_codes;
+		ir->mask_keycode = 0x8f8;
+		break;
+	case BTTV_MAGICTVIEW061:
+	case BTTV_MAGICTVIEW063:
+		ir_codes         = winfast_codes;
+		ir->mask_keycode = 0x0008e000;
+		ir->mask_keydown = 0x00200000;
+		break;
 	}
 	if (NULL == ir_codes) {
 		kfree(ir);

-- 
Es geht darum, daß ein Haufen Scriptkiddies gerade dabei sind, USENET in
Bunt neu zu erfinden, und sie derzeit einen Haufen Fehler neu machen,
die schon seit 20 Jahren nicht mehr Gegenstand der Forschung sind.
	-- Kristian Köhntopp über blogs und blogger

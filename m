Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUDEMA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 08:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUDEMAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 08:00:25 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:52896 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262051AbUDEMAQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 08:00:16 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 5 Apr 2004 13:53:28 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: tuner fix
Message-ID: <20040405115328.GA29527@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch fixes a bug in the tuner descriptions and prepares for the
removal of the type= insmod option by printing a warning when it is
used.

  Gerd

diff -up linux-2.6.5/drivers/media/video/tuner.c linux/drivers/media/video/tuner.c
--- linux-2.6.5/drivers/media/video/tuner.c	2004-04-05 10:42:40.510765397 +0200
+++ linux/drivers/media/video/tuner.c	2004-04-05 10:49:57.836295644 +0200
@@ -233,7 +233,7 @@ static struct tunertype tuners[] = {
 	{ "Philips 1236D ATSC/NTSC daul in",Philips,ATSC,
 	  16*157.25,16*454.00,0xa0,0x90,0x30,0x8e,732},
         { "Philips NTSC MK3 (FM1236MK3 or FM1236/F)", Philips, NTSC,
-          16*160.00,16*442.00,0x01,0x02,0x04,0x8,732},
+          16*160.00,16*442.00,0x01,0x02,0x04,0x8e,732},
 
         { "Philips 4 in 1 (ATI TV Wonder Pro/Conexant)", Philips, NTSC,
           16*160.00,16*442.00,0x01,0x02,0x04,0x8e,732},
@@ -1050,8 +1050,12 @@ static int tuner_attach(struct i2c_adapt
 	t->radio_if2  = 10700*1000; // 10.7MHz - FM radio
 
         i2c_attach_client(client);
-	if (type < TUNERS)
+	if (type < TUNERS) {
 		set_type(client, type, "insmod option");
+		printk("tuner: The type=<n> insmod option will go away soon.\n");
+		printk("tuner: Please use the tuner=<n> option provided by\n");
+		printk("tuner: tv card core driver (bttv, saa7134, ...) instead.\n");
+	}
 	return 0;
 }
 

-- 
http://bigendian.bytesex.org

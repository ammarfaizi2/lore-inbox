Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVGBUY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVGBUY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 16:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVGBUYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 16:24:55 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:27229 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261275AbVGBUYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 16:24:49 -0400
Message-ID: <42C6F812.1090700@m1k.net>
Date: Sat, 02 Jul 2005 16:24:50 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>, luckas@musoft.de,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] v4l: add TerraTec Cinergy 1400 DVB-T
References: <200507010838.08542.luckas@musoft.de>
In-Reply-To: <200507010838.08542.luckas@musoft.de>
Content-Type: multipart/mixed;
 boundary="------------060702020708080608070800"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060702020708080608070800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------060702020708080608070800
Content-Type: text/plain;
 name="v4l-add-terratec-cinergy-1400-dvb-t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l-add-terratec-cinergy-1400-dvb-t.patch"

Add support for TerraTec Cinergy 1400 DVB-T.

Signed-off-by: Uli Luckas <luckas@musoft.de>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/video/cx88/cx88-cards.c |   15 ++++++++++++++-
 linux/drivers/media/video/cx88/cx88-dvb.c   |    3 ++-
 linux/drivers/media/video/cx88/cx88.h       |    3 ++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff -u linux-2.6.13/drivers/media/video/cx88/cx88.h linux/drivers/media/video/cx88/cx88.h
--- linux-2.6.13/drivers/media/video/cx88/cx88.h	2005-07-02 13:19:07.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88.h	2005-07-02 16:04:23.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88.h,v 1.66 2005/06/22 22:58:04 mchehab Exp $
+ * $Id: cx88.h,v 1.67 2005/07/01 12:10:07 mkrufky Exp $
  *
  * v4l2 device driver for cx2388x based TV cards
  *
@@ -170,6 +170,7 @@
 #define CX88_BOARD_PIXELVIEW_PLAYTV_ULTRA_PRO 27
 #define CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T  28
 #define CX88_BOARD_ADSTECH_DVB_T_PCI          29
+#define CX88_BOARD_TERRATEC_CINERGY_1400_DVB_T1  30
 
 enum cx88_itype {
 	CX88_VMUX_COMPOSITE1 = 1,
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-cards.c linux/drivers/media/video/cx88/cx88-cards.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-cards.c	2005-07-02 14:24:10.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-cards.c	2005-07-02 16:04:23.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-cards.c,v 1.82 2005/06/28 04:33:53 mkrufky Exp $
+ * $Id: cx88-cards.c,v 1.84 2005/07/02 19:42:09 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * card-specific stuff.
@@ -743,6 +743,15 @@
                 }},
 		.dvb            = 1,
 	},
+	[CX88_BOARD_TERRATEC_CINERGY_1400_DVB_T1] = {
+		.name           = "TerraTec Cinergy 1400 DVB-T",
+		.tuner_type     = TUNER_ABSENT,
+		.input          = {{
+			.type   = CX88_VMUX_DVB,
+			.vmux   = 0,
+		}},
+		.dvb            = 1,
+	},
 };
 const unsigned int cx88_bcount = ARRAY_SIZE(cx88_boards);
 
@@ -866,6 +875,10 @@
 		.subvendor = 0x1421,
 		.subdevice = 0x0334,
 		.card      = CX88_BOARD_ADSTECH_DVB_T_PCI,
+ 	},{
+		.subvendor = 0x153b,
+		.subdevice = 0x1166,
+		.card      = CX88_BOARD_TERRATEC_CINERGY_1400_DVB_T1,
 	},
 };
 const unsigned int cx88_idcount = ARRAY_SIZE(cx88_subids);
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c	2005-07-02 14:24:10.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-07-02 16:04:23.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-dvb.c,v 1.37 2005/06/28 23:41:47 mkrufky Exp $
+ * $Id: cx88-dvb.c,v 1.39 2005/07/02 20:00:46 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * MPEG Transport Stream (DVB) routines
@@ -235,6 +235,7 @@
 		dev->dvb.frontend = cx22702_attach(&hauppauge_novat_config,
 						   &dev->core->i2c_adap);
 		break;
+	case CX88_BOARD_TERRATEC_CINERGY_1400_DVB_T1:
 	case CX88_BOARD_CONEXANT_DVB_T1:
 		dev->dvb.frontend = cx22702_attach(&connexant_refboard_config,
 						   &dev->core->i2c_adap);

--------------060702020708080608070800--

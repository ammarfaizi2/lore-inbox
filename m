Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965536AbWCTPt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965536AbWCTPt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWCTPt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:49:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33250 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966713AbWCTPUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:20:08 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 047/141] V4L/DVB (3276): Added terratec hybrid xs and
	kworld 2800rf support
Date: Mon, 20 Mar 2006 12:08:44 -0300
Message-id: <20060320150844.PS827204000047@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Rechberger <mrechberger@gmail.com>
Date: 1139300739 -0200

- Added terratec hybrid xs product/vendorid
- Added gpio audio initialization for kworld pvr 2800rf

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.em28xx b/Documentation/video4linux/CARDLIST.em28xx
diff --git a/Documentation/video4linux/CARDLIST.em28xx b/Documentation/video4linux/CARDLIST.em28xx
index a0c7cad..7a903f7 100644
--- a/Documentation/video4linux/CARDLIST.em28xx
+++ b/Documentation/video4linux/CARDLIST.em28xx
@@ -8,3 +8,4 @@
   7 -> Leadtek Winfast USB II                   (em2800)
   8 -> Kworld USB2800                           (em2800)
   9 -> Pinnacle Dazzle DVC 90                   (em2820/em2840) [2304:0207]
+ 12 -> Unknown EM2820/2840 video grabber        (em2820/em2840)
diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
index ed428c5..573d24d 100644
--- a/drivers/media/video/em28xx/em28xx-cards.c
+++ b/drivers/media/video/em28xx/em28xx-cards.c
@@ -72,6 +72,24 @@ struct em28xx_board em28xx_boards[] = {
 			.amux     = 1,
 		}},
 	},
+	[EM2820_BOARD_KWORLD_PVRTV2800RF] = {
+		.name         = "Unknown EM2820/2840 video grabber",
+		.is_em2800    = 0,
+		.vchannels    = 2,
+		.norm         = VIDEO_MODE_PAL,
+		.tda9887_conf = TDA9887_PRESENT,
+		.has_tuner    = 1,
+		.decoder      = EM28XX_SAA7113,
+		.input           = {{
+			.type     = EM28XX_VMUX_COMPOSITE1,
+			.vmux     = 0,
+			.amux     = 1,
+		},{
+			.type     = EM28XX_VMUX_SVIDEO,
+			.vmux     = 9,
+			.amux     = 1,
+		}},
+	},
 	[EM2820_BOARD_TERRATEC_CINERGY_250] = {
 		.name         = "Terratec Cinergy 250 USB",
 		.vchannels    = 3,
@@ -136,8 +154,30 @@ struct em28xx_board em28xx_boards[] = {
 			.amux     = 1,
 		}},
 	},
-	[EM2880_BOARD_WINTV_HVR_900] = {
-		.name         = "WinTV HVR 900",
+	[EM2880_BOARD_HAUPPAUGE_WINTV_HVR_900] = {
+		.name         = "Hauppauge WinTV HVR 900",
+		.vchannels    = 3,
+		.norm         = VIDEO_MODE_PAL,
+		.has_tuner    = 0,
+		.tda9887_conf = TDA9887_PRESENT,
+		.has_tuner    = 1,
+		.decoder      = EM28XX_TVP5150,
+		.input          = {{
+			.type     = EM28XX_VMUX_COMPOSITE1,
+			.vmux     = 2,
+			.amux     = 0,
+		},{
+			.type     = EM28XX_VMUX_TELEVISION,
+			.vmux     = 0,
+			.amux     = 1,
+		},{
+			.type     = EM28XX_VMUX_SVIDEO,
+			.vmux     = 9,
+			.amux     = 1,
+		}},
+	},
+	[EM2880_BOARD_TERRATEC_HYBRID_XS] = {
+		.name         = "Terratec Hybrid XS",
 		.vchannels    = 3,
 		.norm         = VIDEO_MODE_PAL,
 		.has_tuner    = 0,
@@ -276,7 +316,8 @@ struct usb_device_id em28xx_id_table [] 
 	{ USB_DEVICE(0x2304, 0x0208), .driver_info = EM2820_BOARD_PINNACLE_USB_2 },
 	{ USB_DEVICE(0x2040, 0x4200), .driver_info = EM2820_BOARD_HAUPPAUGE_WINTV_USB_2 },
 	{ USB_DEVICE(0x2304, 0x0207), .driver_info = EM2820_BOARD_PINNACLE_DVC_90 },
-	{ USB_DEVICE(0x2040, 0x6500), .driver_info = EM2880_BOARD_WINTV_HVR_900 },
+	{ USB_DEVICE(0x2040, 0x6500), .driver_info = EM2880_BOARD_HAUPPAUGE_WINTV_HVR_900 },
+	{ USB_DEVICE(0x0ccd, 0x0042), .driver_info = EM2880_BOARD_TERRATEC_HYBRID_XS },
 	{ },
 };
 
@@ -284,7 +325,8 @@ void em28xx_pre_card_setup(struct em28xx
 {
 	/* request some modules */
 	switch(dev->model){
-		case EM2880_BOARD_WINTV_HVR_900:
+		case EM2880_BOARD_HAUPPAUGE_WINTV_HVR_900:
+		case EM2880_BOARD_TERRATEC_HYBRID_XS:
 			{
 				em28xx_write_regs_req(dev, 0x00, 0x08, "\x7d", 1); // reset through GPIO?
 				break;
@@ -317,6 +359,12 @@ void em28xx_card_setup(struct em28xx *de
 					dev->has_msp34xx=0;
 				break;
 			}
+		case EM2820_BOARD_KWORLD_PVRTV2800RF:
+			{
+				em28xx_write_regs_req(dev,0x00,0x08, "\xf9", 1); // GPIO enables sound on KWORLD PVR TV 2800RF
+				break;
+			}
+
 	}
 }
 
diff --git a/drivers/media/video/em28xx/em28xx.h b/drivers/media/video/em28xx/em28xx.h
diff --git a/drivers/media/video/em28xx/em28xx.h b/drivers/media/video/em28xx/em28xx.h
index 8269cca..ddf06c5 100644
--- a/drivers/media/video/em28xx/em28xx.h
+++ b/drivers/media/video/em28xx/em28xx.h
@@ -41,7 +41,9 @@
 #define EM2800_BOARD_LEADTEK_WINFAST_USBII      7
 #define EM2800_BOARD_KWORLD_USB2800             8
 #define EM2820_BOARD_PINNACLE_DVC_90		9
-#define EM2880_BOARD_WINTV_HVR_900              10
+#define EM2880_BOARD_HAUPPAUGE_WINTV_HVR_900	10
+#define EM2880_BOARD_TERRATEC_HYBRID_XS		11
+#define EM2820_BOARD_KWORLD_PVRTV2800RF		12
 
 #define UNSET -1
 


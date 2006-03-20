Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966683AbWCTPT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966683AbWCTPT6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966697AbWCTPT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:19:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29922 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966681AbWCTPTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:19:50 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 075/141] V4L/DVB (3326): Adding support for Terratec
	Prodigy XS
Date: Mon, 20 Mar 2006 12:08:49 -0300
Message-id: <20060320150849.PS545777000075@infradead.org>
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
Date: 1139289256 +0100

Adding support for Terratec Prodigy XS

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
index a9e7cec..703927e 100644
--- a/drivers/media/video/em28xx/em28xx-cards.c
+++ b/drivers/media/video/em28xx/em28xx-cards.c
@@ -198,6 +198,30 @@ struct em28xx_board em28xx_boards[] = {
 			.amux     = 1,
 		}},
 	},
+	/* maybe there's a reason behind it why Terratec sells the Hybrid XS as Prodigy XS with a
+	 * different PID, let's keep it separated for now maybe we'll need it lateron */
+	[EM2880_BOARD_TERRATEC_PRODIGY_XS] = {
+		.name         = "Terratec Prodigy XS",
+		.vchannels    = 3,
+		.norm         = VIDEO_MODE_PAL,
+		.tda9887_conf = TDA9887_PRESENT,
+		.has_tuner    = 1,
+		.tuner_type   = TUNER_XCEIVE_XC3028,
+		.decoder      = EM28XX_TVP5150,
+		.input          = {{
+			.type     = EM28XX_VMUX_TELEVISION,
+			.vmux     = 0,
+			.amux     = 0,
+		},{
+			.type     = EM28XX_VMUX_COMPOSITE1,
+			.vmux     = 2,
+			.amux     = 1,
+		},{
+			.type     = EM28XX_VMUX_SVIDEO,
+			.vmux     = 9,
+			.amux     = 1,
+		}},
+	},
 	[EM2820_BOARD_MSI_VOX_USB_2] = {
 		.name		= "MSI VOX USB 2.0",
 		.vchannels	= 3,
@@ -318,6 +342,7 @@ struct usb_device_id em28xx_id_table [] 
 	{ USB_DEVICE(0x2304, 0x0207), .driver_info = EM2820_BOARD_PINNACLE_DVC_90 },
 	{ USB_DEVICE(0x2040, 0x6500), .driver_info = EM2880_BOARD_HAUPPAUGE_WINTV_HVR_900 },
 	{ USB_DEVICE(0x0ccd, 0x0042), .driver_info = EM2880_BOARD_TERRATEC_HYBRID_XS },
+	{ USB_DEVICE(0x0ccd, 0x0047), .driver_info = EM2880_BOARD_TERRATEC_PRODIGY_XS },
 	{ },
 };
 
@@ -325,6 +350,7 @@ void em28xx_pre_card_setup(struct em28xx
 {
 	/* request some modules */
 	switch(dev->model){
+		case EM2880_BOARD_TERRATEC_PRODIGY_XS:
 		case EM2880_BOARD_HAUPPAUGE_WINTV_HVR_900:
 		case EM2880_BOARD_TERRATEC_HYBRID_XS:
 			{
diff --git a/drivers/media/video/em28xx/em28xx.h b/drivers/media/video/em28xx/em28xx.h
diff --git a/drivers/media/video/em28xx/em28xx.h b/drivers/media/video/em28xx/em28xx.h
index 4e2fe62..e1ddc2f 100644
--- a/drivers/media/video/em28xx/em28xx.h
+++ b/drivers/media/video/em28xx/em28xx.h
@@ -45,6 +45,7 @@
 #define EM2880_BOARD_HAUPPAUGE_WINTV_HVR_900	10
 #define EM2880_BOARD_TERRATEC_HYBRID_XS		11
 #define EM2820_BOARD_KWORLD_PVRTV2800RF		12
+#define EM2880_BOARD_TERRATEC_PRODIGY_XS	13
 
 #define UNSET -1
 


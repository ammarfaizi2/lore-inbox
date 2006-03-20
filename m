Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965363AbWCTPlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965363AbWCTPlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965292AbWCTPZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:25:02 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22200 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965286AbWCTPYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:24:49 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 081/141] V4L/DVB (3332): XC3028 code marked with an special
	define option
Date: Mon, 20 Mar 2006 12:08:50 -0300
Message-id: <20060320150850.PS547075000081@infradead.org>
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

From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1141009657 -0300

- Current xc3028 support is still experimental, requiring more work to be
  sent to mainstream. So, it was marked inside some defines, in order to be
  removed by gentree.pl stript. Script also updated to remove it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
index 00665d6..6666305 100644
--- a/drivers/media/video/em28xx/em28xx-cards.c
+++ b/drivers/media/video/em28xx/em28xx-cards.c
@@ -154,6 +154,7 @@ struct em28xx_board em28xx_boards[] = {
 			.amux     = 1,
 		}},
 	},
+#ifdef CONFIG_XC3028
 	[EM2880_BOARD_HAUPPAUGE_WINTV_HVR_900] = {
 		.name         = "Hauppauge WinTV HVR 900",
 		.vchannels    = 3,
@@ -222,6 +223,7 @@ struct em28xx_board em28xx_boards[] = {
 			.amux     = 1,
 		}},
 	},
+#endif
 	[EM2820_BOARD_MSI_VOX_USB_2] = {
 		.name		= "MSI VOX USB 2.0",
 		.vchannels	= 3,
@@ -340,9 +342,11 @@ struct usb_device_id em28xx_id_table [] 
 	{ USB_DEVICE(0x2304, 0x0208), .driver_info = EM2820_BOARD_PINNACLE_USB_2 },
 	{ USB_DEVICE(0x2040, 0x4200), .driver_info = EM2820_BOARD_HAUPPAUGE_WINTV_USB_2 },
 	{ USB_DEVICE(0x2304, 0x0207), .driver_info = EM2820_BOARD_PINNACLE_DVC_90 },
+#ifdef CONFIG_XC3028
 	{ USB_DEVICE(0x2040, 0x6500), .driver_info = EM2880_BOARD_HAUPPAUGE_WINTV_HVR_900 },
 	{ USB_DEVICE(0x0ccd, 0x0042), .driver_info = EM2880_BOARD_TERRATEC_HYBRID_XS },
 	{ USB_DEVICE(0x0ccd, 0x0047), .driver_info = EM2880_BOARD_TERRATEC_PRODIGY_XS },
+#endif
 	{ },
 };
 
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index 4a660a4..3a96cc4 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -216,9 +216,11 @@ static void set_type(struct i2c_client *
 		i2c_master_send(c,buffer,4);
 		default_tuner_init(c);
 		break;
+#ifdef CONFIG_XC3028
 	case TUNER_XCEIVE_XC3028:
 		xc3028_init(c);
 		break;
+#endif
 	default:
 		default_tuner_init(c);
 		break;
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index a4384e6..15761dd 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -983,23 +983,6 @@ static struct tuner_params tuner_samsung
 	},
 };
 
-/* ------------ TUNER_XCEIVE_XC3028 - Xceive xc3028 ------------ */
-
-static struct tuner_range tuner_xceive_xc3028_ranges[] = {
-	{ 16 * 140.25 /*MHz*/, 0x02, },
-	{ 16 * 463.25 /*MHz*/, 0x04, },
-	{ 16 * 999.99        , 0x01, },
-};
-
-static struct tuner_params tuner_xceive_xc3028_params[] = {
-	{
-		.type   = TUNER_XCEIVE_XC3028,
-		.ranges = tuner_xceive_xc3028_ranges,
-		.count  = ARRAY_SIZE(tuner_xceive_xc3028_ranges),
-	},
-};
-
-
 /* --------------------------------------------------------------------- */
 
 struct tunertype tuners[] = {
@@ -1369,7 +1352,7 @@ struct tunertype tuners[] = {
 	},
 	[TUNER_XCEIVE_XC3028] = { /* Xceive 3028 */
 		.name	= "Xceive xc3028",
-		.params = tuner_xceive_xc3028_params,
+		/* see xc3028.c for details */
 	},
 };
 


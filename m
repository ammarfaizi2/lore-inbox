Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965273AbWCTPWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965273AbWCTPWW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966834AbWCTPVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:21:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48098 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966841AbWCTPVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:21:42 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 080/141] V4L/DVB (3293): Fixed amux hauppauge
	hvr900/terratec hybrid xs
Date: Mon, 20 Mar 2006 12:08:50 -0300
Message-id: <20060320150850.PS380181000080@infradead.org>
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
Date: 1141009654 -0300

Fixed amux hauppauge hvr900/terratec hybrid xs

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
index fc58907..00665d6 100644
--- a/drivers/media/video/em28xx/em28xx-cards.c
+++ b/drivers/media/video/em28xx/em28xx-cards.c
@@ -101,7 +101,7 @@ struct em28xx_board em28xx_boards[] = {
 		.input          = {{
 			.type     = EM28XX_VMUX_TELEVISION,
 			.vmux     = 2,
-			.amux     = 0,
+			.amux     = 1,
 		},{
 			.type     = EM28XX_VMUX_COMPOSITE1,
 			.vmux     = 0,
@@ -165,11 +165,11 @@ struct em28xx_board em28xx_boards[] = {
 		.input          = {{
 			.type     = EM28XX_VMUX_COMPOSITE1,
 			.vmux     = 2,
-			.amux     = 0,
+			.amux     = 1,
 		},{
 			.type     = EM28XX_VMUX_TELEVISION,
 			.vmux     = 0,
-			.amux     = 1,
+			.amux     = 0,
 		},{
 			.type     = EM28XX_VMUX_SVIDEO,
 			.vmux     = 9,
@@ -185,12 +185,12 @@ struct em28xx_board em28xx_boards[] = {
 		.tuner_type   = TUNER_XCEIVE_XC3028,
 		.decoder      = EM28XX_TVP5150,
 		.input          = {{
-			.type     = EM28XX_VMUX_COMPOSITE1,
-			.vmux     = 2,
-			.amux     = 0,
-		},{
 			.type     = EM28XX_VMUX_TELEVISION,
 			.vmux     = 0,
+			.amux     = 0,
+		},{
+			.type     = EM28XX_VMUX_COMPOSITE1,
+			.vmux     = 2,
 			.amux     = 1,
 		},{
 			.type     = EM28XX_VMUX_SVIDEO,
diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
index 671fc52..f56ae48 100644
--- a/drivers/media/video/em28xx/em28xx-video.c
+++ b/drivers/media/video/em28xx/em28xx-video.c
@@ -222,8 +222,8 @@ static int em28xx_config(struct em28xx *
 
 	/* enable vbi capturing */
 
-	em28xx_write_regs_req(dev,0x00,0x0e,"\xC0",1);
-	em28xx_write_regs_req(dev,0x00,0x0f,"\x80",1);
+/*	em28xx_write_regs_req(dev,0x00,0x0e,"\xC0",1); audio register */
+/*	em28xx_write_regs_req(dev,0x00,0x0f,"\x80",1); clk register */
 	em28xx_write_regs_req(dev,0x00,0x11,"\x51",1);
 
 	em28xx_audio_usb_mute(dev, 1);
@@ -313,11 +313,11 @@ static void video_mux(struct em28xx *dev
 		em28xx_audio_source(dev, ainput);
 	} else {
 		switch (dev->ctl_ainput) {
-		case 0:
-			ainput = EM28XX_AUDIO_SRC_TUNER;
-			break;
-		default:
-			ainput = EM28XX_AUDIO_SRC_LINE;
+			case 0:
+				ainput = EM28XX_AUDIO_SRC_TUNER;
+				break;
+			default:
+				ainput = EM28XX_AUDIO_SRC_LINE;
 		}
 		em28xx_audio_source(dev, ainput);
 	}


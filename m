Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965704AbWCTQDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965704AbWCTQDu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965701AbWCTQDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:03:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37016 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966443AbWCTPQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:16:02 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 079/141] V4L/DVB (3292): Fixed xc3028 firmware extractor,
	added terratec fw support
Date: Mon, 20 Mar 2006 12:08:50 -0300
Message-id: <20060320150850.PS211574000079@infradead.org>
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
Date: 1141009651 -0300

Fixed xc3028 firmware extractor for terratec's emBDA.sys firmware
Fixed delay in firmwareupload, now terratec's firmware also works

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
index e9834c1..fc58907 100644
--- a/drivers/media/video/em28xx/em28xx-cards.c
+++ b/drivers/media/video/em28xx/em28xx-cards.c
@@ -181,8 +181,8 @@ struct em28xx_board em28xx_boards[] = {
 		.vchannels    = 3,
 		.norm         = VIDEO_MODE_PAL,
 		.tda9887_conf = TDA9887_PRESENT,
-		.tuner_type   = TUNER_XCEIVE_XC3028,
 		.has_tuner    = 1,
+		.tuner_type   = TUNER_XCEIVE_XC3028,
 		.decoder      = EM28XX_TVP5150,
 		.input          = {{
 			.type     = EM28XX_VMUX_COMPOSITE1,
diff --git a/drivers/media/video/em28xx/em28xx-i2c.c b/drivers/media/video/em28xx/em28xx-i2c.c
diff --git a/drivers/media/video/em28xx/em28xx-i2c.c b/drivers/media/video/em28xx/em28xx-i2c.c
index 6ca8631..5b6cece 100644
--- a/drivers/media/video/em28xx/em28xx-i2c.c
+++ b/drivers/media/video/em28xx/em28xx-i2c.c
@@ -420,7 +420,6 @@ static int em28xx_set_tuner(int check_ee
 		tun_setup.mode_mask = T_ANALOG_TV | T_RADIO;
 		tun_setup.type = dev->tuner_type;
 		tun_setup.addr = dev->tuner_addr;
-
 		em28xx_i2c_call_clients(dev, TUNER_SET_TYPE_ADDR, &tun_setup);
 	}
 
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index 520f274..4a660a4 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -173,7 +173,6 @@ static void set_type(struct i2c_client *
 	}
 
 	t->type = type;
-
 	switch (t->type) {
 	case TUNER_MT2032:
 		microtune_init(c);


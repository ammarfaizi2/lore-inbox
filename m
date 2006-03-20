Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965635AbWCTP5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965635AbWCTP5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966588AbWCTPSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:18:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61336 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966578AbWCTPSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:18:33 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 138/141] V4L/DVB (3411): FE6600 is a Thomson tuner
Date: Mon, 20 Mar 2006 12:09:00 -0300
Message-id: <20060320150900.PS019539000138@infradead.org>
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

From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1141182282 -0300

- The tuner used in DViCO FusionHDTV DVB-T hybrid is made by Thomson
- renamed tuner and dvb_pll structs accordingly

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.tuner b/Documentation/video4linux/CARDLIST.tuner
diff --git a/Documentation/video4linux/CARDLIST.tuner b/Documentation/video4linux/CARDLIST.tuner
index ab344c9..603f165 100644
--- a/Documentation/video4linux/CARDLIST.tuner
+++ b/Documentation/video4linux/CARDLIST.tuner
@@ -70,4 +70,4 @@ tuner=68 - Philips TUV1236D ATSC/NTSC du
 tuner=69 - Tena TNF 5335 MF
 tuner=70 - Samsung TCPN 2121P30A
 tuner=71 - Xceive xc3028
-tuner=72 - FE6600
+tuner=72 - Thomson FE6600
diff --git a/drivers/media/dvb/frontends/dvb-pll.c b/drivers/media/dvb/frontends/dvb-pll.c
diff --git a/drivers/media/dvb/frontends/dvb-pll.c b/drivers/media/dvb/frontends/dvb-pll.c
index 8a4c904..b6e2c38 100644
--- a/drivers/media/dvb/frontends/dvb-pll.c
+++ b/drivers/media/dvb/frontends/dvb-pll.c
@@ -405,8 +405,8 @@ struct dvb_pll_desc dvb_pll_philips_td13
 EXPORT_SYMBOL(dvb_pll_philips_td1316);
 
 /* FE6600 used on DViCO Hybrid */
-struct dvb_pll_desc dvb_pll_unknown_fe6600 = {
-	.name = "FE6600",
+struct dvb_pll_desc dvb_pll_thomson_fe6600 = {
+	.name = "Thomson FE6600",
 	.min =  44250000,
 	.max = 858000000,
 	.count = 4,
@@ -417,7 +417,7 @@ struct dvb_pll_desc dvb_pll_unknown_fe66
 		{ 999999999, 36213333, 166667, 0xf4, 0x18 },
 	}
 };
-EXPORT_SYMBOL(dvb_pll_unknown_fe6600);
+EXPORT_SYMBOL(dvb_pll_thomson_fe6600);
 
 /* ----------------------------------------------------------- */
 /* code                                                        */
diff --git a/drivers/media/dvb/frontends/dvb-pll.h b/drivers/media/dvb/frontends/dvb-pll.h
diff --git a/drivers/media/dvb/frontends/dvb-pll.h b/drivers/media/dvb/frontends/dvb-pll.h
index 8a7f0b9..2b84617 100644
--- a/drivers/media/dvb/frontends/dvb-pll.h
+++ b/drivers/media/dvb/frontends/dvb-pll.h
@@ -42,7 +42,7 @@ extern struct dvb_pll_desc dvb_pll_samsu
 extern struct dvb_pll_desc dvb_pll_philips_sd1878_tda8261;
 extern struct dvb_pll_desc dvb_pll_philips_td1316;
 
-extern struct dvb_pll_desc dvb_pll_unknown_fe6600;
+extern struct dvb_pll_desc dvb_pll_thomson_fe6600;
 
 int dvb_pll_configure(struct dvb_pll_desc *desc, u8 *buf,
 		      u32 freq, int bandwidth);
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index f655567..c0d1f0b 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -1073,7 +1073,7 @@ struct cx88_board cx88_boards[] = {
 	},
 	[CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_HYBRID] = {
 		.name           = "DViCO FusionHDTV DVB-T Hybrid",
-		.tuner_type     = TUNER_FE6600,
+		.tuner_type     = TUNER_THOMSON_FE6600,
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
diff --git a/drivers/media/video/cx88/cx88-dvb.c b/drivers/media/video/cx88/cx88-dvb.c
diff --git a/drivers/media/video/cx88/cx88-dvb.c b/drivers/media/video/cx88/cx88-dvb.c
index 2c97d3f..a9fc269 100644
--- a/drivers/media/video/cx88/cx88-dvb.c
+++ b/drivers/media/video/cx88/cx88-dvb.c
@@ -599,7 +599,7 @@ static int dvb_register(struct cx8802_de
 #ifdef HAVE_ZL10353
 	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_HYBRID:
 		dev->core->pll_addr = 0x61;
-		dev->core->pll_desc = &dvb_pll_unknown_fe6600;
+		dev->core->pll_desc = &dvb_pll_thomson_fe6600;
 		dev->dvb.frontend = zl10353_attach(&dvico_fusionhdtv_hybrid,
 						   &dev->core->i2c_adap);
 		break;
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index d10cfd4..db8b987 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -983,19 +983,19 @@ static struct tuner_params tuner_samsung
 	},
 };
 
-/* ------------ TUNER_FE6600 - DViCO Hybrid PAL ------------ */
+/* ------------ TUNER_THOMSON_FE6600 - DViCO Hybrid PAL ------------ */
 
-static struct tuner_range tuner_fe6600_ranges[] = {
+static struct tuner_range tuner_thomson_fe6600_ranges[] = {
 	{ 16 * 160.00 /*MHz*/, 0xfe, 0x11, },
 	{ 16 * 442.00 /*MHz*/, 0xf6, 0x12, },
 	{ 16 * 999.99        , 0xf6, 0x18, },
 };
 
-static struct tuner_params tuner_fe6600_params[] = {
+static struct tuner_params tuner_thomson_fe6600_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_PAL,
-		.ranges = tuner_fe6600_ranges,
-		.count  = ARRAY_SIZE(tuner_fe6600_ranges),
+		.ranges = tuner_thomson_fe6600_ranges,
+		.count  = ARRAY_SIZE(tuner_thomson_fe6600_ranges),
 	},
 };
 
@@ -1370,9 +1370,9 @@ struct tunertype tuners[] = {
 		.name	= "Xceive xc3028",
 		/* see xc3028.c for details */
 	},
-	[TUNER_FE6600] = { /* */
-		.name   = "FE6600",
-		.params = tuner_fe6600_params,
+	[TUNER_THOMSON_FE6600] = { /* Thomson PAL / DVB-T */
+		.name   = "Thomson FE6600",
+		.params = tuner_thomson_fe6600_params,
 	},
 };
 
diff --git a/include/media/tuner.h b/include/media/tuner.h
diff --git a/include/media/tuner.h b/include/media/tuner.h
index 039c77e..02d7d9a 100644
--- a/include/media/tuner.h
+++ b/include/media/tuner.h
@@ -118,7 +118,7 @@
 #define TUNER_SAMSUNG_TCPN_2121P30A     70 	/* Hauppauge PVR-500MCE NTSC */
 #define TUNER_XCEIVE_XC3028		71
 
-#define TUNER_FE6600			72	/* DViCO FusionHDTV DVB-T Hybrid */
+#define TUNER_THOMSON_FE6600		72	/* DViCO FusionHDTV DVB-T Hybrid */
 
 /* tv card specific */
 #define TDA9887_PRESENT 		(1<<0)


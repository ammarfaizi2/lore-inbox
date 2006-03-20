Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965591AbWCTPw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965591AbWCTPw6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965583AbWCTPw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:52:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51918 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965240AbWCTPwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:52:54 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 059/141] V4L/DVB (3305): Added support for the ADS Instant
	TV DUO Cardbus PTV331
Date: Mon, 20 Mar 2006 12:08:46 -0300
Message-id: <20060320150846.PS815651000059@infradead.org>
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

From: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Date: 1139302150 -0200

Analog and DVB-T are working, Remote not yet.
This card is based on the new LifeView design, there should be many variants.

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
index 1823e4c..ee1618d 100644
--- a/Documentation/video4linux/CARDLIST.saa7134
+++ b/Documentation/video4linux/CARDLIST.saa7134
@@ -85,3 +85,4 @@
  84 -> LifeView FlyDVB Trio                     [5168:0319]
  85 -> AverTV DVB-T 777                         [1461:2c05]
  86 -> LifeView FlyDVB-T                        [5168:0301]
+ 87 -> ADS Instant TV Duo Cardbus PTV331        [0331:1421]
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index f469f17..d65b9dd 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2657,7 +2657,23 @@ struct saa7134_board saa7134_boards[] = 
 			.amux = LINE2,
 		}},
 	},
-
+	[SAA7134_BOARD_ADS_DUO_CARDBUS_PTV331] = {
+		.name           = "ADS Instant TV Duo Cardbus PTV331",
+		.audio_clock    = 0x00200000,
+		.tuner_type     = TUNER_PHILIPS_TDA8290,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
+		.mpeg           = SAA7134_MPEG_DVB,
+		.gpiomask       = 0x00600000, /* Bit 21 0=Radio, Bit 22 0=TV */
+		.inputs = {{
+			.name   = name_tv,
+			.vmux   = 1,
+			.amux   = TV,
+			.tv     = 1,
+			.gpio   = 0x00200000,
+		}},
+	},
 };
 
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
@@ -3141,6 +3157,12 @@ struct pci_device_id saa7134_pci_tbl[] =
 		.subdevice    = 0x0301,
 		.driver_data  = SAA7134_BOARD_FLYDVBT_LR301,
 	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+		.subvendor    = 0x0331,
+		.subdevice    = 0x1421,
+		.driver_data  = SAA7134_BOARD_ADS_DUO_CARDBUS_PTV331,
+	},{
 		/* --- boards without eeprom + subsystem ID --- */
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
@@ -3263,6 +3285,10 @@ int saa7134_board_init1(struct saa7134_d
 		saa_writeb(SAA7134_GPIO_GPMODE3, 0x08);
 		saa_writeb(SAA7134_GPIO_GPSTATUS3, 0x06);
 		break;
+	case SAA7134_BOARD_ADS_DUO_CARDBUS_PTV331:
+		saa_writeb(SAA7134_GPIO_GPMODE3, 0x08);
+		saa_writeb(SAA7134_GPIO_GPSTATUS3, 0x00);
+		break;
 	case SAA7134_BOARD_AVERMEDIA_CARDBUS:
 		/* power-up tuner chip */
 		saa_andorl(SAA7134_GPIO_GPMODE0 >> 2,   0xffffffff, 0xffffffff);
@@ -3413,6 +3439,14 @@ int saa7134_board_init2(struct saa7134_d
 		i2c_transfer(&dev->i2c_adap, &msg, 1);
 		}
 		break;
+	case SAA7134_BOARD_ADS_DUO_CARDBUS_PTV331:
+		/* make the tda10046 find its eeprom */
+		{
+		u8 data[] = { 0x3c, 0x33, 0x62};
+		struct i2c_msg msg = {.addr=0x08, .flags=0, .buf=data, .len = sizeof(data)};
+		i2c_transfer(&dev->i2c_adap, &msg, 1);
+		}
+		break;
 	}
 	return 0;
 }
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
index be110b8..a0c8fa3 100644
--- a/drivers/media/video/saa7134/saa7134-dvb.c
+++ b/drivers/media/video/saa7134/saa7134-dvb.c
@@ -846,6 +846,45 @@ static struct tda1004x_config philips_ti
 	.request_firmware = NULL,
 };
 
+/* ------------------------------------------------------------------ */
+
+static int ads_duo_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
+{
+	int ret;
+
+	ret = philips_tda827xa_pll_set(0x61, fe, params);
+	return ret;
+};
+
+static int ads_duo_dvb_mode(struct dvb_frontend *fe)
+{
+	struct saa7134_dev *dev = fe->dvb->priv;
+	/* route TDA8275a AGC input to the channel decoder */
+	saa_writeb(SAA7134_GPIO_GPSTATUS2, 0x60);
+	return 0;
+}
+
+static void ads_duo_analog_mode(struct dvb_frontend *fe)
+{
+	struct saa7134_dev *dev = fe->dvb->priv;
+	/* route TDA8275a AGC input to the analog IF chip*/
+	saa_writeb(SAA7134_GPIO_GPSTATUS2, 0x20);
+	philips_tda827xa_pll_sleep( 0x61, fe);
+}
+
+static struct tda1004x_config ads_tech_duo_config = {
+	.demod_address = 0x08,
+	.invert        = 1,
+	.invert_oclk   = 0,
+	.xtal_freq     = TDA10046_XTAL_16M,
+	.agc_config    = TDA10046_AGC_TDA827X_GPL,
+	.if_freq       = TDA10046_FREQ_045,
+	.pll_init      = ads_duo_dvb_mode,
+	.pll_set       = ads_duo_pll_set,
+	.pll_sleep     = ads_duo_analog_mode,
+	.request_firmware = NULL,
+};
+
 #endif
 
 /* ------------------------------------------------------------------ */
@@ -928,6 +967,10 @@ static int dvb_init(struct saa7134_dev *
 		dev->dvb.frontend = tda10046_attach(&tda827x_lifeview_config,
 						    &dev->i2c_adap);
 		break;
+	case SAA7134_BOARD_ADS_DUO_CARDBUS_PTV331:
+		dev->dvb.frontend = tda10046_attach(&ads_tech_duo_config,
+						    &dev->i2c_adap);
+		break;
 #endif
 #ifdef HAVE_NXT200X
 	case SAA7134_BOARD_AVERMEDIA_AVERTVHD_A180:
diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
index ed556e6..4b49ee0 100644
--- a/drivers/media/video/saa7134/saa7134.h
+++ b/drivers/media/video/saa7134/saa7134.h
@@ -213,6 +213,7 @@ struct saa7134_format {
 #define SAA7134_BOARD_FLYDVB_TRIO 84
 #define SAA7134_BOARD_AVERMEDIA_777 85
 #define SAA7134_BOARD_FLYDVBT_LR301 86
+#define SAA7134_BOARD_ADS_DUO_CARDBUS_PTV331 87
 
 #define SAA7134_MAXBOARDS 8
 #define SAA7134_INPUT_MAX 8


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbWCTPgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWCTPgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965301AbWCTP0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:26:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28856 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964875AbWCTPZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:25:23 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Tamuki Shoichi <tamuki@linet.gr.jp>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 090/141] V4L/DVB (3346): Add saa713x card: ELSA EX-VISION
	700TV (saa7130)
Date: Mon, 20 Mar 2006 12:08:52 -0300
Message-id: <20060320150852.PS030253000090@infradead.org>
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

From: Tamuki Shoichi <tamuki@linet.gr.jp>
Date: 1141009684 -0300

Add support for ELSA EX-VISION 700TV, which is the ELSA Japan's
flagship model of the software encoding TV capture card.
All inputs (Television, Composite1 and S-Video) have been tested.

Signed-off-by: Tamuki Shoichi <tamuki@linet.gr.jp>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
index c10cfd2..617c757 100644
--- a/Documentation/video4linux/CARDLIST.saa7134
+++ b/Documentation/video4linux/CARDLIST.saa7134
@@ -87,3 +87,4 @@
  86 -> LifeView FlyDVB-T                        [5168:0301]
  87 -> ADS Instant TV Duo Cardbus PTV331        [0331:1421]
  88 -> Tevion DVB-T 220RF                       [17de:7201]
+ 89 -> ELSA EX-VISION 700TV                     [1131:7130]
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 3f41862..f5c7989 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -640,6 +640,32 @@ struct saa7134_board saa7134_boards[] = 
 			.tv   = 1,
 		}},
 	},
+	[SAA7134_BOARD_ELSA_700TV] = {
+		.name           = "ELSA EX-VISION 700TV",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_HITACHI_NTSC,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
+		.inputs         = {{
+			.name = name_tv,
+			.vmux = 4,
+			.amux = LINE2,
+			.tv   = 1,
+		},{
+			.name = name_comp1,
+			.vmux = 6,
+			.amux = LINE1,
+		},{
+			.name = name_svideo,
+			.vmux = 7,
+			.amux = LINE1,
+		}},
+		.mute           = {
+			.name = name_mute,
+			.amux = TV,
+		},
+	},
 	[SAA7134_BOARD_ASUSTeK_TVFM7134] = {
 		.name           = "ASUS TV-FM 7134",
 		.audio_clock    = 0x00187de7,
@@ -2831,6 +2857,12 @@ struct pci_device_id saa7134_pci_tbl[] =
 		.driver_data  = SAA7134_BOARD_ELSA_500TV,
 	},{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
+		.subvendor    = 0x1131,
+		.subdevice    = 0x7130,
+		.driver_data  = SAA7134_BOARD_ELSA_700TV,
+	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
 		.subvendor    = PCI_VENDOR_ID_ASUSTEK,
 		.subdevice    = 0x4842,
diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
index 691c10b..55a6733 100644
--- a/drivers/media/video/saa7134/saa7134.h
+++ b/drivers/media/video/saa7134/saa7134.h
@@ -216,6 +216,7 @@ struct saa7134_format {
 #define SAA7134_BOARD_FLYDVBT_LR301 86
 #define SAA7134_BOARD_ADS_DUO_CARDBUS_PTV331 87
 #define SAA7134_BOARD_TEVION_DVBT_220RF 88
+#define SAA7134_BOARD_ELSA_700TV       89
 
 #define SAA7134_MAXBOARDS 8
 #define SAA7134_INPUT_MAX 8


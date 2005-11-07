Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVKGDRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVKGDRS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVKGDQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:16:51 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:59218 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932427AbVKGDQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:16:36 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com, Pavel Mihaylov <bin@bash.info>
Subject: [Patch 06/20] V4L(906) Remote and more info for pctv cardbus
	whitespace cleanup
Date: Mon, 07 Nov 2005 00:58:07 -0200
Message-Id: <1131333341.25215.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Mihaylov <bin@bash.info>

- Remote and more info for PCTV Cardbus. Whitespace cleanup.

Signed-off-by: Pavel Mihaylov <bin@bash.info>
Signed-off-by: Nickolay V. Shmyrev <nshmyrev@yandex.ru>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 Documentation/video4linux/CARDLIST.saa7134  |    1 
 drivers/media/video/saa7134/saa7134-cards.c |   23 ++++++++++++---
 drivers/media/video/saa7134/saa7134-dvb.c   |    8 ++---
 drivers/media/video/saa7134/saa7134-input.c |   42 ++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 8 deletions(-)

--- hg.orig/Documentation/video4linux/CARDLIST.saa7134
+++ hg/Documentation/video4linux/CARDLIST.saa7134
@@ -79,3 +79,4 @@
  78 -> ASUSTeK P7131 Dual                       [1043:4862]
  79 -> PCTV Cardbus TV/Radio (ITO25 Rev:2B)
  80 -> ASUS Digimatrix TV                       [1043:0210]
+ 81 -> Philips Tiger reference design           [1131:2018]
--- hg.orig/drivers/media/video/saa7134/saa7134-cards.c
+++ hg/drivers/media/video/saa7134/saa7134-cards.c
@@ -2453,18 +2453,33 @@ struct saa7134_board saa7134_boards[] = 
 	},
 	[SAA7134_BOARD_PCTV_CARDBUS] = {
 		/* Paul Tom Zalac <pzalac@gmail.com> */
-		/* tda8275a tuner doesnt work yet */
+		/* Pavel Mihaylov <bin@bash.info> */
 		.name           = "PCTV Cardbus TV/Radio (ITO25 Rev:2B)",
+				/* Sedna Cardbus TV Tuner */
 		.audio_clock    = 0x00187de7,
-		.tuner_type     = TUNER_ABSENT,
+		.tuner_type     = TUNER_PHILIPS_TDA8290,
 		.radio_type     = UNSET,
 		.tuner_addr     = ADDR_UNSET,
 		.radio_addr     = ADDR_UNSET,
+		.gpiomask       = 0xe880c0,
 		.inputs         = {{
+			.name = name_tv,
+			.vmux = 3,
+			.amux = TV,
+			.tv   = 1,
+		},{
 			.name = name_comp1,
 			.vmux = 1,
-			.amux = LINE2,
+			.amux = LINE1,
+		},{
+			.name = name_svideo,
+			.vmux = 6,
+			.amux = LINE1,
 		}},
+		.radio = {
+			.name = name_radio,
+			.amux = LINE2,
+		},
 	},
 	[SAA7134_BOARD_ASUSTEK_DIGIMATRIX_TV] = {
 		/* "Cyril Lacoux (Yack)" <clacoux@ifeelgood.org> */
@@ -2942,7 +2957,7 @@ struct pci_device_id saa7134_pci_tbl[] =
 		.subvendor    = 0x1043,
 		.subdevice    = 0x4862,
 		.driver_data  = SAA7134_BOARD_ASUSTeK_P7131_DUAL,
- 	},{
+	},{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
 		.subvendor    = PCI_VENDOR_ID_PHILIPS,
--- hg.orig/drivers/media/video/saa7134/saa7134-dvb.c
+++ hg/drivers/media/video/saa7134/saa7134-dvb.c
@@ -667,7 +667,7 @@ static struct tda827xa_data tda827xa_dvb
 	{ .lomax = 911000000, .svco = 3, .spd = 0, .scr = 2, .sbs = 4, .gc3 = 0},
 	{ .lomax =         0, .svco = 0, .spd = 0, .scr = 0, .sbs = 0, .gc3 = 0}};
 
-			
+
 static int philips_tda827xa_pll_set(u8 addr, struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
 {
 	struct saa7134_dev *dev = fe->dvb->priv;
@@ -677,7 +677,7 @@ static int philips_tda827xa_pll_set(u8 a
 	struct i2c_msg msg = {.addr = addr,.flags = 0,.buf = tuner_buf};
 	int i, tuner_freq, if_freq;
 	u32 N;
-	
+
 	switch (params->u.ofdm.bandwidth) {
 	case BANDWIDTH_6_MHZ:
 		if_freq = 4000000;
@@ -749,9 +749,9 @@ static void philips_tda827xa_pll_sleep(u
 	struct saa7134_dev *dev = fe->dvb->priv;
 	static u8 tda827xa_sleep[] = { 0x30, 0x90};
 	struct i2c_msg tuner_msg = {.addr = addr,.flags = 0,.buf = tda827xa_sleep,
-	                            .len = sizeof(tda827xa_sleep) };
+		                    .len = sizeof(tda827xa_sleep) };
 	i2c_transfer(&dev->i2c_adap, &tuner_msg, 1);
-	
+
 }
 
 /* ------------------------------------------------------------------ */
--- hg.orig/drivers/media/video/saa7134/saa7134-input.c
+++ hg/drivers/media/video/saa7134/saa7134-input.c
@@ -543,6 +543,42 @@ static IR_KEYTAB_TYPE ir_codes_pinnacle[
 	[ 0x0a ] = KEY_BACKSPACE,
 };
 
+/* Mapping for the 28 key remote control as seen at
+   http://www.sednacomputer.com/photo/cardbus-tv.jpg
+   Pavel Mihaylov <bin@bash.info> */
+static IR_KEYTAB_TYPE pctv_cardbus_codes[IR_KEYTAB_SIZE] = {
+	[    0 ] = KEY_KP0,
+	[    1 ] = KEY_KP1,
+	[    2 ] = KEY_KP2,
+	[    3 ] = KEY_KP3,
+	[    4 ] = KEY_KP4,
+	[    5 ] = KEY_KP5,
+	[    6 ] = KEY_KP6,
+	[    7 ] = KEY_KP7,
+	[    8 ] = KEY_KP8,
+	[    9 ] = KEY_KP9,
+
+	[ 0x0a ] = KEY_AGAIN,          /* Recall */
+	[ 0x0b ] = KEY_CHANNELUP,
+	[ 0x0c ] = KEY_VOLUMEUP,
+	[ 0x0d ] = KEY_MODE,           /* Stereo */
+	[ 0x0e ] = KEY_STOP,
+	[ 0x0f ] = KEY_PREVIOUSSONG,
+	[ 0x10 ] = KEY_ZOOM,
+	[ 0x11 ] = KEY_TUNER,          /* Source */
+	[ 0x12 ] = KEY_POWER,
+	[ 0x13 ] = KEY_MUTE,
+	[ 0x15 ] = KEY_CHANNELDOWN,
+	[ 0x18 ] = KEY_VOLUMEDOWN,
+	[ 0x19 ] = KEY_SHUFFLE,        /* Snapshot */
+	[ 0x1a ] = KEY_NEXTSONG,
+	[ 0x1b ] = KEY_TEXT,           /* Time Shift */
+	[ 0x1c ] = KEY_RADIO,          /* FM Radio */
+	[ 0x1d ] = KEY_RECORD,
+	[ 0x1e ] = KEY_PAUSE,
+};
+
+
 /* -------------------- GPIO generic keycode builder -------------------- */
 
 static int build_key(struct saa7134_dev *dev)
@@ -745,6 +781,12 @@ int saa7134_input_init1(struct saa7134_d
 		mask_keyup   = 0x004000;
 		polling      = 50; // ms
 		break;
+	case SAA7134_BOARD_PCTV_CARDBUS:
+		ir_codes     = pctv_cardbus_codes;
+		mask_keycode = 0x001f00;
+		mask_keyup   = 0x004000;
+		polling      = 50; // ms
+		break;
 	case SAA7134_BOARD_GOTVIEW_7135:
 		ir_codes     = gotview7135_codes;
 		mask_keycode = 0x0003EC;


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVFBLkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVFBLkt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 07:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVFBLkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 07:40:49 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:40359 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261377AbVFBLkR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 07:40:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TsIDL1N0DhvGQ6WlkOWJzB6sWoTVyRH5pKrd29+9hIYZiVXh8fX1HdCO9DK560qXwsFVOdMPT6ydUQUi0Is04A5N6Qg0AotMp/4eb2gJOZr5gR9IomvieJ71uF8UrKKSqZQzS3yxudmBEqt3tKA4tA6RlucP5IIldlxYriCi18E=
Message-ID: <105fc4d4050602044078818ad@mail.gmail.com>
Date: Thu, 2 Jun 2005 12:40:16 +0100
From: Manuel Capinha <mcapinha@gmail.com>
Reply-To: Manuel Capinha <mcapinha@gmail.com>
To: Linux and Kernel Video <video4linux-list@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <maurochehab@gmail.com>
Subject: [Patch] Add support for PixelView Ultra Pro in v4l
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds support for the PixelView Ultra Pro video
capture card in v4l.
- It removes the remote control key definitions from ir-kbd-gpio.c and
moves them to ir-common.c so that they can be shared between bt878 and
cx88 based cards.
- The patch also moves the FUSIONHDTV_3_GOLD_Q card from number 27 to
28 to regain compatibility with the V4L cvs.

This patch was made against 2.6.12-rc5-mm.

Thanks and feel free to contact me if you need any aditional info on this,
Manuel

----------------------------------SNIP------------------------------------------------

diff -ur linux-2.6.12-rc5-mm/drivers/media/common/ir-common.c
linux-2.6.12-rc5-mm-PixelView/drivers/media/common/ir-common.c
--- linux-2.6.12-rc5-mm/drivers/media/common/ir-common.c	2005-06-02
00:38:34.191718432 +0100
+++ linux-2.6.12-rc5-mm-PixelView/drivers/media/common/ir-common.c	2005-06-02
01:01:40.322994448 +0100
@@ -213,6 +213,39 @@
 };
 EXPORT_SYMBOL(ir_codes_hauppauge_new);
 
+IR_KEYTAB_TYPE ir_codes_pixelview[IR_KEYTAB_SIZE] = {
+	[  2 ] = KEY_KP0,
+	[  1 ] = KEY_KP1,
+	[ 11 ] = KEY_KP2,
+	[ 27 ] = KEY_KP3,
+	[  5 ] = KEY_KP4,
+	[  9 ] = KEY_KP5,
+	[ 21 ] = KEY_KP6,
+	[  6 ] = KEY_KP7,
+	[ 10 ] = KEY_KP8,
+	[ 18 ] = KEY_KP9,
+
+	[  3 ] = KEY_TUNER,       // TV/FM
+	[  7 ] = KEY_SEARCH,      // scan
+	[ 28 ] = KEY_ZOOM,        // full screen
+	[ 30 ] = KEY_POWER,
+	[ 23 ] = KEY_VOLUMEDOWN,
+	[ 31 ] = KEY_VOLUMEUP,
+	[ 20 ] = KEY_CHANNELDOWN,
+	[ 22 ] = KEY_CHANNELUP,
+	[ 24 ] = KEY_MUTE,
+
+	[  0 ] = KEY_LIST,        // source
+	[ 19 ] = KEY_INFO,        // loop
+	[ 16 ] = KEY_LAST,        // +100
+	[ 13 ] = KEY_CLEAR,       // reset
+	[ 12 ] = BTN_RIGHT,       // fun++
+	[  4 ] = BTN_LEFT,        // fun--
+	[ 14 ] = KEY_GOTO,        // function
+	[ 15 ] = KEY_STOP,         // freeze
+};
+EXPORT_SYMBOL(ir_codes_pixelview);
+
 /* --------------------------------------------------------------------------
*/
 
 static void ir_input_key_event(struct input_dev *dev, struct
ir_input_state *ir)
diff -ur linux-2.6.12-rc5-mm/drivers/media/video/cx88/cx88-cards.c
linux-2.6.12-rc5-mm-PixelView/drivers/media/video/cx88/cx88-cards.c
--- linux-2.6.12-rc5-mm/drivers/media/video/cx88/cx88-cards.c	2005-06-02
00:38:32.761935792 +0100
+++ linux-2.6.12-rc5-mm-PixelView/drivers/media/video/cx88/cx88-cards.c	2005-06-02
00:55:47.298662304 +0100
@@ -628,6 +628,27 @@
 			.gpio1  = 0x0000e07f,
 		}}
 	},
+	[CX88_BOARD_PIXELVIEW_PLAYTV_ULTRA_PRO] = {
+		.name           = "PixelView PlayTV Ultra Pro (Stereo)",
+		.tuner_type     = 38,
+		.input          = {{
+			.type   = CX88_VMUX_TELEVISION,
+			.vmux   = 0,
+			.gpio0  = 0xbf61,  // internal decoder
+		},{
+			.type   = CX88_VMUX_COMPOSITE1,
+			.vmux   = 1,
+			.gpio0  = 0xbf63,
+		},{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 2,
+			.gpio0  = 0xbf63,
+		}},
+		.radio = {
+			.type  = CX88_RADIO,
+			.gpio0 = 0xbf60,
+		},
+	},
 };
 const unsigned int cx88_bcount = ARRAY_SIZE(cx88_boards);
 
diff -ur linux-2.6.12-rc5-mm/drivers/media/video/cx88/cx88.h
linux-2.6.12-rc5-mm-PixelView/drivers/media/video/cx88/cx88.h
--- linux-2.6.12-rc5-mm/drivers/media/video/cx88/cx88.h	2005-06-02
00:38:32.764935336 +0100
+++ linux-2.6.12-rc5-mm-PixelView/drivers/media/video/cx88/cx88.h	2005-06-02
00:56:31.586929464 +0100
@@ -162,7 +162,8 @@
 #define CX88_BOARD_HAUPPAUGE_ROSLYN        24
 #define CX88_BOARD_DIGITALLOGIC_MEC	       25
 #define CX88_BOARD_IODATA_GVBCTV7E         26
-#define CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q   27
+#define CX88_BOARD_PIXELVIEW_PLAYTV_ULTRA_PRO 27
+#define CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q   28
 
 enum cx88_itype {
 	CX88_VMUX_COMPOSITE1 = 1,
diff -ur linux-2.6.12-rc5-mm/drivers/media/video/cx88/cx88-input.c
linux-2.6.12-rc5-mm-PixelView/drivers/media/video/cx88/cx88-input.c
--- linux-2.6.12-rc5-mm/drivers/media/video/cx88/cx88-input.c	2005-06-02
00:38:32.777933360 +0100
+++ linux-2.6.12-rc5-mm-PixelView/drivers/media/video/cx88/cx88-input.c	2005-06-02
00:58:05.120710168 +0100
@@ -261,6 +261,13 @@
 		ir->mask_keydown = 0x02;
 		ir->polling      = 5; // ms
 		break;
+	case CX88_BOARD_PIXELVIEW_PLAYTV_ULTRA_PRO:
+		ir_codes         = ir_codes_pixelview;
+		ir->gpio_addr    = MO_GP1_IO;
+		ir->mask_keycode = 0x1f;
+		ir->mask_keyup   = 0x80;
+		ir->polling      = 1; // ms
+		break;
 	}
 	if (NULL == ir_codes) {
 		kfree(ir);
diff -ur linux-2.6.12-rc5-mm/drivers/media/video/ir-kbd-gpio.c
linux-2.6.12-rc5-mm-PixelView/drivers/media/video/ir-kbd-gpio.c
--- linux-2.6.12-rc5-mm/drivers/media/video/ir-kbd-gpio.c	2005-06-02
00:38:33.108883048 +0100
+++ linux-2.6.12-rc5-mm-PixelView/drivers/media/video/ir-kbd-gpio.c	2005-06-02
01:03:08.762549592 +0100
@@ -114,38 +114,6 @@
 	[ 0x3e ] = KEY_VOLUMEUP,    // 'volume +'
 };
 
-static IR_KEYTAB_TYPE ir_codes_pixelview[IR_KEYTAB_SIZE] = {
-	[  2 ] = KEY_KP0,
-	[  1 ] = KEY_KP1,
-	[ 11 ] = KEY_KP2,
-	[ 27 ] = KEY_KP3,
-	[  5 ] = KEY_KP4,
-	[  9 ] = KEY_KP5,
-	[ 21 ] = KEY_KP6,
-	[  6 ] = KEY_KP7,
-	[ 10 ] = KEY_KP8,
-	[ 18 ] = KEY_KP9,
-
-	[  3 ] = KEY_TUNER,       // TV/FM
-	[  7 ] = KEY_SEARCH,      // scan
-	[ 28 ] = KEY_ZOOM,        // full screen
-	[ 30 ] = KEY_POWER,
-	[ 23 ] = KEY_VOLUMEDOWN,
-	[ 31 ] = KEY_VOLUMEUP,
-	[ 20 ] = KEY_CHANNELDOWN,
-	[ 22 ] = KEY_CHANNELUP,
-	[ 24 ] = KEY_MUTE,
-
-	[  0 ] = KEY_LIST,        // source
-	[ 19 ] = KEY_INFO,        // loop
-	[ 16 ] = KEY_LAST,        // +100
-	[ 13 ] = KEY_CLEAR,       // reset
-	[ 12 ] = BTN_RIGHT,       // fun++
-	[  4 ] = BTN_LEFT,        // fun--
-	[ 14 ] = KEY_GOTO,        // function
-	[ 15 ] = KEY_STOP,         // freeze
-};
-
 /* Attila Kondoros <attila.kondoros@chello.hu> */
 static IR_KEYTAB_TYPE ir_codes_apac_viewcomp[IR_KEYTAB_SIZE] = {
 
diff -ur linux-2.6.12-rc5-mm/include/media/ir-common.h
linux-2.6.12-rc5-mm-PixelView/include/media/ir-common.h
--- linux-2.6.12-rc5-mm/include/media/ir-common.h	2005-06-02
00:39:52.044882952 +0100
+++ linux-2.6.12-rc5-mm-PixelView/include/media/ir-common.h	2005-06-02
01:02:22.670556640 +0100
@@ -50,6 +50,7 @@
 extern IR_KEYTAB_TYPE ir_codes_winfast[IR_KEYTAB_SIZE];
 extern IR_KEYTAB_TYPE ir_codes_empty[IR_KEYTAB_SIZE];
 extern IR_KEYTAB_TYPE ir_codes_hauppauge_new[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_pixelview[IR_KEYTAB_SIZE];
 
 void ir_input_init(struct input_dev *dev, struct ir_input_state *ir,
 		   int ir_type, IR_KEYTAB_TYPE *ir_codes);




----------------------------------SNIP------------------------------------------------

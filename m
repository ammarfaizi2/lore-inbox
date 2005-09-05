Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932677AbVIEVoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbVIEVoH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbVIEVnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:43:52 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:20562 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932677AbVIEVnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:43:41 -0400
Date: Mon, 05 Sep 2005 18:26:15 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 04/24] V4L: SAA7134 updates and board additions
Message-ID: <431cb7f7.GOx66tQV23534Tpt%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f7.ZAMOIm5bB9cfYK2hVL+RW7Nffz7tuAD93Pl1iLA8+Dt0SiL5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f7.ZAMOIm5bB9cfYK2hVL+RW7Nffz7tuAD93Pl1iLA8+Dt0SiL5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f7.ZAMOIm5bB9cfYK2hVL+RW7Nffz7tuAD93Pl1iLA8+Dt0SiL5
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-04-saa7134-update.diff"

- Remove $Id CVS logs for V4L files
- linux/version.h replaced by linux/utsname.h
- Add new Digimatrix card and LG TAPC Mini tuner for it

Signed-off-by: Hermann Pitton <hermann.pitton@onlinehome.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 Documentation/video4linux/CARDLIST.saa7134    |    1 
 drivers/media/video/saa7134/saa7134-cards.c   |   48 +++++++++++++++++++++++++-
 drivers/media/video/saa7134/saa7134-core.c    |    1 
 drivers/media/video/saa7134/saa7134-dvb.c     |    1 
 drivers/media/video/saa7134/saa7134-empress.c |    1 
 drivers/media/video/saa7134/saa7134-i2c.c     |    1 
 drivers/media/video/saa7134/saa7134-input.c   |    1 
 drivers/media/video/saa7134/saa7134-oss.c     |    1 
 drivers/media/video/saa7134/saa7134-reg.h     |    1 
 drivers/media/video/saa7134/saa7134-ts.c      |    1 
 drivers/media/video/saa7134/saa7134-tvaudio.c |    1 
 drivers/media/video/saa7134/saa7134-vbi.c     |    1 
 drivers/media/video/saa7134/saa7134-video.c   |   25 -------------
 drivers/media/video/saa7134/saa7134.h         |    4 +-
 14 files changed, 51 insertions(+), 37 deletions(-)

diff -upr linux-2.6.13.orig/Documentation/video4linux/CARDLIST.saa7134 linux-2.6.13/Documentation/video4linux/CARDLIST.saa7134
--- linux-2.6.13.orig/Documentation/video4linux/CARDLIST.saa7134	2005-09-05 11:41:05.108719917 -0500
+++ linux-2.6.13/Documentation/video4linux/CARDLIST.saa7134	2005-09-05 11:49:47.531714572 -0500
@@ -62,3 +62,4 @@
  61 -> Philips TOUGH DVB-T reference design     [1131:2004]
  62 -> Compro VideoMate TV Gold+II
  63 -> Kworld Xpert TV PVR7134
+ 64 -> FlyTV mini Asus Digimatrix               [1043:0210,1043:0210]
diff -upr linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-cards.c linux-2.6.13/drivers/media/video/saa7134/saa7134-cards.c
--- linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-cards.c	2005-09-05 11:41:05.683505374 -0500
+++ linux-2.6.13/drivers/media/video/saa7134/saa7134-cards.c	2005-09-05 11:49:33.319019934 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: saa7134-cards.c,v 1.80 2005/07/07 01:49:30 mkrufky Exp $
  *
  * device driver for philips saa7134 based TV cards
  * card-specific stuff.
@@ -2001,6 +2000,41 @@ struct saa7134_board saa7134_boards[] = 
 			.gpio = 0x000,
 		},
 	},
+	[SAA7134_BOARD_FLYTV_DIGIMATRIX] = {
+		.name		= "FlyTV mini Asus Digimatrix",
+		.audio_clock	= 0x00200000,
+		.tuner_type	= TUNER_LG_NTSC_TALN_MINI,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
+		.inputs         = {{
+			.name = name_tv,
+			.vmux = 1,
+			.amux = TV,
+			.tv   = 1,
+		},{
+			.name = name_tv_mono,
+			.vmux = 1,
+			.amux = LINE2,
+			.tv   = 1,
+		},{
+			.name = name_comp1,
+			.vmux = 0,
+			.amux = LINE2,
+		},{
+			.name = name_comp2,
+			.vmux = 3,
+			.amux = LINE2,
+		},{
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE2,
+		}},
+		.radio = {
+			.name = name_radio,		/* radio unconfirmed */
+			.amux = LINE2,
+		},
+	},
 };
 
 
@@ -2346,6 +2380,18 @@ struct pci_device_id saa7134_pci_tbl[] =
 		.subvendor    = 0x4e42,
 		.subdevice    = 0x0502,
 		.driver_data  = SAA7134_BOARD_THYPHOON_DVBT_DUO_CARDBUS,
+	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+		.subvendor    = 0x1043,
+		.subdevice    = 0x0210,		/* mini pci NTSC version */
+		.driver_data  = SAA7134_BOARD_FLYTV_DIGIMATRIX,
+	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+		.subvendor    = 0x1043,
+		.subdevice    = 0x0210,		/* mini pci PAL/SECAM version */
+		.driver_data  = SAA7134_BOARD_FLYTV_DIGIMATRIX,
 
 	},{
 		/* --- boards without eeprom + subsystem ID --- */
diff -upr linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-core.c linux-2.6.13/drivers/media/video/saa7134/saa7134-core.c
--- linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-core.c	2005-09-05 11:41:05.682505747 -0500
+++ linux-2.6.13/drivers/media/video/saa7134/saa7134-core.c	2005-09-05 11:49:08.302358216 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: saa7134-core.c,v 1.39 2005/07/05 17:37:35 nsh Exp $
  *
  * device driver for philips saa7134 based TV cards
  * driver core
diff -upr linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-dvb.c linux-2.6.13/drivers/media/video/saa7134/saa7134-dvb.c
--- linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-dvb.c	2005-09-05 11:41:05.680506493 -0500
+++ linux-2.6.13/drivers/media/video/saa7134/saa7134-dvb.c	2005-09-05 11:49:08.313354111 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: saa7134-dvb.c,v 1.23 2005/07/24 22:12:47 mkrufky Exp $
  *
  * (c) 2004 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
  *
diff -upr linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-empress.c linux-2.6.13/drivers/media/video/saa7134/saa7134-empress.c
--- linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-empress.c	2005-09-05 11:41:05.682505747 -0500
+++ linux-2.6.13/drivers/media/video/saa7134/saa7134-empress.c	2005-09-05 11:49:08.313354111 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: saa7134-empress.c,v 1.11 2005/05/22 19:23:39 nsh Exp $
  *
  * (c) 2004 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
  *
diff -upr linux-2.6.13.orig/drivers/media/video/saa7134/saa7134.h linux-2.6.13/drivers/media/video/saa7134/saa7134.h
--- linux-2.6.13.orig/drivers/media/video/saa7134/saa7134.h	2005-09-05 11:41:05.681506120 -0500
+++ linux-2.6.13/drivers/media/video/saa7134/saa7134.h	2005-09-05 11:49:33.318020307 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: saa7134.h,v 1.49 2005/07/13 17:25:25 mchehab Exp $
  *
  * v4l2 device driver for philips saa7134 based TV cards
  *
@@ -20,7 +19,7 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/version.h>
+#include <linux/utsname.h>
 #define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,14)
 
 #include <linux/pci.h>
@@ -185,6 +184,7 @@ struct saa7134_format {
 #define SAA7134_BOARD_PHILIPS_TOUGH 61
 #define SAA7134_BOARD_VIDEOMATE_TV_GOLD_PLUSII 62
 #define SAA7134_BOARD_KWORLD_XPERT 63
+#define SAA7134_BOARD_FLYTV_DIGIMATRIX 64
 
 #define SAA7134_MAXBOARDS 8
 #define SAA7134_INPUT_MAX 8
diff -upr linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-i2c.c linux-2.6.13/drivers/media/video/saa7134/saa7134-i2c.c
--- linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-i2c.c	2005-09-05 11:41:05.680506493 -0500
+++ linux-2.6.13/drivers/media/video/saa7134/saa7134-i2c.c	2005-09-05 11:49:08.306356723 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: saa7134-i2c.c,v 1.22 2005/07/22 04:09:41 mkrufky Exp $
  *
  * device driver for philips saa7134 based TV cards
  * i2c interface support
diff -upr linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-input.c linux-2.6.13/drivers/media/video/saa7134/saa7134-input.c
--- linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-input.c	2005-09-05 11:41:05.680506493 -0500
+++ linux-2.6.13/drivers/media/video/saa7134/saa7134-input.c	2005-09-05 11:49:08.312354484 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: saa7134-input.c,v 1.21 2005/06/22 23:37:34 nsh Exp $
  *
  * handle saa7134 IR remotes via linux kernel input layer.
  *
diff -upr linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-oss.c linux-2.6.13/drivers/media/video/saa7134/saa7134-oss.c
--- linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-oss.c	2005-09-05 11:41:05.681506120 -0500
+++ linux-2.6.13/drivers/media/video/saa7134/saa7134-oss.c	2005-09-05 11:49:08.311354858 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: saa7134-oss.c,v 1.17 2005/06/28 23:41:47 mkrufky Exp $
  *
  * device driver for philips saa7134 based TV cards
  * oss dsp interface
diff -upr linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-reg.h linux-2.6.13/drivers/media/video/saa7134/saa7134-reg.h
--- linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-reg.h	2005-09-05 11:41:05.683505374 -0500
+++ linux-2.6.13/drivers/media/video/saa7134/saa7134-reg.h	2005-09-05 11:49:08.301358589 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: saa7134-reg.h,v 1.2 2004/09/15 16:15:24 kraxel Exp $
  *
  * philips saa7134 registers
  */
diff -upr linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-ts.c linux-2.6.13/drivers/media/video/saa7134/saa7134-ts.c
--- linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-ts.c	2005-09-05 11:41:05.684505001 -0500
+++ linux-2.6.13/drivers/media/video/saa7134/saa7134-ts.c	2005-09-05 11:49:08.312354484 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: saa7134-ts.c,v 1.15 2005/06/14 22:48:18 hhackmann Exp $
  *
  * device driver for philips saa7134 based TV cards
  * video4linux video interface
diff -upr linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-tvaudio.c linux-2.6.13/drivers/media/video/saa7134/saa7134-tvaudio.c
--- linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-tvaudio.c	2005-09-05 11:41:05.680506493 -0500
+++ linux-2.6.13/drivers/media/video/saa7134/saa7134-tvaudio.c	2005-09-05 11:49:08.307356350 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: saa7134-tvaudio.c,v 1.30 2005/06/28 23:41:47 mkrufky Exp $
  *
  * device driver for philips saa7134 based TV cards
  * tv audio decoder (fm stereo, nicam, ...)
diff -upr linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-vbi.c linux-2.6.13/drivers/media/video/saa7134/saa7134-vbi.c
--- linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-vbi.c	2005-09-05 11:41:05.681506120 -0500
+++ linux-2.6.13/drivers/media/video/saa7134/saa7134-vbi.c	2005-09-05 11:49:08.311354858 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: saa7134-vbi.c,v 1.7 2005/05/24 23:13:06 nsh Exp $
  *
  * device driver for philips saa7134 based TV cards
  * video4linux video interface
diff -upr linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-video.c linux-2.6.13/drivers/media/video/saa7134/saa7134-video.c
--- linux-2.6.13.orig/drivers/media/video/saa7134/saa7134-video.c	2005-09-05 11:41:05.682505747 -0500
+++ linux-2.6.13/drivers/media/video/saa7134/saa7134-video.c	2005-09-05 11:49:51.577204456 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: saa7134-video.c,v 1.36 2005/06/28 23:41:47 mkrufky Exp $
  *
  * device driver for philips saa7134 based TV cards
  * video4linux video interface
@@ -1368,29 +1367,7 @@ static int video_release(struct inode *i
 	saa_andorb(SAA7134_OFMT_DATA_A, 0x1f, 0);
 	saa_andorb(SAA7134_OFMT_DATA_B, 0x1f, 0);
 
-	if (dev->tuner_type == TUNER_PHILIPS_TDA8290) {
-		u8 data[2];
-		int ret;
-		struct i2c_msg msg = {.addr=I2C_ADDR_TDA8290, .flags=0, .buf=data, .len = 2};
-		data[0] = 0x21;
-		data[1] = 0xc0;
-		ret = i2c_transfer(&dev->i2c_adap, &msg, 1);
-		if (ret != 1)
-			printk(KERN_ERR "TDA8290 access failure\n");
-		msg.addr = I2C_ADDR_TDA8275;
-		data[0] = 0x30;
-		data[1] = 0xd0;
-		ret = i2c_transfer(&dev->i2c_adap, &msg, 1);
-		if (ret != 1)
-			printk(KERN_ERR "TDA8275 access failure\n");
-		msg.addr = I2C_ADDR_TDA8290;
-		data[0] = 0x21;
-		data[1] = 0x80;
-		i2c_transfer(&dev->i2c_adap, &msg, 1);
-		data[0] = 0x00;
-		data[1] = 0x02;
-		i2c_transfer(&dev->i2c_adap, &msg, 1);
-	}
+	saa7134_i2c_call_clients(dev, TUNER_SET_STANDBY, NULL);
 
 	/* free stuff */
 	videobuf_mmap_free(&fh->cap);

--=_431cb7f7.ZAMOIm5bB9cfYK2hVL+RW7Nffz7tuAD93Pl1iLA8+Dt0SiL5--

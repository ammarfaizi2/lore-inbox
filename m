Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbUKIAv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbUKIAv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 19:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbUKIAv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 19:51:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15369 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261315AbUKIAuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 19:50:46 -0500
Date: Tue, 9 Nov 2004 01:50:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [1/11] drivers/media/video: the easy cleanups
Message-ID: <20041109005013.GP15077@stusta.de>
References: <20041107175017.GP14308@stusta.de> <20041108114008.GB20607@bytesex> <20041109004341.GO15077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109004341.GO15077@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch only makes code that is neither mentioned in a header file 
nor declared extern in another file static.

Additionally, it does remove the unused function stradis_driver from 
stradis.c (or what should the comment mean?).


diffstat output:
 drivers/media/video/bt819.c                 |    2 +-
 drivers/media/video/bttv-cards.c            |   20 ++++++++++----------
 drivers/media/video/bttv-driver.c           |    6 +++---
 drivers/media/video/bttv-i2c.c              |    2 +-
 drivers/media/video/bw-qcam.c               |    8 ++++----
 drivers/media/video/c-qcam.c                |    4 ++--
 drivers/media/video/dpc7146.c               |    7 +++----
 drivers/media/video/hexium_orion.c          |    4 ++--
 drivers/media/video/mxb.c                   |    4 ++--
 drivers/media/video/mxb.h                   |    2 +-
 drivers/media/video/pms.c                   |    2 +-
 drivers/media/video/saa7134/saa7134-core.c  |    2 +-
 drivers/media/video/saa7134/saa7134-video.c |   14 +++++++-------
 drivers/media/video/stradis.c               |    7 -------
 drivers/media/video/tuner-3036.c            |    4 ++--
 15 files changed, 40 insertions(+), 48 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bt819.c.old	2004-11-07 16:33:44.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bt819.c	2004-11-07 16:33:57.000000000 +0100
@@ -95,7 +95,7 @@
 };
 
 /* for values, see the bt819 datasheet */
-struct timing timing_data[] = {
+static struct timing timing_data[] = {
 	{864 - 24, 20, 625 - 2, 1, 0x0504, 0x0000},
 	{858 - 24, 20, 525 - 2, 1, 0x00f8, 0x0000},
 };
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-i2c.c.old	2004-11-07 16:43:56.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-i2c.c	2004-11-07 16:44:33.000000000 +0100
@@ -253,7 +253,7 @@
        	return retval;
 }
 
-int bttv_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
+static int bttv_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
 {
 	struct bttv *btv = i2c_get_adapdata(i2c_adap);
 	int retval = 0;
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/hexium_orion.c.old	2004-11-07 17:01:06.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/hexium_orion.c	2004-11-07 17:01:19.000000000 +0100
@@ -499,7 +499,7 @@
 	.irq_func = NULL,
 };
 
-int __init hexium_init_module(void)
+static int __init hexium_init_module(void)
 {
 	if (0 != saa7146_register_extension(&extension)) {
 		DEB_S(("failed to register extension.\n"));
@@ -509,7 +509,7 @@
 	return 0;
 }
 
-void __exit hexium_cleanup_module(void)
+static void __exit hexium_cleanup_module(void)
 {
 	saa7146_unregister_extension(&extension);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/tuner-3036.c.old	2004-11-07 17:07:29.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/tuner-3036.c	2004-11-07 17:07:41.000000000 +0100
@@ -197,14 +197,14 @@
 	.name		= "SAB3036",
 };
 
-int __init
+static int __init
 tuner3036_init(void)
 {
 	i2c_add_driver(&i2c_driver_tuner);
 	return 0;
 }
 
-void __exit
+static void __exit
 tuner3036_exit(void)
 {
 	i2c_del_driver(&i2c_driver_tuner);
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/stradis.c.old	2004-11-07 17:06:54.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/stradis.c	2004-11-07 17:07:17.000000000 +0100
@@ -97,13 +97,6 @@
 #define debAudio	(NewCard ? nDebAudio : oDebAudio)
 #define debDMA		(NewCard ? nDebDMA : oDebDMA)
 
-#ifdef DEBUG
-int stradis_driver(void)	/* for the benefit of ksymoops */
-{
-	return 1;
-}
-#endif
-
 #ifdef USE_RESCUE_EEPROM_SDM275
 static unsigned char rescue_eeprom[64] = {
 0x00,0x01,0x04,0x13,0x26,0x0f,0x10,0x00,0x00,0x00,0x43,0x63,0x22,0x01,0x29,0x15,0x73,0x00,0x1f, 'd', 'e', 'c', 'x', 'l', 'd', 'v', 'a',0x02,0x00,0x01,0x00,0xcc,0xa4,0x63,0x09,0xe2,0x10,0x00,0x0a,0x00,0x02,0x02, 'd', 'e', 'c', 'x', 'l', 'a',0x00,0x00,0x42,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/dpc7146.c.old	2004-11-07 17:00:31.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/dpc7146.c	2004-11-07 17:00:54.000000000 +0100
@@ -58,8 +58,7 @@
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "debug verbosity");
 
-/* global variables */
-int dpc_num = 0;
+static int dpc_num = 0;
 
 #define DPC_INPUTS	2
 static struct v4l2_input dpc_inputs[DPC_INPUTS] = {
@@ -379,7 +378,7 @@
 	.irq_func	= NULL,
 };	
 
-int __init dpc_init_module(void) 
+static int __init dpc_init_module(void) 
 {
 	if( 0 != saa7146_register_extension(&extension)) {
 		DEB_S(("failed to register extension.\n"));
@@ -389,7 +388,7 @@
 	return 0;
 }
 
-void __exit dpc_cleanup_module(void) 
+static void __exit dpc_cleanup_module(void) 
 {
 	saa7146_unregister_extension(&extension);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/mxb.h.old	2004-11-07 17:02:18.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/mxb.h	2004-11-07 17:02:57.000000000 +0100
@@ -12,7 +12,7 @@
 
 /* these are the available audio sources, which can switched
    to the line- and cd-output individually */
-struct v4l2_audio mxb_audios[MXB_AUDIOS] = {
+static struct v4l2_audio mxb_audios[MXB_AUDIOS] = {
 	    {
 		.index	= 0,
 		.name	= "Tuner",
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/mxb.c.old	2004-11-07 17:03:05.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/mxb.c	2004-11-07 17:03:22.000000000 +0100
@@ -1012,7 +1012,7 @@
 	.irq_func	= NULL,
 };	
 
-int __init mxb_init_module(void) 
+static int __init mxb_init_module(void) 
 {
 	if( 0 != saa7146_register_extension(&extension)) {
 		DEB_S(("failed to register extension.\n"));
@@ -1022,7 +1022,7 @@
 	return 0;
 }
 
-void __exit mxb_cleanup_module(void) 
+static void __exit mxb_cleanup_module(void) 
 {
 	saa7146_unregister_extension(&extension);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/pms.c.old	2004-11-07 17:03:42.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/pms.c	2004-11-07 17:04:01.000000000 +0100
@@ -896,7 +896,7 @@
 	.fops           = &pms_fops,
 };
 
-struct pms_device pms_device;
+static struct pms_device pms_device;
 
 
 /*
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/c-qcam.c.old	2004-11-07 16:52:23.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/c-qcam.c	2004-11-07 16:52:39.000000000 +0100
@@ -741,7 +741,7 @@
 static struct qcam_device *qcams[MAX_CAMS];
 static unsigned int num_cams = 0;
 
-int init_cqcam(struct parport *port)
+static int init_cqcam(struct parport *port)
 {
 	struct qcam_device *qcam;
 
@@ -798,7 +798,7 @@
 	return 0;
 }
 
-void close_cqcam(struct qcam_device *qcam)
+static void close_cqcam(struct qcam_device *qcam)
 {
 	video_unregister_device(&qcam->vdev);
 	parport_unregister_device(qcam->pdev);
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-cards.c.old	2004-11-07 16:34:59.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-cards.c	2004-11-07 17:14:25.000000000 +0100
@@ -2180,7 +2181,7 @@
 	// .has_remote     = 1,
 }};
 
-const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
+static const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
 
 /* ----------------------------------------------------------------------- */
 
@@ -2349,10 +2350,10 @@
 	//todo: if(has_tda9874) btv->audio_hook = fv2000s_audio;
 }
 
-int miro_tunermap[] = { 0,6,2,3,   4,5,6,0,  3,0,4,5,  5,2,16,1,
-			14,2,17,1, 4,1,4,3,  1,2,16,1, 4,4,4,4 };
-int miro_fmtuner[]  = { 0,0,0,0,   0,0,0,0,  0,0,0,0,  0,0,0,1,
-			1,1,1,1,   1,1,1,0,  0,0,0,0,  0,1,0,0 };
+static int miro_tunermap[] = { 0,6,2,3,   4,5,6,0,  3,0,4,5,  5,2,16,1,
+			       14,2,17,1, 4,1,4,3,  1,2,16,1, 4,4,4,4 };
+static int miro_fmtuner[]  = { 0,0,0,0,   0,0,0,0,  0,0,0,0,  0,0,0,1,
+			       1,1,1,1,   1,1,1,0,  0,0,0,0,  0,1,0,0 };
 
 static void miro_pinnacle_gpio(struct bttv *btv)
 {
@@ -3129,7 +3109,7 @@
 /* ----------------------------------------------------------------------- */
 /* AVermedia specific stuff, from  bktr_card.c                             */
 
-int tuner_0_table[] = {
+static int tuner_0_table[] = {
         TUNER_PHILIPS_NTSC,  TUNER_PHILIPS_PAL /* PAL-BG*/,
         TUNER_PHILIPS_PAL,   TUNER_PHILIPS_PAL /* PAL-I*/,
         TUNER_PHILIPS_PAL,   TUNER_PHILIPS_PAL,
@@ -3144,7 +3124,7 @@
         PHILIPS_FR1236_SECAM, PHILIPS_FR1216_PAL};
 #endif
 
-int tuner_1_table[] = {
+static int tuner_1_table[] = {
         TUNER_TEMIC_NTSC,  TUNER_TEMIC_PAL,
 	TUNER_TEMIC_PAL,   TUNER_TEMIC_PAL,
 	TUNER_TEMIC_PAL,   TUNER_TEMIC_PAL,
@@ -3338,7 +3318,7 @@
  * Brutally hacked by Dan Sheridan <dan.sheridan@contact.org.uk> djs52 8/3/00
  */
 
-void bus_low(struct bttv *btv, int bit)
+static void bus_low(struct bttv *btv, int bit)
 {
 	if (btv->mbox_ior) {
 		gpio_bits(btv->mbox_ior | btv->mbox_iow | btv->mbox_csel,
@@ -3355,7 +3335,7 @@
 	}
 }
 
-void bus_high(struct bttv *btv, int bit)
+static void bus_high(struct bttv *btv, int bit)
 {
 	if (btv->mbox_ior) {
 		gpio_bits(btv->mbox_ior | btv->mbox_iow | btv->mbox_csel,
@@ -3372,7 +3352,7 @@
 	}
 }
 
-int bus_in(struct bttv *btv, int bit)
+static int bus_in(struct bttv *btv, int bit)
 {
 	if (btv->mbox_ior) {
 		gpio_bits(btv->mbox_ior | btv->mbox_iow | btv->mbox_csel,
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-driver.c.old	2004-11-07 16:40:15.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-driver.c	2004-11-07 16:41:55.000000000 +0100
@@ -627,7 +627,7 @@
 	}
 
 };
-const int BTTV_CTLS = ARRAY_SIZE(bttv_ctls);
+static const int BTTV_CTLS = ARRAY_SIZE(bttv_ctls);
 
 /* ----------------------------------------------------------------------- */
 /* resource management                                                     */
@@ -763,7 +763,7 @@
 }
 
 /* used to switch between the bt848's analog/digital video capture modes */
-void bt848A_set_timing(struct bttv *btv)
+static void bt848A_set_timing(struct bttv *btv)
 {
 	int i, len;
 	int table_idx = bttv_tvnorms[btv->tvnorm].sram;
@@ -3048,7 +3048,7 @@
 	.minor    = -1,
 };
 
-struct video_device bttv_vbi_template =
+static struct video_device bttv_vbi_template =
 {
 	.name     = "bt848/878 vbi",
 	.type     = VID_TYPE_TUNER|VID_TYPE_TELETEXT,
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bw-qcam.c.old	2004-11-07 16:50:36.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bw-qcam.c	2004-11-07 16:51:57.000000000 +0100
@@ -446,7 +446,7 @@
 /* Reset the QuickCam and program for brightness, contrast,
  * white-balance, and resolution. */
 
-void qc_set(struct qcam_device *q)
+static void qc_set(struct qcam_device *q)
 {
 	int val;
 	int val2;
@@ -596,7 +596,7 @@
  * n=2^(bit depth)-1.  Ask me for more details if you don't understand
  * this. */
 
-long qc_capture(struct qcam_device * q, char __user *buf, unsigned long len)
+static long qc_capture(struct qcam_device * q, char __user *buf, unsigned long len)
 {
 	int i, j, k, yield;
 	int bytes;
@@ -896,7 +896,7 @@
 static struct qcam_device *qcams[MAX_CAMS];
 static unsigned int num_cams = 0;
 
-int init_bwqcam(struct parport *port)
+static int init_bwqcam(struct parport *port)
 {
 	struct qcam_device *qcam;
 
@@ -939,7 +939,7 @@
 	return 0;
 }
 
-void close_bwqcam(struct qcam_device *qcam)
+static void close_bwqcam(struct qcam_device *qcam)
 {
 	video_unregister_device(&qcam->vdev);
 	parport_unregister_device(qcam->pdev);
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/saa7134/saa7134-core.c.old	2004-11-07 17:04:57.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/saa7134/saa7134-core.c	2004-11-07 17:05:24.000000000 +0100
@@ -233,7 +233,7 @@
 /* ------------------------------------------------------------------ */
 
 /* nr of (saa7134-)pages for the given buffer size */
-int saa7134_buffer_pages(int size)
+static int saa7134_buffer_pages(int size)
 {
 	size  = PAGE_ALIGN(size);
 	size += PAGE_SIZE; /* for non-page-aligned buffers */
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/saa7134/saa7134-video.c.old	2004-11-07 17:05:54.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/saa7134/saa7134-video.c	2004-11-07 17:06:39.000000000 +0100
@@ -1383,7 +1383,7 @@
 
 /* ------------------------------------------------------------------ */
 
-void saa7134_vbi_fmt(struct saa7134_dev *dev, struct v4l2_format *f)
+static void saa7134_vbi_fmt(struct saa7134_dev *dev, struct v4l2_format *f)
 {
 	struct saa7134_tvnorm *norm = dev->tvnorm;
 
@@ -1406,8 +1406,8 @@
 #endif
 }
 
-int saa7134_g_fmt(struct saa7134_dev *dev, struct saa7134_fh *fh,
-		  struct v4l2_format *f)
+static int saa7134_g_fmt(struct saa7134_dev *dev, struct saa7134_fh *fh,
+			 struct v4l2_format *f)
 {
 	switch (f->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
@@ -1432,8 +1432,8 @@
 	}
 }
 
-int saa7134_try_fmt(struct saa7134_dev *dev, struct saa7134_fh *fh,
-		    struct v4l2_format *f)
+static int saa7134_try_fmt(struct saa7134_dev *dev, struct saa7134_fh *fh,
+			   struct v4l2_format *f)
 {
 	int err;
 	
@@ -1497,8 +1497,8 @@
 	}
 }
 
-int saa7134_s_fmt(struct saa7134_dev *dev, struct saa7134_fh *fh,
-		  struct v4l2_format *f)
+static int saa7134_s_fmt(struct saa7134_dev *dev, struct saa7134_fh *fh,
+			 struct v4l2_format *f)
 {
 	unsigned long flags;
 	int err;

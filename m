Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130911AbQKRBz3>; Fri, 17 Nov 2000 20:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130912AbQKRBzT>; Fri, 17 Nov 2000 20:55:19 -0500
Received: from ha2.rdc2.mi.home.com ([24.2.68.69]:4534 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S130911AbQKRBzG>; Fri, 17 Nov 2000 20:55:06 -0500
Message-ID: <3A15DA0A.A7DA3D28@didntduck.org>
Date: Fri, 17 Nov 2000 20:23:22 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11-pre5-mm i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Video4Linux cleanup
Content-Type: multipart/mixed;
 boundary="------------57B81B0109FAA46154A51C5F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------57B81B0109FAA46154A51C5F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Patch against test11-pre6

- Converts struct video_device to named initializers
- Fixes radio-maestro init
- Removes superfluous initialize functions (those that just return 0)

-- 

						Brian Gerst
--------------57B81B0109FAA46154A51C5F
Content-Type: text/plain; charset=us-ascii;
 name="v4l-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l-1.diff"

diff -urN linux-2.4.0t11p6/drivers/media/radio/radio-aimslab.c linux-v4l1/drivers/media/radio/radio-aimslab.c
--- linux-2.4.0t11p6/drivers/media/radio/radio-aimslab.c	Mon Jun 19 16:25:06 2000
+++ linux-v4l1/drivers/media/radio/radio-aimslab.c	Fri Nov 17 19:32:28 2000
@@ -322,17 +322,12 @@
 
 static struct video_device rtrack_radio=
 {
-	"RadioTrack radio",
-	VID_TYPE_TUNER,
-	VID_HARDWARE_RTRACK,
-	rt_open,
-	rt_close,
-	NULL,	/* Can't read  (no capture ability) */
-	NULL,	/* Can't write */
-	NULL,	/* No poll */
-	rt_ioctl,
-	NULL,
-	NULL
+	name:		"RadioTrack radio",
+	type:		VID_TYPE_TUNER,
+	hardware:	VID_HARDWARE_RTRACK,
+	open:		rt_open,
+	close:		rt_close,
+	ioctl:		rt_ioctl,
 };
 
 static int __init rtrack_init(void)
diff -urN linux-2.4.0t11p6/drivers/media/radio/radio-aztech.c linux-v4l1/drivers/media/radio/radio-aztech.c
--- linux-2.4.0t11p6/drivers/media/radio/radio-aztech.c	Wed Sep 29 17:02:59 1999
+++ linux-v4l1/drivers/media/radio/radio-aztech.c	Fri Nov 17 19:32:28 2000
@@ -273,17 +273,12 @@
 
 static struct video_device aztech_radio=
 {
-	"Aztech radio",
-	VID_TYPE_TUNER,
-	VID_HARDWARE_AZTECH,
-	az_open,
-	az_close,
-	NULL,	/* Can't read  (no capture ability) */
-	NULL,	/* Can't write */
-	NULL,	/* No poll */
-	az_ioctl,
-	NULL,
-	NULL
+	name:		"Aztech radio",
+	type:		VID_TYPE_TUNER,
+	hardware:	VID_HARDWARE_AZTECH,
+	open:		az_open,
+	close:		az_close,
+	ioctl:		az_ioctl,
 };
 
 static int __init aztech_init(void)
diff -urN linux-2.4.0t11p6/drivers/media/radio/radio-cadet.c linux-v4l1/drivers/media/radio/radio-cadet.c
--- linux-2.4.0t11p6/drivers/media/radio/radio-cadet.c	Thu Nov 16 22:09:22 2000
+++ linux-v4l1/drivers/media/radio/radio-cadet.c	Fri Nov 17 19:32:28 2000
@@ -542,17 +542,13 @@
 
 static struct video_device cadet_radio=
 {
-	"Cadet radio",
-	VID_TYPE_TUNER,
-	VID_HARDWARE_CADET,
-	cadet_open,
-	cadet_close,
-	cadet_read,
-	NULL,	/* Can't write */
-	NULL,	/* No poll */
-	cadet_ioctl,
-	NULL,
-	NULL
+	name:		"Cadet radio",
+	type:		VID_TYPE_TUNER,
+	hardware:	VID_HARDWARE_CADET,
+	open:		cadet_open,
+	close:		cadet_close,
+	read:		cadet_read,
+	ioctl:		cadet_ioctl,
 };
 
 #ifdef CONFIG_ISAPNP
diff -urN linux-2.4.0t11p6/drivers/media/radio/radio-gemtek.c linux-v4l1/drivers/media/radio/radio-gemtek.c
--- linux-2.4.0t11p6/drivers/media/radio/radio-gemtek.c	Mon Mar 13 12:43:36 2000
+++ linux-v4l1/drivers/media/radio/radio-gemtek.c	Fri Nov 17 19:32:28 2000
@@ -249,17 +249,12 @@
 
 static struct video_device gemtek_radio=
 {
-	"GemTek radio",
-	VID_TYPE_TUNER,
-	VID_HARDWARE_GEMTEK,
-	gemtek_open,
-	gemtek_close,
-	NULL,	/* Can't read  (no capture ability) */
-	NULL,	/* Can't write */
-	NULL,	/* Can't poll */
-	gemtek_ioctl,
-	NULL,
-	NULL
+	name:		"GemTek radio",
+	type:		VID_TYPE_TUNER,
+	hardware:	VID_HARDWARE_GEMTEK,
+	open:		gemtek_open,
+	close:		gemtek_close,
+	ioctl:		gemtek_ioctl,
 };
 
 static int __init gemtek_init(void)
diff -urN linux-2.4.0t11p6/drivers/media/radio/radio-maestro.c linux-v4l1/drivers/media/radio/radio-maestro.c
--- linux-2.4.0t11p6/drivers/media/radio/radio-maestro.c	Tue Sep 19 11:01:34 2000
+++ linux-v4l1/drivers/media/radio/radio-maestro.c	Fri Nov 17 20:12:29 2000
@@ -69,17 +69,12 @@
 
 static struct video_device maestro_radio=
 {
-	"Maestro radio",
-	VID_TYPE_TUNER,
-	VID_HARDWARE_SF16MI,
-	radio_open,
-	radio_close,
-	NULL,
-	NULL,
-	NULL,
-	radio_ioctl,
-	NULL,
-	NULL
+	name:		"Maestro radio",
+	type:		VID_TYPE_TUNER,
+	hardware:	VID_HARDWARE_SF16MI,
+	open:		radio_open,
+	close:		radio_close,
+	ioctl:		radio_ioctl,
 };
 
 static struct radio_device
@@ -300,21 +295,17 @@
 
 inline static __u16 radio_install(struct pci_dev *pcidev);
 
-#ifdef MODULE
 MODULE_AUTHOR("Adam Tlalka, atlka@pg.gda.pl");
 MODULE_DESCRIPTION("Radio driver for the Maestro PCI sound card radio.");
 
 EXPORT_NO_SYMBOLS;
 
-void cleanup_module(void)
+void __exit maestro_radio_exit(void)
 {
 	video_unregister_device(&maestro_radio);
 }
 
-int init_module(void)
-#else
-int __init maestro_radio_init(struct video_init *v)
-#endif
+int __init maestro_radio_init(void)
 {
 	register __u16 found=0;
 	struct pci_dev *pcidev = NULL;
@@ -334,6 +325,9 @@
 	}
 	return 0;
 }
+
+module_init(maestro_radio_init);
+module_exit(maestro_radio_exit);
 
 inline static __u16 radio_power_on(struct radio_device *dev)
 {
diff -urN linux-2.4.0t11p6/drivers/media/radio/radio-miropcm20.c linux-v4l1/drivers/media/radio/radio-miropcm20.c
--- linux-2.4.0t11p6/drivers/media/radio/radio-miropcm20.c	Tue Aug 22 14:29:02 2000
+++ linux-v4l1/drivers/media/radio/radio-miropcm20.c	Fri Nov 17 19:32:28 2000
@@ -192,17 +192,12 @@
 
 static struct video_device pcm20_radio=
 {
-	"Miro PCM 20 radio",
-	VID_TYPE_TUNER,
-	VID_HARDWARE_RTRACK,
-	pcm20_open,
-	pcm20_close,
-	NULL,	/* Can't read  (no capture ability) */
-	NULL,	/* Can't write */
-	NULL,	/* Can't poll */
-	pcm20_ioctl,
-	NULL,
-	NULL
+	name:		"Miro PCM 20 radio",
+	type:		VID_TYPE_TUNER,
+	hardware:	VID_HARDWARE_RTRACK,
+	open:		pcm20_open,
+	close:		pcm20_close,
+	ioctl:		pcm20_ioctl,
 };
 
 static int __init pcm20_init(void)
diff -urN linux-2.4.0t11p6/drivers/media/radio/radio-rtrack2.c linux-v4l1/drivers/media/radio/radio-rtrack2.c
--- linux-2.4.0t11p6/drivers/media/radio/radio-rtrack2.c	Thu Oct 28 19:12:56 1999
+++ linux-v4l1/drivers/media/radio/radio-rtrack2.c	Fri Nov 17 19:32:28 2000
@@ -215,17 +215,12 @@
 
 static struct video_device rtrack2_radio=
 {
-	"RadioTrack II radio",
-	VID_TYPE_TUNER,
-	VID_HARDWARE_RTRACK2,
-	rt_open,
-	rt_close,
-	NULL,	/* Can't read  (no capture ability) */
-	NULL,	/* Can't write */
-	NULL,	/* Can't poll */
-	rt_ioctl,
-	NULL,
-	NULL
+	name:		"RadioTrack II radio",
+	type:		VID_TYPE_TUNER,
+	hardware:	VID_HARDWARE_RTRACK2,
+	open:		rt_open,
+	close:		rt_close,
+	ioctl:		rt_ioctl,
 };
 
 static int __init rtrack2_init(void)
diff -urN linux-2.4.0t11p6/drivers/media/radio/radio-sf16fmi.c linux-v4l1/drivers/media/radio/radio-sf16fmi.c
--- linux-2.4.0t11p6/drivers/media/radio/radio-sf16fmi.c	Thu Oct 28 19:13:00 1999
+++ linux-v4l1/drivers/media/radio/radio-sf16fmi.c	Fri Nov 17 19:32:28 2000
@@ -276,17 +276,12 @@
 
 static struct video_device fmi_radio=
 {
-	"SF16FMx radio",
-	VID_TYPE_TUNER,
-	VID_HARDWARE_SF16MI,
-	fmi_open,
-	fmi_close,
-	NULL,	/* Can't read  (no capture ability) */
-	NULL,	/* Can't write */
-	NULL,	/* Can't poll */
-	fmi_ioctl,
-	NULL,
-	NULL
+	name:		"SF16FMx radio",
+	type:		VID_TYPE_TUNER,
+	hardware:	VID_HARDWARE_SF16MI,
+	open:		fmi_open,
+	close:		fmi_close,
+	ioctl:		fmi_ioctl,
 };
 
 static int __init fmi_init(void)
diff -urN linux-2.4.0t11p6/drivers/media/radio/radio-terratec.c linux-v4l1/drivers/media/radio/radio-terratec.c
--- linux-2.4.0t11p6/drivers/media/radio/radio-terratec.c	Thu Oct 28 19:13:03 1999
+++ linux-v4l1/drivers/media/radio/radio-terratec.c	Fri Nov 17 19:32:29 2000
@@ -294,17 +294,12 @@
 
 static struct video_device terratec_radio=
 {
-	"TerraTec ActiveRadio",
-	VID_TYPE_TUNER,
-	VID_HARDWARE_TERRATEC,
-	tt_open,
-	tt_close,
-	NULL,	/* Can't read  (no capture ability) */
-	NULL,	/* Can't write */
-	NULL,	/* No poll */
-	tt_ioctl,
-	NULL,
-	NULL
+	name:		"TerraTec ActiveRadio",
+	type:		VID_TYPE_TUNER,
+	hardware:	VID_HARDWARE_TERRATEC,
+	open:		tt_open,
+	close:		tt_close,
+	ioctl:		tt_ioctl,
 };
 
 static int __init terratec_init(void)
diff -urN linux-2.4.0t11p6/drivers/media/radio/radio-trust.c linux-v4l1/drivers/media/radio/radio-trust.c
--- linux-2.4.0t11p6/drivers/media/radio/radio-trust.c	Thu Oct 28 19:13:07 1999
+++ linux-v4l1/drivers/media/radio/radio-trust.c	Fri Nov 17 19:32:29 2000
@@ -286,17 +286,12 @@
 
 static struct video_device trust_radio=
 {
-	"Trust FM Radio",
-	VID_TYPE_TUNER,
-	VID_HARDWARE_TRUST,
-	tr_open,
-	tr_close,
-	NULL,	/* Can't read  (no capture ability) */
-	NULL,	/* Can't write */
-	NULL,	/* No poll */
-	tr_ioctl,
-	NULL,
-	NULL
+	name:		"Trust FM Radio",
+	type:		VID_TYPE_TUNER,
+	hardware:	VID_HARDWARE_TRUST,
+	open:		tr_open,
+	close:		tr_close,
+	ioctl:		tr_ioctl,
 };
 
 static int __init trust_init(void)
diff -urN linux-2.4.0t11p6/drivers/media/radio/radio-typhoon.c linux-v4l1/drivers/media/radio/radio-typhoon.c
--- linux-2.4.0t11p6/drivers/media/radio/radio-typhoon.c	Fri Aug  4 21:36:46 2000
+++ linux-v4l1/drivers/media/radio/radio-typhoon.c	Fri Nov 17 19:32:29 2000
@@ -273,27 +273,19 @@
 
 static struct typhoon_device typhoon_unit =
 {
-	0,				/* users */
-	CONFIG_RADIO_TYPHOON_PORT,	/* iobase */
-	0,				/* curvol */
-	0,				/* muted */
-	CONFIG_RADIO_TYPHOON_MUTEFREQ,	/* curfreq */
-	CONFIG_RADIO_TYPHOON_MUTEFREQ	/* mutefreq */
+	iobase:		CONFIG_RADIO_TYPHOON_PORT,
+	curfreq:	CONFIG_RADIO_TYPHOON_MUTEFREQ,
+	mutefreq:	CONFIG_RADIO_TYPHOON_MUTEFREQ,
 };
 
 static struct video_device typhoon_radio =
 {
-	"Typhoon Radio",
-	VID_TYPE_TUNER,
-	VID_HARDWARE_TYPHOON,
-	typhoon_open,
-	typhoon_close,
-	NULL,			/* Can't read  (no capture ability) */
-	NULL,			/* Can't write */
-	NULL,			/* Can't poll */
-	typhoon_ioctl,
-	NULL,
-	NULL
+	name:		"Typhoon Radio",
+	type:		VID_TYPE_TUNER,
+	hardware:	VID_HARDWARE_TYPHOON,
+	open:		typhoon_open,
+	close:		typhoon_close,
+	ioctl:		typhoon_ioctl,
 };
 
 #ifdef CONFIG_RADIO_TYPHOON_PROC_FS
diff -urN linux-2.4.0t11p6/drivers/media/radio/radio-zoltrix.c linux-v4l1/drivers/media/radio/radio-zoltrix.c
--- linux-2.4.0t11p6/drivers/media/radio/radio-zoltrix.c	Thu Oct 28 19:13:13 1999
+++ linux-v4l1/drivers/media/radio/radio-zoltrix.c	Fri Nov 17 19:32:29 2000
@@ -341,17 +341,12 @@
 
 static struct video_device zoltrix_radio =
 {
-	"Zoltrix Radio Plus",
-	VID_TYPE_TUNER,
-	VID_HARDWARE_ZOLTRIX,
-	zol_open,
-	zol_close,
-	NULL,			/* Can't read  (no capture ability) */
-	NULL,			/* Can't write */
-	NULL,
-	zol_ioctl,
-	NULL,
-	NULL
+	name:		"Zoltrix Radio Plus",
+	type:		VID_TYPE_TUNER,
+	hardware:	VID_HARDWARE_ZOLTRIX,
+	open:		zol_open,
+	close:		zol_close,
+	ioctl:		zol_ioctl,
 };
 
 static int __init zoltrix_init(void)
diff -urN linux-2.4.0t11p6/drivers/media/video/bttv-driver.c linux-v4l1/drivers/media/video/bttv-driver.c
--- linux-2.4.0t11p6/drivers/media/video/bttv-driver.c	Thu Nov 16 22:09:22 2000
+++ linux-v4l1/drivers/media/video/bttv-driver.c	Fri Nov 17 19:32:29 2000
@@ -2016,11 +2016,6 @@
 	return 0;
 }
 
-static int bttv_init_done(struct video_device *dev)
-{
-	return 0;
-}
-
 /*
  *	This maps the vmalloced and reserved fbuffer to user space.
  *
@@ -2067,20 +2062,16 @@
 
 static struct video_device bttv_template=
 {
-	"UNSET",
-	VID_TYPE_TUNER|VID_TYPE_CAPTURE|VID_TYPE_OVERLAY|VID_TYPE_TELETEXT,
-	VID_HARDWARE_BT848,
-	bttv_open,
-	bttv_close,
-	bttv_read,
-	bttv_write,
-	NULL,
-	bttv_ioctl,
-	bttv_mmap,
-	bttv_init_done,
-	NULL,
-	0,
-	-1
+	name:		"UNSET",
+	type:		VID_TYPE_TUNER|VID_TYPE_CAPTURE|VID_TYPE_OVERLAY|VID_TYPE_TELETEXT,
+	hardware:	VID_HARDWARE_BT848,
+	open:		bttv_open,
+	close:		bttv_close,
+	read:		bttv_read,
+	write:		bttv_write,
+	ioctl:		bttv_ioctl,
+	mmap:		bttv_mmap,
+	minor:		-1,
 };
 
 
@@ -2220,20 +2211,16 @@
 
 static struct video_device vbi_template=
 {
-	"bttv vbi",
-	VID_TYPE_CAPTURE|VID_TYPE_TELETEXT,
-	VID_HARDWARE_BT848,
-	vbi_open,
-	vbi_close,
-	vbi_read,
-	bttv_write,
-	vbi_poll,
-	vbi_ioctl,
-	NULL,	/* no mmap yet */
-	bttv_init_done,
-	NULL,
-	0,
-	-1
+	name:		"bttv vbi",
+	type:		VID_TYPE_CAPTURE|VID_TYPE_TELETEXT,
+	hardware:	VID_HARDWARE_BT848,
+	open:		vbi_open,
+	close:		vbi_close,
+	read:		vbi_read,
+	write:		bttv_write,
+	poll:		vbi_poll,
+	ioctl:		vbi_ioctl,
+	minor:		-1,
 };
 
 
@@ -2342,20 +2329,15 @@
 
 static struct video_device radio_template=
 {
-	"bttv radio",
-	VID_TYPE_TUNER,
-	VID_HARDWARE_BT848,
-	radio_open,
-	radio_close,
-	radio_read,          /* just returns -EINVAL */
-	bttv_write,          /* just returns -EINVAL */
-	NULL,                /* no poll */
-	radio_ioctl,
-	NULL,	             /* no mmap */
-	bttv_init_done,      /* just returns 0 */
-	NULL,
-	0,
-	-1
+	name:		"bttv radio",
+	type:		VID_TYPE_TUNER,
+	hardware:	VID_HARDWARE_BT848,
+	open:		radio_open,
+	close:		radio_close,
+	read:		radio_read,          /* just returns -EINVAL */
+	write:		bttv_write,          /* just returns -EINVAL */
+	ioctl:		radio_ioctl,
+	minor:		-1,
 };
 
 
diff -urN linux-2.4.0t11p6/drivers/media/video/buz.c linux-v4l1/drivers/media/video/buz.c
--- linux-2.4.0t11p6/drivers/media/video/buz.c	Tue Sep 19 11:01:34 2000
+++ linux-v4l1/drivers/media/video/buz.c	Fri Nov 17 19:32:29 2000
@@ -3027,28 +3027,18 @@
 	return 0;
 }
 
-static int zoran_init_done(struct video_device *dev)
-{
-	return 0;
-}
-
 static struct video_device zoran_template =
 {
-	BUZ_NAME,
-	VID_TYPE_CAPTURE | VID_TYPE_OVERLAY | VID_TYPE_CLIPPING | VID_TYPE_FRAMERAM |
-	VID_TYPE_SCALES | VID_TYPE_SUBCAPTURE,
-	VID_HARDWARE_ZR36067,
-	zoran_open,
-	zoran_close,
-	zoran_read,
-	zoran_write,
-	NULL,
-	zoran_ioctl,
-	zoran_mmap,
-	zoran_init_done,
-	NULL,
-	0,
-	0
+	name:		BUZ_NAME,
+	type:		VID_TYPE_CAPTURE | VID_TYPE_OVERLAY | VID_TYPE_CLIPPING | VID_TYPE_FRAMERAM |
+			VID_TYPE_SCALES | VID_TYPE_SUBCAPTURE,
+	hardware:	VID_HARDWARE_ZR36067,
+	open:		zoran_open,
+	close:		zoran_close,
+	read:		zoran_read,
+	write:		zoran_write,
+	ioctl:		zoran_ioctl,
+	mmap:		zoran_mmap,
 };
 
 static int zr36057_init(int i)
diff -urN linux-2.4.0t11p6/drivers/media/video/bw-qcam.c linux-v4l1/drivers/media/video/bw-qcam.c
--- linux-2.4.0t11p6/drivers/media/video/bw-qcam.c	Sat Oct  2 10:35:15 1999
+++ linux-v4l1/drivers/media/video/bw-qcam.c	Fri Nov 17 19:39:56 2000
@@ -705,11 +705,6 @@
 	MOD_DEC_USE_COUNT;
 }
 
-static int qcam_init_done(struct video_device *dev)
-{
-	return 0;
-}
-
 static long qcam_write(struct video_device *v, const char *buf, unsigned long count, int noblock)
 {
 	return -EINVAL;
@@ -926,20 +921,14 @@
  
 static struct video_device qcam_template=
 {
-	"Connectix Quickcam",
-	VID_TYPE_CAPTURE,
-	VID_HARDWARE_QCAM_BW,
-	qcam_open,
-	qcam_close,
-	qcam_read,
-	qcam_write,
-	NULL,
-	qcam_ioctl,
-	NULL,
-	qcam_init_done,
-	NULL,
-	0,
-	0
+	name:		"Connectix Quickcam",
+	type:		VID_TYPE_CAPTURE,
+	hardware:	VID_HARDWARE_QCAM_BW,
+	open:		qcam_open,
+	close:		qcam_close,
+	read:		qcam_read,
+	write:		qcam_write,
+	ioctl:		qcam_ioctl,
 };
 
 #define MAX_CAMS 4
diff -urN linux-2.4.0t11p6/drivers/media/video/c-qcam.c linux-v4l1/drivers/media/video/c-qcam.c
--- linux-2.4.0t11p6/drivers/media/video/c-qcam.c	Mon Jun 19 20:59:42 2000
+++ linux-v4l1/drivers/media/video/c-qcam.c	Fri Nov 17 19:32:29 2000
@@ -509,11 +509,6 @@
 	MOD_DEC_USE_COUNT;
 }
 
-static int qcam_init_done(struct video_device *dev)
-{
-	return 0;
-}
-
 static long qcam_write(struct video_device *v, const char *buf, unsigned long count, int noblock)
 {
 	return -EINVAL;
@@ -733,20 +728,14 @@
 /* video device template */
 static struct video_device qcam_template=
 {
-	"Colour QuickCam",
-	VID_TYPE_CAPTURE,
-	VID_HARDWARE_QCAM_C,
-	qcam_open,
-	qcam_close,
-	qcam_read,
-	qcam_write,
-	NULL,
-	qcam_ioctl,
-	NULL,
-	qcam_init_done,
-	NULL,
-	0,
-	0
+	name:		"Colour QuickCam",
+	type:		VID_TYPE_CAPTURE,
+	hardware:	VID_HARDWARE_QCAM_C,
+	open:		qcam_open,
+	close:		qcam_close,
+	read:		qcam_read,
+	write:		qcam_write,
+	ioctl:		qcam_ioctl,
 };
 
 /* Initialize the QuickCam driver control structure. */
diff -urN linux-2.4.0t11p6/drivers/media/video/cpia.c linux-v4l1/drivers/media/video/cpia.c
--- linux-2.4.0t11p6/drivers/media/video/cpia.c	Tue Aug  8 00:01:35 2000
+++ linux-v4l1/drivers/media/video/cpia.c	Fri Nov 17 19:32:29 2000
@@ -3031,20 +3031,16 @@
 }
 
 static struct video_device cpia_template = {
-	"CPiA Camera",
-	VID_TYPE_CAPTURE,
-	VID_HARDWARE_CPIA,      /* FIXME */
-	cpia_open,              /* open */
-	cpia_close,             /* close */
-	cpia_read,              /* read */
-	NULL,                   /* no write */
-	NULL,                   /* no poll */
-	cpia_ioctl,             /* ioctl */
-	cpia_mmap,              /* mmap */
-	cpia_video_init,        /* initialize */
-	NULL,                   /* priv */
-	0,                      /* busy */
-	-1                      /* minor - unset */
+	name:		"CPiA Camera",
+	type:		VID_TYPE_CAPTURE,
+	hardware:	VID_HARDWARE_CPIA,      /* FIXME */
+	open:		cpia_open,
+	close:		cpia_close,
+	read:		cpia_read,
+	ioctl:		cpia_ioctl,
+	mmap:		cpia_mmap,
+	initialize:	cpia_video_init,
+	minor:		-1,
 };
 
 /* initialise cam_data structure  */
diff -urN linux-2.4.0t11p6/drivers/media/video/planb.c linux-v4l1/drivers/media/video/planb.c
--- linux-2.4.0t11p6/drivers/media/video/planb.c	Tue Aug  8 00:01:36 2000
+++ linux-v4l1/drivers/media/video/planb.c	Fri Nov 17 19:32:30 2000
@@ -2035,31 +2035,17 @@
 	return 0;
 }
 
-/* This gets called upon device registration */
-/* we could do some init here */
-static int planb_init_done(struct video_device *dev)
-{
-	return 0;
-}
-
 static struct video_device planb_template=
 {
-	PLANB_DEVICE_NAME,
-	VID_TYPE_OVERLAY,
-	VID_HARDWARE_PLANB,
-	planb_open,
-	planb_close,
-	planb_read,
-	planb_write,
-#if LINUX_VERSION_CODE >= 0x020100
-	NULL,	/* poll */
-#endif
-	planb_ioctl,
-	planb_mmap,	/* mmap? */
-	planb_init_done,
-	NULL,	/* pointer to private data */
-	0,
-	0
+	name:		PLANB_DEVICE_NAME,
+	type:		VID_TYPE_OVERLAY,
+	hardware:	VID_HARDWARE_PLANB,
+	open:		planb_open,
+	close:		planb_close,
+	read:		planb_read,
+	write:		planb_write,
+	ioctl:		planb_ioctl,
+	mmap:		planb_mmap,	/* mmap? */
 };
 
 static int init_planb(struct planb *pb)
diff -urN linux-2.4.0t11p6/drivers/media/video/pms.c linux-v4l1/drivers/media/video/pms.c
--- linux-2.4.0t11p6/drivers/media/video/pms.c	Wed Nov 10 16:39:06 1999
+++ linux-v4l1/drivers/media/video/pms.c	Fri Nov 17 19:32:30 2000
@@ -681,11 +681,6 @@
 	MOD_DEC_USE_COUNT;
 }
 
-static int pms_init_done(struct video_device *dev)
-{
-	return 0;
-}
-
 static long pms_write(struct video_device *v, const char *buf, unsigned long count, int noblock)
 {
 	return -EINVAL;
@@ -907,20 +902,14 @@
  
 struct video_device pms_template=
 {
-	"Mediavision PMS",
-	VID_TYPE_CAPTURE,
-	VID_HARDWARE_PMS,
-	pms_open,
-	pms_close,
-	pms_read,
-	pms_write,
-	NULL,		/* FIXME - we can use POLL on this board with the irq */
-	pms_ioctl,
-	NULL,
-	pms_init_done,
-	NULL,
-	0,
-	0
+	name:		"Mediavision PMS",
+	type:		VID_TYPE_CAPTURE,
+	hardware:	VID_HARDWARE_PMS,
+	open:		pms_open,
+	close:		pms_close,
+	read:		pms_read,
+	write:		pms_write,
+	ioctl:		pms_ioctl,
 };
 
 struct pms_device pms_device;
diff -urN linux-2.4.0t11p6/drivers/media/video/saa5249.c linux-v4l1/drivers/media/video/saa5249.c
--- linux-2.4.0t11p6/drivers/media/video/saa5249.c	Wed Feb  9 21:48:03 2000
+++ linux-v4l1/drivers/media/video/saa5249.c	Fri Nov 17 19:32:30 2000
@@ -669,15 +669,12 @@
 
 static struct video_device saa_template =
 {
-	IF_NAME,
-	VID_TYPE_TELETEXT,	/*| VID_TYPE_TUNER ?? */
-	VID_HARDWARE_SAA5249,
-	saa5249_open,
-	saa5249_release,
-	NULL,			/* read */
-	saa5249_write,
-	NULL,			/* poll */
-	saa5249_ioctl,
-	/* the rest are null */
+	name:		IF_NAME,
+	type:		VID_TYPE_TELETEXT,	/*| VID_TYPE_TUNER ?? */
+	hardware:	VID_HARDWARE_SAA5249,
+	open:		saa5249_open,
+	close:		saa5249_release,
+	write:		saa5249_write,
+	ioctl:		saa5249_ioctl,
 };
 
diff -urN linux-2.4.0t11p6/drivers/media/video/stradis.c linux-v4l1/drivers/media/video/stradis.c
--- linux-2.4.0t11p6/drivers/media/video/stradis.c	Wed Jul  5 13:56:13 2000
+++ linux-v4l1/drivers/media/video/stradis.c	Fri Nov 17 19:32:30 2000
@@ -1827,11 +1827,6 @@
 	return 0;
 }
 
-static int saa_init_done(struct video_device *dev)
-{
-	return 0;
-}
-
 static int saa_mmap(struct video_device *dev, const char *adr,
 		    unsigned long size)
 {
@@ -1993,20 +1988,15 @@
 /* template for video_device-structure */
 static struct video_device saa_template =
 {
-	"SAA7146A",
-	VID_TYPE_CAPTURE | VID_TYPE_OVERLAY,
-	VID_HARDWARE_SAA7146,
-	saa_open,
-	saa_close,
-	saa_read,
-	saa_write,
-	NULL,			/* poll */
-	saa_ioctl,
-	saa_mmap,
-	saa_init_done,
-	NULL,
-	0,
-	0
+	name:		"SAA7146A",
+	type:		VID_TYPE_CAPTURE | VID_TYPE_OVERLAY,
+	hardware:	VID_HARDWARE_SAA7146,
+	open:		saa_open,
+	close:		saa_close,
+	read:		saa_read,
+	write:		saa_write,
+	ioctl:		saa_ioctl,
+	mmap:		saa_mmap,
 };
 
 static int configure_saa7146(struct pci_dev *dev, int num)
diff -urN linux-2.4.0t11p6/drivers/media/video/vino.c linux-v4l1/drivers/media/video/vino.c
--- linux-2.4.0t11p6/drivers/media/video/vino.c	Fri Feb 25 13:26:42 2000
+++ linux-v4l1/drivers/media/video/vino.c	Fri Nov 17 19:32:30 2000
@@ -224,20 +224,13 @@
 }
 
 static struct video_device vino_dev = {
-	"Vino IndyCam/TV",
-	VID_TYPE_CAPTURE,
-	VID_HARDWARE_VINO,
-	vino_open,
-	vino_close,
-	NULL,		/* vino_read */
-	NULL,		/* vino_write */
-	NULL,		/* vino_poll */
-	vino_ioctl,
-	vino_mmap,
-	NULL,		/* vino_init */
-	NULL,
-	0,
-	0
+	name:		"Vino IndyCam/TV",
+	type:		VID_TYPE_CAPTURE,
+	hardware:	VID_HARDWARE_VINO,
+	open:		vino_open,
+	close:		vino_close,
+	ioctl:		vino_ioctl,
+	mmap:		vino_mmap,
 };
 
 int __init init_vino(struct video_device *dev)
diff -urN linux-2.4.0t11p6/drivers/media/video/zr36120.c linux-v4l1/drivers/media/video/zr36120.c
--- linux-2.4.0t11p6/drivers/media/video/zr36120.c	Tue Aug 29 17:09:15 2000
+++ linux-v4l1/drivers/media/video/zr36120.c	Fri Nov 17 19:32:30 2000
@@ -1482,23 +1482,17 @@
 
 static struct video_device zr36120_template=
 {
-	"UNSET",
-	VID_TYPE_TUNER|VID_TYPE_CAPTURE|VID_TYPE_OVERLAY,
-	VID_HARDWARE_ZR36120,
-
-	zoran_open,
-	zoran_close,
-	zoran_read,
-	zoran_write,
-#if LINUX_VERSION_CODE >= 0x020100
-	zoran_poll,		/* poll */
-#endif
-	zoran_ioctl,
-	zoran_mmap,
-	NULL,			/* initialize */
-	NULL,
-	0,
-	-1
+	name:		"UNSET",
+	type:		VID_TYPE_TUNER|VID_TYPE_CAPTURE|VID_TYPE_OVERLAY,
+	hardware:	VID_HARDWARE_ZR36120,
+	open:		zoran_open,
+	close:		zoran_close,
+	read:		zoran_read,
+	write:		zoran_write,
+	poll:		zoran_poll,
+	ioctl:		zoran_ioctl,
+	mmap:		zoran_mmap,
+	minor:		-1,
 };
 
 static
@@ -1825,23 +1819,16 @@
 
 static struct video_device vbi_template=
 {
-	"UNSET",
-	VID_TYPE_CAPTURE|VID_TYPE_TELETEXT,
-	VID_HARDWARE_ZR36120,
-
-	vbi_open,
-	vbi_close,
-	vbi_read,
-	zoran_write,
-#if LINUX_VERSION_CODE >= 0x020100
-	vbi_poll,		/* poll */
-#endif
-	vbi_ioctl,
-	NULL,			/* no mmap */
-	NULL,			/* no initialize */
-	NULL,			/* priv */
-	0,			/* busy */
-	-1			/* minor */
+	name:		"UNSET",
+	type:		VID_TYPE_CAPTURE|VID_TYPE_TELETEXT,
+	hardware:	VID_HARDWARE_ZR36120,
+	open:		vbi_open,
+	close:		vbi_close,
+	read:		vbi_read,
+	write:		zoran_write,
+	poll:		vbi_poll,
+	ioctl:		vbi_ioctl,
+	minor:		-1,
 };
 
 /*
diff -urN linux-2.4.0t11p6/drivers/usb/dsbr100.c linux-v4l1/drivers/usb/dsbr100.c
--- linux-2.4.0t11p6/drivers/usb/dsbr100.c	Thu Nov 16 22:09:27 2000
+++ linux-v4l1/drivers/usb/dsbr100.c	Fri Nov 17 19:32:30 2000
@@ -91,17 +91,12 @@
 
 static struct video_device usb_dsbr100_radio=
 {
-	"D-Link DSB R-100 USB radio",
-	VID_TYPE_TUNER,
-	VID_HARDWARE_AZTECH,
-	usb_dsbr100_open,
-	usb_dsbr100_close,
-	NULL,	/* Can't read  (no capture ability) */
-	NULL,	/* Can't write */
-	NULL,	/* No poll */
-	usb_dsbr100_ioctl,
-	NULL,
-	NULL
+	name:		"D-Link DSB R-100 USB radio",
+	type:		VID_TYPE_TUNER,
+	hardware:	VID_HARDWARE_AZTECH,
+	open:		usb_dsbr100_open,
+	close:		usb_dsbr100_close,
+	ioctl:		usb_dsbr100_ioctl,
 };
 
 static int users = 0;
diff -urN linux-2.4.0t11p6/drivers/usb/ibmcam.c linux-v4l1/drivers/usb/ibmcam.c
--- linux-2.4.0t11p6/drivers/usb/ibmcam.c	Thu Nov 16 22:09:27 2000
+++ linux-v4l1/drivers/usb/ibmcam.c	Fri Nov 17 19:32:30 2000
@@ -2492,11 +2492,6 @@
 	MOD_DEC_USE_COUNT;
 }
 
-static int ibmcam_init_done(struct video_device *dev)
-{
-	return 0;
-}
-
 static long ibmcam_write(struct video_device *dev, const char *buf, unsigned long count, int noblock)
 {
 	return -EINVAL;
@@ -2855,20 +2850,15 @@
 }
 
 static struct video_device ibmcam_template = {
-	"CPiA USB Camera",
-	VID_TYPE_CAPTURE,
-	VID_HARDWARE_CPIA,
-	ibmcam_open,
-	ibmcam_close,
-	ibmcam_read,
-	ibmcam_write,
-	NULL,
-	ibmcam_ioctl,
-	ibmcam_mmap,
-	ibmcam_init_done,
-	NULL,
-	0,
-	0
+	name:		"CPiA USB Camera",
+	type:		VID_TYPE_CAPTURE,
+	hardware:	VID_HARDWARE_CPIA,
+	open:		ibmcam_open,
+	close:		ibmcam_close,
+	read:		ibmcam_read,
+	write:		ibmcam_write,
+	ioctl:		ibmcam_ioctl,
+	mmap:		ibmcam_mmap,
 };
 
 static void usb_ibmcam_configure_video(struct usb_ibmcam *ibmcam)

--------------57B81B0109FAA46154A51C5F--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

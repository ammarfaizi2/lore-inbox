Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262808AbVG3FiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbVG3FiV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 01:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbVG3FiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 01:38:18 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:61347 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S262808AbVG3Fhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 01:37:47 -0400
Message-ID: <42EB122E.1090608@brturbo.com.br>
Date: Sat, 30 Jul 2005 02:37:50 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.6-1mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [PATCH for 2.6.13-rc4] V4L Miscelaneous fix
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------090507030702040304010800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090507030702040304010800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------090507030702040304010800
Content-Type: text/x-patch;
 name="v4l_misc_bug_fixes_linus.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_misc_bug_fixes_linus.diff"

- Fixed some bttv card numbers.
- BTTV and SAA7134 version numbers incremented to reflect changes.

- pci_dma_supported() is called after pci_set_dma_mask() which
  already did check that for us. This patch removes the unneeded call to
  pci_dma_supported() at bttv-driver.c

- Ensure a sufficient I2C bus idle time between 2 messages for 
saa7134-i2c.c

- It is important to write at first to MO_GP3_IO for cx88-tvaudio.c

- Use try_to_freeze() instead of refrigerator at msp3400.c

- Recognizing the MFPE05-2 Tuner at tveeprom.c

- Add new parameter to help identify radio chipsets at tuner module:
  show_i2c=1 will show 16 reading bytes from detected tuners.

- BTTV does generate some Unimplemented IOCTL log at tuner module:
  0x40046d11(dir=1,tp=0x6d,nr=17,sz=4) means that it is sending
  MSP3400 calls to non-msp3400 tuners. Warning eliminated.
  VIDIOSAUDIO is also called, so debug messages updated. It is still
  requiring IOCTL implementation.

- Added two more tuners.

- Add support for the SVideo input on the GDI Black Gold.

Signed-off-by: Peter Missel <peter.missel@onlinehome.de>
Signed-off-by: Graham Bevan <graham.bevan@ntlworld.com>
Signed-off-by: Torsten Seeboth <Torsten.Seeboth@t-online.de>
Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t.online.de>
Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/Documentation/video4linux/CARDLIST.tuner  |    2 +
 linux/drivers/media/video/bttv-driver.c         |    7 ---
 linux/drivers/media/video/bttv.h                |    6 ++-
 linux/drivers/media/video/bttvp.h               |    6 +--
 linux/drivers/media/video/cx88/cx88-cards.c     |    5 ++
 linux/drivers/media/video/cx88/cx88-video.c     |    4 +-
 linux/drivers/media/video/msp3400.c             |    4 --
 linux/drivers/media/video/saa7134/saa7134-i2c.c |    4 +-
 linux/drivers/media/video/saa7134/saa7134.h     |    6 +--
 linux/drivers/media/video/tea5767.c             |   15 ++++----
 linux/drivers/media/video/tuner-core.c          |   29 +++++++++++++++-
 linux/drivers/media/video/tuner-simple.c        |    8 +++-
 linux/drivers/media/video/tveeprom.c            |    2 -
 linux/include/media/tuner.h                     |    4 +-
 14 files changed, 70 insertions(+), 32 deletions(-)

diff -u linux-2.6.13/drivers/media/video/bttv.h linux/drivers/media/video/bttv.h
--- linux-2.6.13/drivers/media/video/bttv.h	2005-07-28 19:44:44.000000000 -0300
+++ linux/drivers/media/video/bttv.h	2005-07-30 01:16:36.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: bttv.h,v 1.18 2005/05/24 23:41:42 nsh Exp $
+ * $Id: bttv.h,v 1.22 2005/07/28 18:41:21 mchehab Exp $
  *
  *  bttv - Bt848 frame grabber driver
  *
@@ -135,7 +135,9 @@
 #define BTTV_DVICO_DVBT_LITE  0x80
 #define BTTV_TIBET_CS16  0x83
 #define BTTV_KODICOM_4400R  0x84
-#define BTTV_ADLINK_RTV24   0x85
+#define BTTV_ADLINK_RTV24   0x86
+#define BTTV_DVICO_FUSIONHDTV_5_LITE 0x87
+#define BTTV_ACORP_Y878F   0x88
 
 /* i2c address list */
 #define I2C_TSA5522        0xc2
diff -u linux-2.6.13/drivers/media/video/bttvp.h linux/drivers/media/video/bttvp.h
--- linux-2.6.13/drivers/media/video/bttvp.h	2005-07-28 19:44:44.000000000 -0300
+++ linux/drivers/media/video/bttvp.h	2005-07-30 01:16:36.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: bttvp.h,v 1.19 2005/06/16 21:38:45 nsh Exp $
+    $Id: bttvp.h,v 1.21 2005/07/15 21:44:14 mchehab Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -26,8 +26,8 @@
 #ifndef _BTTVP_H_
 #define _BTTVP_H_
 
-#include <linux/version.h>
-#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,15)
+#include <linux/utsname.h>
+#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,16)
 
 #include <linux/types.h>
 #include <linux/wait.h>
diff -u linux-2.6.13/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux-2.6.13/drivers/media/video/bttv-driver.c	2005-07-28 19:44:44.000000000 -0300
+++ linux/drivers/media/video/bttv-driver.c	2005-07-30 01:16:36.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-driver.c,v 1.42 2005/07/05 17:37:35 nsh Exp $
+    $Id: bttv-driver.c,v 1.45 2005/07/20 19:43:24 mkrufky Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -3869,11 +3869,6 @@
         pci_set_master(dev);
 	pci_set_command(dev);
 	pci_set_drvdata(dev,btv);
-	if (!pci_dma_supported(dev,0xffffffff)) {
-		printk("bttv%d: Oops: no 32bit PCI DMA ???\n", btv->c.nr);
-		result = -EIO;
-		goto fail1;
-	}
 
         pci_read_config_byte(dev, PCI_CLASS_REVISION, &btv->revision);
         pci_read_config_byte(dev, PCI_LATENCY_TIMER, &lat);

diff -u linux-2.6.13/drivers/media/video/cx88/cx88-cards.c linux/drivers/media/video/cx88/cx88-cards.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-cards.c	2005-07-28 19:44:44.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-cards.c	2005-07-30 01:16:37.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-cards.c,v 1.86 2005/07/14 03:06:43 mchehab Exp $
+ * $Id: cx88-cards.c,v 1.90 2005/07/28 02:47:42 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * card-specific stuff.
@@ -90,6 +90,9 @@
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
+		},{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 2,
 		}},
 	},
 	[CX88_BOARD_PIXELVIEW] = {
 
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-video.c linux/drivers/media/video/cx88/cx88-video.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-video.c	2005-07-28 19:44:44.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-video.c	2005-07-30 01:16:37.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-video.c,v 1.80 2005/07/13 08:49:08 mchehab Exp $
+ * $Id: cx88-video.c,v 1.82 2005/07/22 05:13:34 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * video4linux video interface
@@ -758,10 +758,10 @@
 		struct cx88_core *core = dev->core;
 		int board = core->board;
 		dprintk(1,"video_open: setting radio device\n");
+		cx_write(MO_GP3_IO, cx88_boards[board].radio.gpio3);
 		cx_write(MO_GP0_IO, cx88_boards[board].radio.gpio0);
 		cx_write(MO_GP1_IO, cx88_boards[board].radio.gpio1);
 		cx_write(MO_GP2_IO, cx88_boards[board].radio.gpio2);
-		cx_write(MO_GP3_IO, cx88_boards[board].radio.gpio3);
 		dev->core->tvaudio = WW_FM;
 		cx88_set_tvaudio(core);
 		cx88_set_stereo(core,V4L2_TUNER_MODE_STEREO,1);

diff -u linux-2.6.13/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- linux-2.6.13/drivers/media/video/msp3400.c	2005-07-28 19:44:44.000000000 -0300
+++ linux/drivers/media/video/msp3400.c	2005-07-30 01:16:38.000000000 -0300
@@ -741,11 +741,9 @@
 			schedule_timeout(msecs_to_jiffies(timeout));
 		}
 	}
-	if (current->flags & PF_FREEZE) {
-		refrigerator ();
-	}
 
 	remove_wait_queue(&msp->wq, &wait);
+	try_to_freeze();
 	return msp->restart;
 }
 
diff -u linux-2.6.13/include/media/tuner.h linux/include/media/tuner.h
--- linux-2.6.13/include/media/tuner.h	2005-07-28 19:44:44.000000000 -0300
+++ linux/include/media/tuner.h	2005-07-30 01:16:38.000000000 -0300
@@ -1,5 +1,5 @@
 
-/* $Id: tuner.h,v 1.42 2005/07/06 09:42:19 mchehab Exp $
+/* $Id: tuner.h,v 1.45 2005/07/28 18:41:21 mchehab Exp $
  *
     tuner.h - definition for different tuners
 
@@ -108,6 +108,8 @@
 
 #define TUNER_TEA5767         62	/* Only FM Radio Tuner */
 #define TUNER_PHILIPS_FMD1216ME_MK3 63
+#define TUNER_LG_TDVS_H062F   64	/* DViCO FusionHDTV 5 */
+#define TUNER_YMEC_TVF66T5_B_DFF 65	/* Acorp Y878F */
 
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */
diff -u linux-2.6.13/drivers/media/video/tuner-core.c linux/drivers/media/video/tuner-core.c
--- linux-2.6.13/drivers/media/video/tuner-core.c	2005-07-28 19:44:44.000000000 -0300
+++ linux/drivers/media/video/tuner-core.c	2005-07-30 01:16:38.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner-core.c,v 1.58 2005/07/14 03:06:43 mchehab Exp $
+ * $Id: tuner-core.c,v 1.63 2005/07/28 18:19:55 mchehab Exp $
  *
  * i2c tv tuner chip device driver
  * core core, i.e. kernel interfaces, registering and so on
@@ -23,6 +23,8 @@
 #include <media/tuner.h>
 #include <media/audiochip.h>
 
+#include "msp3400.h"
+
 #define UNSET (-1U)
 
 /* standard i2c insmod options */
@@ -42,6 +44,9 @@
 static unsigned int no_autodetect = 0;
 module_param(no_autodetect, int, 0444);
 
+static unsigned int show_i2c = 0;
+module_param(show_i2c, int, 0444);
+
 /* insmod options used at runtime => read/write */
 unsigned int tuner_debug = 0;
 module_param(tuner_debug, int, 0644);
@@ -320,6 +325,17 @@
 
 	tuner_info("chip found @ 0x%x (%s)\n", addr << 1, adap->name);
 
+	if (show_i2c) {
+		unsigned char buffer[16];
+		int i,rc;
+
+		memset(buffer, 0, sizeof(buffer));
+		rc = i2c_master_recv(&t->i2c, buffer, sizeof(buffer));
+		printk("tuner-%04x I2C RECV = ",addr);
+		for (i=0;i<rc;i++)
+			printk("%02x ",buffer[i]);
+		printk("\n");
+	}
 	/* TEA5767 autodetection code - only for addr = 0xc0 */
 	if (!no_autodetect) {
 		if (addr == 0x60) {
@@ -451,6 +467,17 @@
 			break;
 		}
 		break;
+	case VIDIOCSAUDIO:
+		if (check_mode(t, "VIDIOCSAUDIO") == EINVAL)
+			return 0;
+		if (check_v4l2(t) == EINVAL)
+			return 0;
+
+		/* Should be implemented, since bttv calls it */
+		tuner_dbg("VIDIOCSAUDIO not implemented.\n");
+
+		break;
+	case MSP_SET_MATRIX:
 	case TDA9887_SET_CONFIG:
 		break;
 	/* --- v4l ioctls --- */
diff -u linux-2.6.13/drivers/media/video/tuner-simple.c linux/drivers/media/video/tuner-simple.c
--- linux-2.6.13/drivers/media/video/tuner-simple.c	2005-07-28 19:44:44.000000000 -0300
+++ linux/drivers/media/video/tuner-simple.c	2005-07-30 01:16:38.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner-simple.c,v 1.39 2005/07/07 01:49:30 mkrufky Exp $
+ * $Id: tuner-simple.c,v 1.43 2005/07/28 18:41:21 mchehab Exp $
  *
  * i2c tv tuner chip device driver
  * controls all those simple 4-control-bytes style tuners.
@@ -245,6 +245,12 @@
           /* see tea5767.c for details */},
 	{ "Philips FMD1216ME MK3 Hybrid Tuner", Philips, PAL,
 	  16*160.00,16*442.00,0x51,0x52,0x54,0x86,623 },
+
+	{ "LG TDVS-H062F/TUA6034", LGINNOTEK, NTSC,
+	  16*160.00,16*455.00,0x01,0x02,0x04,0x8e,732},
+
+	{ "Ymec TVF66T5-B/DFF", Philips, PAL,
+          16*160.25,16*464.25,0x01,0x02,0x08,0x8e,623},
 };
 
 unsigned const int tuner_count = ARRAY_SIZE(tuners);

diff -u linux-2.6.13/drivers/media/video/tea5767.c linux/drivers/media/video/tea5767.c
--- linux-2.6.13/drivers/media/video/tea5767.c	2005-07-28 19:44:44.000000000 -0300
+++ linux/drivers/media/video/tea5767.c	2005-07-30 01:16:38.000000000 -0300
@@ -2,7 +2,7 @@
  * For Philips TEA5767 FM Chip used on some TV Cards like Prolink Pixelview
  * I2C address is allways 0xC0.
  *
- * $Id: tea5767.c,v 1.21 2005/07/14 03:06:43 mchehab Exp $
+ * $Id: tea5767.c,v 1.26 2005/07/27 12:00:36 mkrufky Exp $
  *
  * Copyright (c) 2005 Mauro Carvalho Chehab (mchehab@brturbo.com.br)
  * This code is placed under the terms of the GNU General Public License
@@ -15,7 +15,6 @@
 #include <linux/videodev.h>
 #include <linux/delay.h>
 #include <media/tuner.h>
-#include <media/tuner.h>
 
 #define PREFIX "TEA5767 "
 
@@ -293,7 +292,7 @@
 
 int tea5767_autodetection(struct i2c_client *c)
 {
-	unsigned char buffer[5] = { 0xff, 0xff, 0xff, 0xff, 0xff };
+	unsigned char buffer[7] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 	int rc;
 	struct tuner *t = i2c_get_clientdata(c);
 
@@ -302,7 +301,7 @@
 		return EINVAL;
 	}
 
-	/* If all bytes are the same then it's a TV tuner and not a tea5767 chip. */
+	/* If all bytes are the same then it's a TV tuner and not a tea5767 */
 	if (buffer[0] == buffer[1] && buffer[0] == buffer[2] &&
 	    buffer[0] == buffer[3] && buffer[0] == buffer[4]) {
 		tuner_warn("All bytes are equal. It is not a TEA5767\n");
@@ -318,6 +317,11 @@
 		tuner_warn("Chip ID is not zero. It is not a TEA5767\n");
 		return EINVAL;
 	}
+	/* It seems that tea5767 returns 0xff after the 5th byte */
+	if ((buffer[5] != 0xff) || (buffer[6] != 0xff)) {
+		tuner_warn("Returned more than 5 bytes. It is not a TEA5767\n");
+		return EINVAL;
+	}
 
 	tuner_warn("TEA5767 detected.\n");
 	return 0;
@@ -327,9 +331,6 @@
 {
 	struct tuner *t = i2c_get_clientdata(c);
 
-	if (tea5767_autodetection(c) == EINVAL)
-		return EINVAL;
-
 	tuner_info("type set to %d (%s)\n", t->type, "Philips TEA5767HN FM Radio");
 	strlcpy(c->name, "tea5767", sizeof(c->name));
 
diff -u linux-2.6.13/drivers/media/video/saa7134/saa7134.h linux/drivers/media/video/saa7134/saa7134.h
--- linux-2.6.13/drivers/media/video/saa7134/saa7134.h	2005-07-28 19:44:44.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134.h	2005-07-30 01:16:38.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134.h,v 1.48 2005/07/01 08:22:24 nsh Exp $
+ * $Id: saa7134.h,v 1.49 2005/07/13 17:25:25 mchehab Exp $
  *
  * v4l2 device driver for philips saa7134 based TV cards
  *
@@ -20,8 +20,8 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/version.h>
-#define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,13)
+#include <linux/utsname.h>
+#define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,14)
 
 #include <linux/pci.h>
 #include <linux/i2c.h>

diff -u linux-2.6.13/drivers/media/video/saa7134/saa7134-i2c.c linux/drivers/media/video/saa7134/saa7134-i2c.c
--- linux-2.6.13/drivers/media/video/saa7134/saa7134-i2c.c	2005-07-28 19:44:44.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-i2c.c	2005-07-30 01:16:38.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-i2c.c,v 1.19 2005/07/07 01:49:30 mkrufky Exp $
+ * $Id: saa7134-i2c.c,v 1.22 2005/07/22 04:09:41 mkrufky Exp $
  *
  * device driver for philips saa7134 based TV cards
  * i2c interface support
@@ -300,6 +300,8 @@
   	status = i2c_get_status(dev);
 	if (i2c_is_error(status))
 		goto err;
+	/* ensure that the bus is idle for at least one bit slot */
+	msleep(1);
 
 	d1printk("\n");
 	return num;
diff -u linux-2.6.13/drivers/media/video/tveeprom.c linux/drivers/media/video/tveeprom.c
--- linux-2.6.13/drivers/media/video/tveeprom.c	2005-07-28 19:44:44.000000000 -0300
+++ linux/drivers/media/video/tveeprom.c	2005-07-30 01:16:39.000000000 -0300
@@ -189,7 +189,7 @@
 	{ TUNER_ABSENT,        "Philips FQ1236 MK3"},
 	{ TUNER_ABSENT,        "Samsung TCPN 2121P30A"},
 	{ TUNER_ABSENT,        "Samsung TCPE 4121P30A"},
-	{ TUNER_ABSENT,        "TCL MFPE05 2"},
+	{ TUNER_PHILIPS_FM1216ME_MK3, "TCL MFPE05 2"},
 	/* 90-99 */
 	{ TUNER_ABSENT,        "LG TALN H202T"},
 	{ TUNER_PHILIPS_FQ1216AME_MK4, "Philips FQ1216AME MK4"},
diff -u linux-2.6.13/Documentation/video4linux/CARDLIST.tuner linux/Documentation/video4linux/CARDLIST.tuner
--- linux-2.6.13/Documentation/video4linux/CARDLIST.tuner	2005-07-28 19:44:44.000000000 -0300
+++ linux/Documentation/video4linux/CARDLIST.tuner	2005-07-30 01:16:39.000000000 -0300
@@ -62,3 +62,5 @@
 tuner=61 - Tena TNF9533-D/IF/TNF9533-B/DF
 tuner=62 - Philips TEA5767HN FM Radio
 tuner=63 - Philips FMD1216ME MK3 Hybrid Tuner
+tuner=64 - LG TDVS-H062F/TUA6034
+tuner=65 - Ymec TVF66T5-B/DFF

--------------090507030702040304010800--

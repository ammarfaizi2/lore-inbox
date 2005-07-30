Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVG3FJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVG3FJv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 01:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVG3FJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 01:09:51 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:10566 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261557AbVG3FJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 01:09:50 -0400
Message-ID: <42EB0B9E.4080901@m1k.net>
Date: Sat, 30 Jul 2005 01:09:50 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Peter Missel <peter.missel@onlinehome.de>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [2.6.13 PATCH] v4l: cx88 card support and documentation finishing
 touches
Content-Type: multipart/mixed;
 boundary="------------010007050501040708070407"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010007050501040708070407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------010007050501040708070407
Content-Type: text/plain;
 name="v4l-2.6.13-finishing-touches.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l-2.6.13-finishing-touches.patch"

Peter Missel:
- Add support for the SVideo input on the GDI Black Gold.

Mauro Carvalho Chehab:
- Linux/version.h removed. Replaced by linux/utsname.h

Michael Krufky:
- Added analog support for DViCO FusionHDTV5 Gold.

CC: Peter Missel <peter.missel@onlinehome.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/Documentation/video4linux/CARDLIST.cx88  |    1 
 linux/Documentation/video4linux/CARDLIST.tuner |    1 
 linux/drivers/media/video/cx88/cx88-cards.c    |   30 ++++++++++++++++-
 linux/drivers/media/video/cx88/cx88.h          |    3 +
 linux/drivers/media/video/saa7134/saa7134.h    |    2 -
 linux/drivers/media/video/tuner-simple.c       |    5 ++
 linux/include/media/tuner.h                    |    3 +
 7 files changed, 40 insertions(+), 5 deletions(-)

diff -u linux-2.6.13/drivers/media/video/cx88/cx88.h linux/drivers/media/video/cx88/cx88.h
--- linux-2.6.13/drivers/media/video/cx88/cx88.h	2005-07-28 22:49:12.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88.h	2005-07-30 01:04:57.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88.h,v 1.69 2005/07/13 17:25:25 mchehab Exp $
+ * $Id: cx88.h,v 1.70 2005/07/24 17:44:09 mkrufky Exp $
  *
  * v4l2 device driver for cx2388x based TV cards
  *
@@ -171,6 +171,7 @@
 #define CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T  28
 #define CX88_BOARD_ADSTECH_DVB_T_PCI          29
 #define CX88_BOARD_TERRATEC_CINERGY_1400_DVB_T1  30
+#define CX88_BOARD_DVICO_FUSIONHDTV_5_GOLD 31
 
 enum cx88_itype {
 	CX88_VMUX_COMPOSITE1 = 1,
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-cards.c linux/drivers/media/video/cx88/cx88-cards.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-cards.c	2005-07-28 22:49:12.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-cards.c	2005-07-30 01:04:57.000000000 +0000
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
@@ -753,6 +756,27 @@
 		}},
 		.dvb            = 1,
 	},
+	[CX88_BOARD_DVICO_FUSIONHDTV_5_GOLD] = {
+		.name           = "DViCO FusionHDTV 5 Gold",
+		.tuner_type     = TUNER_LG_TDVS_H062F,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
+		/*  See DViCO FusionHDTV 3 Gold-Q for GPIO documentation.  */
+		.input          = {{
+                        .type   = CX88_VMUX_TELEVISION,
+                        .vmux   = 0,
+                        .gpio0  = 0x0f0d,
+                },{
+                        .type   = CX88_VMUX_COMPOSITE1,
+                        .vmux   = 1,
+                        .gpio0  = 0x0f00,
+                },{
+                        .type   = CX88_VMUX_SVIDEO,
+                        .vmux   = 2,
+                        .gpio0  = 0x0f00,
+                }},
+	},
 };
 const unsigned int cx88_bcount = ARRAY_SIZE(cx88_boards);
 
@@ -880,6 +904,10 @@
 		.subvendor = 0x153b,
 		.subdevice = 0x1166,
 		.card      = CX88_BOARD_TERRATEC_CINERGY_1400_DVB_T1,
+ 	},{
+		.subvendor = 0x18ac,
+		.subdevice = 0xd500,
+		.card      = CX88_BOARD_DVICO_FUSIONHDTV_5_GOLD,
 	},
 };
 const unsigned int cx88_idcount = ARRAY_SIZE(cx88_subids);
diff -u linux-2.6.13/include/media/tuner.h linux/include/media/tuner.h
--- linux-2.6.13/include/media/tuner.h	2005-07-28 22:49:14.000000000 +0000
+++ linux/include/media/tuner.h	2005-07-30 01:04:57.000000000 +0000
@@ -1,5 +1,5 @@
 
-/* $Id: tuner.h,v 1.42 2005/07/06 09:42:19 mchehab Exp $
+/* $Id: tuner.h,v 1.44 2005/07/28 02:47:42 mkrufky Exp $
  *
     tuner.h - definition for different tuners
 
@@ -108,6 +108,7 @@
 
 #define TUNER_TEA5767         62	/* Only FM Radio Tuner */
 #define TUNER_PHILIPS_FMD1216ME_MK3 63
+#define TUNER_LG_TDVS_H062F   64	/* DViCO FusionHDTV 5 */
 
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */
diff -u linux-2.6.13/drivers/media/video/tuner-simple.c linux/drivers/media/video/tuner-simple.c
--- linux-2.6.13/drivers/media/video/tuner-simple.c	2005-07-28 22:49:12.000000000 +0000
+++ linux/drivers/media/video/tuner-simple.c	2005-07-30 01:04:57.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner-simple.c,v 1.39 2005/07/07 01:49:30 mkrufky Exp $
+ * $Id: tuner-simple.c,v 1.42 2005/07/27 12:00:36 mkrufky Exp $
  *
  * i2c tv tuner chip device driver
  * controls all those simple 4-control-bytes style tuners.
@@ -245,6 +245,9 @@
           /* see tea5767.c for details */},
 	{ "Philips FMD1216ME MK3 Hybrid Tuner", Philips, PAL,
 	  16*160.00,16*442.00,0x51,0x52,0x54,0x86,623 },
+
+	{ "LG TDVS-H062F/TUA6034", LGINNOTEK, NTSC,
+	  16*160.00,16*455.00,0x01,0x02,0x04,0x8e,732},
 };
 
 unsigned const int tuner_count = ARRAY_SIZE(tuners);
diff -u linux-2.6.13/drivers/media/video/saa7134/saa7134.h linux/drivers/media/video/saa7134/saa7134.h
--- linux-2.6.13/drivers/media/video/saa7134/saa7134.h	2005-07-30 00:28:57.000000000 +0000
+++ linux/drivers/media/video/saa7134/saa7134.h	2005-07-30 01:04:57.000000000 +0000
@@ -20,7 +20,7 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/version.h>
+#include <linux/utsname.h>
 #define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,14)
 
 #include <linux/pci.h>
diff -u linux-2.6.13/Documentation/video4linux/CARDLIST.tuner linux/Documentation/video4linux/CARDLIST.tuner
--- linux-2.6.13/Documentation/video4linux/CARDLIST.tuner	2005-07-28 22:49:10.000000000 +0000
+++ linux/Documentation/video4linux/CARDLIST.tuner	2005-07-30 01:04:57.000000000 +0000
@@ -62,3 +62,4 @@
 tuner=61 - Tena TNF9533-D/IF/TNF9533-B/DF
 tuner=62 - Philips TEA5767HN FM Radio
 tuner=63 - Philips FMD1216ME MK3 Hybrid Tuner
+tuner=64 - LG TDVS-H062F/TUA6034
diff -u linux-2.6.13/Documentation/video4linux/CARDLIST.cx88 linux/Documentation/video4linux/CARDLIST.cx88
--- linux-2.6.13/Documentation/video4linux/CARDLIST.cx88	2005-07-28 22:49:10.000000000 +0000
+++ linux/Documentation/video4linux/CARDLIST.cx88	2005-07-30 01:04:57.000000000 +0000
@@ -29,3 +29,4 @@
 card=28 - DViCO FusionHDTV 3 Gold-T
 card=29 - ADS Tech Instant TV DVB-T PCI
 card=30 - TerraTec Cinergy 1400 DVB-T
+card=31 - DViCO FusionHDTV 5 Gold

--------------010007050501040708070407--

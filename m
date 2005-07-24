Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVGXXdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVGXXdb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 19:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVGXXda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 19:33:30 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:63555 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261541AbVGXXd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 19:33:29 -0400
Message-ID: <42E42550.9050508@m1k.net>
Date: Sun, 24 Jul 2005 19:33:36 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>, sam@ravnborg.org
Subject: [-mm PATCH] v4l: hybrid dvb: rename CFLAGS from CONFIG_DVB_xxxx back
 to original HAVE_xxxx
References: <42E2DA27.9050402@krufky.com> <42E2DAE0.307@m1k.net>
In-Reply-To: <42E2DAE0.307@m1k.net>
Content-Type: multipart/mixed;
 boundary="------------050309080702020606010702"
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
--------------050309080702020606010702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------050309080702020606010702
Content-Type: text/plain;
 name="v4l-dvb-03-rename-cflags-config-dvb-to-have.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l-dvb-03-rename-cflags-config-dvb-to-have.patch"

The #define CONFIG_DVB_* are actually CFLAGS set by Makefile.
CONFIG_* namespace is reserved for Kconfig. This renames them back to HAVE_*

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/video/cx88/Makefile         |    8 ++--
 linux/drivers/media/video/cx88/cx88-dvb.c       |   26 ++++++++--------
 linux/drivers/media/video/saa7134/Makefile      |    4 +-
 linux/drivers/media/video/saa7134/saa7134-dvb.c |   16 ++++-----
 4 files changed, 27 insertions(+), 27 deletions(-)

diff -u linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c	2005-07-24 17:59:15.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-07-24 18:21:52.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-dvb.c,v 1.51 2005/07/24 19:09:28 mkrufky Exp $
+ * $Id: cx88-dvb.c,v 1.52 2005/07/24 22:12:47 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * MPEG Transport Stream (DVB) routines
@@ -35,17 +35,17 @@
 #include "cx88.h"
 #include "dvb-pll.h"
 
-#ifdef CONFIG_DVB_MT352
+#ifdef HAVE_MT352
 # include "mt352.h"
 # include "mt352_priv.h"
 #endif
-#ifdef CONFIG_DVB_CX22702
+#ifdef HAVE_CX22702
 # include "cx22702.h"
 #endif
-#ifdef CONFIG_DVB_OR51132
+#ifdef HAVE_OR51132
 # include "or51132.h"
 #endif
-#ifdef CONFIG_DVB_LGDT3302
+#ifdef HAVE_LGDT3302
 # include "lgdt3302.h"
 #endif
 
@@ -104,7 +104,7 @@
 
 /* ------------------------------------------------------------------ */
 
-#ifdef CONFIG_DVB_MT352
+#ifdef HAVE_MT352
 static int dvico_fusionhdtv_demod_init(struct dvb_frontend* fe)
 {
 	static u8 clock_config []  = { CLOCK_CTL,  0x38, 0x39 };
@@ -174,7 +174,7 @@
 };
 #endif
 
-#ifdef CONFIG_DVB_CX22702
+#ifdef HAVE_CX22702
 static struct cx22702_config connexant_refboard_config = {
 	.demod_address = 0x43,
 	.output_mode   = CX22702_SERIAL_OUTPUT,
@@ -190,7 +190,7 @@
 };
 #endif
 
-#ifdef CONFIG_DVB_OR51132
+#ifdef HAVE_OR51132
 static int or51132_set_ts_param(struct dvb_frontend* fe,
 				int is_punctured)
 {
@@ -207,7 +207,7 @@
 };
 #endif
 
-#ifdef CONFIG_DVB_LGDT3302
+#ifdef HAVE_LGDT3302
 static int lgdt3302_pll_set(struct dvb_frontend* fe,
 			    struct dvb_frontend_parameters* params,
 			    u8* pllbuf)
@@ -258,7 +258,7 @@
 
 	/* init frontend */
 	switch (dev->core->board) {
-#ifdef CONFIG_DVB_CX22702
+#ifdef HAVE_CX22702
 	case CX88_BOARD_HAUPPAUGE_DVB_T1:
 		dev->dvb.frontend = cx22702_attach(&hauppauge_novat_config,
 						   &dev->core->i2c_adap);
@@ -269,7 +269,7 @@
 						   &dev->core->i2c_adap);
 		break;
 #endif
-#ifdef CONFIG_DVB_MT352
+#ifdef HAVE_MT352
 	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1:
 		dev->core->pll_addr = 0x61;
 		dev->core->pll_desc = &dvb_pll_lg_z201;
@@ -291,13 +291,13 @@
 						 &dev->core->i2c_adap);
 		break;
 #endif
-#ifdef CONFIG_DVB_OR51132
+#ifdef HAVE_OR51132
 	case CX88_BOARD_PCHDTV_HD3000:
 		dev->dvb.frontend = or51132_attach(&pchdtv_hd3000,
 						 &dev->core->i2c_adap);
 		break;
 #endif
-#ifdef CONFIG_DVB_LGDT3302
+#ifdef HAVE_LGDT3302
 	case CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q:
 		dev->ts_gen_cntrl = 0x08;
 		{
diff -u linux-2.6.13/drivers/media/video/saa7134/saa7134-dvb.c linux/drivers/media/video/saa7134/saa7134-dvb.c
--- linux-2.6.13/drivers/media/video/saa7134/saa7134-dvb.c	2005-07-24 17:56:27.000000000 +0000
+++ linux/drivers/media/video/saa7134/saa7134-dvb.c	2005-07-24 18:21:52.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-dvb.c,v 1.22 2005/07/23 10:08:00 mkrufky Exp $
+ * $Id: saa7134-dvb.c,v 1.23 2005/07/24 22:12:47 mkrufky Exp $
  *
  * (c) 2004 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
  *
@@ -35,11 +35,11 @@
 #include "saa7134-reg.h"
 #include "saa7134.h"
 
-#ifdef CONFIG_DVB_MT352
+#ifdef HAVE_MT352
 # include "mt352.h"
 # include "mt352_priv.h" /* FIXME */
 #endif
-#ifdef CONFIG_DVB_TDA1004X
+#ifdef HAVE_TDA1004X
 # include "tda1004x.h"
 #endif
 
@@ -53,7 +53,7 @@
 
 /* ------------------------------------------------------------------ */
 
-#ifdef CONFIG_DVB_MT352
+#ifdef HAVE_MT352
 static int pinnacle_antenna_pwr(struct saa7134_dev *dev, int on)
 {
 	u32 ok;
@@ -152,7 +152,7 @@
 
 /* ------------------------------------------------------------------ */
 
-#ifdef CONFIG_DVB_TDA1004X
+#ifdef HAVE_TDA1004X
 static int philips_tu1216_pll_init(struct dvb_frontend *fe)
 {
 	struct saa7134_dev *dev = fe->dvb->priv;
@@ -384,7 +384,7 @@
 	return 0;
 }
 
-#ifdef CONFIG_DVB_TDA1004X
+#ifdef HAVE_TDA1004X
 static struct tda1004x_config medion_cardbus = {
 	.demod_address = 0x08,
 	.invert        = 1,
@@ -547,14 +547,14 @@
 			    dev);
 
 	switch (dev->board) {
-#ifdef CONFIG_DVB_MT352
+#ifdef HAVE_MT352
 	case SAA7134_BOARD_PINNACLE_300I_DVBT_PAL:
 		printk("%s: pinnacle 300i dvb setup\n",dev->name);
 		dev->dvb.frontend = mt352_attach(&pinnacle_300i,
 						 &dev->i2c_adap);
 		break;
 #endif
-#ifdef CONFIG_DVB_TDA1004X
+#ifdef HAVE_TDA1004X
 	case SAA7134_BOARD_MD7134:
 		dev->dvb.frontend = tda10046_attach(&medion_cardbus,
 						    &dev->i2c_adap);
diff -u linux-2.6.13/drivers/media/video/cx88/Makefile linux/drivers/media/video/cx88/Makefile
--- linux-2.6.13/drivers/media/video/cx88/Makefile	2005-07-24 17:56:27.000000000 +0000
+++ linux/drivers/media/video/cx88/Makefile	2005-07-24 18:21:52.000000000 +0000
@@ -10,14 +10,14 @@
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/frontends
 ifneq ($(CONFIG_DVB_CX22702),n)
- EXTRA_CFLAGS += -DCONFIG_DVB_CX22702=1
+ EXTRA_CFLAGS += -DHAVE_CX22702=1
 endif
 ifneq ($(CONFIG_DVB_OR51132),n)
- EXTRA_CFLAGS += -DCONFIG_DVB_OR51132=1
+ EXTRA_CFLAGS += -DHAVE_OR51132=1
 endif
 ifneq ($(CONFIG_DVB_LGDT3302),n)
- EXTRA_CFLAGS += -DCONFIG_DVB_LGDT3302=1
+ EXTRA_CFLAGS += -DHAVE_LGDT3302=1
 endif
 ifneq ($(CONFIG_DVB_MT352),n)
- EXTRA_CFLAGS += -DCONFIG_DVB_MT352=1
+ EXTRA_CFLAGS += -DHAVE_MT352=1
 endif
diff -u linux-2.6.13/drivers/media/video/saa7134/Makefile linux/drivers/media/video/saa7134/Makefile
--- linux-2.6.13/drivers/media/video/saa7134/Makefile	2005-07-24 17:56:27.000000000 +0000
+++ linux/drivers/media/video/saa7134/Makefile	2005-07-24 18:21:52.000000000 +0000
@@ -10,8 +10,8 @@
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/frontends
 ifneq ($(CONFIG_DVB_MT352),n)
- EXTRA_CFLAGS += -DCONFIG_DVB_MT352=1
+ EXTRA_CFLAGS += -DHAVE_MT352=1
 endif
 ifneq ($(CONFIG_DVB_TDA1004X),n)
- EXTRA_CFLAGS += -DCONFIG_DVB_TDA1004X=1
+ EXTRA_CFLAGS += -DHAVE_TDA1004X=1
 endif

--------------050309080702020606010702--

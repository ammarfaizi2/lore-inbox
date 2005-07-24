Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVGXAAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVGXAAm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 20:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVGXAAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 20:00:42 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:58721 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S262099AbVGXAAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 20:00:39 -0400
Message-ID: <42E2DA27.9050402@krufky.com>
Date: Sat, 23 Jul 2005 20:00:39 -0400
From: Michael Krufky <mike@krufky.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>, mike@krufky.com
Subject: [-mm PATCH] v4l: hybrid dvb: fix warnings with -Wundef
Content-Type: multipart/mixed;
 boundary="------------090400020608080903040102"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - krufky.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090400020608080903040102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------090400020608080903040102
Content-Type: text/plain;
 name="v4l-dvb-01-fix-warnings-with-Wundef.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l-dvb-01-fix-warnings-with-Wundef.patch"

This patch adds a missing #ifdef to saa7134-dvb.c
(thanks to Mauro Carvalho Chehab)
and changes #if to #ifdef in both files.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/video/cx88/cx88-dvb.c       |   24 ++++++++--------
 linux/drivers/media/video/saa7134/saa7134-dvb.c |   15 +++++-----
 2 files changed, 20 insertions(+), 19 deletions(-)

diff -u linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c	2005-07-23 18:54:34.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-07-23 19:06:49.000000000 +0000
@@ -38,17 +38,17 @@
 #include "cx88.h"
 #include "dvb-pll.h"
 
-#if CONFIG_DVB_MT352
+#ifdef CONFIG_DVB_MT352
 # include "mt352.h"
 # include "mt352_priv.h"
 #endif
-#if CONFIG_DVB_CX22702
+#ifdef CONFIG_DVB_CX22702
 # include "cx22702.h"
 #endif
-#if CONFIG_DVB_OR51132
+#ifdef CONFIG_DVB_OR51132
 # include "or51132.h"
 #endif
-#if CONFIG_DVB_LGDT3302
+#ifdef CONFIG_DVB_LGDT3302
 # include "lgdt3302.h"
 #endif
 
@@ -107,7 +107,7 @@
 
 /* ------------------------------------------------------------------ */
 
-#if CONFIG_DVB_MT352
+#ifdef CONFIG_DVB_MT352
 static int dvico_fusionhdtv_demod_init(struct dvb_frontend* fe)
 {
 	static u8 clock_config []  = { CLOCK_CTL,  0x38, 0x39 };
@@ -177,7 +177,7 @@
 };
 #endif
 
-#if CONFIG_DVB_CX22702
+#ifdef CONFIG_DVB_CX22702
 static struct cx22702_config connexant_refboard_config = {
 	.demod_address = 0x43,
 	.pll_address   = 0x60,
@@ -191,7 +191,7 @@
 };
 #endif
 
-#if CONFIG_DVB_OR51132
+#ifdef CONFIG_DVB_OR51132
 static int or51132_set_ts_param(struct dvb_frontend* fe,
 				int is_punctured)
 {
@@ -208,7 +208,7 @@
 };
 #endif
 
-#if CONFIG_DVB_LGDT3302
+#ifdef CONFIG_DVB_LGDT3302
 static int lgdt3302_pll_set(struct dvb_frontend* fe,
 			    struct dvb_frontend_parameters* params,
 			    u8* pllbuf)
@@ -259,7 +259,7 @@
 
 	/* init frontend */
 	switch (dev->core->board) {
-#if CONFIG_DVB_CX22702
+#ifdef CONFIG_DVB_CX22702
 	case CX88_BOARD_HAUPPAUGE_DVB_T1:
 		dev->dvb.frontend = cx22702_attach(&hauppauge_novat_config,
 						   &dev->core->i2c_adap);
@@ -270,7 +270,7 @@
 						   &dev->core->i2c_adap);
 		break;
 #endif
-#if CONFIG_DVB_MT352
+#ifdef CONFIG_DVB_MT352
 	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1:
 		dev->core->pll_addr = 0x61;
 		dev->core->pll_desc = &dvb_pll_lg_z201;
@@ -292,13 +292,13 @@
 						 &dev->core->i2c_adap);
 		break;
 #endif
-#if CONFIG_DVB_OR51132
+#ifdef CONFIG_DVB_OR51132
 	case CX88_BOARD_PCHDTV_HD3000:
 		dev->dvb.frontend = or51132_attach(&pchdtv_hd3000,
 						 &dev->core->i2c_adap);
 		break;
 #endif
-#if CONFIG_DVB_LGDT3302
+#ifdef CONFIG_DVB_LGDT3302
 	case CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q:
 		dev->ts_gen_cntrl = 0x08;
 		{
diff -u linux-2.6.13/drivers/media/video/saa7134/saa7134-dvb.c linux/drivers/media/video/saa7134/saa7134-dvb.c
--- linux-2.6.13/drivers/media/video/saa7134/saa7134-dvb.c	2005-07-23 18:39:40.000000000 +0000
+++ linux/drivers/media/video/saa7134/saa7134-dvb.c	2005-07-23 19:06:49.000000000 +0000
@@ -36,11 +36,11 @@
 #include "saa7134-reg.h"
 #include "saa7134.h"
 
-#if CONFIG_DVB_MT352
+#ifdef CONFIG_DVB_MT352
 # include "mt352.h"
 # include "mt352_priv.h" /* FIXME */
 #endif
-#if CONFIG_DVB_TDA1004X
+#ifdef CONFIG_DVB_TDA1004X
 # include "tda1004x.h"
 #endif
 
@@ -54,7 +54,7 @@
 
 /* ------------------------------------------------------------------ */
 
-#if CONFIG_DVB_MT352
+#ifdef CONFIG_DVB_MT352
 static int pinnacle_antenna_pwr(struct saa7134_dev *dev, int on)
 {
 	u32 ok;
@@ -153,7 +153,7 @@
 
 /* ------------------------------------------------------------------ */
 
-#if CONFIG_DVB_TDA1004X
+#ifdef CONFIG_DVB_TDA1004X
 static int philips_tu1216_pll_init(struct dvb_frontend *fe)
 {
 	struct saa7134_dev *dev = fe->dvb->priv;
@@ -385,7 +385,7 @@
 	return 0;
 }
 
-
+#ifdef CONFIG_DVB_TDA1004X
 static struct tda1004x_config medion_cardbus = {
 	.demod_address = 0x08,
 	.invert        = 1,
@@ -398,6 +398,7 @@
 	.pll_sleep	   = philips_fmd1216_analog,
 	.request_firmware = NULL,
 };
+#endif
 
 /* ------------------------------------------------------------------ */
 
@@ -547,14 +548,14 @@
 			    dev);
 
 	switch (dev->board) {
-#if CONFIG_DVB_MT352
+#ifdef CONFIG_DVB_MT352
 	case SAA7134_BOARD_PINNACLE_300I_DVBT_PAL:
 		printk("%s: pinnacle 300i dvb setup\n",dev->name);
 		dev->dvb.frontend = mt352_attach(&pinnacle_300i,
 						 &dev->i2c_adap);
 		break;
 #endif
-#if CONFIG_DVB_TDA1004X
+#ifdef CONFIG_DVB_TDA1004X
 	case SAA7134_BOARD_MD7134:
 		dev->dvb.frontend = tda10046_attach(&medion_cardbus,
 						    &dev->i2c_adap);

--------------090400020608080903040102--

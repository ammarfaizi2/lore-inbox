Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbULYPer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbULYPer (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 10:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbULYPer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 10:34:47 -0500
Received: from coderock.org ([193.77.147.115]:14300 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261519AbULYPej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 10:34:39 -0500
Subject: [patch 2/2] miropcm20-radio cleanup
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, sebek64@post.cz
From: domen@coderock.org
Date: Sat, 25 Dec 2004 16:34:43 +0100
Message-Id: <20041225153433.CCB291EA0F@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is cleanup of file miropcm20-radio.c

Compile tested.

Signed-off-by: Marcel Sebek <sebek64@post.cz>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/media/radio/miropcm20-radio.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff -puN drivers/media/radio/miropcm20-radio.c~cleanup-drivers_media_radio_miropcm20-radio.c drivers/media/radio/miropcm20-radio.c
--- kj/drivers/media/radio/miropcm20-radio.c~cleanup-drivers_media_radio_miropcm20-radio.c	2004-12-25 01:36:06.000000000 +0100
+++ kj-domen/drivers/media/radio/miropcm20-radio.c	2004-12-25 01:36:06.000000000 +0100
@@ -22,11 +22,12 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/videodev.h>
+#include <linux/moduleparam.h>
 #include "../../../sound/oss/aci.h"
 #include "miropcm20-rds-core.h"
 
 static int radio_nr = -1;
-MODULE_PARM(radio_nr, "i");
+module_param(radio_nr, int, 0444);
 
 struct pcm20_device {
 	unsigned long freq;
@@ -75,9 +76,7 @@ static int pcm20_getflags(struct pcm20_d
 
 	if ((i=aci_rw_cmd(ACI_READ_TUNERSTATION, -1, -1))<0)
 		return i;
-#ifdef DEBUG
-	printk("check_sig: 0x%x\n", i);
-#endif
+	pr_debug("check_sig: 0x%x\n", i);
 	if (i & 0x80) {
 		/* no signal from tuner */
 		*flags=0;
@@ -107,9 +106,7 @@ static int pcm20_getflags(struct pcm20_d
 
 	if ((i=aci_rds_cmd(RDS_RXVALUE, &buf, 1))<0)
 		return i;
-#ifdef DEBUG
-	printk("rds-signal: %d\n", buf);
-#endif
+	pr_debug("rds-signal: %d\n", buf);
 	if (buf > 15) {
 		printk("miropcm20-radio: RX strengths unexpected high...\n");
 		buf=15;
@@ -172,9 +169,7 @@ static int pcm20_do_ioctl(struct inode *
 			unsigned long *freq = arg;
 			pcm20->freq = *freq;
 			i=pcm20_setfreq(pcm20, pcm20->freq);
-#ifdef DEBUG
-			printk("First view (setfreq): 0x%x\n", i);
-#endif
+			pr_debug("First view (setfreq): 0x%x\n", i);
 			return i;
 		}
 		case VIDIOCGAUDIO:
_

Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751405AbWFEUMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWFEUMl (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWFEUMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:12:40 -0400
Received: from mail.gmx.de ([213.165.64.20]:31680 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751406AbWFEUMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:12:39 -0400
X-Authenticated: #704063
Subject: [Patch] Zoran strncpy() cleanup
From: Eric Sesterhenn <snakebyte@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: bdirks@pacbell.net
Content-Type: text/plain
Date: Mon, 05 Jun 2006 22:12:37 +0200
Message-Id: <1149538357.16994.7.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this was spotted by coverity ( bug id #536 ). While
it is not really a bug, i think we should clean it up.
std->name can only hold 24 chars, not 32 as the strncpy() calls
suggest. std->name can hold 32 chars, but since we use constant
fixed-sized strings, which will always fit into these arrays, i changed
the strncpy() calls to strcpy(). If you prefer strncpy(foo->name, "bar", sizeof(foo->name))
please let me know and i redo the patch.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc5/drivers/media/video/zoran_driver.c.orig	2006-06-05 22:06:42.000000000 +0200
+++ linux-2.6.17-rc5/drivers/media/video/zoran_driver.c	2006-06-05 22:08:50.000000000 +0200
@@ -3566,16 +3566,16 @@ zoran_do_ioctl (struct inode *inode,
 
 		switch (ctrl->id) {
 		case V4L2_CID_BRIGHTNESS:
-			strncpy(ctrl->name, "Brightness", 31);
+			strcpy(ctrl->name, "Brightness");
 			break;
 		case V4L2_CID_CONTRAST:
-			strncpy(ctrl->name, "Contrast", 31);
+			strcpy(ctrl->name, "Contrast");
 			break;
 		case V4L2_CID_SATURATION:
-			strncpy(ctrl->name, "Saturation", 31);
+			strcpy(ctrl->name, "Saturation");
 			break;
 		case V4L2_CID_HUE:
-			strncpy(ctrl->name, "Hue", 31);
+			strcpy(ctrl->name, "Hue");
 			break;
 		}
 
@@ -3693,7 +3693,7 @@ zoran_do_ioctl (struct inode *inode,
 					&caps);
 			if (caps.flags & VIDEO_DECODER_AUTO) {
 				std->id = V4L2_STD_ALL;
-				strncpy(std->name, "Autodetect", 31);
+				strcpy(std->name, "Autodetect");
 				return 0;
 			} else
 				return -EINVAL;
@@ -3701,21 +3701,21 @@ zoran_do_ioctl (struct inode *inode,
 		switch (std->index) {
 		case 0:
 			std->id = V4L2_STD_PAL;
-			strncpy(std->name, "PAL", 31);
+			strcpy(std->name, "PAL");
 			std->frameperiod.numerator = 1;
 			std->frameperiod.denominator = 25;
 			std->framelines = zr->card.tvn[0]->Ht;
 			break;
 		case 1:
 			std->id = V4L2_STD_NTSC;
-			strncpy(std->name, "NTSC", 31);
+			strcpy(std->name, "NTSC");
 			std->frameperiod.numerator = 1001;
 			std->frameperiod.denominator = 30000;
 			std->framelines = zr->card.tvn[1]->Ht;
 			break;
 		case 2:
 			std->id = V4L2_STD_SECAM;
-			strncpy(std->name, "SECAM", 31);
+			strcpy(std->name, "SECAM");
 			std->frameperiod.numerator = 1;
 			std->frameperiod.denominator = 25;
 			std->framelines = zr->card.tvn[2]->Ht;
@@ -3871,7 +3871,7 @@ zoran_do_ioctl (struct inode *inode,
 		memset(outp, 0, sizeof(*outp));
 		outp->index = 0;
 		outp->type = V4L2_OUTPUT_TYPE_ANALOGVGAOVERLAY;
-		strncpy(outp->name, "Autodetect", 31);
+		strcpy(outp->name, "Autodetect");
 
 		return 0;
 	}



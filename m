Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTJHNeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTJHNd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:33:59 -0400
Received: from mail.convergence.de ([212.84.236.4]:8161 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261538AbTJHN26 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:28:58 -0400
Subject: [PATCH 7/14] usual c99 initializer fixes
In-Reply-To: <10656197352583@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 8 Oct 2003 15:28:56 +0200
Message-Id: <10656197362976@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] the usual c99 initialization fixes all over the DVB place
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/ttpci/av7110.c linux-2.6.0-test5/drivers/media/dvb/ttpci/av7110.c
--- xx-linux-2.6.0-test5/drivers/media/dvb/ttpci/av7110.c	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/ttpci/av7110.c	2003-09-10 10:58:29.000000000 +0200
@@ -2608,8 +2615,23 @@
  ****************************************************************************/
 
 static struct v4l2_input inputs[2] = {
-	{ 0,	"DVB",		V4L2_INPUT_TYPE_CAMERA,	1, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 }, 
-	{ 1,	"ANALOG",	V4L2_INPUT_TYPE_TUNER,	2, 1, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+	{	
+		.index 		= 0,
+		.name 		= "DVB",
+		.type		= V4L2_INPUT_TYPE_CAMERA,
+		.audioset 	= 1,
+		.tuner		= 0, /* ignored */
+		.std		= V4L2_STD_PAL_BG|V4L2_STD_NTSC_M,
+		.status		= 0,
+	}, { 
+		.index 		= 1,
+		.name 		= "ANALOG",
+		.type		= V4L2_INPUT_TYPE_TUNER,
+		.audioset 	= 2,
+		.tuner		= 0,
+		.std		= V4L2_STD_PAL_BG|V4L2_STD_NTSC_M,
+		.status		= 0,
+	}
 };
 
 /* taken from ves1820.c */
@@ -4629,19 +4673,45 @@
 /* FIXME: these values are experimental values that look better than the
    values from the latest "official" driver -- at least for me... (MiHu) */
 static struct saa7146_standard standard[] = {
-	{ "PAL", V4L2_STD_PAL, 0x15, 288, 576, 0x4a, 708, 709, 576, 768 },
-//	{ "PAL", V4L2_STD_PAL, 0x15, 288, 576, 0x3a, 720, 721, 576, 768 },
-	{ "NTSC", V4L2_STD_NTSC, 0x10, 244, 480, 0x40, 708, 709, 480, 640 },
+	{
+		.name	= "PAL", 	.id		= V4L2_STD_PAL_BG,
+		.v_offset	= 0x15,	.v_field 	= 288,		.v_calc	= 576,
+		.h_offset	= 0x4a,	.h_pixels 	= 708,		.h_calc	= 709,
+		.v_max_out	= 576,	.h_max_out	= 768,
+	}, {
+		.name	= "NTSC", 	.id		= V4L2_STD_NTSC,
+		.v_offset	= 0x10,	.v_field 	= 244,		.v_calc	= 480,
+		.h_offset	= 0x40,	.h_pixels 	= 708,		.h_calc	= 709,
+		.v_max_out	= 480,	.h_max_out	= 640,
+	}
 };
 
 static struct saa7146_standard analog_standard[] = {
-	{ "PAL", V4L2_STD_PAL, 0x18, 288, 576, 0x08, 708, 709, 576, 768 },
-	{ "NTSC", V4L2_STD_NTSC, 0x10, 244, 480, 0x40, 708, 709, 480, 640 },
+	{
+		.name	= "PAL", 	.id		= V4L2_STD_PAL_BG,
+		.v_offset	= 0x18,	.v_field 	= 288,		.v_calc	= 576,
+		.h_offset	= 0x08,	.h_pixels 	= 708,		.h_calc	= 709,
+		.v_max_out	= 576,	.h_max_out	= 768,
+	}, {
+		.name	= "NTSC", 	.id		= V4L2_STD_NTSC,
+		.v_offset	= 0x10,	.v_field 	= 244,		.v_calc	= 480,
+		.h_offset	= 0x40,	.h_pixels 	= 708,		.h_calc	= 709,
+		.v_max_out	= 480,	.h_max_out	= 640,
+	}
 };
 
 static struct saa7146_standard dvb_standard[] = {
-	{ "PAL", V4L2_STD_PAL, 0x14, 288, 576, 0x4a, 708, 709, 576, 768 },
-	{ "NTSC", V4L2_STD_NTSC, 0x10, 244, 480, 0x40, 708, 709, 480, 640 },
+	{
+		.name	= "PAL", 	.id		= V4L2_STD_PAL_BG,
+		.v_offset	= 0x14,	.v_field 	= 288,		.v_calc	= 576,
+		.h_offset	= 0x4a,	.h_pixels 	= 708,		.h_calc	= 709,
+		.v_max_out	= 576,	.h_max_out	= 768,
+	}, {
+		.name	= "NTSC", 	.id		= V4L2_STD_NTSC,
+		.v_offset	= 0x10,	.v_field 	= 244,		.v_calc	= 480,
+		.h_offset	= 0x40,	.h_pixels 	= 708,		.h_calc	= 709,
+		.v_max_out	= 480,	.h_max_out	= 640,
+	}
 };
 
 static struct saa7146_extension av7110_extension;


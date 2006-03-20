Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965608AbWCTP4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965608AbWCTP4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965615AbWCTP4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:56:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64664 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964996AbWCTPSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:18:52 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 011/141] V4L/DVB (3408): Included new sliced VBI types to
	videodev2.h and tvp5150
Date: Mon, 20 Mar 2006 12:08:38 -0300
Message-id: <20060320150838.PS894761000011@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1138043465 -0200

- Added other sliced VBI types to videodev2.h
- tvp5150 now uses standard V4L2 API codes from videodev2.h
- Implemented VIDIOC_G_SLICED_VBI_CAP for tvp5150. This is
dynamically filled based on defined VDP C-RAM values filled
by the driver.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/cx25840/cx25840-vbi.c b/drivers/media/video/cx25840/cx25840-vbi.c
diff --git a/drivers/media/video/cx25840/cx25840-vbi.c b/drivers/media/video/cx25840/cx25840-vbi.c
index 04d879d..e96fd1f 100644
--- a/drivers/media/video/cx25840/cx25840-vbi.c
+++ b/drivers/media/video/cx25840/cx25840-vbi.c
@@ -151,7 +151,7 @@ int cx25840_vbi(struct i2c_client *clien
 	case VIDIOC_G_FMT:
 	{
 		static u16 lcr2vbi[] = {
-			0, V4L2_SLICED_TELETEXT_B, 0,	/* 1 */
+			0, V4L2_SLICED_TELETEXT_PAL_B, 0,	/* 1 */
 			0, V4L2_SLICED_WSS_625, 0,	/* 4 */
 			V4L2_SLICED_CAPTION_525,	/* 6 */
 			0, 0, V4L2_SLICED_VPS, 0, 0,	/* 9 */
@@ -231,7 +231,7 @@ int cx25840_vbi(struct i2c_client *clien
 		for (i = 7; i <= 23; i++) {
 			for (x = 0; x <= 1; x++) {
 				switch (svbi->service_lines[1-x][i]) {
-				case V4L2_SLICED_TELETEXT_B:
+				case V4L2_SLICED_TELETEXT_PAL_B:
 					lcr[i] |= 1 << (4 * x);
 					break;
 				case V4L2_SLICED_WSS_625:
@@ -282,7 +282,7 @@ int cx25840_vbi(struct i2c_client *clien
 
 		switch (id2) {
 		case 1:
-			id2 = V4L2_SLICED_TELETEXT_B;
+			id2 = V4L2_SLICED_TELETEXT_PAL_B;
 			break;
 		case 4:
 			id2 = V4L2_SLICED_WSS_625;
diff --git a/drivers/media/video/saa7115.c b/drivers/media/video/saa7115.c
diff --git a/drivers/media/video/saa7115.c b/drivers/media/video/saa7115.c
index 048d000..487a429 100644
--- a/drivers/media/video/saa7115.c
+++ b/drivers/media/video/saa7115.c
@@ -791,7 +791,7 @@ static void saa7115_set_lcr(struct i2c_c
 					case 0:
 						lcr[i] |= 0xf << (4 * x);
 						break;
-					case V4L2_SLICED_TELETEXT_B:
+					case V4L2_SLICED_TELETEXT_PAL_B:
 						lcr[i] |= 1 << (4 * x);
 						break;
 					case V4L2_SLICED_CAPTION_525:
@@ -820,7 +820,7 @@ static void saa7115_set_lcr(struct i2c_c
 static int saa7115_get_v4lfmt(struct i2c_client *client, struct v4l2_format *fmt)
 {
 	static u16 lcr2vbi[] = {
-		0, V4L2_SLICED_TELETEXT_B, 0,	/* 1 */
+		0, V4L2_SLICED_TELETEXT_PAL_B, 0,	/* 1 */
 		0, V4L2_SLICED_CAPTION_525,	/* 4 */
 		V4L2_SLICED_WSS_625, 0,		/* 5 */
 		V4L2_SLICED_VPS, 0, 0, 0, 0,	/* 7 */
@@ -985,7 +985,7 @@ static void saa7115_decode_vbi_line(stru
 	/* decode payloads */
 	switch (id2) {
 	case 1:
-		vbi->type = V4L2_SLICED_TELETEXT_B;
+		vbi->type = V4L2_SLICED_TELETEXT_PAL_B;
 		break;
 	case 4:
 		if (!saa7115_odd_parity(p[0]) || !saa7115_odd_parity(p[1]))
diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
index f7fa93c..17a8dd7 100644
--- a/drivers/media/video/tvp5150.c
+++ b/drivers/media/video/tvp5150.c
@@ -1,8 +1,8 @@
 /*
- * tvp5150 - Texas Instruments TVP5150A(M) video decoder driver
+ * tvp5150 - Texas Instruments TVP5150A/AM1 video decoder driver
  *
- * Copyright (c) 2005 Mauro Carvalho Chehab (mchehab@brturbo.com.br)
- * This code is placed under the terms of the GNU General Public License
+ * Copyright (c) 2005,2006 Mauro Carvalho Chehab (mchehab@infradead.org)
+ * This code is placed under the terms of the GNU General Public License v2
  */
 
 #include <linux/i2c.h>
@@ -13,10 +13,11 @@
 
 #include "tvp5150_reg.h"
 
-MODULE_DESCRIPTION("Texas Instruments TVP5150A video decoder driver");	/* standard i2c insmod options */
+MODULE_DESCRIPTION("Texas Instruments TVP5150A video decoder driver");
 MODULE_AUTHOR("Mauro Carvalho Chehab");
 MODULE_LICENSE("GPL");
 
+/* standard i2c insmod options */
 static unsigned short normal_i2c[] = {
 	0xb8 >> 1,
 	0xba >> 1,
@@ -477,82 +478,101 @@ static const struct i2c_reg_value tvp515
 	}
 };
 
+struct tvp5150_vbi_type {
+	unsigned int vbi_type;
+	unsigned int ini_line;
+	unsigned int end_line;
+	unsigned int by_field :1;
+};
+
 struct i2c_vbi_ram_value {
 	u16 reg;
-	unsigned char values[26];
+	struct tvp5150_vbi_type type;
+	unsigned char values[16];
 };
 
-/* tvp5150_vbi_types should follow the same order as vbi_ram_default
+/* This struct have the values for each supported VBI Standard
+ * by
+ tvp5150_vbi_types should follow the same order as vbi_ram_default
  * value 0 means rom position 0x10, value 1 means rom position 0x30
  * and so on. There are 16 possible locations from 0 to 15.
  */
-enum tvp5150_vbi_types {	/* Video line number  Description */
-	VBI_WST_SECAM,		/* 6-23  (field 1,2)  Teletext, SECAM */
-	VBI_WST_PAL_B,		/* 6-22  (field 1,2)  Teletext, PAL, System B */
-	VBI_WST_PAL_C,		/* 6-22  (field 1,2)  Teletext, PAL, System C */
-	VBI_WST_NTSC_B,		/* 10-21 (field 1,2)  Teletext, NTSC, System B */
-	VBI_NABTS_NTSC_C,	/* 10-21 (field 1,2)  Teletext, NTSC, System C */
-	VBI_NABTS_NTSC_D,	/* 10-21 (field 1,2)  Teletext, NTSC, System D */
-	VBI_CC_PAL_SECAM,	/* 22    (field 1,2)  Closed Caption PAL/SECAM */
-	VBI_CC_NTSC,		/* 21    (field 1,2)  Closed Caption NTSC */
-	VBI_WSS_PAL_SECAM,	/* 23    (field 1,2)  Wide Screen Signal PAL/SECAM */
-	VBI_WSS_NTSC,		/* 20    (field 1,2)  Wide Screen Signal NTSC */
-	VBI_VITC_PAL_SECAM,	/* 6-22               Vertical Interval Timecode PAL/SECAM */
-	VBI_VITC_NTSC,		/* 10-20              Vertical Interval Timecode NTSC */
-	VBI_VPS_PAL,		/* 16                 Video Program System PAL */
-	VBI_EPG_GEMSTAR,	/*                    EPG/Gemstar Electronic program guide */
-	VBI_RESERVED,		/*                    not in use on vbi_ram_default table */
-	VBI_FULL_FIELD		/*                    Active video/Full Field */
-};
 
 static struct i2c_vbi_ram_value vbi_ram_default[] =
 {
-	{0x010, /* WST SECAM */
-		{ 0xaa, 0xaa, 0xff, 0xff , 0xe7, 0x2e, 0x20, 0x26, 0xe6, 0xb4, 0x0e, 0x0, 0x0, 0x0, 0x10, 0x0 }
-	},
-	{0x030, /* WST PAL B */
-		{ 0xaa, 0xaa, 0xff, 0xff , 0x27, 0x2e, 0x20, 0x2b, 0xa6, 0x72, 0x10, 0x0, 0x0, 0x0, 0x10, 0x0 }
-	},
-	{0x050, /* WST PAL C */
-		{ 0xaa, 0xaa, 0xff, 0xff , 0xe7, 0x2e, 0x20, 0x22, 0xa6, 0x98, 0x0d, 0x0, 0x0, 0x0, 0x10, 0x0 }
-	},
-	{0x070, /* WST NTSC B */
-		{ 0xaa, 0xaa, 0xff, 0xff , 0x27, 0x2e, 0x20, 0x23, 0x69, 0x93, 0x0d, 0x0, 0x0, 0x0, 0x10, 0x0 }
-	},
-	{0x090, /* NABTS, NTSC */
-		{ 0xaa, 0xaa, 0xff, 0xff , 0xe7, 0x2e, 0x20, 0x22, 0x69, 0x93, 0x0d, 0x0, 0x0, 0x0, 0x15, 0x0 }
-	},
-	{0x0b0, /* NABTS, NTSC-J */
-		{ 0xaa, 0xaa, 0xff, 0xff , 0xa7, 0x2e, 0x20, 0x23, 0x69, 0x93, 0x0d, 0x0, 0x0, 0x0, 0x10, 0x0 }
-	},
-	{0x0d0, /* CC, PAL/SECAM */
-		{ 0xaa, 0x2a, 0xff, 0x3f , 0x04, 0x51, 0x6e, 0x02, 0xa6, 0x7b, 0x09, 0x0, 0x0, 0x0, 0x27, 0x0 }
-	},
-	{0x0f0, /* CC, NTSC */
-		{ 0xaa, 0x2a, 0xff, 0x3f , 0x04, 0x51, 0x6e, 0x02, 0x69, 0x8c, 0x09, 0x0, 0x0, 0x0, 0x27, 0x0 }
-	},
-	{0x110, /* WSS, PAL/SECAM */
-		{ 0x5b, 0x55, 0xc5, 0xff , 0x0, 0x71, 0x6e, 0x42, 0xa6, 0xcd, 0x0f, 0x0, 0x0, 0x0, 0x3a, 0x0 }
-	},
-	{0x130, /* WSS, NTSC C */
-		{ 0x38, 0x00, 0x3f, 0x00 , 0x0, 0x71, 0x6e, 0x43, 0x69, 0x7c, 0x08, 0x0, 0x0, 0x0, 0x39, 0x0 }
-	},
-	{0x150, /* VITC, PAL/SECAM */
-		{ 0x0, 0x0, 0x0, 0x0 , 0x0, 0x8f, 0x6d, 0x49, 0xa6, 0x85, 0x08, 0x0, 0x0, 0x0, 0x4c, 0x0 }
-	},
-	{0x170, /* VITC, NTSC */
-		{ 0x0, 0x0, 0x0, 0x0 , 0x0, 0x8f, 0x6d, 0x49, 0x69, 0x94, 0x08, 0x0, 0x0, 0x0, 0x4c, 0x0 }
-	},
-	{0x190, /* VPS, PAL */
-		{ 0xaa, 0xaa, 0xff, 0xff, 0xba, 0xce, 0x2b, 0x0d, 0xa6, 0xda, 0x0b, 0x0, 0x0, 0x0, 0x60, 0x0 }
-	},
-	{0x1b0, /* Gemstar Custom 1 */
-		{ 0xcc, 0xcc, 0xff, 0xff, 0x05, 0x51, 0x6e, 0x05, 0x69, 0x19, 0x13, 0x0, 0x0, 0x0, 0x60, 0x0 }
+	{0x010, /* Teletext, SECAM, WST System A */
+		{V4L2_SLICED_TELETEXT_SECAM,6,23,1},
+		{ 0xaa, 0xaa, 0xff, 0xff, 0xe7, 0x2e, 0x20, 0x26,
+		  0xe6, 0xb4, 0x0e, 0x00, 0x00, 0x00, 0x10, 0x00 }
+	},
+	{0x030, /* Teletext, PAL, WST System B */
+		{V4L2_SLICED_TELETEXT_PAL_B,6,22,1},
+		{ 0xaa, 0xaa, 0xff, 0xff, 0x27, 0x2e, 0x20, 0x2b,
+		  0xa6, 0x72, 0x10, 0x00, 0x00, 0x00, 0x10, 0x00 }
+	},
+	{0x050, /* Teletext, PAL, WST System C */
+		{V4L2_SLICED_TELETEXT_PAL_C,6,22,1},
+		{ 0xaa, 0xaa, 0xff, 0xff, 0xe7, 0x2e, 0x20, 0x22,
+		  0xa6, 0x98, 0x0d, 0x00, 0x00, 0x00, 0x10, 0x00 }
+	},
+	{0x070, /* Teletext, NTSC, WST System B */
+		{V4L2_SLICED_TELETEXT_NTSC_B,10,21,1},
+		{ 0xaa, 0xaa, 0xff, 0xff, 0x27, 0x2e, 0x20, 0x23,
+		  0x69, 0x93, 0x0d, 0x00, 0x00, 0x00, 0x10, 0x00 }
+	},
+	{0x090, /* Tetetext, NTSC NABTS System C */
+		{V4L2_SLICED_TELETEXT_NTSC_C,10,21,1},
+		{ 0xaa, 0xaa, 0xff, 0xff, 0xe7, 0x2e, 0x20, 0x22,
+		  0x69, 0x93, 0x0d, 0x00, 0x00, 0x00, 0x15, 0x00 }
+	},
+	{0x0b0, /* Teletext, NTSC-J, NABTS System D */
+		{V4L2_SLICED_TELETEXT_NTSC_D,10,21,1},
+		{ 0xaa, 0xaa, 0xff, 0xff, 0xa7, 0x2e, 0x20, 0x23,
+		  0x69, 0x93, 0x0d, 0x00, 0x00, 0x00, 0x10, 0x00 }
+	},
+	{0x0d0, /* Closed Caption, PAL/SECAM */
+		{V4L2_SLICED_CAPTION_625,22,22,1},
+		{ 0xaa, 0x2a, 0xff, 0x3f, 0x04, 0x51, 0x6e, 0x02,
+		  0xa6, 0x7b, 0x09, 0x00, 0x00, 0x00, 0x27, 0x00 }
+	},
+	{0x0f0, /* Closed Caption, NTSC */
+		{V4L2_SLICED_CAPTION_525,21,21,1},
+		{ 0xaa, 0x2a, 0xff, 0x3f, 0x04, 0x51, 0x6e, 0x02,
+		  0x69, 0x8c, 0x09, 0x00, 0x00, 0x00, 0x27, 0x00 }
+	},
+	{0x110, /* Wide Screen Signal, PAL/SECAM */
+		{V4L2_SLICED_WSS_625,20,21,1},
+		{ 0x5b, 0x55, 0xc5, 0xff, 0x00, 0x71, 0x6e, 0x42,
+		  0xa6, 0xcd, 0x0f, 0x00, 0x00, 0x00, 0x3a, 0x00 }
+	},
+	{0x130, /* Wide Screen Signal, NTSC C */
+		{V4L2_SLICED_WSS_525,20,20,1},
+		{ 0x38, 0x00, 0x3f, 0x00, 0x00, 0x71, 0x6e, 0x43,
+		  0x69, 0x7c, 0x08, 0x00, 0x00, 0x00, 0x39, 0x00 }
+	},
+	{0x150, /* Vertical Interval Timecode (VITC), PAL/SECAM */
+		{V4l2_SLICED_VITC_625,6,22,0},
+		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x8f, 0x6d, 0x49,
+		  0xa6, 0x85, 0x08, 0x00, 0x00, 0x00, 0x4c, 0x00 }
+	},
+	{0x170, /* Vertical Interval Timecode (VITC), NTSC */
+		{V4l2_SLICED_VITC_525,10,20,0},
+		{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x8f, 0x6d, 0x49,
+		  0x69, 0x94, 0x08, 0x00, 0x00, 0x00, 0x4c, 0x00 }
+	},
+	{0x190, /* Video Program System (VPS), PAL */
+		{V4L2_SLICED_VPS,16,16,0},
+		{ 0xaa, 0xaa, 0xff, 0xff, 0xba, 0xce, 0x2b, 0x0d,
+		  0xa6, 0xda, 0x0b, 0x00, 0x00, 0x00, 0x60, 0x00 }
 	},
+	/* 0x1d0 User programmable */
+
+	/* End of struct */
+	{ (u16)-1 }
 };
 
 static int tvp5150_write_inittab(struct i2c_client *c,
-				 const struct i2c_reg_value *regs)
+				const struct i2c_reg_value *regs)
 {
 	while (regs->reg != 0xff) {
 		tvp5150_write(c, regs->reg, regs->value);
@@ -562,7 +582,7 @@ static int tvp5150_write_inittab(struct 
 }
 
 static int tvp5150_vdp_init(struct i2c_client *c,
-				 const struct i2c_vbi_ram_value *regs)
+				const struct i2c_vbi_ram_value *regs)
 {
 	unsigned int i;
 
@@ -586,6 +606,24 @@ static int tvp5150_vdp_init(struct i2c_c
 	return 0;
 }
 
+/* Fills VBI capabilities based on i2c_vbi_ram_value struct */
+static void tvp5150_vbi_get_cap(const struct i2c_vbi_ram_value *regs,
+				struct v4l2_sliced_vbi_cap *cap)
+{
+	int line;
+
+	memset(cap, 0, sizeof *cap);
+
+	while (regs->reg != (u16)-1 ) {
+		for (line=regs->type.ini_line;line<=regs->type.end_line;line++) {
+			cap->service_lines[0][line] |= regs->type.vbi_type;
+		}
+		cap->service_set |= regs->type.vbi_type;
+
+		regs++;
+	}
+}
+
 /* Set vbi processing
  * type - one of tvp5150_vbi_types
  * line - line to gather data
@@ -599,7 +637,7 @@ static int tvp5150_vdp_init(struct i2c_c
  *	LSB = field1
  *	MSB = field2
  */
-static int tvp5150_set_vbi(struct i2c_client *c, enum tvp5150_vbi_types type,
+static int tvp5150_set_vbi(struct i2c_client *c, unsigned int type,
 					u8 flags, int line, const int fields)
 {
 	struct tvp5150 *decoder = i2c_get_clientdata(c);
@@ -775,6 +813,15 @@ static int tvp5150_command(struct i2c_cl
 		*(v4l2_std_id *)arg = decoder->norm;
 		break;
 
+	case VIDIOC_G_SLICED_VBI_CAP:
+	{
+		struct v4l2_sliced_vbi_cap *cap = arg;
+		tvp5150_dbg(1, "VIDIOC_G_SLICED_VBI_CAP\n");
+
+		tvp5150_vbi_get_cap(vbi_ram_default, cap);
+		break;
+	}
+
 #ifdef CONFIG_VIDEO_ADV_DEBUG
 	case VIDIOC_INT_G_REGISTER:
 	{
@@ -1021,7 +1068,7 @@ static int tvp5150_detect_client(struct 
 		return rv;
 	}
 
-	if (debug > 1)
+//	if (debug > 1)
 		dump_reg(c);
 	return 0;
 }
diff --git a/drivers/media/video/tvp5150_reg.h b/drivers/media/video/tvp5150_reg.h
diff --git a/drivers/media/video/tvp5150_reg.h b/drivers/media/video/tvp5150_reg.h
index c81587e..4240043 100644
--- a/drivers/media/video/tvp5150_reg.h
+++ b/drivers/media/video/tvp5150_reg.h
@@ -1,3 +1,10 @@
+/*
+ * tvp5150 - Texas Instruments TVP5150A/AM1 video decoder registers
+ *
+ * Copyright (c) 2005,2006 Mauro Carvalho Chehab (mchehab@infradead.org)
+ * This code is placed under the terms of the GNU General Public License v2
+ */
+
 #define TVP5150_VD_IN_SRC_SEL_1      0x00 /* Video input source selection #1 */
 #define TVP5150_ANAL_CHL_CTL         0x01 /* Analog channel controls */
 #define TVP5150_OP_MODE_CTL          0x02 /* Operation mode controls */
diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
index ce40675..27ae3d6 100644
--- a/include/linux/videodev2.h
+++ b/include/linux/videodev2.h
@@ -949,13 +949,50 @@ struct v4l2_sliced_vbi_format
 	__u32   reserved[2];            /* must be zero */
 };
 
-#define V4L2_SLICED_TELETEXT_B          (0x0001)
-#define V4L2_SLICED_VPS                 (0x0400)
-#define V4L2_SLICED_CAPTION_525         (0x1000)
-#define V4L2_SLICED_WSS_625             (0x4000)
-
-#define V4L2_SLICED_VBI_525             (V4L2_SLICED_CAPTION_525)
-#define V4L2_SLICED_VBI_625             (V4L2_SLICED_TELETEXT_B | V4L2_SLICED_VPS | V4L2_SLICED_WSS_625)
+/* Teletext WST, defined on ITU-R BT.653-2 */
+#define V4L2_SLICED_TELETEXT_PAL_B      (0x000001)
+#define V4L2_SLICED_TELETEXT_PAL_C      (0x000002)
+#define V4L2_SLICED_TELETEXT_NTSC_B     (0x000010)
+#define V4L2_SLICED_TELETEXT_SECAM      (0x000020)
+
+/* Teletext NABTS, defined on ITU-R BT.653-2 */
+#define V4L2_SLICED_TELETEXT_NTSC_C     (0x000040)
+#define V4L2_SLICED_TELETEXT_NTSC_D     (0x000080)
+
+/* Video Program System, defined on ETS 300 231*/
+#define V4L2_SLICED_VPS                 (0x000400)
+
+/* Closed Caption, defined on EIA-608 */
+#define V4L2_SLICED_CAPTION_525         (0x001000)
+#define V4L2_SLICED_CAPTION_625         (0x002000)
+
+/* Wide Screen System, defined on ITU-R BT1119.1 */
+#define V4L2_SLICED_WSS_625             (0x004000)
+
+/* Wide Screen System, defined on IEC 61880 */
+#define V4L2_SLICED_WSS_525             (0x008000)
+
+/* Vertical Interval Timecode (VITC), defined on SMPTE 12M */
+#define V4l2_SLICED_VITC_625		(0x010000)
+#define V4l2_SLICED_VITC_525		(0x020000)
+
+/* Compat macro - Should be removed for 2.6.18 */
+#define V4L2_SLICED_TELETEXT_B V4L2_SLICED_TELETEXT_PAL_B
+
+#define V4L2_SLICED_VBI_525             (V4L2_SLICED_TELETEXT_NTSC_B |\
+					 V4L2_SLICED_TELETEXT_NTSC_C |\
+					 V4L2_SLICED_TELETEXT_NTSC_D |\
+					 V4L2_SLICED_CAPTION_525     |\
+					 V4L2_SLICED_WSS_525         |\
+					 V4l2_SLICED_VITC_525)
+
+#define V4L2_SLICED_VBI_625             (V4L2_SLICED_TELETEXT_PAL_B  |\
+					 V4L2_SLICED_TELETEXT_PAL_C  |\
+					 V4L2_SLICED_TELETEXT_SECAM  |\
+					 V4L2_SLICED_VPS             |\
+					 V4L2_SLICED_CAPTION_625     |\
+					 V4L2_SLICED_WSS_625         |\
+					 V4l2_SLICED_VITC_625)
 
 struct v4l2_sliced_vbi_cap
 {


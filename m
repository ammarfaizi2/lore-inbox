Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUFRJV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUFRJV4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbUFRJV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:21:27 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:4284 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265084AbUFRJU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 05:20:26 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 18 Jun 2004 11:06:02 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: v4l2 API updates
Message-ID: <20040618090602.GA23444@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch has some minor updates to v4l2 API:

  * A new pixel format (V4L2_PIX_FMT_SBGGR8).
  * Adds some #defines for tv norms for convenience.
  * Allow to specify the video source to capture from on a
    per-frame basis.

please apply,

  Gerd

diff -up linux-2.6.7/include/linux/videodev2.h linux/include/linux/videodev2.h
--- linux-2.6.7/include/linux/videodev2.h	2004-06-17 10:29:54.000000000 +0200
+++ linux/include/linux/videodev2.h	2004-06-17 13:47:58.649486167 +0200
@@ -207,6 +207,9 @@ struct v4l2_pix_format
 #define V4L2_PIX_FMT_YYUV    v4l2_fourcc('Y','Y','U','V') /* 16  YUV 4:2:2     */
 #define V4L2_PIX_FMT_HI240   v4l2_fourcc('H','I','2','4') /*  8  8-bit color   */
 
+/* see http://www.siliconimaging.com/RGB%20Bayer.htm */
+#define V4L2_PIX_FMT_SBGGR8  v4l2_fourcc('B','A','8','1') /*  8  BGBG.. GRGR.. */
+
 /* compressed formats */
 #define V4L2_PIX_FMT_MJPEG    v4l2_fourcc('M','J','P','G') /* Motion-JPEG   */
 #define V4L2_PIX_FMT_JPEG     v4l2_fourcc('J','P','E','G') /* JFIF JPEG     */
@@ -383,8 +386,8 @@ struct v4l2_buffer
 		unsigned long   userptr;
 	} m;
 	__u32			length;
-
-	__u32			reserved[2];
+	__u32			input;
+	__u32			reserved;
 };
 
 /*  Flags for 'flags' field */
@@ -395,6 +398,7 @@ struct v4l2_buffer
 #define V4L2_BUF_FLAG_PFRAME	0x0010	/* Image is a P-frame */
 #define V4L2_BUF_FLAG_BFRAME	0x0020	/* Image is a B-frame */
 #define V4L2_BUF_FLAG_TIMECODE	0x0100	/* timecode field is valid */
+#define V4L2_BUF_FLAG_INPUT     0x0200  /* input field is valid */
 
 /*
  *	O V E R L A Y   P R E V I E W
@@ -526,12 +530,13 @@ typedef __u64 v4l2_std_id;
 				 V4L2_STD_PAL_I)
 #define V4L2_STD_NTSC           (V4L2_STD_NTSC_M	|\
 				 V4L2_STD_NTSC_M_JP)
+#define V4L2_STD_SECAM_DK      	(V4L2_STD_SECAM_D	|\
+				 V4L2_STD_SECAM_K	|\
+				 V4L2_STD_SECAM_K1)
 #define V4L2_STD_SECAM		(V4L2_STD_SECAM_B	|\
-				 V4L2_STD_SECAM_D	|\
 				 V4L2_STD_SECAM_G	|\
 				 V4L2_STD_SECAM_H	|\
-				 V4L2_STD_SECAM_K	|\
-				 V4L2_STD_SECAM_K1	|\
+				 V4L2_STD_SECAM_DK	|\
 				 V4L2_STD_SECAM_L)
 
 #define V4L2_STD_525_60		(V4L2_STD_PAL_M		|\
@@ -541,6 +546,8 @@ typedef __u64 v4l2_std_id;
 				 V4L2_STD_PAL_N		|\
 				 V4L2_STD_PAL_Nc	|\
 				 V4L2_STD_SECAM)
+#define V4L2_STD_ATSC           (V4L2_STD_ATSC_8_VSB    |\
+		                 V4L2_STD_ATSC_16_VSB)
 
 #define V4L2_STD_UNKNOWN        0
 #define V4L2_STD_ALL            (V4L2_STD_525_60	|\

-- 
Smoking Crack Organization

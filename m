Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWCTPcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWCTPcB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWCTPbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:31:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48056 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965312AbWCTP1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:27:22 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 020/141] V4L/DVB (3419): added some VBI macros and moved
	minor definitions to header file
Date: Mon, 20 Mar 2006 12:08:40 -0300
Message-id: <20060320150840.PS366418000020@infradead.org>
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
Date: 1138043467 -0200

- Moved some hardcoded minor numbers to videodev2.h
- Included more comments for sliced VBI standards
- Included some VBI macros to group similar standards

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
diff --git a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
index 078880e..908fbec 100644
--- a/drivers/media/video/videodev.c
+++ b/drivers/media/video/videodev.c
@@ -279,23 +279,23 @@ int video_register_device(struct video_d
 	switch(type)
 	{
 		case VFL_TYPE_GRABBER:
-			base=0;
-			end=64;
+			base=MINOR_VFL_TYPE_GRABBER_MIN;
+			end=MINOR_VFL_TYPE_GRABBER_MAX+1;
 			name_base = "video";
 			break;
 		case VFL_TYPE_VTX:
-			base=192;
-			end=224;
+			base=MINOR_VFL_TYPE_VTX_MIN;
+			end=MINOR_VFL_TYPE_VTX_MAX+1;
 			name_base = "vtx";
 			break;
 		case VFL_TYPE_VBI:
-			base=224;
-			end=256;
+			base=MINOR_VFL_TYPE_VBI_MIN;
+			end=MINOR_VFL_TYPE_VBI_MAX+1;
 			name_base = "vbi";
 			break;
 		case VFL_TYPE_RADIO:
-			base=64;
-			end=128;
+			base=MINOR_VFL_TYPE_RADIO_MIN;
+			end=MINOR_VFL_TYPE_RADIO_MAX+1;
 			name_base = "radio";
 			break;
 		default:
diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
index 27ae3d6..6e33ce9 100644
--- a/include/linux/videodev2.h
+++ b/include/linux/videodev2.h
@@ -21,7 +21,7 @@
 #include <linux/compiler.h> /* need __user */
 
 
-#define OBSOLETE_OWNER 1 /* It will be removed for 2.6.15 */
+#define OBSOLETE_OWNER 1 /* It will be removed for 2.6.17 */
 #define HAVE_V4L2 1
 
 /*
@@ -48,6 +48,16 @@
 
 #ifdef __KERNEL__
 
+/* Minor device allocation */
+#define MINOR_VFL_TYPE_GRABBER_MIN   0
+#define MINOR_VFL_TYPE_GRABBER_MAX  63
+#define MINOR_VFL_TYPE_RADIO_MIN    64
+#define MINOR_VFL_TYPE_RADIO_MAX   127
+#define MINOR_VFL_TYPE_VTX_MIN     192
+#define MINOR_VFL_TYPE_VTX_MAX     223
+#define MINOR_VFL_TYPE_VBI_MIN     224
+#define MINOR_VFL_TYPE_VBI_MAX     255
+
 #define VFL_TYPE_GRABBER	0
 #define VFL_TYPE_VBI		1
 #define VFL_TYPE_RADIO		2
@@ -949,13 +959,15 @@ struct v4l2_sliced_vbi_format
 	__u32   reserved[2];            /* must be zero */
 };
 
-/* Teletext WST, defined on ITU-R BT.653-2 */
+/* Teletext World System Teletext
+   (WST), defined on ITU-R BT.653-2 */
 #define V4L2_SLICED_TELETEXT_PAL_B      (0x000001)
 #define V4L2_SLICED_TELETEXT_PAL_C      (0x000002)
 #define V4L2_SLICED_TELETEXT_NTSC_B     (0x000010)
 #define V4L2_SLICED_TELETEXT_SECAM      (0x000020)
 
-/* Teletext NABTS, defined on ITU-R BT.653-2 */
+/* Teletext North American Broadcast Teletext Specification
+   (NABTS), defined on ITU-R BT.653-2 */
 #define V4L2_SLICED_TELETEXT_NTSC_C     (0x000040)
 #define V4L2_SLICED_TELETEXT_NTSC_D     (0x000080)
 
@@ -976,8 +988,24 @@ struct v4l2_sliced_vbi_format
 #define V4l2_SLICED_VITC_625		(0x010000)
 #define V4l2_SLICED_VITC_525		(0x020000)
 
-/* Compat macro - Should be removed for 2.6.18 */
-#define V4L2_SLICED_TELETEXT_B V4L2_SLICED_TELETEXT_PAL_B
+#define V4L2_SLICED_TELETEXT_B		(V4L2_SLICED_TELETEXT_PAL_B  |\
+					 V4L2_SLICED_TELETEXT_NTSC_B)
+
+#define V4L2_SLICED_TELETEXT		(V4L2_SLICED_TELETEXT_PAL_B  |\
+					 V4L2_SLICED_TELETEXT_PAL_C  |\
+					 V4L2_SLICED_TELETEXT_SECAM  |\
+					 V4L2_SLICED_TELETEXT_NTSC_B |\
+					 V4L2_SLICED_TELETEXT_NTSC_C |\
+					 V4L2_SLICED_TELETEXT_NTSC_D)
+
+#define V4L2_SLICED_CAPTION		(V4L2_SLICED_CAPTION_525     |\
+					 V4L2_SLICED_CAPTION_625)
+
+#define V4L2_SLICED_WSS			(V4L2_SLICED_WSS_525         |\
+					 V4L2_SLICED_WSS_625)
+
+#define V4L2_SLICED_VITC		(V4L2_SLICED_VITC_525        |\
+					 V4L2_SLICED_VITC_625)
 
 #define V4L2_SLICED_VBI_525             (V4L2_SLICED_TELETEXT_NTSC_B |\
 					 V4L2_SLICED_TELETEXT_NTSC_C |\


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWHHVNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWHHVNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWHHVNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:13:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57546 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030286AbWHHVN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:13:27 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 05/14] V4L/DVB (4399): Fix a typo that caused some compat
	stuff to not work
Date: Tue, 08 Aug 2006 18:06:53 -0300
Message-id: <20060808210653.PS36513600005@infradead.org>
In-Reply-To: <20060808210151.PS78629800000@infradead.org>
References: <20060808210151.PS78629800000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

Config option typo:
-#ifdef CONFIG_V4L1_COMPAT
+#ifdef CONFIG_VIDEO_V4L1_COMPAT

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-video.c       |    4 ++--
 drivers/media/video/saa7134/saa7134-video.c |    2 +-
 drivers/media/video/v4l2-common.c           |    6 +++---
 drivers/media/video/videodev.c              |    2 +-
 drivers/media/video/vivi.c                  |    4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-video.c b/drivers/media/video/cx88/cx88-video.c
index 547cdbd..94c92ba 100644
--- a/drivers/media/video/cx88/cx88-video.c
+++ b/drivers/media/video/cx88/cx88-video.c
@@ -1225,7 +1225,7 @@ static int video_do_ioctl(struct inode *
 		struct v4l2_format *f = arg;
 		return cx8800_try_fmt(dev,fh,f);
 	}
-#ifdef CONFIG_V4L1_COMPAT
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 	/* --- streaming capture ------------------------------------- */
 	case VIDIOCGMBUF:
 	{
@@ -1584,7 +1584,7 @@ static int radio_do_ioctl(struct inode *
 		*id = 0;
 		return 0;
 	}
-#ifdef CONFIG_V4L1_COMPAT
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 	case VIDIOCSTUNER:
 	{
 		struct video_tuner *v = arg;
diff --git a/drivers/media/video/saa7134/saa7134-video.c b/drivers/media/video/saa7134/saa7134-video.c
index 8656f24..2c171af 100644
--- a/drivers/media/video/saa7134/saa7134-video.c
+++ b/drivers/media/video/saa7134/saa7134-video.c
@@ -2087,7 +2087,7 @@ static int video_do_ioctl(struct inode *
 		struct v4l2_format *f = arg;
 		return saa7134_try_fmt(dev,fh,f);
 	}
-#ifdef CONFIG_V4L1_COMPAT
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 	case VIDIOCGMBUF:
 	{
 		struct video_mbuf *mbuf = arg;
diff --git a/drivers/media/video/v4l2-common.c b/drivers/media/video/v4l2-common.c
index 2ecbeff..8d972ff 100644
--- a/drivers/media/video/v4l2-common.c
+++ b/drivers/media/video/v4l2-common.c
@@ -202,7 +202,7 @@ #define prt_names(a,arr) (((a)>=0)&&((a)
 /* ------------------------------------------------------------------ */
 /* debug help functions                                               */
 
-#ifdef CONFIG_V4L1_COMPAT
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 static const char *v4l1_ioctls[] = {
 	[_IOC_NR(VIDIOCGCAP)]       = "VIDIOCGCAP",
 	[_IOC_NR(VIDIOCGCHAN)]      = "VIDIOCGCHAN",
@@ -301,7 +301,7 @@ #endif
 #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
 
 static const char *v4l2_int_ioctls[] = {
-#ifdef CONFIG_V4L1_COMPAT
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 	[_IOC_NR(DECODER_GET_CAPABILITIES)]    = "DECODER_GET_CAPABILITIES",
 	[_IOC_NR(DECODER_GET_STATUS)]          = "DECODER_GET_STATUS",
 	[_IOC_NR(DECODER_SET_NORM)]            = "DECODER_SET_NORM",
@@ -367,7 +367,7 @@ void v4l_printk_ioctl(unsigned int cmd)
 		       (_IOC_NR(cmd) < V4L2_INT_IOCTLS) ?
 		       v4l2_int_ioctls[_IOC_NR(cmd)] : "UNKNOWN", dir, cmd);
 		break;
-#ifdef CONFIG_V4L1_COMPAT
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 	case 'v':
 		printk("v4l1 ioctl %s, dir=%s (0x%08x)\n",
 		       (_IOC_NR(cmd) < V4L1_IOCTLS) ?
diff --git a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
index 0fc90cd..88bf2af 100644
--- a/drivers/media/video/videodev.c
+++ b/drivers/media/video/videodev.c
@@ -760,7 +760,7 @@ static int __video_do_ioctl(struct inode
 		ret=vfd->vidioc_overlay(file, fh, *i);
 		break;
 	}
-#ifdef CONFIG_V4L1_COMPAT
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 	/* --- streaming capture ------------------------------------- */
 	case VIDIOCGMBUF:
 	{
diff --git a/drivers/media/video/vivi.c b/drivers/media/video/vivi.c
index 38bd0c1..841884a 100644
--- a/drivers/media/video/vivi.c
+++ b/drivers/media/video/vivi.c
@@ -986,7 +986,7 @@ static int vidioc_dqbuf (struct file *fi
 				file->f_flags & O_NONBLOCK));
 }
 
-#ifdef CONFIG_V4L1_COMPAT
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 static int vidiocgmbuf (struct file *file, void *priv, struct video_mbuf *mbuf)
 {
 	struct vivi_fh  *fh=priv;
@@ -1328,7 +1328,7 @@ static struct video_device vivi = {
 	.vidioc_s_ctrl        = vidioc_s_ctrl,
 	.vidioc_streamon      = vidioc_streamon,
 	.vidioc_streamoff     = vidioc_streamoff,
-#ifdef CONFIG_V4L1_COMPAT
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 	.vidiocgmbuf          = vidiocgmbuf,
 #endif
 	.tvnorms              = tvnorms,


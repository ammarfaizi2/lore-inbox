Return-Path: <linux-kernel-owner+w=401wt.eu-S932957AbWL0RJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932957AbWL0RJL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932994AbWL0RJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:09:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41744 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932957AbWL0RJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:09:09 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       "audetto@tiscali.it" <audetto@tiscali.it>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 06/28] V4L/DVB (4964): VIDEO_PALETTE_YUYV and
	VIDEO_PALETTE_YUV422 are the same palette
Date: Wed, 27 Dec 2006 14:57:28 -0200
Message-id: <20061227165728.PS02290400006@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: audetto@tiscali.it <audetto@tiscali.it>

Consistent handling of VIDEO_PALETTE_YUYV and VIDEO_PALETTE_YUV422

Signed-off-by: Andrea A Odetti <audetto@tiscali.it>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/meye.c         |    4 ++--
 drivers/media/video/w9966.c        |    2 +-
 drivers/media/video/zoran_device.c |    3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/video/meye.c b/drivers/media/video/meye.c
index b083338..616a35d 100644
--- a/drivers/media/video/meye.c
+++ b/drivers/media/video/meye.c
@@ -923,7 +923,7 @@ static int meye_do_ioctl(struct inode *i
 		struct video_picture *p = arg;
 		if (p->depth != 16)
 			return -EINVAL;
-		if (p->palette != VIDEO_PALETTE_YUV422)
+		if (p->palette != VIDEO_PALETTE_YUV422 && p->palette != VIDEO_PALETTE_YUYV)
 			return -EINVAL;
 		mutex_lock(&meye.lock);
 		sonypi_camera_command(SONYPI_COMMAND_SETCAMERABRIGHTNESS,
@@ -978,7 +978,7 @@ static int meye_do_ioctl(struct inode *i
 
 		if (vm->frame >= gbuffers || vm->frame < 0)
 			return -EINVAL;
-		if (vm->format != VIDEO_PALETTE_YUV422)
+		if (vm->format != VIDEO_PALETTE_YUV422 && vm->format != VIDEO_PALETTE_YUYV)
 			return -EINVAL;
 		if (vm->height * vm->width * 2 > gbufsize)
 			return -EINVAL;
diff --git a/drivers/media/video/w9966.c b/drivers/media/video/w9966.c
index 4bdc886..8d14f30 100644
--- a/drivers/media/video/w9966.c
+++ b/drivers/media/video/w9966.c
@@ -789,7 +789,7 @@ static int w9966_v4l_do_ioctl(struct ino
 	case VIDIOCSPICT:
 	{
 		struct video_picture *vpic = arg;
-		if (vpic->depth != 16 || vpic->palette != VIDEO_PALETTE_YUV422)
+		if (vpic->depth != 16 || (vpic->palette != VIDEO_PALETTE_YUV422 && vpic->palette != VIDEO_PALETTE_YUYV))
 			return -EINVAL;
 
 		cam->brightness = vpic->brightness >> 8;
diff --git a/drivers/media/video/zoran_device.c b/drivers/media/video/zoran_device.c
index 168e431..b075276 100644
--- a/drivers/media/video/zoran_device.c
+++ b/drivers/media/video/zoran_device.c
@@ -429,7 +429,7 @@ zr36057_set_vfe (struct zoran           
 	reg |= (HorDcm << ZR36057_VFESPFR_HorDcm);
 	reg |= (VerDcm << ZR36057_VFESPFR_VerDcm);
 	reg |= (DispMode << ZR36057_VFESPFR_DispMode);
-	if (format->palette != VIDEO_PALETTE_YUV422)
+	if (format->palette != VIDEO_PALETTE_YUV422 && format->palette != VIDEO_PALETTE_YUYV)
 		reg |= ZR36057_VFESPFR_LittleEndian;
 	/* RJ: I don't know, why the following has to be the opposite
 	 * of the corresponding ZR36060 setting, but only this way
@@ -441,6 +441,7 @@ zr36057_set_vfe (struct zoran           
 	reg |= ZR36057_VFESPFR_TopField;
 	switch (format->palette) {
 
+	case VIDEO_PALETTE_YUYV:
 	case VIDEO_PALETTE_YUV422:
 		reg |= ZR36057_VFESPFR_YUV422;
 		break;


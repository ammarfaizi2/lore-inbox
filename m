Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUDELku (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 07:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUDELku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 07:40:50 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:12959 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262050AbUDELkp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 07:40:45 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 5 Apr 2004 13:39:08 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: cropcap ioctl fix
Message-ID: <20040405113908.GA29070@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

The VIDIOC_CROPCAP ioctl had wrong R/W bits, this patch fixes it.

  Gerd

diff -up linux-2.6.5/drivers/media/video/videodev.c linux/drivers/media/video/videodev.c
--- linux-2.6.5/drivers/media/video/videodev.c	2004-04-05 10:39:15.988356075 +0200
+++ linux/drivers/media/video/videodev.c	2004-04-05 10:49:56.735503096 +0200
@@ -160,6 +160,9 @@ video_fix_command(unsigned int cmd)
 	case VIDIOC_G_AUDOUT_OLD:
 		cmd = VIDIOC_G_AUDOUT;
 		break;
+	case VIDIOC_CROPCAP_OLD:
+		cmd = VIDIOC_CROPCAP;
+		break;
 	}
 	return cmd;
 }
diff -up linux-2.6.5/include/linux/videodev2.h linux/include/linux/videodev2.h
--- linux-2.6.5/include/linux/videodev2.h	2004-04-05 10:41:49.838325804 +0200
+++ linux/include/linux/videodev2.h	2004-04-05 10:49:56.742501777 +0200
@@ -869,7 +869,7 @@ struct v4l2_streamparm
 #define VIDIOC_S_MODULATOR	_IOW  ('V', 55, struct v4l2_modulator)
 #define VIDIOC_G_FREQUENCY	_IOWR ('V', 56, struct v4l2_frequency)
 #define VIDIOC_S_FREQUENCY	_IOW  ('V', 57, struct v4l2_frequency)
-#define VIDIOC_CROPCAP		_IOR  ('V', 58, struct v4l2_cropcap)
+#define VIDIOC_CROPCAP		_IOWR ('V', 58, struct v4l2_cropcap)
 #define VIDIOC_G_CROP		_IOWR ('V', 59, struct v4l2_crop)
 #define VIDIOC_S_CROP		_IOW  ('V', 60, struct v4l2_crop)
 #define VIDIOC_G_JPEGCOMP	_IOR  ('V', 61, struct v4l2_jpegcompression)
@@ -887,6 +887,7 @@ struct v4l2_streamparm
 #define VIDIOC_S_CTRL_OLD      	_IOW  ('V', 28, struct v4l2_control)
 #define VIDIOC_G_AUDIO_OLD     	_IOWR ('V', 33, struct v4l2_audio)
 #define VIDIOC_G_AUDOUT_OLD    	_IOWR ('V', 49, struct v4l2_audioout)
+#define VIDIOC_CROPCAP_OLD     	_IOR  ('V', 58, struct v4l2_cropcap)
 
 #define BASE_VIDIOC_PRIVATE	192		/* 192-255 are private */
 

-- 
http://bigendian.bytesex.org

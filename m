Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWIJRKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWIJRKR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 13:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWIJRJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 13:09:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52710 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932317AbWIJRJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 13:09:48 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 1/6] V4L/DVB (4494a): Fix compilation when V4L1 support is
	not present
Date: Sun, 10 Sep 2006 14:06:45 -0300
Message-id: <20060910170645.PS3847250001@infradead.org>
In-Reply-To: <20060910170419.PS3030230000@infradead.org>
References: <20060910170419.PS3030230000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

VIDIOCGMBUF should be compiled only when V4L1 support is selected, since
this ioctl is from the obsoleted API.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/common/saa7146_video.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/media/common/saa7146_video.c b/drivers/media/common/saa7146_video.c
index 8393d47..7e0cedc 100644
--- a/drivers/media/common/saa7146_video.c
+++ b/drivers/media/common/saa7146_video.c
@@ -1190,6 +1190,7 @@ int saa7146_video_do_ioctl(struct inode 
 		}
 		return err;
 	}
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 	case VIDIOCGMBUF:
 	{
 		struct video_mbuf *mbuf = arg;
@@ -1218,6 +1219,7 @@ int saa7146_video_do_ioctl(struct inode 
 		mutex_unlock(&q->lock);
 		return 0;
 	}
+#endif
 	default:
 		return v4l_compat_translate_ioctl(inode,file,cmd,arg,
 						  saa7146_video_do_ioctl);


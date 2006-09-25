Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWIYM6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWIYM6V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 08:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWIYM6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 08:58:21 -0400
Received: from vena.lwn.net ([206.168.112.25]:58497 "HELO lwn.net")
	by vger.kernel.org with SMTP id S932074AbWIYM6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 08:58:20 -0400
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org, mchehab@infradead.org, stable@kernel.org,
       s.hauer@pengutronix.de
Subject: [PATCH] v4l2 VIDIOC_DQBUF typo in 2.6.18
From: corbet@lwn.net (Jonathan Corbet)
Date: Mon, 25 Sep 2006 06:58:20 -0600
Message-ID: <8056.1159189100@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems that, in the rush to create the new V4L2 ioctl() API, the
VIDIOC_DQBUF code got cut-and-pasted in without being fixed up.  I went
and made a patch, only to discover that Sascha Hauer beat me to it.
That patch doesn't seem to have been picked up yet, however.  Since it's
important (streaming I/O will not work without it), here's an attempt to
spread it a bit more widely.

jon


From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] copy-paste bug in videodev.c
Date: Mon, 11 Sep 2006 10:50:55 +0200
To: video4linux-list@redhat.com

This patch fixes a copy-paste bug in videodev.c where the vidioc_qbuf()
function gets called for the dqbuf ioctl.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

diff --git a/drivers/media/video/videodev.c
b/drivers/media/video/videodev.c
index 88bf2af..8abee33 100644
--- a/drivers/media/video/videodev.c
+++ b/drivers/media/video/videodev.c
@@ -739,13 +739,13 @@ static int __video_do_ioctl(struct inode
 	case VIDIOC_DQBUF:
 	{
 		struct v4l2_buffer *p=arg;
-		if (!vfd->vidioc_qbuf)
+		if (!vfd->vidioc_dqbuf)
 			break;
 		ret = check_fmt (vfd, p->type);
 		if (ret)
 			break;
 
-		ret=vfd->vidioc_qbuf(file, fh, p);
+		ret=vfd->vidioc_dqbuf(file, fh, p);
 		if (!ret)
 			dbgbuf(cmd,vfd,p);
 		break;


-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list


--=-=-=--

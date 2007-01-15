Return-Path: <linux-kernel-owner+w=401wt.eu-S1751393AbXAOTNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbXAOTNv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbXAOTNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:13:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51509 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbXAOTNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:13:48 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Thierry MERLE <thierry.merle@free.fr>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 1/9] V4L/DVB (5019): Fix the frame->grabstate update in
	read() entry point.
Date: Mon, 15 Jan 2007 16:37:05 -0200
Message-id: <20070115183705.PS3399200001@infradead.org>
In-Reply-To: <20070115183647.PS0588920000@infradead.org>
References: <20070115183647.PS0588920000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Thierry MERLE <thierry.merle@free.fr>

The Coverity checker spotted that in usbvision_v4l2_read(), the variable
"frmx" is never assigned any value different from -1, but it's used an 
an array index in "usbvision->frame[frmx]".
Thanks to Adrian Bunk <bunk@stusta.de> for warning about that.

Signed-off-by: Thierry MERLE <thierry.merle@free.fr>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/usbvision/usbvision-video.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/usbvision/usbvision-video.c b/drivers/media/video/usbvision/usbvision-video.c
index 8c7eba2..7243337 100644
--- a/drivers/media/video/usbvision/usbvision-video.c
+++ b/drivers/media/video/usbvision/usbvision-video.c
@@ -1080,7 +1080,6 @@ static ssize_t usbvision_v4l2_read(struc
 	int noblock = file->f_flags & O_NONBLOCK;
 	unsigned long lock_flags;
 
-	int frmx = -1;
 	int ret,i;
 	struct usbvision_frame *frame;
 
@@ -1155,7 +1154,7 @@ static ssize_t usbvision_v4l2_read(struc
 		frame->bytes_read = 0;
 
 		/* Mark it as available to be used again. */
-		usbvision->frame[frmx].grabstate = FrameState_Unused;
+		frame->grabstate = FrameState_Unused;
 /* 	} */
 
 	return count;


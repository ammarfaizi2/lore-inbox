Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945963AbWGOXHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945963AbWGOXHj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 19:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945978AbWGOXHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 19:07:39 -0400
Received: from igraine.blacknight.ie ([81.17.252.25]:36783 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S1945963AbWGOXHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 19:07:38 -0400
Date: Sat, 15 Jul 2006 23:08:49 +0000
From: Robert Fitzsimons <robfitz@273k.net>
To: Andrew Morton <akpm@osdl.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, greg@kroah.com,
       76306.1226@compuserve.com, fork0@t-online.de,
       linux-kernel@vger.kernel.org, mchehab@infradead.org,
       shemminger@osdl.org, video4linux-list@redhat.com,
       v4l-dvb-maintainer@linuxtv.org
Subject: [PATCH] V4L: struct video_device corruption
Message-ID: <20060715230849.GA3385@localhost>
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com> <20060713050541.GA31257@kroah.com> <20060712222407.d737129c.rdunlap@xenotime.net> <20060712224453.5faeea4a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712224453.5faeea4a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=1.713, required 7,
	RCVD_IN_NJABL_DUL 1.71)
X-blacknight-igraine-MailScanner-SpamScore: s
X-MailScanner-From: robfitz@273k.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The layout of struct video_device would change depending on whether
videodev.h (V4L1) was include or not before v4l2-dev.h, which caused
the structure to get corrupted.  Include the vidiocgmbuf function
pointer in video_device regardless of the V4L version.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 include/media/v4l2-dev.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/media/v4l2-dev.h b/include/media/v4l2-dev.h
index 62dae1a..69059d8 100644
--- a/include/media/v4l2-dev.h
+++ b/include/media/v4l2-dev.h
@@ -194,10 +194,11 @@ struct video_device
 
 
 	int (*vidioc_overlay) (struct file *file, void *fh, unsigned int i);
-#ifdef HAVE_V4L1
-			/* buffer type is struct vidio_mbuf * */
+	/*
+	 * vidiocgmbuf is part of the V4L1 API
+	 * buffer type is struct vidio_mbuf *
+	 */
 	int (*vidiocgmbuf)  (struct file *file, void *fh, struct video_mbuf *p);
-#endif
 	int (*vidioc_g_fbuf)   (struct file *file, void *fh,
 				struct v4l2_framebuffer *a);
 	int (*vidioc_s_fbuf)   (struct file *file, void *fh,
-- 
1.4.1.ga3e6


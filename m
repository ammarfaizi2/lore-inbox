Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbUKIBDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbUKIBDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbUKIBBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:01:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52489 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261323AbUKIA7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 19:59:44 -0500
Date: Tue, 9 Nov 2004 01:59:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [6/11] v4l2-common.c: remove v4l2_video_std_fps
Message-ID: <20041109005905.GU15077@stusta.de>
References: <20041107175017.GP14308@stusta.de> <20041108114008.GB20607@bytesex> <20041109004341.GO15077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109004341.GO15077@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

v4l2_video_std_fps in drivers/media/video/v4l2-common.c currently has 
exactly zero in-kernel users.


diffstat output:
 drivers/media/video/v4l2-common.c |   13 -------------
 include/linux/videodev2.h         |    1 -
 2 files changed, 14 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/include/linux/videodev2.h.old	2004-11-07 17:09:48.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/include/linux/videodev2.h	2004-11-07 17:09:55.000000000 +0100
@@ -910,7 +910,6 @@
 #include <linux/fs.h>
 
 /*  Video standard functions  */
-extern unsigned int v4l2_video_std_fps(struct v4l2_standard *vs);
 extern int v4l2_video_std_construct(struct v4l2_standard *vs,
 				    int id, char *name);
 
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/v4l2-common.c.old	2004-11-07 17:10:03.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/v4l2-common.c	2004-11-07 17:10:23.000000000 +0100
@@ -84,18 +84,6 @@
  *  Video Standard Operations (contributed by Michael Schimek)
  */
 
-/* This is the recommended method to deal with the framerate fields. More
-   sophisticated drivers will access the fields directly. */
-unsigned int
-v4l2_video_std_fps(struct v4l2_standard *vs)
-{
-	if (vs->frameperiod.numerator > 0)
-		return (((vs->frameperiod.denominator << 8) /
-			 vs->frameperiod.numerator) +
-			(1 << 7)) / (1 << 8);
-	return 0;
-}
-
 /* Fill in the fields of a v4l2_standard structure according to the
    'id' and 'transmission' parameters.  Returns negative on error.  */
 int v4l2_video_std_construct(struct v4l2_standard *vs,
@@ -259,7 +247,6 @@
 
 /* ----------------------------------------------------------------- */
 
-EXPORT_SYMBOL(v4l2_video_std_fps);
 EXPORT_SYMBOL(v4l2_video_std_construct);
 
 EXPORT_SYMBOL(v4l2_prio_init);


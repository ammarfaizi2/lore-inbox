Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbUKSRGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUKSRGH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbUKSRFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:05:09 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:28647 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261491AbUKSREL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:04:11 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 19 Nov 2004 17:56:43 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: disable unused function.
Message-ID: <20041119165643.GA2834@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#ifdef out a currently unused (in-kernel) function, lets see if any
out-of-kernel users cry.  If not we can drop it altogether later on.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/v4l2-common.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -u linux-2.6.10/drivers/media/video/v4l2-common.c linux/drivers/media/video/v4l2-common.c
--- linux-2.6.10/drivers/media/video/v4l2-common.c	2004-11-17 18:41:45.000000000 +0100
+++ linux/drivers/media/video/v4l2-common.c	2004-11-19 14:48:45.866703049 +0100
@@ -84,6 +84,7 @@
  *  Video Standard Operations (contributed by Michael Schimek)
  */
 
+#if 0 /* seems to have no users */
 /* This is the recommended method to deal with the framerate fields. More
    sophisticated drivers will access the fields directly. */
 unsigned int
@@ -95,6 +96,8 @@
 			(1 << 7)) / (1 << 8);
 	return 0;
 }
+EXPORT_SYMBOL(v4l2_video_std_fps);
+#endif
 
 /* Fill in the fields of a v4l2_standard structure according to the
    'id' and 'transmission' parameters.  Returns negative on error.  */
@@ -259,7 +262,6 @@
 
 /* ----------------------------------------------------------------- */
 
-EXPORT_SYMBOL(v4l2_video_std_fps);
 EXPORT_SYMBOL(v4l2_video_std_construct);
 
 EXPORT_SYMBOL(v4l2_prio_init);

-- 
#define printk(args...) fprintf(stderr, ## args)

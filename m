Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317798AbSGVUmM>; Mon, 22 Jul 2002 16:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317806AbSGVUmM>; Mon, 22 Jul 2002 16:42:12 -0400
Received: from phobos.hpl.hp.com ([192.6.19.124]:39666 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317798AbSGVUmK>;
	Mon, 22 Jul 2002 16:42:10 -0400
Date: Mon, 22 Jul 2002 13:45:14 -0700
From: Christopher Hoover <ch@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: ch@murgatroid.com
Subject: [PATCH] 2.5.24+ fix needed for non-modular video build
Message-ID: <20020722134514.B11556@friction.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -X ../dontdiff.txt -Naur linux-2.5.24-rmk1/drivers/media/video/videodev.c linux-2.5.24-rmk1-ch1/drivers/media/video/videodev.c
--- linux-2.5.24-rmk1/drivers/media/video/videodev.c	Thu Jun 20 15:53:45 2002
+++ linux-2.5.24-rmk1-ch1/drivers/media/video/videodev.c	Tue Jul  9 15:36:53 2002
@@ -288,8 +288,6 @@
 	video_dev_proc_entry->owner = THIS_MODULE;
 }
 
-#ifdef MODULE
-#if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
 static void videodev_proc_destroy(void)
 {
 	if (video_dev_proc_entry != NULL)
@@ -298,8 +296,6 @@
 	if (video_proc_entry != NULL)
 		remove_proc_entry("video", &proc_root);
 }
-#endif
-#endif
 
 static void videodev_proc_create_dev (struct video_device *vfd, char *name)
 {

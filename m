Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317450AbSGITkD>; Tue, 9 Jul 2002 15:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317452AbSGITkC>; Tue, 9 Jul 2002 15:40:02 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:25477
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317450AbSGITkA>; Tue, 9 Jul 2002 15:40:00 -0400
Date: Tue, 9 Jul 2002 12:42:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix drivers/media/video/videodev.c on !MODULE case
Message-ID: <20020709194226.GR695@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently videodev_proc_destroy() isn't always compiled in when used.
Right now it's compiled in based on MODULE && CONFIG_PROC_FS &&
CONFIG_VIDEO_PROC_FS.  The two problems here the part of the file where
videodev_proc_destroy resides is already protected by CONFIG_PROC_FS &&
CONFIG_VIDEO_PROC_FS.  The second problem is that
videodev_proc_destroy() isn't module specific, and is called on
CONFIG_PROC_FS && CONFIG_VIDEO_PROC_FS.

This removes the unnecessary tests and updates a comment as well to
reflect what's being tested.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== drivers/media/video/videodev.c 1.13 vs edited =====
--- 1.13/drivers/media/video/videodev.c	Wed Apr  3 17:05:11 2002
+++ edited/drivers/media/video/videodev.c	Tue Jul  9 12:38:30 2002
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
@@ -344,7 +340,7 @@
 	}
 }
 
-#endif /* CONFIG_VIDEO_PROC_FS */
+#endif /* CONFIG_VIDEO_PROC_FS && CONFIG_VIDEO_PROC_FS */
 
 extern struct file_operations video_fops;
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbTA2HEJ>; Wed, 29 Jan 2003 02:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbTA2HEJ>; Wed, 29 Jan 2003 02:04:09 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:35121 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S264920AbTA2HEI>; Wed, 29 Jan 2003 02:04:08 -0500
Date: Wed, 29 Jan 2003 02:15:16 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: faith@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.59] trivial cleanup of DRM 4.0 code from i830 driver
Message-ID: <Pine.LNX.4.50L0.0301290157580.23868-100000@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I found some old DRM 4.0 code in 2.5.59.   Here is patch to remove them.

John Kim


--- linux-2.5.59/drivers/char/drm/i830_dma.c	2003-01-16 21:21:38.000000000 -0500
+++ linux-2.5.59-new/drivers/char/drm/i830_dma.c	2003-01-29 02:06:25.000000000 -0500
@@ -40,12 +40,6 @@
 #include <linux/interrupt.h>	/* For task queue support */
 #include <linux/delay.h>
 
-#ifdef DO_MUNMAP_4_ARGS
-#define DO_MUNMAP(m, a, l)	do_munmap(m, a, l, 1)
-#else
-#define DO_MUNMAP(m, a, l)	do_munmap(m, a, l)
-#endif
-
 #define I830_BUF_FREE		2
 #define I830_BUF_CLIENT		1
 #define I830_BUF_HARDWARE      	0
@@ -230,7 +224,7 @@
 		return -EINVAL;
 
 	down_write(&current->mm->mmap_sem);
-	retcode = DO_MUNMAP(current->mm,
+	retcode = do_munmap(current->mm,
 			    (unsigned long)buf_priv->virtual,
 			    (size_t) buf->total);
 	up_write(&current->mm->mmap_sem);

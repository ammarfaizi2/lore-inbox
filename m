Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbTARXKX>; Sat, 18 Jan 2003 18:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbTARXKW>; Sat, 18 Jan 2003 18:10:22 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56804 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265169AbTARXKT>; Sat, 18 Jan 2003 18:10:19 -0500
Date: Sun, 19 Jan 2003 00:19:14 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org, Pauline Middelink <middelin@polyware.nl>
Subject: [2.5 patch] remove #if'd kernel 2.0 code from drivers/media/video/*
Message-ID: <20030118231914.GU10647@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes some #if'd code for 2.0 and early 2.2 kernels 
from drivers/media/video/*.

diffstat output:
 bw-qcam.c |    2 --
 planb.c   |    5 -----
 zoran.h   |    4 ----
 zr36120.c |    4 ----
 4 files changed, 15 deletions(-)


cu
Adrian

--- linux-2.5.59-full/drivers/media/video/bw-qcam.c.old	2003-01-18 23:52:37.000000000 +0100
+++ linux-2.5.59-full/drivers/media/video/bw-qcam.c	2003-01-18 23:53:00.000000000 +0100
@@ -83,11 +83,9 @@
 static unsigned int yieldlines=4;  /* Yield after this many during capture */
 static int video_nr = -1;
 
-#if LINUX_VERSION_CODE >= 0x020117
 MODULE_PARM(maxpoll,"i");
 MODULE_PARM(yieldlines,"i");   
 MODULE_PARM(video_nr,"i");
-#endif
 
 static inline int read_lpstatus(struct qcam_device *q)
 {
--- linux-2.5.59-full/drivers/media/video/zr36120.c.old	2003-01-18 23:53:26.000000000 +0100
+++ linux-2.5.59-full/drivers/media/video/zr36120.c	2003-01-18 23:53:48.000000000 +0100
@@ -943,7 +943,6 @@
 	return -EINVAL;
 }
 
-#if LINUX_VERSION_CODE >= 0x020100
 static
 unsigned int zoran_poll(struct video_device *dev, struct file *file, poll_table *wait)
 {
@@ -964,7 +963,6 @@
 
 	return mask;
 }
-#endif
 
 /* append a new clipregion to the vector of video_clips */
 static
@@ -1745,7 +1743,6 @@
 	return count;
 }
 
-#if LINUX_VERSION_CODE >= 0x020100
 static
 unsigned int vbi_poll(struct video_device *dev, struct file *file, poll_table *wait)
 {
@@ -1766,7 +1763,6 @@
 
 	return mask;
 }
-#endif
 
 static
 int vbi_ioctl(struct video_device *dev, unsigned int cmd, void *arg)
--- linux-2.5.59-full/drivers/media/video/planb.c.old	2003-01-18 23:54:12.000000000 +0100
+++ linux-2.5.59-full/drivers/media/video/planb.c	2003-01-18 23:54:41.000000000 +0100
@@ -181,12 +181,7 @@
 
 	/* Let's wait 30msec for this one */
 	current->state = TASK_INTERRUPTIBLE;
-#if LINUX_VERSION_CODE >= 0x02017F
 	schedule_timeout(30 * HZ / 1000);
-#else
-	current->timeout = jiffies + 30 * HZ / 1000;	/* 30 ms */;
-	schedule();
-#endif
 
 	return (unsigned char)in_8 (&planb_regs->saa_status);
 }
--- linux-2.5.59-full/drivers/media/video/zoran.h.old	2003-01-18 23:55:02.000000000 +0100
+++ linux-2.5.59-full/drivers/media/video/zoran.h	2003-01-18 23:55:24.000000000 +0100
@@ -32,10 +32,6 @@
 
 #include <linux/config.h>
 
-#if LINUX_VERSION_CODE < 0x20212
-typedef struct wait_queue *wait_queue_head_t;
-#endif
-
 /* The Buz only supports a maximum width of 720, but some V4L
    applications (e.g. xawtv are more happy with 768).
    If XAWTV_HACK is defined, we try to fake a device with bigger width */

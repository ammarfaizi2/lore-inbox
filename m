Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbTBOWVH>; Sat, 15 Feb 2003 17:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTBOWVH>; Sat, 15 Feb 2003 17:21:07 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:60800 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S265270AbTBOWVG>;
	Sat, 15 Feb 2003 17:21:06 -0500
Subject: [PATCH] fix for uninitialized timer in drm_drv.h
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045348260.681.19.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 15 Feb 2003 23:31:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a fix for an uninitialized timer in drm_drv.h, for some reason it
initilizes the timer when the device is opened, not at init.
It moves the initilization for the waitqueue to init aswell.

I'm not sure these changes are 100% correct since the drm code is a
mess. I've been running the patch here without any problems for a while.


--- linux-2.5.58/drivers/char/drm/drm_drv.h.orig	2003-01-16 20:39:47.000000000 +0100
+++ linux-2.5.58/drivers/char/drm/drm_drv.h	2003-01-16 20:49:22.000000000 +0100
@@ -323,8 +323,6 @@
 	dev->last_context = 0;
 	dev->last_switch = 0;
 	dev->last_checked = 0;
-	init_timer( &dev->timer );
-	init_waitqueue_head( &dev->context_wait );
 
 	dev->ctx_start = 0;
 	dev->lck_start = 0;
@@ -580,6 +578,8 @@
 		memset( (void *)dev, 0, sizeof(*dev) );
 		dev->count_lock = SPIN_LOCK_UNLOCKED;
 		sema_init( &dev->struct_sem, 1 );
+		init_timer( &dev->timer );
+		init_waitqueue_head( &dev->context_wait );
 
 		if ((DRM(minor)[i] = DRM(stub_register)(DRIVER_NAME, &DRM(fops),dev)) < 0)
 			return -EPERM;



-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

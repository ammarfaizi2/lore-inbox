Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267426AbSLEU5P>; Thu, 5 Dec 2002 15:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267393AbSLEU4t>; Thu, 5 Dec 2002 15:56:49 -0500
Received: from [195.39.17.254] ([195.39.17.254]:14596 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267385AbSLEU4l>;
	Thu, 5 Dec 2002 15:56:41 -0500
Date: Wed, 4 Dec 2002 14:05:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: md support
Message-ID: <20021204130514.GA8235@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds basic support to md.c. Please apply,
								Pavel

--- clean/drivers/md/md.c	2002-11-23 19:55:20.000000000 +0100
+++ linux-swsusp/drivers/md/md.c	2002-11-23 19:57:55.000000000 +0100
@@ -36,6 +36,7 @@
 #include <linux/bio.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/buffer_head.h> /* for invalidate_bdev */
+#include <linux/suspend.h>
 
 #include <linux/init.h>
 
@@ -2466,6 +2467,8 @@
 
 		wait_event_interruptible(thread->wqueue,
 					 test_bit(THREAD_WAKEUP, &thread->flags));
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 
 		clear_bit(THREAD_WAKEUP, &thread->flags);
 

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?

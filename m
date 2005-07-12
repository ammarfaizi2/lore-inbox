Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVGLIct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVGLIct (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 04:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVGLIai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 04:30:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9349 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261259AbVGLIaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 04:30:30 -0400
Date: Tue, 12 Jul 2005 10:30:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] move name_to_dev_t prototype where it belongs
Message-ID: <20050712083019.GD1854@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


...this fixes warning in swsusp and removes two prototypes done "by
hand".

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- linux-good/include/linux/mount.h	2005-04-27 15:04:30.000000000 +0200
+++ linux-struct/include/linux/mount.h	2005-07-12 10:24:53.000000000 +0200
@@ -74,6 +74,7 @@
 			int mnt_flags, struct list_head *fslist);
 
 extern void mark_mounts_for_expiry(struct list_head *mounts);
+extern dev_t name_to_dev_t(char *name);
 
 extern spinlock_t vfsmount_lock;
 
--- linux-good/init/do_mounts.h	2005-04-27 15:04:30.000000000 +0200
+++ linux-struct/init/do_mounts.h	2005-07-12 10:24:25.000000000 +0200
@@ -9,7 +9,6 @@
 #include <linux/major.h>
 #include <linux/root_dev.h>
 
-dev_t name_to_dev_t(char *name);
 void  change_floppy(char *fmt, ...);
 void  mount_block_root(char *name, int flags);
 void  mount_root(void);
--- linux-good/kernel/power/disk.c	2005-07-03 23:51:41.000000000 +0200
+++ linux-struct/kernel/power/disk.c	2005-07-12 10:17:29.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include "power.h"
 
 
--- linux-good/kernel/power/swsusp.c	2005-07-03 23:55:30.000000000 +0200
+++ linux-struct/kernel/power/swsusp.c	2005-07-12 10:17:15.000000000 +0200
@@ -1399,8 +1399,6 @@
 	return error;
 }
 
-extern dev_t name_to_dev_t(const char *line);
-
 /**
  *	read_pagedir - Read page backup list pages from swap
  */

-- 
teflon -- maybe it is a trademark, but it should not be.

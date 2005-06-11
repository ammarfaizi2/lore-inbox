Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVFKI1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVFKI1S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 04:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVFKI1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 04:27:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:3524 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261655AbVFKHsu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:50 -0400
Subject: [PATCH] Remove devfs_mk_symlink() function from the kernel tree
In-Reply-To: <11184761113507@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:31 -0700
Message-Id: <11184761111851@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Removes the devfs_mk_symlink() function and all callers of it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/drivers/ubd_kern.c      |    7 -------
 include/linux/devfs_fs_kernel.h |    4 ----
 2 files changed, 11 deletions(-)

--- gregkh-2.6.orig/arch/um/drivers/ubd_kern.c	2005-06-10 23:37:16.000000000 -0700
+++ gregkh-2.6/arch/um/drivers/ubd_kern.c	2005-06-10 23:38:12.000000000 -0700
@@ -619,7 +619,6 @@
 			
 {
 	struct gendisk *disk;
-	char from[sizeof("ubd/nnnnn\0")], to[sizeof("discnnnnn/disc\0")];
 	int err;
 
 	disk = alloc_disk(1 << UBD_SHIFT);
@@ -633,12 +632,6 @@
 	if(major == MAJOR_NR){
 		sprintf(disk->disk_name, "ubd%c", 'a' + unit);
 		sprintf(disk->devfs_name, "ubd/disc%d", unit);
-		sprintf(from, "ubd/%d", unit);
-		sprintf(to, "disc%d/disc", unit);
-		err = devfs_mk_symlink(from, to);
-		if(err)
-			printk("ubd_new_disk failed to make link from %s to "
-			       "%s, error = %d\n", from, to, err);
 	}
 	else {
 		sprintf(disk->disk_name, "ubd_fake%d", unit);
--- gregkh-2.6.orig/include/linux/devfs_fs_kernel.h	2005-06-10 23:37:16.000000000 -0700
+++ gregkh-2.6/include/linux/devfs_fs_kernel.h	2005-06-10 23:38:20.000000000 -0700
@@ -15,10 +15,6 @@
 {
 	return 0;
 }
-static inline int devfs_mk_symlink(const char *name, const char *link)
-{
-	return 0;
-}
 static inline void devfs_remove(const char *fmt, ...)
 {
 }


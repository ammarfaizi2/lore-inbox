Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVFUHqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVFUHqt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVFUHqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 03:46:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:46307 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261982AbVFUGar convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:30:47 -0400
Cc: gregkh@suse.de
Subject: [PATCH] devfs: Remove devfs_mk_symlink() function from the kernel tree
In-Reply-To: <111933544291@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 23:30:43 -0700
Message-Id: <11193354432926@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] devfs: Remove devfs_mk_symlink() function from the kernel tree

Removes the devfs_mk_symlink() function and all callers of it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 00c3ef98b7c620441fbcb03b4426d33430d90e38
tree cbd742f0cd08aeefdb3ca66dfb9633c7256664ee
parent 59fc8ea23cb33097e8ca69729cf136174faabced
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 21:15:16 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 23:13:32 -0700

 arch/um/drivers/ubd_kern.c      |    7 -------
 include/linux/devfs_fs_kernel.h |    4 ----
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -619,7 +619,6 @@ static int ubd_new_disk(int major, u64 s
 			
 {
 	struct gendisk *disk;
-	char from[sizeof("ubd/nnnnn\0")], to[sizeof("discnnnnn/disc\0")];
 	int err;
 
 	disk = alloc_disk(1 << UBD_SHIFT);
@@ -633,12 +632,6 @@ static int ubd_new_disk(int major, u64 s
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
diff --git a/include/linux/devfs_fs_kernel.h b/include/linux/devfs_fs_kernel.h
--- a/include/linux/devfs_fs_kernel.h
+++ b/include/linux/devfs_fs_kernel.h
@@ -15,10 +15,6 @@ static inline int devfs_mk_cdev(dev_t de
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


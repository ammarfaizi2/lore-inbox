Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWDJWUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWDJWUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 18:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWDJWUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 18:20:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30994 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932132AbWDJWUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 18:20:25 -0400
Date: Tue, 11 Apr 2006 00:20:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/md/md.c: make md_print_devices() static
Message-ID: <20060410222024.GL2408@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global md_print_devices() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/md/md.c         |    7 +++++--
 include/linux/raid/md.h |    4 ----
 2 files changed, 5 insertions(+), 6 deletions(-)

--- linux-2.6.17-rc1-mm2-full/include/linux/raid/md.h.old	2006-04-10 22:51:39.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/include/linux/raid/md.h	2006-04-10 22:53:00.000000000 +0200
@@ -85,8 +85,6 @@
 extern void md_error (mddev_t *mddev, mdk_rdev_t *rdev);
 extern void md_unplug_mddev(mddev_t *mddev);
 
-extern void md_print_devices (void);
-
 extern void md_super_write(mddev_t *mddev, mdk_rdev_t *rdev,
 			   sector_t sector, int size, struct page *page);
 extern void md_super_wait(mddev_t *mddev);
@@ -97,7 +95,5 @@
 
 extern void md_update_sb(mddev_t * mddev);
 
-#define MD_BUG(x...) { printk("md: bug in file %s, line %d\n", __FILE__, __LINE__); md_print_devices(); }
-
 #endif 
 
--- linux-2.6.17-rc1-mm2-full/drivers/md/md.c.old	2006-04-10 22:51:56.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/md/md.c	2006-04-10 22:53:32.000000000 +0200
@@ -72,6 +72,10 @@
 static LIST_HEAD(pers_list);
 static DEFINE_SPINLOCK(pers_lock);
 
+static void md_print_devices(void);
+
+#define MD_BUG(x...) { printk("md: bug in file %s, line %d\n", __FILE__, __LINE__); md_print_devices(); }
+
 /*
  * Current RAID-1,4,5 parallel reconstruction 'guaranteed speed limit'
  * is 1000 KB/sec, so the extra system load does not show up that much.
@@ -1503,7 +1507,7 @@
 		printk(KERN_INFO "md: no rdev superblock!\n");
 }
 
-void md_print_devices(void)
+static void md_print_devices(void)
 {
 	struct list_head *tmp, *tmp2;
 	mdk_rdev_t *rdev;
@@ -5205,7 +5209,6 @@
 EXPORT_SYMBOL(md_register_thread);
 EXPORT_SYMBOL(md_unregister_thread);
 EXPORT_SYMBOL(md_wakeup_thread);
-EXPORT_SYMBOL(md_print_devices);
 EXPORT_SYMBOL(md_check_recovery);
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("md");


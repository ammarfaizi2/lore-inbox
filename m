Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVEBCST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVEBCST (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 22:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVEBCSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 22:18:10 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23824 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261626AbVEBBq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:46:29 -0400
Date: Mon, 2 May 2005 03:46:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/md/: make some code static
Message-ID: <20050502014627.GM3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Apr 2005

 drivers/md/dm-hw-handler.c    |    2 +-
 drivers/md/dm-path-selector.c |    2 +-
 drivers/md/dm-table.c         |    2 +-
 drivers/md/dm-zero.c          |    4 ++--
 drivers/md/md.c               |   14 +++++++-------
 drivers/md/multipath.c        |    3 ++-
 6 files changed, 14 insertions(+), 13 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/md/dm-hw-handler.c.old	2005-04-19 00:46:32.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/md/dm-hw-handler.c	2005-04-19 00:46:39.000000000 +0200
@@ -23,7 +23,7 @@
 static LIST_HEAD(_hw_handlers);
 static DECLARE_RWSEM(_hwh_lock);
 
-struct hwh_internal *__find_hw_handler_type(const char *name)
+static struct hwh_internal *__find_hw_handler_type(const char *name)
 {
 	struct hwh_internal *hwhi;
 
--- linux-2.6.12-rc2-mm3-full/drivers/md/dm-path-selector.c.old	2005-04-19 00:47:18.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/md/dm-path-selector.c	2005-04-19 00:47:28.000000000 +0200
@@ -26,7 +26,7 @@
 static LIST_HEAD(_path_selectors);
 static DECLARE_RWSEM(_ps_lock);
 
-struct ps_internal *__find_path_selector_type(const char *name)
+static struct ps_internal *__find_path_selector_type(const char *name)
 {
 	struct ps_internal *psi;
 
--- linux-2.6.12-rc2-mm3-full/drivers/md/dm-table.c.old	2005-04-19 00:48:00.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/md/dm-table.c	2005-04-19 00:48:07.000000000 +0200
@@ -242,7 +242,7 @@
 	}
 }
 
-void table_destroy(struct dm_table *t)
+static void table_destroy(struct dm_table *t)
 {
 	unsigned int i;
 
--- linux-2.6.12-rc2-mm3-full/drivers/md/dm-zero.c.old	2005-04-19 00:48:17.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/md/dm-zero.c	2005-04-19 00:48:37.000000000 +0200
@@ -55,7 +55,7 @@
 	.map    = zero_map,
 };
 
-int __init dm_zero_init(void)
+static int __init dm_zero_init(void)
 {
 	int r = dm_register_target(&zero_target);
 
@@ -65,7 +65,7 @@
 	return r;
 }
 
-void __exit dm_zero_exit(void)
+static void __exit dm_zero_exit(void)
 {
 	int r = dm_unregister_target(&zero_target);
 
--- linux-2.6.12-rc2-mm3-full/drivers/md/md.c.old	2005-04-19 00:50:02.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/md/md.c	2005-04-19 00:51:12.000000000 +0200
@@ -1046,7 +1046,7 @@
 }
 
 
-struct super_type super_types[] = {
+static struct super_type super_types[] = {
 	[0] = {
 		.name	= "0.90.0",
 		.owner	= THIS_MODULE,
@@ -2942,7 +2942,7 @@
 	.revalidate_disk= md_revalidate,
 };
 
-int md_thread(void * arg)
+static int md_thread(void * arg)
 {
 	mdk_thread_t *thread = arg;
 
@@ -3440,7 +3440,7 @@
 	}
 }
 
-DECLARE_WAIT_QUEUE_HEAD(resync_wait);
+static DECLARE_WAIT_QUEUE_HEAD(resync_wait);
 
 #define SYNC_MARKS	10
 #define	SYNC_MARK_STEP	(3*HZ)
@@ -3837,8 +3837,8 @@
 	}
 }
 
-int md_notify_reboot(struct notifier_block *this,
-					unsigned long code, void *x)
+static int md_notify_reboot(struct notifier_block *this,
+			    unsigned long code, void *x)
 {
 	struct list_head *tmp;
 	mddev_t *mddev;
@@ -3861,7 +3861,7 @@
 	return NOTIFY_DONE;
 }
 
-struct notifier_block md_notifier = {
+static struct notifier_block md_notifier = {
 	.notifier_call	= md_notify_reboot,
 	.next		= NULL,
 	.priority	= INT_MAX, /* before any real devices */
@@ -3878,7 +3878,7 @@
 		p->proc_fops = &md_seq_fops;
 }
 
-int __init md_init(void)
+static int __init md_init(void)
 {
 	int minor;
 
--- linux-2.6.12-rc2-mm3-full/drivers/md/multipath.c.old	2005-04-19 00:51:23.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/md/multipath.c	2005-04-19 00:51:36.000000000 +0200
@@ -103,7 +103,8 @@
 	mempool_free(mp_bh, conf->pool);
 }
 
-int multipath_end_request(struct bio *bio, unsigned int bytes_done, int error)
+static int multipath_end_request(struct bio *bio, unsigned int bytes_done,
+				 int error)
 {
 	int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
 	struct multipath_bh * mp_bh = (struct multipath_bh *)(bio->bi_private);


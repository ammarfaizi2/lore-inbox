Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264404AbUD0XU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264404AbUD0XU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbUD0XU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:20:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:56287 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264404AbUD0XUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:20:34 -0400
Date: Tue, 27 Apr 2004 16:22:41 -0700
From: Dave Olien <dmo@osdl.org>
To: thornber@redhat.com
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] trivial patch to dm-ioctl.c
Message-ID: <20040427232241.GA17471@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This path adds static declarations to functions, and adds an __exit
qualifier on dm_interface_exit().


diff -ur linux-2.6.6-rc2-udm1-original/drivers/md/dm-ioctl.c linux-2.6.6-rc2-udm1-patched/drivers/md/dm-ioctl.c
--- linux-2.6.6-rc2-udm1-original/drivers/md/dm-ioctl.c	2004-04-27 16:20:28.000000000 -0700
+++ linux-2.6.6-rc2-udm1-patched/drivers/md/dm-ioctl.c	2004-04-27 16:19:35.000000000 -0700
@@ -46,7 +46,7 @@
 static struct list_head _name_buckets[NUM_BUCKETS];
 static struct list_head _uuid_buckets[NUM_BUCKETS];
 
-void dm_hash_remove_all(void);
+static void dm_hash_remove_all(void);
 
 /*
  * Guards access to both hash tables.
@@ -61,7 +61,7 @@
 		INIT_LIST_HEAD(buckets + i);
 }
 
-int dm_hash_init(void)
+static int dm_hash_init(void)
 {
 	init_buckets(_name_buckets);
 	init_buckets(_uuid_buckets);
@@ -69,7 +69,7 @@
 	return 0;
 }
 
-void dm_hash_exit(void)
+static void dm_hash_exit(void)
 {
 	dm_hash_remove_all();
 	devfs_remove(DM_DIR);
@@ -195,7 +195,7 @@
  * The kdev_t and uuid of a device can never change once it is
  * initially inserted.
  */
-int dm_hash_insert(const char *name, const char *uuid, struct mapped_device *md)
+static int dm_hash_insert(const char *name, const char *uuid, struct mapped_device *md)
 {
 	struct hash_cell *cell;
 
@@ -234,7 +234,7 @@
 	return -EBUSY;
 }
 
-void __hash_remove(struct hash_cell *hc)
+static void __hash_remove(struct hash_cell *hc)
 {
 	/* remove from the dev hash */
 	list_del(&hc->uuid_list);
@@ -246,7 +246,7 @@
 	free_cell(hc);
 }
 
-void dm_hash_remove_all(void)
+static void dm_hash_remove_all(void)
 {
 	int i;
 	struct hash_cell *hc;
@@ -262,7 +262,7 @@
 	up_write(&_hash_lock);
 }
 
-int dm_hash_rename(const char *old, const char *new)
+static int dm_hash_rename(const char *old, const char *new)
 {
 	char *new_name, *old_name;
 	struct hash_cell *hc;
@@ -1338,7 +1338,7 @@
 	return 0;
 }
 
-void dm_interface_exit(void)
+void __exit dm_interface_exit(void)
 {
 	if (misc_deregister(&_dm_misc) < 0)
 		DMERR("misc_deregister failed for control device");

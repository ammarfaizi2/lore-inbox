Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbWJKQ3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbWJKQ3G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161117AbWJKQ3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:29:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53412 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161111AbWJKQ2s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:28:48 -0400
To: torvalds@osdl.org
Subject: [PATCH] z2_init() in non-modular case
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1GXgwp-0005hw-B1@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 17:28:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


... another victim - this time of 2.5.1-pre2

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/block/z2ram.c |   28 ++++++----------------------
 1 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 82ddbdd..7cc2685 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -329,7 +329,7 @@ static struct kobject *z2_find(dev_t dev
 
 static struct request_queue *z2_queue;
 
-int __init 
+static int __init 
 z2_init(void)
 {
     int ret;
@@ -370,26 +370,7 @@ err:
     return ret;
 }
 
-#if defined(MODULE)
-
-MODULE_LICENSE("GPL");
-
-int
-init_module( void )
-{
-    int error;
-    
-    error = z2_init();
-    if ( error == 0 )
-    {
-	printk( KERN_INFO DEVICE_NAME ": loaded as module\n" );
-    }
-    
-    return error;
-}
-
-void
-cleanup_module( void )
+static void __exit z2_exit(void)
 {
     int i, j;
     blk_unregister_region(MKDEV(Z2RAM_MAJOR, 0), 256);
@@ -425,4 +406,7 @@ cleanup_module( void )
 
     return;
 } 
-#endif
+
+module_init(z2_init);
+module_exit(z2_exit);
+MODULE_LICENSE("GPL");
-- 
1.4.2.GIT


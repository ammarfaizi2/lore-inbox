Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUD1CFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUD1CFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 22:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbUD1CFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 22:05:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:26072 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264600AbUD1CEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 22:04:47 -0400
Date: Tue, 27 Apr 2004 19:06:55 -0700
From: Dave Olien <dmo@osdl.org>
To: thornber@redhat.com
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] trival patch to dm.c and dm.h
Message-ID: <20040428020655.GA21775@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dm_blk_dops is made static, and add __exit to local_exit().  Modified
local_init() declaration to look more like other uses of __init.

diff -ur linux-2.6.6-rc2-udm1-original/drivers/md/dm.c linux-2.6.6-rc2-udm1-patched/drivers/md/dm.c
--- linux-2.6.6-rc2-udm1-original/drivers/md/dm.c	2004-04-27 19:04:42.000000000 -0700
+++ linux-2.6.6-rc2-udm1-patched/drivers/md/dm.c	2004-04-27 19:04:24.000000000 -0700
@@ -93,7 +93,7 @@
 static kmem_cache_t *_io_cache;
 static kmem_cache_t *_tio_cache;
 
-static __init int local_init(void)
+static int __init local_init(void)
 {
 	int r;
 
@@ -125,7 +125,7 @@
 	return 0;
 }
 
-static void local_exit(void)
+static void __exit local_exit(void)
 {
 	kmem_cache_destroy(_tio_cache);
 	kmem_cache_destroy(_io_cache);
@@ -663,6 +663,8 @@
 	return r;
 }
 
+static struct block_device_operations dm_blk_dops;
+
 /*
  * Allocate and initialise a blank device with a given minor.
  */
@@ -1100,7 +1102,7 @@
 	return test_bit(DMF_SUSPENDED, &md->flags);
 }
 
-struct block_device_operations dm_blk_dops = {
+static struct block_device_operations dm_blk_dops = {
 	.open = dm_blk_open,
 	.release = dm_blk_close,
 	.owner = THIS_MODULE
diff -ur linux-2.6.6-rc2-udm1-original/drivers/md/dm.h linux-2.6.6-rc2-udm1-patched/drivers/md/dm.h
--- linux-2.6.6-rc2-udm1-original/drivers/md/dm.h	2004-04-27 19:04:38.000000000 -0700
+++ linux-2.6.6-rc2-udm1-patched/drivers/md/dm.h	2004-04-27 19:04:27.000000000 -0700
@@ -31,8 +31,6 @@
 
 #define SECTOR_SHIFT 9
 
-extern struct block_device_operations dm_blk_dops;
-
 /*
  * List of devices that a metadevice uses and should open/close.
  */

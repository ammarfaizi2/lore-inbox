Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVASALQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVASALQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 19:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVASALP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 19:11:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:46220 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261496AbVASAK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 19:10:56 -0500
Date: Tue, 18 Jan 2005 16:09:36 -0800
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] AOE: fix up the block device registration so that it actually works now.
Message-ID: <20050119000935.GA22454@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed, I need the following patch against the latest -bk tree in order to
get the aoe code to load and work properly.  Does it look good to you?

thanks,

greg k-h

-------------

AOE: fix up the block device registration so that it actually works now.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
--- a/drivers/block/aoe/aoeblk.c	2005-01-18 16:06:57 -08:00
+++ b/drivers/block/aoe/aoeblk.c	2005-01-18 16:06:57 -08:00
@@ -249,6 +249,7 @@
 aoeblk_exit(void)
 {
 	kmem_cache_destroy(buf_pool_cache);
+	unregister_blkdev(AOE_MAJOR, DEVICE_NAME);
 }
 
 int __init
diff -Nru a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
--- a/drivers/block/aoe/aoemain.c	2005-01-18 16:06:57 -08:00
+++ b/drivers/block/aoe/aoemain.c	2005-01-18 16:06:57 -08:00
@@ -82,11 +82,6 @@
 	ret = aoenet_init();
 	if (ret)
 		goto net_fail;
-	ret = register_blkdev(AOE_MAJOR, DEVICE_NAME);
-	if (ret < 0) {
-		printk(KERN_ERR "aoe: aoeblk_init: can't register major\n");
-		goto blkreg_fail;
-	}
 
 	printk(KERN_INFO
 	       "aoe: aoe_init: AoE v2.6-%s initialised.\n",

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbUCKIaX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 03:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUCKIaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 03:30:23 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:37543 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S262892AbUCKIaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 03:30:16 -0500
Message-ID: <40502396.3030402@objectxp.com>
Date: Thu, 11 Mar 2004 09:30:14 +0100
From: Michel Marti <michel.marti@objectxp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5.1) Gecko/20031203
X-Accept-Language: en, de-ch
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.4: Fix NULL pointer dereference in blkmtd.c
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

The blkmtd driver oopses in add_device(). The following trivial patch fixes
this.

Cheers,

- Michel


diff -urN linux-2.6.4/drivers/mtd/devices/blkmtd.c linux-2.6.4-mma/drivers/mtd/devices/blkmtd.c
--- linux-2.6.4/drivers/mtd/devices/blkmtd.c	2004-02-18 04:57:13.000000000 +0100
+++ linux-2.6.4-mma/drivers/mtd/devices/blkmtd.c	2004-03-11 09:02:45.000000000 +0100
@@ -664,12 +664,12 @@
  	}

  	memset(dev, 0, sizeof(struct blkmtd_dev));
+	dev->blkdev = bdev;
  	atomic_set(&(dev->blkdev->bd_inode->i_mapping->truncate_count), 0);
  	if(!readonly) {
  		init_MUTEX(&dev->wrbuf_mutex);
  	}

-	dev->blkdev = bdev;
  	dev->mtd_info.size = dev->blkdev->bd_inode->i_size & PAGE_MASK;

  	/* Setup the MTD structure */


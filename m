Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbSKMWTG>; Wed, 13 Nov 2002 17:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbSKMWTG>; Wed, 13 Nov 2002 17:19:06 -0500
Received: from air-2.osdl.org ([65.172.181.6]:64384 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262692AbSKMWTE>;
	Wed, 13 Nov 2002 17:19:04 -0500
Date: Wed, 13 Nov 2002 14:25:54 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.47] Fix char/raw.c to build as module
Message-ID: <20021113222554.GA3336@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small fixes that lets the raw driver be built as a module.

diff -Nru a/drivers/char/raw.c b/drivers/char/raw.c
--- a/drivers/char/raw.c	Wed Nov 13 14:09:57 2002
+++ b/drivers/char/raw.c	Wed Nov 13 14:09:57 2002
@@ -103,7 +103,7 @@
 {
 	struct block_device *bdev = filp->private_data;
 
-	return blkdev_ioctl(bdev->bd_inode, NULL, command, arg);
+	return ioctl_by_bdev(bdev->bd_inode, command, arg);
 }
 
 /*
@@ -241,3 +241,4 @@
 
 module_init(raw_init);
 module_exit(raw_exit);
+MODULE_LICENSE("GPL");
 
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17

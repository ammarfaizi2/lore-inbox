Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266546AbSLPKBl>; Mon, 16 Dec 2002 05:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbSLPKBk>; Mon, 16 Dec 2002 05:01:40 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:49419 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266584AbSLPKAz>; Mon, 16 Dec 2002 05:00:55 -0500
Date: Mon, 16 Dec 2002 10:09:01 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 5/19
Message-ID: <20021216100901.GF7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check_device_area was comparing the bytes with sectors.
[Stefan Lauterbach]
--- diff/drivers/md/dm-table.c	2002-12-16 09:40:34.000000000 +0000
+++ source/drivers/md/dm-table.c	2002-12-16 09:40:44.000000000 +0000
@@ -388,7 +388,7 @@
 static int check_device_area(struct dm_dev *dd, sector_t start, sector_t len)
 {
 	sector_t dev_size;
-	dev_size = dd->bdev->bd_inode->i_size;
+	dev_size = dd->bdev->bd_inode->i_size >> SECTOR_SHIFT;
 	return ((start < dev_size) && (len <= (dev_size - start)));
 }
 
--- diff/drivers/md/dm.c	2002-11-28 11:30:39.000000000 +0000
+++ source/drivers/md/dm.c	2002-12-16 09:40:44.000000000 +0000
@@ -16,7 +16,6 @@
 
 static const char *_name = DM_NAME;
 #define MAX_DEVICES (1 << KDEV_MINOR_BITS)
-#define SECTOR_SHIFT 9
 
 static int major = 0;
 static int _major = 0;
--- diff/drivers/md/dm.h	2002-11-18 10:11:54.000000000 +0000
+++ source/drivers/md/dm.h	2002-12-16 09:40:44.000000000 +0000
@@ -29,6 +29,8 @@
 #define SECTOR_FORMAT "%lu"
 #endif
 
+#define SECTOR_SHIFT 9
+
 extern struct block_device_operations dm_blk_dops;
 
 /*

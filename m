Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315379AbSGEFEK>; Fri, 5 Jul 2002 01:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSGEFEJ>; Fri, 5 Jul 2002 01:04:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52128 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315379AbSGEFEH>;
	Fri, 5 Jul 2002 01:04:07 -0400
Date: Fri, 5 Jul 2002 01:06:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] raid kdev_t cleanups - part 3
Message-ID: <Pine.GSO.4.21.0207050105160.14718-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* ->dev killed for md/linear.c (same as previous parts)

diff -urN C24-0/drivers/md/linear.c C24-current/drivers/md/linear.c
--- C24-0/drivers/md/linear.c	Thu Jun 20 13:37:24 2002
+++ C24-current/drivers/md/linear.c	Sat Jun 29 17:05:33 2002
@@ -60,7 +60,6 @@
 			goto out;
 		}
 
-		disk->dev = rdev->dev;
 		disk->bdev = rdev->bdev;
 		atomic_inc(&rdev->bdev->bd_count);
 		disk->size = rdev->size;
@@ -163,7 +162,7 @@
     
 	if (block >= (tmp_dev->size + tmp_dev->offset)
 				|| block < tmp_dev->offset) {
-		printk ("linear_make_request: Block %ld out of bounds on dev %s size %ld offset %ld\n", block, kdevname(tmp_dev->dev), tmp_dev->size, tmp_dev->offset);
+		printk ("linear_make_request: Block %ld out of bounds on dev %s size %ld offset %ld\n", block, bdevname(tmp_dev->bdev), tmp_dev->size, tmp_dev->offset);
 		bio_io_error(bio);
 		return 0;
 	}
@@ -186,11 +185,11 @@
 	for (j = 0; j < conf->nr_zones; j++)
 	{
 		sz += sprintf(page+sz, "[%s",
-			partition_name(conf->hash_table[j].dev0->dev));
+			bdev_partition_name(conf->hash_table[j].dev0->bdev));
 
 		if (conf->hash_table[j].dev1)
 			sz += sprintf(page+sz, "/%s] ",
-			  partition_name(conf->hash_table[j].dev1->dev));
+			  bdev_partition_name(conf->hash_table[j].dev1->bdev));
 		else
 			sz += sprintf(page+sz, "] ");
 	}
diff -urN C24-0/include/linux/raid/linear.h C24-current/include/linux/raid/linear.h
--- C24-0/include/linux/raid/linear.h	Mon Apr 29 08:06:41 2002
+++ C24-current/include/linux/raid/linear.h	Sat Jun 29 17:05:39 2002
@@ -4,7 +4,6 @@
 #include <linux/raid/md.h>
 
 struct dev_info {
-	kdev_t		dev;
 	struct block_device *bdev;
 	unsigned long	size;
 	unsigned long	offset;


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288554AbSADJII>; Fri, 4 Jan 2002 04:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSADJH7>; Fri, 4 Jan 2002 04:07:59 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:48837 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S288554AbSADJHp>; Fri, 4 Jan 2002 04:07:45 -0500
Date: Fri, 4 Jan 2002 01:07:43 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: PATCH: linux-2.5.2-pre7/drivers/block/nbd.c
Message-ID: <20020104010743.A14809@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	kdev_t compilation fixes for linux-2.5.2-pre7/drivers/block/nbd.c.
I only know that it compiles at this point.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nbd.diffs"

--- linux-2.5.2-pre7/drivers/block/nbd.c	Thu Jan  3 19:52:01 2002
+++ linux/drivers/block/nbd.c	Fri Jan  4 01:05:49 2002
@@ -78,7 +78,7 @@
 
 	if (!inode)
 		return -EINVAL;
-	dev = MINOR(inode->i_rdev);
+	dev = minor(inode->i_rdev);
 	if (dev >= MAX_NBD)
 		return -ENODEV;
 
@@ -253,7 +253,7 @@
 		if (req != blkdev_entry_prev_request(&lo->queue_head)) {
 			printk(KERN_ALERT "NBD: I have problem...\n");
 		}
-		if (lo != &nbd_dev[MINOR(req->rq_dev)]) {
+		if (lo != &nbd_dev[minor(req->rq_dev)]) {
 			printk(KERN_ALERT "NBD: request corrupted!\n");
 			continue;
 		}
@@ -291,7 +291,7 @@
 			printk( KERN_ALERT "NBD: panic, panic, panic\n" );
 			break;
 		}
-		if (lo != &nbd_dev[MINOR(req->rq_dev)]) {
+		if (lo != &nbd_dev[minor(req->rq_dev)]) {
 			printk(KERN_ALERT "NBD: request corrupted when clearing!\n");
 			continue;
 		}
@@ -328,7 +328,7 @@
 		if (!req)
 			FAIL("que not empty but no request?");
 #endif
-		dev = MINOR(req->rq_dev);
+		dev = minor(req->rq_dev);
 #ifdef PARANOIA
 		if (dev >= MAX_NBD)
 			FAIL("Minor too big.");		/* Probably can not happen */
@@ -381,7 +381,7 @@
 		return -EPERM;
 	if (!inode)
 		return -EINVAL;
-	dev = MINOR(inode->i_rdev);
+	dev = minor(inode->i_rdev);
 	if (dev >= MAX_NBD)
 		return -ENODEV;
 
@@ -473,7 +473,7 @@
 
 	if (!inode)
 		return -ENODEV;
-	dev = MINOR(inode->i_rdev);
+	dev = minor(inode->i_rdev);
 	if (dev >= MAX_NBD)
 		return -ENODEV;
 	lo = &nbd_dev[dev];
@@ -528,7 +528,7 @@
 		nbd_blksize_bits[i] = 10;
 		nbd_bytesizes[i] = 0x7ffffc00; /* 2GB */
 		nbd_sizes[i] = nbd_bytesizes[i] >> BLOCK_SIZE_BITS;
-		register_disk(NULL, MKDEV(MAJOR_NR,i), 1, &nbd_fops,
+		register_disk(NULL, mk_kdev(MAJOR_NR,i), 1, &nbd_fops,
 				nbd_bytesizes[i]>>9);
 	}
 	devfs_handle = devfs_mk_dir (NULL, "nbd", NULL);

--82I3+IH0IqGh5yIs--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287511AbSAEIOO>; Sat, 5 Jan 2002 03:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSAEIOF>; Sat, 5 Jan 2002 03:14:05 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:51932 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S287511AbSAEIOB>; Sat, 5 Jan 2002 03:14:01 -0500
Date: Sat, 5 Jan 2002 00:13:59 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: mingo@redhat.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Patch: linux-2.5.2-pre8/drivers/md/raid1.c kdev_t compilation fixes
Message-ID: <20020105001359.A20912@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	kdev_t compilation fixes for linux-2.5.2-pre8/drivers/md/raid1.c.
I have not tested it beyond seeing that it compiles.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="raid1.diff"

--- linux-2.5.2-pre8/drivers/md/raid1.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/md/raid1.c	Sat Jan  5 00:10:46 2002
@@ -611,7 +611,7 @@
 	 * else mark the drive as failed
 	 */
 	for (i = 0; i < disks; i++)
-		if (mirrors[i].dev == dev && mirrors[i].operational)
+		if (kdev_same(mirrors[i].dev, dev) && mirrors[i].operational)
 			break;
 	if (i == disks)
 		return 0;
@@ -853,7 +853,7 @@
 
 		*d = failed_desc;
 
-		if (sdisk->dev == MKDEV(0,0))
+		if (kdev_none(sdisk->dev))
 			sdisk->used_slot = 0;
 		/*
 		 * this really activates the spare.
@@ -879,7 +879,7 @@
 			err = 1;
 			goto abort;
 		}
-		rdisk->dev = MKDEV(0,0);
+		rdisk->dev = mk_kdev(0,0);
 		rdisk->used_slot = 0;
 		conf->nr_disks--;
 		break;
@@ -896,7 +896,7 @@
 
 		adisk->number = added_desc->number;
 		adisk->raid_disk = added_desc->raid_disk;
-		adisk->dev = MKDEV(added_desc->major, added_desc->minor);
+		adisk->dev = mk_kdev(added_desc->major, added_desc->minor);
 
 		adisk->operational = 0;
 		adisk->write_only = 0;
@@ -1098,7 +1098,7 @@
 		case READA:
 			dev = bio->bi_dev;
 			map(mddev, &bio->bi_dev);
-			if (bio->bi_dev == dev) {
+			if (kdev_same(bio->bi_dev, dev)) {
 				printk(IO_ERROR, partition_name(bio->bi_dev), r1_bio->sector);
 				raid_end_bio_io(r1_bio, 0, 0);
 				break;
@@ -1428,7 +1428,7 @@
 
 			disk->number = descriptor->number;
 			disk->raid_disk = disk_idx;
-			disk->dev = MKDEV(0,0);
+			disk->dev = mk_kdev(0,0);
 
 			disk->operational = 0;
 			disk->write_only = 0;

--CE+1k2dSO48ffgeK--

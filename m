Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284979AbRLKLpz>; Tue, 11 Dec 2001 06:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284989AbRLKLpq>; Tue, 11 Dec 2001 06:45:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59396 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284979AbRLKLph>;
	Tue, 11 Dec 2001 06:45:37 -0500
Date: Tue, 11 Dec 2001 12:45:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Bas Vermeulen <bvermeul@blackstar.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre8 oopses on non existing acorn partition
Message-ID: <20011211114531.GP13498@suse.de>
In-Reply-To: <Pine.LNX.4.33.0112110910350.1461-100000@laptop.blackstar.nl> <20011211112509.GO13498@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <20011211112509.GO13498@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11 2001, Jens Axboe wrote:
> On Tue, Dec 11 2001, Bas Vermeulen wrote:
> > 2.5.1-pre8 oopses in adfspart_check_ICS (probably the put_dev_sector, 
> > not entirely sure, since there doesn't seem to be anything wrong).
> > I've enabled advanced partitions, and all the partition types.
> > Disabling advanced partitions fixes it.
> 
> Please try attached patch.

Updated version, needs pagemap as well. Actually, it's the 2nd time this
bit us in 2.5 now.

-- 
Jens Axboe


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=acorn-part-2

--- /opt/kernel/linux-2.5.1-pre9/fs/partitions/acorn.c	Mon Oct  1 23:03:26 2001
+++ fs/partitions/acorn.c	Tue Dec 11 06:39:47 2001
@@ -162,12 +162,12 @@
 		struct adfs_discrecord *dr;
 		unsigned int nr_sects;
 
-		if (!(minor & mask))
-			break;
-
 		data = read_dev_sector(bdev, start_blk * 2 + 6, &sect);
 		if (!data)
 			return -1;
+
+		if (!(minor & mask))
+			break;
 
 		dr = adfs_partition(hd, name, data, first_sector, minor++);
 		if (!dr)
--- /opt/kernel/linux-2.5.1-pre9/fs/partitions/check.h	Tue Dec 11 05:01:51 2001
+++ fs/partitions/check.h	Tue Dec 11 06:43:31 2001
@@ -1,3 +1,5 @@
+#include <linux/pagemap.h>
+
 /*
  * add_gd_partition adds a partitions details to the devices partition
  * description.

--aVD9QWMuhilNxW9f--

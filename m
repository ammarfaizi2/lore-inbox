Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284969AbRLKLZ3>; Tue, 11 Dec 2001 06:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284970AbRLKLZU>; Tue, 11 Dec 2001 06:25:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:3332 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284969AbRLKLZQ>;
	Tue, 11 Dec 2001 06:25:16 -0500
Date: Tue, 11 Dec 2001 12:25:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Bas Vermeulen <bvermeul@blackstar.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre8 oopses on non existing acorn partition
Message-ID: <20011211112509.GO13498@suse.de>
In-Reply-To: <Pine.LNX.4.33.0112110910350.1461-100000@laptop.blackstar.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112110910350.1461-100000@laptop.blackstar.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11 2001, Bas Vermeulen wrote:
> 2.5.1-pre8 oopses in adfspart_check_ICS (probably the put_dev_sector, 
> not entirely sure, since there doesn't seem to be anything wrong).
> I've enabled advanced partitions, and all the partition types.
> Disabling advanced partitions fixes it.

Please try attached patch.

-- 
Jens Axboe


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=acorn-part-1

--- /opt/kernel/linux-2.5.1-pre9/fs/partitions/acorn.c	Mon Oct  1 23:03:26 2001
+++ fs/partitions/acorn.c	Tue Dec 11 06:21:54 2001
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

--k1lZvvs/B4yU6o8G--

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314232AbSEFHDG>; Mon, 6 May 2002 03:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314238AbSEFHDF>; Mon, 6 May 2002 03:03:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:36046 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314232AbSEFHDE>;
	Mon, 6 May 2002 03:03:04 -0400
Date: Mon, 6 May 2002 03:03:04 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rd.c blocksize fix
Message-ID: <Pine.GSO.4.21.0205060300250.29064-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(fallout from blksize_size[] removal)

rd.c depends on exact value of blocksize being set from the very
beginning.

--- drivers/block/rd.c	Fri May  3 03:26:05 2002
+++ /tmp/rd.c	Mon May  6 03:00:00 2002
@@ -376,6 +376,7 @@
 		rd_bdev[unit] = bdget(kdev_t_to_nr(inode->i_rdev));
 		rd_bdev[unit]->bd_openers++;
 		rd_bdev[unit]->bd_inode->i_mapping->a_ops = &ramdisk_aops;
+		rd_bdev[unit]->bd_block_size = rd_blocksize;
 	}
 
 	return 0;


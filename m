Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282979AbRLQW2H>; Mon, 17 Dec 2001 17:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282988AbRLQW15>; Mon, 17 Dec 2001 17:27:57 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:29348 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282979AbRLQW1v>;
	Mon, 17 Dec 2001 17:27:51 -0500
Date: Mon, 17 Dec 2001 17:27:45 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Carl Scarfoglio <scarfoglio@arpacoop.it>, linux-kernel@vger.kernel.org
Subject: [FIX] Re: 2.5.1 - Cannot mount Hpfs partitions, cdroms, shutdown
In-Reply-To: <3C1E6462.8060304@arpacoop.it>
Message-ID: <Pine.GSO.4.21.0112171726380.5688-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Please, apply.  That should fix the things for hpfs.  Cdroms
are a different story - apparently started earlier.

diff -urN C1/fs/hpfs/super.c C1-hpfs/fs/hpfs/super.c
--- C1/fs/hpfs/super.c	Thu Oct 25 03:02:26 2001
+++ C1-hpfs/fs/hpfs/super.c	Mon Dec 17 17:18:05 2001
@@ -410,6 +410,8 @@
 	/*s->s_hpfs_mounting = 1;*/
 	dev = s->s_dev;
 	set_blocksize(dev, 512);
+	s->s_blocksize = 512;
+	s->s_blocksize_bits = 9;
 	s->s_hpfs_fs_size = -1;
 	if (!(bootblock = hpfs_map_sector(s, 0, &bh0, 0))) goto bail1;
 	if (!(superblock = hpfs_map_sector(s, 16, &bh1, 1))) goto bail2;
@@ -436,8 +438,6 @@
 
 	/* Fill superblock stuff */
 	s->s_magic = HPFS_SUPER_MAGIC;
-	s->s_blocksize = 512;
-	s->s_blocksize_bits = 9;
 	s->s_op = &hpfs_sops;
 
 	s->s_hpfs_root = superblock->root;



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162944AbWLBLOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162944AbWLBLOX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162960AbWLBLOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:14:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:63257 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1162944AbWLBLOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:14:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Dsfuru1MzwNa1TUvfQJ4ZhIvVrqtKAYc8YBRGnROScxjLVNs+yABpVg4priw/2jQL8quzzHk4MGvtfdzhDgp+pmaM+jZ+PDOTp/QPwA+d4SRg/6YP8g2F3HpL1TqkITFMyU8hrsoRjrhrkck04NAKpEvfAkFw9MgpzSqXO2F8+o=
Subject: [PATCH 2.6.19] affs: replace kmalloc+memset with kzalloc
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, zippel@linux-m68k.org
Content-Type: text/plain
Date: Sat, 02 Dec 2006 13:13:31 +0200
Message-Id: <1165058011.4523.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kzalloc

Signed-off-by: Yan Burman <burman.yan@gmail.com>	

diff -rubp linux-2.6.19-rc5_orig/fs/affs/bitmap.c linux-2.6.19-rc5_kzalloc/fs/affs/bitmap.c
--- linux-2.6.19-rc5_orig/fs/affs/bitmap.c	2006-11-09 12:16:20.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/fs/affs/bitmap.c	2006-11-11 22:44:04.000000000 +0200
@@ -289,12 +289,11 @@ int affs_init_bitmap(struct super_block 
 	sbi->s_bmap_count = (sbi->s_partition_size - sbi->s_reserved +
 				 sbi->s_bmap_bits - 1) / sbi->s_bmap_bits;
 	size = sbi->s_bmap_count * sizeof(*bm);
-	bm = sbi->s_bitmap = kmalloc(size, GFP_KERNEL);
+	bm = sbi->s_bitmap = kzalloc(size, GFP_KERNEL);
 	if (!sbi->s_bitmap) {
 		printk(KERN_ERR "AFFS: Bitmap allocation failed\n");
 		return -ENOMEM;
 	}
-	memset(sbi->s_bitmap, 0, size);
 
 	bmap_blk = (__be32 *)sbi->s_root_bh->b_data;
 	blk = sb->s_blocksize / 4 - 49;
diff -rubp linux-2.6.19-rc5_orig/fs/afs/server.c linux-2.6.19-rc5_kzalloc/fs/afs/server.c
--- linux-2.6.19-rc5_orig/fs/afs/server.c	2006-11-09 12:16:20.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/fs/afs/server.c	2006-11-11 22:44:04.000000000 +0200
@@ -55,13 +55,12 @@ int afs_server_lookup(struct afs_cell *c
 	_enter("%p,%08x,", cell, ntohl(addr->s_addr));
 
 	/* allocate and initialise a server record */
-	server = kmalloc(sizeof(struct afs_server), GFP_KERNEL);
+	server = kzalloc(sizeof(struct afs_server), GFP_KERNEL);
 	if (!server) {
 		_leave(" = -ENOMEM");
 		return -ENOMEM;
 	}
 
-	memset(server, 0, sizeof(struct afs_server));
 	atomic_set(&server->usage, 1);
 
 	INIT_LIST_HEAD(&server->link);
diff -rubp linux-2.6.19-rc5_orig/fs/afs/super.c linux-2.6.19-rc5_kzalloc/fs/afs/super.c
--- linux-2.6.19-rc5_orig/fs/afs/super.c	2006-11-09 12:16:20.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/fs/afs/super.c	2006-11-11 22:44:04.000000000 +0200
@@ -242,14 +242,12 @@ static int afs_fill_super(struct super_b
 	kenter("");
 
 	/* allocate a superblock info record */
-	as = kmalloc(sizeof(struct afs_super_info), GFP_KERNEL);
+	as = kzalloc(sizeof(struct afs_super_info), GFP_KERNEL);
 	if (!as) {
 		_leave(" = -ENOMEM");
 		return -ENOMEM;
 	}
 
-	memset(as, 0, sizeof(struct afs_super_info));
-
 	afs_get_volume(params->volume);
 	as->volume = params->volume;
 





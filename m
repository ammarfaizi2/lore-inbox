Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264864AbSJOVMg>; Tue, 15 Oct 2002 17:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264849AbSJOVL2>; Tue, 15 Oct 2002 17:11:28 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:17186 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S264828AbSJOVKK>; Tue, 15 Oct 2002 17:10:10 -0400
Date: Tue, 15 Oct 2002 22:16:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Jari Ruusu <jari.ruusu@pp.inet.fi>, "Adam J. Richter" <adam@yggdrasil.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] loop allow highmem
Message-ID: <Pine.LNX.4.44.0210152213450.1521-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The loop driver forces the underlying inode's gfp_mask to GFP_NOIO.
But its own code seems fully kmapped, and if the underlying filesystem
says it can handle __GFP_HIGHMEM in its gfp_mask, why limit it?

--- 2.5.42-mm3/drivers/block/loop.c	Sat Oct 12 08:25:59 2002
+++ linux/drivers/block/loop.c	Tue Oct 15 13:14:34 2002
@@ -715,7 +715,7 @@
 		goto out_putf;
 	}
 	lo->old_gfp_mask = inode->i_mapping->gfp_mask;
-	inode->i_mapping->gfp_mask = GFP_NOIO;
+	inode->i_mapping->gfp_mask &= ~(__GFP_IO|__GFP_HIGHIO|__GFP_FS);
 
 	set_blocksize(bdev, block_size(lo_device));
 


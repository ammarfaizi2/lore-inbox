Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313273AbSC1WrN>; Thu, 28 Mar 2002 17:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313272AbSC1WrD>; Thu, 28 Mar 2002 17:47:03 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:38537 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S313271AbSC1Wqp>; Thu, 28 Mar 2002 17:46:45 -0500
Message-ID: <3CA39D1A.4050106@didntduck.org>
Date: Thu, 28 Mar 2002 17:45:46 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, davej@suse.de
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <3CA2C68E.5B8C4176@zip.com.au>
Content-Type: multipart/mixed;
 boundary="------------070004080607050603040801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070004080607050603040801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> In 2.5.7 there is a thinko in the allocation and initialisation
> of the fs-private superblock for ext2.  It's passing the wrong type
> to the sizeof operator (which of course gives the wrong size)
> when allocating and clearing the memory. 

Same bug with bfs patch (only in -dj tree so far).

-- 

						Brian Gerst

--------------070004080607050603040801
Content-Type: text/plain;
 name="sb-bfs-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-bfs-2"

diff -urN linux-2.5.7-dj2/fs/bfs/inode.c linux/fs/bfs/inode.c
--- linux-2.5.7-dj2/fs/bfs/inode.c	Thu Mar 28 16:34:37 2002
+++ linux/fs/bfs/inode.c	Thu Mar 28 16:35:43 2002
@@ -292,11 +292,11 @@
 	int i, imap_len;
 	struct bfs_sb_info * info;
 
-	info = kmalloc(sizeof(struct bfs_super_block), GFP_KERNEL);
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 	s->u.generic_sbp = info;
-	memset(info, 0, sizeof(struct bfs_super_block));
+	memset(info, 0, sizeof(*info));
 
 	sb_set_blocksize(s, BFS_BSIZE);
 

--------------070004080607050603040801--


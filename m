Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131014AbQLECOu>; Mon, 4 Dec 2000 21:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131033AbQLECOl>; Mon, 4 Dec 2000 21:14:41 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:50605 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131014AbQLECOd>; Mon, 4 Dec 2000 21:14:33 -0500
Message-ID: <3A2C493C.4A321797@uow.edu.au>
Date: Tue, 05 Dec 2000 12:47:40 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] inode dirty blocks
In-Reply-To: <3A2B9B39.AA240475@uow.edu.au> <Pine.GSO.4.21.0012040843490.5153-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
>         OK, guys, I think I've got it:

Yes, you have.

Two machines, four hours, zero failures.

This is with

	- test12-pre4
	- aviro bforget patch 
	- UnlockPage() removed from vmscan.c:623
	- and


--- linux-2.4.0-test12-pre4/fs/ext2/inode.c	Mon Dec  4 21:07:12 2000
+++ linux-akpm/fs/ext2/inode.c	Tue Dec  5 08:46:38 2000
@@ -1208,7 +1208,7 @@
 		raw_inode->i_block[0] = cpu_to_le32(kdev_t_to_nr(inode->i_rdev));
 	else for (block = 0; block < EXT2_N_BLOCKS; block++)
 		raw_inode->i_block[block] = inode->u.ext2_i.i_data[block];
-	mark_buffer_dirty_inode(bh, inode);
+	mark_buffer_dirty(bh);
 	if (do_sync) {
 		ll_rw_block (WRITE, 1, &bh);
 		wait_on_buffer (bh);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

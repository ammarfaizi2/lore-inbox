Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129640AbQLDOUJ>; Mon, 4 Dec 2000 09:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129638AbQLDOUA>; Mon, 4 Dec 2000 09:20:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28558 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129640AbQLDOTv>;
	Mon, 4 Dec 2000 09:19:51 -0500
Date: Mon, 4 Dec 2000 08:49:23 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] inode dirty blocks
In-Reply-To: <3A2B9B39.AA240475@uow.edu.au>
Message-ID: <Pine.GSO.4.21.0012040843490.5153-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	OK, guys, I think I've got it:

static int ext2_update_inode(struct inode * inode, int do_sync)
{
	...
	mark_buffer_dirty_inode(bh, inode);
	...
}

Yes, that's right. bh of piece of inode table is put on inode's list.
Fix: in ext2/inode.c 1211s/mark_buffer_dirty_inode/mark_buffer_dirty/

HTH,
	Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

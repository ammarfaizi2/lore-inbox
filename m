Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131444AbQKRWZs>; Sat, 18 Nov 2000 17:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131450AbQKRWZh>; Sat, 18 Nov 2000 17:25:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:50101 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131444AbQKRWZY>;
	Sat, 18 Nov 2000 17:25:24 -0500
Date: Sat, 18 Nov 2000 16:55:23 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 largefile fixes + [f]truncate() error value fix
In-Reply-To: <20001118194058.C24555@athlon.random>
Message-ID: <Pine.GSO.4.21.0011181643420.21893-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Nov 2000, Andrea Arcangeli wrote:

[2.2 variant]

RLIMIT_FSIZE stuff - vmtruncate().
size < 0 - caller.
size > ... - ext2_notify_change().
> 		if (size >> 33) {
                       ITYM 32 
> 			struct super_block *sb = inode->i_sb;
> 			struct ext2_super_block *es = sb->u.ext2_sb.s_es;
> 			if (!(es->s_feature_ro_compat &
> 			      cpu_to_le32(EXT2_FEATURE_RO_COMPAT_LARGE_FILE))){
> 				/* If this is the first large file
> 				 * created, add a flag to the superblock */
> 				es->s_feature_ro_compat |=
> 				cpu_to_le32(EXT2_FEATURE_RO_COMPAT_LARGE_FILE);
> 				mark_buffer_dirty(sb->u.ext2_sb.s_sbh, 1);
> 			}
> 		}
 
... and that one - in ext2_update_inode().

> and btw the large file feature setting seems missing also from write(2) ext2
> in 2.4.x, confirm?

NAK. You do such write(), you end up doing ext2_update_inode().

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

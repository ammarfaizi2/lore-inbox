Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282379AbRKXG6l>; Sat, 24 Nov 2001 01:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282380AbRKXG6d>; Sat, 24 Nov 2001 01:58:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:63964 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282379AbRKXG6T>;
	Sat, 24 Nov 2001 01:58:19 -0500
Date: Sat, 24 Nov 2001 01:58:16 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <20011124075045.B1601@athlon.random>
Message-ID: <Pine.GSO.4.21.0111240152110.4000-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Nov 2001, Andrea Arcangeli wrote:

> and it's slower and overlay complex compared to the right fix:
 
> --- 2.4.15aa1/fs/ext2/super.c.~1~	Fri Nov 23 08:21:00 2001
> +++ 2.4.15aa1/fs/ext2/super.c	Sat Nov 24 07:50:19 2001
> @@ -643,6 +643,7 @@
>  			printk(KERN_ERR "EXT2-fs: corrupt root inode, run e2fsck\n");
>  		} else
>  			printk(KERN_ERR "EXT2-fs: get root inode failed\n");
> +		invalidate_inodes(sb);
>  		goto failed_mount2;
>  	}
>  	ext2_setup_super (sb, es, sb->s_flags & MS_RDONLY);


	It also fixes the problem for good for all filesystems.  As
for the speed - see previous posting.  It _is_ noise.  Comparison
with zero, test bit and two not taken branches.  In final iput().

	Seriously, check what else happens on that path.


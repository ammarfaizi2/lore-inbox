Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318265AbSHKHxM>; Sun, 11 Aug 2002 03:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318266AbSHKHxL>; Sun, 11 Aug 2002 03:53:11 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:55538 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318265AbSHKHxL>;
	Sun, 11 Aug 2002 03:53:11 -0400
Date: Sun, 11 Aug 2002 03:56:57 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/21] random fixes
In-Reply-To: <3D56146B.C3CAB5E1@zip.com.au>
Message-ID: <Pine.GSO.4.21.0208110352520.12398-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Aug 2002, Andrew Morton wrote:

>  	flush_dcache_page(page);
> --- 2.5.31/fs/block_dev.c~misc	Sat Aug 10 23:23:35 2002
> +++ 2.5.31-akpm/fs/block_dev.c	Sat Aug 10 23:23:35 2002
> @@ -26,12 +26,12 @@
>  
>  static sector_t max_block(struct block_device *bdev)
>  {
> -	sector_t retval = ~0U;
> +	sector_t retval = ~((sector_t)0);
>  	loff_t sz = bdev->bd_inode->i_size;
>  
>  	if (sz) {
> -		sector_t size = block_size(bdev);
> -		unsigned sizebits = blksize_bits(size);
> +		unsigned int size = block_size(bdev);
> +		unsigned int sizebits = blksize_bits(size);
>  		retval = (sz >> sizebits);

Ugh.  Why do we have all that stuff, anyway?

	bdev->bd_inode->i_size >> bdev->bd_inode->i_blkbits

should work just fine...


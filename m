Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316650AbSFFBWo>; Wed, 5 Jun 2002 21:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSFFBWn>; Wed, 5 Jun 2002 21:22:43 -0400
Received: from h-64-105-34-84.SNVACAID.covad.net ([64.105.34.84]:25036 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316666AbSFFBWN>; Wed, 5 Jun 2002 21:22:13 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 5 Jun 2002 18:22:08 -0700
Message-Id: <200206060122.SAA00693@adam.yggdrasil.com>
To: colpatch@us.ibm.com
Subject: Re: Patch??: linux-2.5.20/fs/bio.c - ll_rw_kio could generate bio's bigger than queue could handle
Cc: akpm@zip.com.au, axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I am cc'ing lkml, Andrew and Jens on this one, because I believe it
is probably a real world example of the oversized bio problem that I
was describing, although from fs/mpage.c, as Andrew Moreton
suggested.]

>Adam,
>	I have been experiencing kernel panic's due to the BUG_ON that checks the 
>bio size vs the queue size in generic_make_request (ll_rw_blk.c).  I 
>tried your patch, but it didn't fix the panic.  Below is the output of 
>putting:
>		printk("***generic_make_request: bio_sectors(bio) = %d, q->max_sectors = 
>%d\n", bio_sectors(bio), q->max_sectors);

>the line before the bug on in generic_make_request.  I've also attached 
>the output of ksymoops on the oops.  I don't know if you're interested 
>in pursing it or not, but let me know if you want some more information, 
>otherwise, I'll be attempting to slug through this on my own.

>Cheers!

[...]
>***generic_make_request: bio_sectors(bio) = 8, q->max_sectors = 64
>***generic_make_request: bio_sectors(bio) = 96, q->max_sectors = 64
>kernel BUG at ll_rw_blk.c:1602!
[...]
>>>EIP; c01bb604 <generic_make_request+d4/130>   <=====
>Trace; c01bb6dc <submit_bio+5c/70>
>Trace; c0152aa1 <mpage_bio_submit+31/40>
>Trace; c0152dee <do_mpage_readpage+2ee/340>
>Trace; c019ae75 <radix_tree_insert+15/30>
>Trace; c012809e <__add_to_page_cache+1e/a0>
>Trace; c01281bd <add_to_page_cache_unique+3d/60>
>Trace; c0152eaa <mpage_readpages+6a/b0>
>Trace; c01620a0 <ext2_get_block+0/400>
[...]

	I think your kernel panic is proably related to the
same problem that I addressed in ll_rw_kio, but, in fs/mpage.c
as Andrew Moreton suggested:

| Does this not also need to be done in fs/mpage.c? [...]


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

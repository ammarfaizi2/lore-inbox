Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317347AbSIATMV>; Sun, 1 Sep 2002 15:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSIATMV>; Sun, 1 Sep 2002 15:12:21 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:13032 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S317347AbSIATMU>;
	Sun, 1 Sep 2002 15:12:20 -0400
Date: Sun, 1 Sep 2002 21:16:49 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200209011916.VAA18956@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: Re: 2.5.33-bk testing
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Sep 2002 11:03:44 -0700 (PDT), Linus Torvalds wrote:
>On Sun, 1 Sep 2002, Mikael Pettersson wrote:
>> 
>> The patch below is an update of the floppy workarounds patch
>> I've been maintaining since the problems began in 2.5.13.
>> With this patch I'm able to reliably read and write to the
>> raw /dev/fd0 device. I'm not suggesting that my hack to
>> bdev->bd_block_size is the correct fix, but maybe someone who
>> understands the block I/O system can see what's going on and
>> do a proper fix.
>
>It looks like what your fix does is to force a 512-byte blocksize on the 
>floppy.
>
>Which implies to me that the floppy driver is broken for other blocksizes.

I did not test other block sizes. I just tested with the hardsect size
and noticed that that combo worked.

>Does your patch still leave the floppy driver broken for something like a 
>mounted minix or ext2 filesystem? Those have 1kB blocksizes, and will set 
>it to that. If the non-512B blocksize in the floppy driver is broken, then 
>such mounted filesystems should not work reliably either.

In kernels 2.5.13--2.5.32, it was always the case that with my hack,
a mounted ext2 would seem to work for a while and then break down,
e.g. when unmounted and fsck:d. I haven't checked 2.5.33.

Also, attempts to put lilo on ext2 on /dev/fd0 would throw the
kernel into an infinite stream of "buffer layer error!" from
buffer.c:__find_get_block_slow().

/Mikael

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSIARvg>; Sun, 1 Sep 2002 13:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317302AbSIARvg>; Sun, 1 Sep 2002 13:51:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3078 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317299AbSIARvg>; Sun, 1 Sep 2002 13:51:36 -0400
Date: Sun, 1 Sep 2002 11:03:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.33-bk testing
In-Reply-To: <200209011159.NAA15370@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0209011057190.12138-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 1 Sep 2002, Mikael Pettersson wrote:
> 
> The patch below is an update of the floppy workarounds patch
> I've been maintaining since the problems began in 2.5.13.
> With this patch I'm able to reliably read and write to the
> raw /dev/fd0 device. I'm not suggesting that my hack to
> bdev->bd_block_size is the correct fix, but maybe someone who
> understands the block I/O system can see what's going on and
> do a proper fix.

It looks like what your fix does is to force a 512-byte blocksize on the 
floppy.

Which implies to me that the floppy driver is broken for other blocksizes.

Does your patch still leave the floppy driver broken for something like a 
mounted minix or ext2 filesystem? Those have 1kB blocksizes, and will set 
it to that. If the non-512B blocksize in the floppy driver is broken, then 
such mounted filesystems should not work reliably either.

		Linus


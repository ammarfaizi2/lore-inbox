Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262325AbSJ0JWH>; Sun, 27 Oct 2002 04:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbSJ0JWH>; Sun, 27 Oct 2002 04:22:07 -0500
Received: from smtp.mailix.net ([216.148.213.132]:39761 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id <S262325AbSJ0JWE>;
	Sun, 27 Oct 2002 04:22:04 -0500
Date: Sun, 27 Oct 2002 11:28:21 +0100
From: Alex Riesen <fork0@users.sf.net>
To: Vladim?r Trebick? <guru@cimice.yo.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Swap doesn't work
Message-ID: <20021027102821.GA4778@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <20021027092337.GA4507@steel> <000601c27d96$15654540$4500a8c0@cybernet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000601c27d96$15654540$4500a8c0@cybernet.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladim?r Trebick?, Sun, Oct 27, 2002 09:51:17 +0100:
> > Does your swap partition show up in /proc/swaps? It has to contain
> > something like this:
> I have
> /dev/hda6                       partition       594364  0       -1

looks ok.

> > Btw, do you see something swap-related in dmesg? Like:
> 
> In dmesg I see only this, but some problem with signanture is in syslog
> (at the end of this mail)
> 
> $ dmesg | grep swap
> Starting kswapd
> Adding Swap: 594364k swap-space (priority -1)
> 
> > How did you initialized the swap partition? Recent kernels support both
> > v1 and v2 swaps, which is can be set for mkswap using -v0 (-v1).
> > Actually i mean did you initialized it at all? 8)
> 
> I just created a partition with fdisk /dev/hda6, done "mkswap /dev/hda6" put

May i assume you did swapoff before?

> the information to /etc/fstab and turned it on with "swapon -a". TOP shows
> Swap:  594364K av,       0K used,  594364K free
> 
> syslog logs these kinds of kernel messages (those I guess are important):
> 
> Sep 29 22:04:19 shunka kernel: swap_free: Bad swap offset entry 1b3d0000
> ...
> Sep 29 22:04:19 shunka kernel: swap_free: Bad swap offset entry 1b3d0000
> ...
> Sep 10 10:03:28 shunka2 kernel: swap_dup: Bad swap file entry 00000022

You change hostname inbetween or this is just a typo?

> Sep  4 21:30:40 shunka kernel: Unable to find swap-space signature        //
> !!!!!!!!

Wow. Any of the errors above prevents swap partition from being used.
How did you manage to see anything in /proc/swaps?
I suggest you do:
 swapoff /dev/hda6
 badblocks /dev/hda6

Alternatively, you can try

dd if=/dev/zero of=/dev/hda6; mkswap /dev/hda6

Look for "SWAP-SPACE" (old swap) or "SWAPSPACE2" (the new one).
Just to make sure you've initialized the partition properly.
Than turn it on: swapon /dev/hda6; tail /var/log/syslog

> Oct 26 19:25:29 shunka kernel:  <1>Unable to handle kernel paging request at
> virtual address 2064656e

Oops, you've sent, is pretty useless without decoding. Read
Documentation/oops-tracing.txt from the kernel source tree.

-alex

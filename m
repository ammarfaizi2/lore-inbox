Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269387AbRHGTs7>; Tue, 7 Aug 2001 15:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269385AbRHGTsu>; Tue, 7 Aug 2001 15:48:50 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:15358 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269380AbRHGTsf>; Tue, 7 Aug 2001 15:48:35 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108071948.f77Jm42H016486@webber.adilger.int>
Subject: Re: encrypted swap
In-Reply-To: <Pine.LNX.4.33L2.0108072212590.18776-100000@spiral.extreme.ro>
 "from Dan Podeanu at Aug 7, 2001 10:23:15 pm"
To: Dan Podeanu <pdan@spiral.extreme.ro>
Date: Tue, 7 Aug 2001 13:48:04 -0600 (MDT)
CC: Torrey Hoffman <torrey.hoffman@myrio.com>,
        "'David Maynor'" <david.maynor@oit.gatech.edu>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan writes:
> Or, somehow better & safer (or, explain the drawback):
> 
> spiral:~# dd if=/dev/zero of=/swap bs=1024k count=16
> 16+0 records in
> 16+0 records out
> spiral:~# losetup -e DES /dev/loop0 /swap
> Password:
> Init (up to 16 hex digits):
> spiral:~# mkswap /dev/loop0
> Setting up swapspace version 1, size = 16773120 bytes
> spiral:~# swapon /dev/loop0
> spiral:~# cat /proc/swaps
> Filename                        Type            Size    Used    Priority
> /dev/loop0                      partition       16376   0       -3
> 
> Of course, you'll need to enter the losetup password upon booting, which
> might prove annoying

Actually, since you don't care about the old contents of swap on each
boot, just have something like:

losetup -e AES /dev/loop0 /swap < /dev/random

then you get a random password each boot, which is strong because it
uses the full 256 character passwords, as opposed to passwords that
people can easily use/remember.

You would likely need something more along the lines of (I don't know
what input format losetup actually needs):

dd if=/dev/random bs=1 count=16 | od -tx4 | \
    awk '/0000000/ { print $2 $3 $4 $5 }' | losetup -e AES -p0 /dev/loop0 /swap

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert


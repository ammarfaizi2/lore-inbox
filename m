Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265559AbSKFIV5>; Wed, 6 Nov 2002 03:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265996AbSKFIV4>; Wed, 6 Nov 2002 03:21:56 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:16787 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S265559AbSKFIVz>; Wed, 6 Nov 2002 03:21:55 -0500
Date: Wed, 6 Nov 2002 08:28:30 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
X-X-Sender: mb@jester.mews
To: Keith Owens <kaos@ocs.com.au>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-rc1 dirty ext2 mount error 
In-Reply-To: <21861.1036564011@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44.0211060823290.1535-100000@jester.mews>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Auth-User: mb
X-uvscan-result: clean (189LY6-0004qW-00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:26 +1100 Keith Owens wrote:

>>> The root partition was originally ext3.  fstab now contains
>>> 
>>> /dev/sda1               /                       ext2    defaults        1 1
>>> 
>>> Booting 2.4.20-rc1 (ext3 as a module, not loaded yet) with a dirty / gets
>>> 
>>> EXT2-fs: sd(8,1): couldn't mount because of unsupported optional features (4).
>>> Drop back to 2.4.18 and it works, automatically running fsck.ext2 -a /dev/sda1.

>Come up on 2.4.18-14 from RH.  It detects ext3 and cleans the journal,
>even though fstab says ext2.  Then ext2 does fsck.ext2 -a /dev/sda1.  I
>guess the question is why ext3 is being used when fstab says ext2?

My guess answer is that /etc/fstab lives on / and can't be read till it's 
mounted. 2.4.18-14 has the ext3 modules loaded from initrd so the kernel 
can have 2 guesses at how to mount /

>Especially when that stuffs up booting into other kernels that do not
>have ext3 support at all.

Maybe you need to tune2fs -O ^has_journal /dev/sda1, or build an initrd 
which doesn't load the ext3 modules.

Matt


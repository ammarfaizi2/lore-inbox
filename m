Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312931AbSD2RMF>; Mon, 29 Apr 2002 13:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312939AbSD2RME>; Mon, 29 Apr 2002 13:12:04 -0400
Received: from conn6m.toms.net ([64.32.246.219]:494 "EHLO conn6m.toms.net")
	by vger.kernel.org with ESMTP id <S312931AbSD2RME>;
	Mon, 29 Apr 2002 13:12:04 -0400
Date: Mon, 29 Apr 2002 13:11:37 -0400 (EDT)
From: Tom Oehser <tom@toms.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: I made a bzip2 bootloader and ramdisk patch, ?useful/not?
In-Reply-To: <Pine.LNX.4.44.0204290923490.2423-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0204291233420.32489-100000@conn6m.toms.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(First, I apologize for getting a 'vger.rutgers.org' into a mail header
instead of 'vger.kernel.org', probably causing every reply to bounce...)

On Mon, 29 Apr 2002, Linus Torvalds wrote:

> On Mon, 29 Apr 2002, Tom Oehser wrote:
> >
> >               Speed    Memory
> >
> > Gzip      Lightning   Thimble
> >
> > Bzip2      Molasses   Bathtub
>
> While I appreciate the extensive scientific testing and regression that
> went into these numbers, I think that the main thing that matters is
> whether the bathtub of memory makes it harder to boot on a 4-8MB system,
> and whether the molassic speed makes the boot noticeably slower on older
> 486-class machines despite a faster load phase..
>
> Do you have any statistics for this? Can you answer that age-old question
> of how many bathtubs can dance on the head of a 4MB machine?
>
> 		Linus

It fits and works on a 4MB machine with no problems, my 831K-compressed bzip2
-9 kernel works on a 4MB box, ... *if* I'm not also loading a 4MB ramdisk ...

Specifically, the window allocated in misc.c is 32K, bzip2 using 'small'
varies between 350K for a -1 compressed file and 2350K for a -9 compressed
file.  (My previously posted compression numbers are for -9.)

The decompress time for bzip2 -d -s is about 14 times slower than gzip.
If you are booting a 386 from striped U2W arrays, it would for sure be
'noticably slower'.  If, however, as is more common with tomsrtbt, you are
booting for the purpose of rescue and recovery, from a grinding floppy drive,
it is probably never slower enough to matter, even on a 486.  I certainly
only consider it appropriate for situations where this trade off makes sense.
Floppies and flash memory come to mind, but not hard drives.

	-Tom



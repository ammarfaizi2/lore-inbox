Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131476AbRC3PAQ>; Fri, 30 Mar 2001 10:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131474AbRC3PAH>; Fri, 30 Mar 2001 10:00:07 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:15620
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131472AbRC3PAB>; Fri, 30 Mar 2001 10:00:01 -0500
Date: Fri, 30 Mar 2001 06:58:52 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jochen Hoenicke <Jochen.Hoenicke@Informatik.Uni-Oldenburg.DE>
cc: linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl
Subject: Re: Bug in EZ-Drive remapping code (ide.c)
In-Reply-To: <15044.24107.858836.866924@huxley.Informatik.Uni-Oldenburg.DE>
Message-ID: <Pine.LNX.4.10.10103300656400.27013-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jochen,

I don't really care about Disk Overlays.
However if you can fix it or if Andries can great.

Sorry,

On Fri, 30 Mar 2001, Jochen Hoenicke wrote:

> Hello,
> 
> The EZ-Drive remapping code remaps to many sectors, if they are read
> together with sector 0 in one bunch.  This is even documented:
> 
> >From linux-2.4.0/drivers/ide/ide.c line 1165:
> /* Yecch - this will shift the entire interval,
>    possibly killing some innocent following sector */
> 
> This problem hit a GRUB user using linux-2.4.2 but it exists for a
> long time; the remapping code is already in 2.0.xx.  The reason that
> nobody cares is probably because there are only a few programs that
> access /dev/hda directly.
> 
> GRUB is a boot loader that normally runs under plain BIOS but there is
> also a wrapper to run it under linux and other unixes.  Because it
> shares most code with its BIOS derivate it accesses the disk the hard
> way, reading directly from /dev/hda and interpreting the file system
> with its own (read-only) file system drivers.
> 
> This is what happened: Grub reads the first track in one bunch and
> since a track has an odd number of sectors, linux adds the first
> sector of the next track to this bunch.  This sector contains the boot
> sector of the first FAT partition.  The result of the remapping is
> that grub can't access that partition.
> 
> Please CC me on reply.
> 
>   Jochen
> 

Andre Hedrick
Linux ATA Development


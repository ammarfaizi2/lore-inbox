Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132821AbRDUS1b>; Sat, 21 Apr 2001 14:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132811AbRDUS1V>; Sat, 21 Apr 2001 14:27:21 -0400
Received: from s7n18.hfx.eastlink.ca ([24.222.7.18]:63956 "EHLO fop.ns.ca")
	by vger.kernel.org with ESMTP id <S132809AbRDUS1F>;
	Sat, 21 Apr 2001 14:27:05 -0400
Date: Sat, 21 Apr 2001 15:27:00 -0300 (ADT)
From: Steve Bromwich <kernel@fop.ns.ca>
To: Ville Holma <ville.holma@pp.htv.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: a way to restore my hd ?
In-Reply-To: <000701c0ca7b$051934a0$6786f3d5@pp.htv.fi>
Message-ID: <Pine.LNX.4.10.10104211518260.10031-100000@chizz.foppity.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, Ville Holma wrote:

> Anyway now that I try to boot up the system I get a kernel panic like this:
> 
> EXT2-fs: #blocks per group too big: 2147516416
> fatfs: bodus cluster size
> kernel panic: VFS: Unable to mount root fs on 03:47
> 
> So I set up another linux box and tried to run e2fsck on the partition
> resulting in this
> 
> debian:~# e2fsck /dev/hdb7
> e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> Corruption found in superblock.  (frags_per_group = 2147516416).
> 
> The superblock could not be read or does not describe a correct ext2
> filesystem.  If the device is valid and it really contains an ext2
> filesystem (and not swap or ufs or something else), then the superblock
> is corrupt, and you might try running e2fsck with an alternate superblock:
>     e2fsck -b -2147450879 <device>

This doesn't look like a reasonable number for an inode, you might want to
try 8193 or 16385. Before doing that I'd recommend taking an image,
something like dd if=/dev/hdb7 of=/tmp/backup and then using the loop
device to work on that. If the partition's bigger than 2 gig you will
probably need to compress it first with something like dd if=/dev/hdb7 |
gzip > /tmp/backup.gz (note that if it's compressed the loop device won't
work and you'll have to work on the bare hardware). If using an alternate
superblock doesn't work a last ditch fix may be mke2fs -S /tmp/backup (or
mke2fs -S /dev/hdb7 if the dd result was too big). This will rewrite the
superblocks, you will then need to run e2fsck to clean up. This did the
trick for me on a drive that got a whole bunch of bad sectors that I had
to get data off.

If even that doesn't work and you're really desperate for the data and
it's in text format, you can probably extract it from the backup image.

Cheers, Steve


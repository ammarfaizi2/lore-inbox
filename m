Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTD3MZQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 08:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTD3MZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 08:25:16 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:6016 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261561AbTD3MZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 08:25:14 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304301241.h3UCfDPp000309@81-2-122-30.bradfords.org.uk>
Subject: Re: Bootable CD idea
To: root@chaos.analogic.com
Date: Wed, 30 Apr 2003 13:41:13 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0304300811300.12971@chaos> from "Richard B. Johnson" at Apr 30, 2003 08:21:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Just a random idea that occurred to me...
> >
> > Since the El-Torito bootable CD standard supports multiple floppy
> > images on a single CD, it would be possible to write a script that
> > takes a .config file, and the source to, say all the -pre and -rc
> > versions of a particular kernel, compiles multiple kernels with the
> > same .config, and writes a CD with them all on, set to boot from an
> > arbitrary disk partition.
> >
> > It would make:
> >
> > > > > Foo doesn't work in -rc2
> > > > Did it work in -rc1
> > > Not sure
> >
> > E-Mail exchanges a thing of the past.
> >
> > Note, that as each floppy image is separate, it's not the same as
> > trying to cram multiple kernels on a 2.88 MB floppy image, and is
> > therefore actually do-able :-).
> >
> > John.
> 
> Well, it's a boot-loader problem that has to be solved in one
> of the boot-loader programs like grub or lilo. When booting a
> CD, the BIOS is made to 'think' that a CD is a floppy. It
> loads the boot-record and jumps to its code. From that point
> on, whatever happens is based upon how, what, and where the
> boot record and subsequent code executes. With the large
> data space available, you could certainly have multiple
> operating systems. It's simply a coding problem. If you
> want to modify one of the existing boot-loader programs
> let me know. I may be able to help, and certainly can test.

I didn't think we'd need to modify anything - the BIOS lets us choose
the floppy image we want, so each image only needs to contain a
bootloader[1], and a kernel.  The root filesystem doesn't need to be
on the CD - if the disk is to be used for quickly visiting another
kernel to see if something breaks, you'd want your normal root
filesystem.  If you set the root filesystem to /dev/fd0, you can
actually use a real floppy, as the kernel bypasses the BIOS floppy
emulation :-).  So, you can boot from a CD, and use a floppy that
you've prepared separately as your root filesystem.

Were you suggesting that we could have the root filesystem as a set of
blocks on the CD, which are accessed directly, and not via El-Torito
floppy emulation?  That would be pretty useful.  Heh, initial ram disk
on a CD would be even better...

[1] I originally thought that the 2.4 kernel's in-built floppy
bootloader used BIOS calls to access the disk, and that a 2.4 kernel
image as the El-Torito boot image would work, as the kernel would be
accessing the emulated disk, but it didn't seem to when I tried it
just now - it failed with an error saying something along the lines of
it had run out of data to decompress.

> FYI I have a bootable CR/ROM (who doesn't), that contains
> a limited root file-system with ramdisks that mount on
> /tmp and /var. I use this to boot any linux machine and
> repair it. It would be nice to be able to select different
> operating system versions as well.

Yeah, maybe I was just being lazy, but I imagined something like:

make allprepatches 

running the same config through 2.4.21-pre1 to -pre7, and -rc1, and
writing a CD that boots and gives you a menu to select from.

Kind of like make bzdisk, but for 2003 instead of 1991 :-).

I mean, if we're killing of the in-kernel bootloader in 2.5, why not?

John.

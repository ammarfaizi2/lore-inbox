Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129074AbQJaUXx>; Tue, 31 Oct 2000 15:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129958AbQJaUXn>; Tue, 31 Oct 2000 15:23:43 -0500
Received: from [24.65.192.120] ([24.65.192.120]:47091 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S129777AbQJaUXi>;
	Tue, 31 Oct 2000 15:23:38 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200010312022.e9VKM0j10597@webber.adilger.net>
Subject: Re: 2.2.X patch query (with initial PATCH against 2.2.17)
In-Reply-To: <200010311938.e9VJc0315960@pincoya.inf.utfsm.cl>
 "from Horst von Brand at Oct 31, 2000 04:38:00 pm"
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Date: Tue, 31 Oct 2000 13:22:00 -0700 (MST)
CC: Riley Williams <rhw@memalpha.cx>,
        Dominik Kubla <dominik.kubla@uni-mainz.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dr. Horst H. von Brand writes:
> Dominik Kubla <dominik.kubla@uni-mainz.de> said:
> > On Tue, Oct 31, 2000 at 01:38:56PM +0000, Riley Williams wrote:
> > ...
> > > Also, part of my plan was to check that the disk is already in this
> > > non-standard format, and refuse to dump if not. This would ensure that
> > > doing so didn't overwrite somebody's master boot disk by accident, as
> > > such disks will not normally be in this non-standard format.
> 
> > Just write a magic number somewhere to the disk and mark these blocks
> > bad in the fat. Then just check if the blocks are marked as bad and
> > contain the magic number. No need for a special disk format per se...
> 
> Why any filesystem at all? Just dump the whole on the diskette in the
> drive. If root doesn't know what they are doing fiddling with SysRq, they
> deserve it in any case. No FAT, MS-DOS, VFAT or whatever. Just a plain
> formated diskette. Remember, this has to be absolutely as simple and robust
> as possible, and have minimal impact on the rest of the kernel (no "must
> now pull in RW-floppy-format + fat + msdos modules to do SysRq-D", no
> "<foo> must be built into the kernel for SysRq-D to work" (at most "floppy
> in kernel", more can be hard to swallow in limited environments where this
> will be most needed as the only/principal way of looking at logs)).

Actually, as I had previously sent to Riley (privately), the kmsgdump
patch does exactly what I would want it to do:

1) can dump to a raw floppy disk (cat or dd to retrieve later)
2) can check for a labelled FAT floppy (via MS-DOS DISKLABEL)
   - will only dump to FAT floppy if magic label is correct (avoid overwrite)
   - will dump in "MS-DOS" FAT format (see below)
3) can be set up to automatically dump and reboot
   - writes a simple boot loader at start of FAT floppy which causes BIOS
     to continue booting, so we do not hang computer at boot after dump
4) FAT format is "normal" in that mcopy or msdos modules can read it
   - does not need fat/msdos modules installed because it is not a fully
     formatted floppy, just enough to store 1 dump file in root directory
5) has console mode to view syslogs (with scrolling, etc) after
   crash/SysRQ-D in case no floppy is on machine
   - can also print logs to printer

http://www-miaif.lip6.fr/willy/pub/linux-patches/kmsgdump/

It has a 2.2 and 2.3 version (nothing recently, probably because of 2.4
freeze).  It would probably be a prime candidate for the "loadable SysRq
modules" patch that has been posted to l-k the last couple of weeks.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

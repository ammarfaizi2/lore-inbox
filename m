Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129412AbQKUX25>; Tue, 21 Nov 2000 18:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130095AbQKUX2r>; Tue, 21 Nov 2000 18:28:47 -0500
Received: from [212.137.176.14] ([212.137.176.14]:36078 "EHLO
	StarBase-1.UFP.CX") by vger.kernel.org with ESMTP
	id <S129412AbQKUX2l>; Tue, 21 Nov 2000 18:28:41 -0500
Posted-Date: Fri, 3 Nov 2000 17:23:12 GMT
Date: Fri, 3 Nov 2000 17:23:11 +0000 (GMT)
From: Riley Williams <root@MemAlpha.cx>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Dominik Kubla <dominik.kubla@uni-mainz.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.X patch query (with initial PATCH against 2.2.17) 
In-Reply-To: <200010311938.e9VJc0315960@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.21.0011031658330.8829-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horst.

 >>> Also, part of my plan was to check that the disk is
 >>> already in this non-standard format, and refuse to
 >>> dump if not. This would ensure that doing so didn't
 >>> overwrite somebody's master boot disk by accident, as
 >>> such disks will not normally be in this non-standard
 >>> format.

 >> Just write a magic number somewhere to the disk and
 >> mark these blocks bad in the fat. Then just check if
 >> the blocks are marked as bad and contain the magic
 >> number. No need for a special disk format per se...

There's much better reasons for using a special format than
that. Horst has hit the main one - code simplicity.

 > Why any filesystem at all? Just dump the whole on the
 > diskette in the drive. If root doesn't know what they
 > are doing fiddling with SysRq, they deserve it in any
 > case. No FAT, MS-DOS, VFAT or whatever. Just a plain
 > formated diskette.

That argument's a non-starter in my book - the difference
between writing a raw floppy and one with an MS-DOS type 
filesystem on it comes down to prepending a fixed header to
the data, nothing more.

The MS-DOS type of filesystem is one of the simplest one can
get, but the standard version thereof used with floppies is
just a PITA to work with. What I've done is to remain
compatible with it, but tweak the parameters to produce a
much simpler version thereof.

 > Remember, this has to be absolutely as simple and
 > robust as possible, and have minimal impact on the
 > rest of the kernel...

That's precicely why I'm using the modified filesystem I
referred to in a previous post. Can I suggest that, before
you complain any more about it, you actually try it out? I
wrote and released the formatter that produces the said
filesystem many months ago now, and can easily send you a
copy to play with. It's also its own source code, as the
said formatter is written entirely as a BASH shell script,
and the fact that it's done that way should speak for itself
as to the simplicity of the format used.

Basically, from a programming point of view, it comes down
to writing a raw disk, but prepending a fixed header (size
4k on a 1440k floppy) to the log being written, and gaining
a LOT of advantages with virtually no disadvantages.

For reference, here's a few of the features of the said
format:

 1. Disks in this format can be read from and written
    to by MS-DOS 2.11, 3.10, 5.00 and 6.22 and by Windows
    95, 98 and NT (all tested).

 2. Disks formatted in this format do NOT use any extra
    tracks or sectors per track over those formatted in
    the standard format.

 3. From a programmer's viewpoint, the resulting format
    is MUCH simpler to handle than the standard one.

 4. The data area available on the disk is maximised for
    any particular physical layout.

The first two features mean that the resulting disks can be
used on ANY standard floppy drive. The third means that the
so-called bloat just will not exist.

The fourth is the one that people seem to have concentrated
on, but is irrelevant for this application. That particular
feature is only really relevant for backup disks.

 > ...(no "must now pull in RW-floppy-format + fat +
 > msdos modules to do SysRq-D", no "<foo> must be built
 > into the kernel for SysRq-D to work" (at most "floppy
 > in kernel", more can be hard to swallow in limited
 > environments where this will be most needed as the
 > only/principal way of looking at logs)).

None of that is required to use this format - it is designed
to (a) be fully compatible with the requirements of MS-DOS
2.00 and later (including WIndows 9x and NT, and (b) be as
simple as possible for the programmer to code.

Best wishes from Riley.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286335AbRLTSsJ>; Thu, 20 Dec 2001 13:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286327AbRLTSsA>; Thu, 20 Dec 2001 13:48:00 -0500
Received: from relay03.cablecom.net ([62.2.33.103]:33830 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S286331AbRLTSrn>; Thu, 20 Dec 2001 13:47:43 -0500
Message-ID: <3C22324D.B0DD7A75@bluewin.ch>
Date: Thu, 20 Dec 2001 19:47:44 +0100
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <Pine.GSO.4.21.0112161542420.937-100000@weyl.math.psu.edu> <3C1E3E4D.FFCAC861@bluewin.ch> <20011217120749.P855@lynx.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well "multiple streams file format" is purely a FILESYSTEM issue.  When it
> is outside of the filesystem, it is an ARCHIVE (e.g. tar, cpio, zip, SHA, etc).
> So this whole concept is bogus.
> 
It is a FILESYSTEM issue and an ARCHIVE is simply an implementation of the
"multiple streams file format" (MSFF), with archiving in mind. But it is not at
all bogus as long as it _isn't_ supported directly by the kernel. The MSFF
kernel support has more uses (i.e. transparently accessing anything inside as if
it were a directory). Since it is a kind of fs within an fs it can be easy
accessed from a boot loader regardless of the surrounding fs. I.e. Lilo can
access it regardless if the MSFF is on SCSI raid system, a FAT floppy or a Mac
Zip drive (on i386). 

> > So anybody has to write a kernel module for the cpio/tar format and help
> > with implementing it into  boot loaders. Maybe you could give some help.
> 
> Well, the good news is that this whole discussion is moot.  Al Viro has
> already written a kernel patch which does all of this, and I'm sure he
> is just waiting to get it into the 2.5 kernel.  It creates an "initramfs"
> which is populated from a cpio (or tar, can't remeber) archive attached
> to the kernel image.
> 
When I first read about initramfs I considered it just a slight improvement of
initrd and now after more reading about it, I still think it's not the best
solution. It still has to be loaded somewhere. Well initramfs might be usable
but it is just another special case for the booting process. 

With MSFF the kernel just sees it as an ordinary directory and accesses modules
as if they where ordinary files (maybe within sub directories). The bootloader
first just sees a file and tries to start the stream in it. Depending on how
smart the MSFF is the boot loader does not even need to know the MSFF itself as
long as it is able to start the stream. Otherwise if the MSFF is i.e. a tar
archive even Lilo doesn't need much intelligence to start the kernel within.

O. Wyss

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbSLFLhz>; Fri, 6 Dec 2002 06:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbSLFLhz>; Fri, 6 Dec 2002 06:37:55 -0500
Received: from pop.gmx.de ([213.165.64.20]:30430 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262326AbSLFLhy>;
	Fri, 6 Dec 2002 06:37:54 -0500
Message-ID: <3DF08DD0.BA70DA62@gmx.de>
Date: Fri, 06 Dec 2002 12:45:20 +0100
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: DervishD <raul@pleyades.net>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unable to boot a raw kernel image :??
References: <20021129132126.GA102@DervishD>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
> 
>     Hi all :))
> 
>     A time ago I was able to generate bootable Linux CD's just by
> dd'ing a floppy containing a raw kernel image:
> 
>     dd if=/dev/fd0 of=eltorito
> 
>     After that, mkisofsing, toasting and booting. But now, depending
> on the machine, I have 'invalid compressed format' errors, or even
> ye olde register dump when the image was damaged :(
> 
>     Booting directly from the floppy works, but booting with that
> same image from a CD does not :(( I now I can use LILO, or better
> yet, Syslinux or isolinux, but I'm just curious why I cannot boot raw
> image-based CD's anymore.
> 
>     Anyone knows what's happenning here?

I had this problem a while ago.  It turned out to be a (widespread)
BIOS bug triggered be the disk-size probe of the kernel's boot loader.

The crude fix which worked for me: disable the probing for 2.88MB disks
by changing the first byte of the disksizes table at the end of bootsect.S
from 36 to 18.

The long explanation: The BIOS allows bigger-than-track-size reads
in El-Torito mode which confuses the probe routine which then assumes
a 2.88MB disk when the BIOS is actually emulating a 1.44MB disk.
In LBA mode that would be no problem but in CHS mode (which is used
by the loader) it does not work.

Ciao, ET.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279812AbRJ0MWl>; Sat, 27 Oct 2001 08:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279813AbRJ0MWb>; Sat, 27 Oct 2001 08:22:31 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:45072 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S279812AbRJ0MW1>; Sat, 27 Oct 2001 08:22:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: TreeWater Society Berlin
To: "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Re: VIA KT133 data corruption update
Date: Sat, 27 Oct 2001 14:22:52 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <1004179736.1615.19.camel@pelerin.serpentine.com>
In-Reply-To: <1004179736.1615.19.camel@pelerin.serpentine.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011027122255.36BFDFC2@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 27. October 2001 12:48, Bryan O'Sullivan wrote:
> After several months of begrudgingly putting up with my ASUS A7V
> motherboard corrupting roughly 1 byte per 100 million read during
> moderate to heavy PCI bus activity, I flashed VIA's 1009 BIOS this
> evening.
>
> I have not been able to reproduce any corruption since then (it was
> ridiculously easy before the new BIOS), and my machine seems otherwise
> as stable as I would hope.  This marks the first time since 2.4.6 that
> I've been able to run a Linus kernel without cowering.

Good news. Congrats.

> I also discovered, of necessity, a halfway manageable process for
> creating a DOS boot floppy using Windows ME, which Microsoft would
> apparently prefer was not possible.  I'll reproduce the steps here,
> since otherwise flashing a new BIOS is likely to be nightmarish for
> people stuck dual booting into WinME.
>
> Most of these steps occur under Linux, and I'll assume that your Windows
> Me "C:" drive is mounted as /dos/c.
>
> - Format a floppy:
>   fdformat /dev/fd0H1440
>
> - Create a FAT filesystem:
>   mkdosfs /dev/fd0
>
> - Mount the floppy:
>   mount /dev/fd0 /mnt
>
> - Copy across a few files:
>   cp /dos/c/command.com /mnt
>   cp /dos/c/io.sys /mnt
>   cp /dos/c/msdos.sys /mnt
>
> - Edit /mnt/msdos.sys, and change values as follows:
>   [Paths]
>   WinDir=a:\
>   WinBootDir=a:\
>   HostWinBootDrv=a
>
>   [Options]
>   BootMulti=0
>   BootGUI=0
>   AutoScan=0
>
> - Copy across your BIOS flash utility (probably aflash.exe) and BIOS
>   image.  Unmount the floppy (important; don't just reboot):
>   umount /mnt/floppy
>
> - When you reboot to the floppy, it will desperately try to boot into
>   Windows.  When it prompts you for the path to some Windows VXD, just
>   type "a:\command.com", and lo, you've got a DOS prompt.

Since your floppy doesn't contain a valid bootsector, it won't start
from floppy here. At least my mkdosfs created boot sector says:
This is not a bootable disk.  Please insert a bootable floppy and
press any key to try again ...

The simplest solution is choosing win(9*|me) from boot manager then, press
F8 immediately, select boot to command prompt. (Hope this works in me, too) 
Issue
c:\> sys a:
and
c:\> edit msdos.sys
then, as above. If booting from floppy still fails, check BIOS boot order.

Note: if you don't trust your winloose inst., check the created bootsector:
1) Label at offset 3 should read MSWIN4.1 or the like
2) some readable error messages at around 0x180 
3) IO      SYSMSDOS  SYS at ~0x1d8

BTW[FAR OT]: Somebody remember IHC here?

> Cheers,
>
> 	<b

Have-a-nice-stay-where-ever-you-are-ly yours,
FrisPete

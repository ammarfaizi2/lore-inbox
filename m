Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292855AbSCKUbv>; Mon, 11 Mar 2002 15:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292866AbSCKUbn>; Mon, 11 Mar 2002 15:31:43 -0500
Received: from group1.mxgrp.airmail.net ([209.196.77.108]:61188 "EHLO
	mx11.airmail.net") by vger.kernel.org with ESMTP id <S292855AbSCKUb2>;
	Mon, 11 Mar 2002 15:31:28 -0500
Date: Mon, 11 Mar 2002 14:42:55 -0600
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Troubles with ALI15X3 driver in 2.4 kernels
Message-ID: <20020311144255.A560@debian>
In-Reply-To: <20020311110434.B32667@debian> <E16kTTB-00018N-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16kTTB-00018N-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 05:20:21PM +0000, Alan Cox wrote:
> > ALI15X3: simplex device:  DMA disabled
> > ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
> > ALI15X3: simplex device:  DMA disabled
> > ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
> 
> Is the drive disabled in the BIOS settings ?
> 
> > ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> > hda: status error: staus = 0x58 { DriveReady SeekComplete DataRequest}
> > ... a few more of the same ...
> > hda: drive not ready for command
> 
> > My system - i586-pc-linux-gnu
> > Compiler - gcc-3.0.5 (cvs)
> 
> At this point I just lost interest. Please reproduce it with 2.95/2.96 - I'm
> betting you can but it would be nice to be sure.
> 

Using ...

$ gcc -v
gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20010810 (Debian prerelease)
$

... I saw the same problem as I did when using the gcc-3.0.5 compiler.
Here's my transcription of the kernel output when poking around
with the disks ...

ALI15X3: chipset rev 32
ALI15X3: not 100% native mode, will probe irqs later
 ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
 ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
ide0 at 0x1f0-0x1f7, 0x3f6 on irq 14
ide1 at 0x170-0x177, 0x376 on irq 15
hda: 6303024 sectors (3227MB) w/128 kiB Cache, CHS=781/128/63 (U)DMA
hdc: 16514064 sectors (8455MB) w/512 kiB Cache, CHS=16383/16/63 (U)DMA

at this point there are again the messages about ide_dmaproc and
then the "drive not ready for command".

I have an old 2.2 Debian kernel that I booted from, and it has
the driver in it. Here is it's output, if that is of any use ...

...
ALI15X3: IDE controller on PCI bus 00 dev 58
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: ST33232A, ATA DISK drive
hdb: ATAPI CDROM, ATAPI CDROM drive
hdc: FUJITSU MPD3084AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: ST33232A, 3077MB w/128kB Cache, CHS=781/128/63
hdc: FUJITSU MPD3084AT, 8063MB w/512kB Cache, CHS=16383/16/63
hdb: ATAPI 24X CD-ROM drive, 120kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
md driver 0.36.6 MAX_MD_DEV=4, MAX_REAL=8
scsi: <fdomain> Detection failed (no card)
NCR53c406a: no available ports found
sym53c416.c: Version 1.0.0
Failed initialization of WD-7000 SCSI card!
IBM MCA SCSI: Version 3.2
IBM MCA SCSI: No Microchannel-bus present --> Aborting.
              This machine does not have any IBM MCA-bus
              or the MCA-Kernel-support is not enabled!
megaraid: v1.11 (Aug 23, 2000)
aec671x_detect: 
3w-xxxx: tw_findcards(): No cards found.
scsi : 0 hosts.
scsi : detected total.
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
 hdc: [PTBL] [1027/255/63] hdc1 hdc2 < hdc5 hdc6 > hdc3
apm: BIOS not found.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 156k freed
...

As for the question about the drive being disabled in the BIOS, if
I read you right then the answer is no, the drive is not disabled.
Otherwise I couldn't boot up. As for the settings of things like
DMA, 32-bit mode, etc, I can set much of them with hdparm, though
DMA I could not do, and I've poked around the BIOS configuration
screen looking for what to set, and have come up empty. The BIOS,
BTW, is 'AMIBIOS 8/28/1997 S' and the motherboard has a
"TXpro Pentium PCI" chipset and supports Ultra DMA/33, according
to the manual that came with it.

-- 
They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759

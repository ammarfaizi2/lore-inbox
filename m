Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311320AbSCaO3F>; Sun, 31 Mar 2002 09:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311839AbSCaO24>; Sun, 31 Mar 2002 09:28:56 -0500
Received: from c0s14.ami.com.au ([203.55.31.79]:23569 "EHLO
	dugite.os2.ami.com.au") by vger.kernel.org with ESMTP
	id <S311320AbSCaO2k>; Sun, 31 Mar 2002 09:28:40 -0500
Message-Id: <200203311302.g2VD1s007756@numbat.Os2.Ami.Com.Au>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: John Summerfield <summer@os2.ami.com.au>, Bill Davidsen <davidsen@tmr.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Lord <mlord@pobox.com>, "Jeremy Jackson" <jerj@coplanar.net>
Subject: Re: IDE and hot-swap disk caddies 
In-Reply-To: Message from Mark Hahn <hahn@physics.mcmaster.ca> 
   of "Wed, 27 Mar 2002 11:39:09 EST." <Pine.LNX.4.33.0203271134090.28872-100000@coffee.psychology.mcmaster.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 31 Mar 2002 21:01:54 +0800
From: John Summerfield <summer@os2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not knowing a lot about how it all works, but also not willing to give 
up without trying, ....


> > > > > syslog, of course, is user-space.  the real question is where does 
> > > > > your (raw, kernel-level) console go.  serial console?
> > > > 
> > > > What do I need to do to get them on tty11?
> > > 
> > > kernel-level logging can't be configured like that: it logs 
> > > to physical devices.
> > 
> > What are my options to get to a position I'm sure to see the kernel 
> > messages as they appear?
> 
> serial console.  or work in text mode.  or parallel console.
> the point is that panic-level kernel messages cannot possibly
> go through the regular device infrastructure, and therefore 
> cannot be tidily tucked away on some other VC, etc.  the serial
> and parallel console code is used directly by printk to frob
> the hardware.

I'm working in runlevel 3 (no GUI) at the console.

> 
> > > > Can I play games with modules? Perhaps by defining the 5513 driver as a 
> > > > module and loading it separately for each IDE channel?
> > > 
> > > I don't believe so.
> > 
> > What would happen I boot with ide1=noprobe and then load ide.o 
> > (extracted from a modularised compile)?
> 
> if you could boot with no ide, then insmod the ide, that would work.

I booted with ide1=noprobe and that came up with no IDE1 which is what 
I want.

Except that, when I installed the IDE modules built from the same 
source (so the versions match), this happens:
Linux version 2.4.9-31 (bhcompile@daffy.perf.redhat.com) (gcc version 
2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Tue Feb 26 06:25:35 EST 
2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003c00000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 15360
zone(0): 4096 pages.
zone(1): 11264 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hda2 vga=6 ide1=noprobe
ide_setup: ide1=noprobe
Initializing CPU#0
Detected 133.160 MHz processor.
<snip>
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 09
PCI: Found IRQ 11 for device 00:01.1
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS5597
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MPB3043ATU E, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 8448300 sectors (4326 MB), CHS=525/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M

Doesn't my 'noprobe" mean don't probe IDE1?


and then this:
Freeing initrd memory: 414k freed
VFS: Mounted root (ext2 filesystem).
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 09
PCI: Found IRQ 11 for device 00:01.1
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS5597
    ide0: BM-DMA at 0xd000-0xd007 -- ERROR, PORT ADDRESSES ALREADY IN 
USE
    ide1: BM-DMA at 0xd008-0xd00f -- ERROR, PORT ADDRESSES ALREADY IN 
USE
Journalled Block Device driver loaded


(the drive's turned off at present).

When I turned the drive on, the system instantly rebooted. If there 
were any messages, there was no time to read them.



=====================================
If I boot with the drive turned on, then this happens:
The same as before for the builtin IDE driver, then ....

RAMDISK: Compressed image found at block 0
Freeing initrd memory: 414k freed
VFS: Mounted root (ext2 filesystem).
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 09
PCI: Found IRQ 11 for device 00:01.1
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS5597
    ide0: BM-DMA at 0xd000-0xd007 -- ERROR, PORT ADDRESSES ALREADY IN 
USE
    ide1: BM-DMA at 0xd008-0xd00f -- ERROR, PORT ADDRESSES ALREADY IN 
USE
hdc: M1614TA, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: 2131584 sectors (1091 MB) w/64KiB Cache, CHS=2114/16/63
 hdc: hdc1 hdc2 hdc3
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.


On the screen, there's a message (I guess from modprobe) about loading 
the three modules.

These are the modules loaded:
Module                  Size  Used by    Not tainted
parport_pc             14692   1  (autoclean)
lp                      6400   0  (autoclean)
parport                25568   1  (autoclean) [parport_pc lp]
appletalk              20972  12 
iptable_filter          2176   0  (autoclean) (unused)
ip_tables              11712   1  [iptable_filter]
epic100                12260   1 
ne                      7136   0  (unused)
8390                    6624   0  [ne]
ext3                   62512   2 
jbd                    40320   2  [ext3]
ide-disk                7152   0 
ide-probe-mod           8416   0 
ide-mod               144128   0  [ide-disk ide-probe-mod]


The only entries in /etc/modules.conf pertain to the printer and 
network interfaces.

How do I control when these modules load?

fwiw it seems that I can unload/reload those modules as I like, until I 
cycle power on the drive.


> 
> > On this system, it does not matter if I destroy filesystems while 
> > testing, though I don't wish to fry any hardware.
> 
> the risk of frying hardware is *inherent* to ide hotplug,
> since the hardware doesn't support HP.
> 

-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my 
disposition.

==============================
If you don't like being told you're wrong,
	be right!




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbTJaTIW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 14:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTJaTIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 14:08:22 -0500
Received: from ppp-62-245-232-154.mnet-online.de ([62.245.232.154]:20608 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S263565AbTJaTIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 14:08:18 -0500
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Julien Oster <lkml@mc.frodoid.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: WD Raptor/SATA with RAID0 way to slow
From: Julien Oster <frodoid@frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Fri, 31 Oct 2003 20:08:16 +0100
In-Reply-To: <1067621682.1119.115.camel@rivendell.arnor.net> (Torrey
 Hoffman's message of "Fri, 31 Oct 2003 09:34:42 -0800")
Message-ID: <frodoid.frodo.878yn1444f.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <frodoid.frodo.873cdadsux.fsf@usenet.frodoid.org>
	<1067621682.1119.115.camel@rivendell.arnor.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torrey Hoffman <thoffman@arnor.net> writes:

Hello,

>> Those harddisks are supposed to be "really fast", but I don't really
>> get the performance out of them. In fact, I get much less performance
>> than with my "standard consumer" IBM DeskStars.

> What version of the Linux kernel are you using?

Hmpf. The part of mentioning the kernel version in use is so obviously
elementary that I'm always missing it :)

It's 2.4.22-ac4. I'm using this kernel, because I had no real luck
with other kernels on my mainboard (the well-known A7N8X lockups that
are being discussed here). This one seems to work well.

> What does the kernel log say about how it is detecting and
> configuring your drives?

It's hard with 2.4.22-ac4 to get a good kernel log, since because
ACPI, APIC and the not less than seven softraids the log buffer is a
bit too small, but I managed to get everything from bootup except the
first lines.

I'll not only paste the relevant lines for the WD Raptors, but also
for the IBM harddrives, maybe there's something to compare or the
like.

The PATA controller says the following:

NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits correctly. Enabling workaround.
AMD_IDE: Bios didn't set cable bits correctly. Enabling workaround.
AMD_IDE: nVidia Corporation nForce2 IDE (rev a2) UDMA133 controller on pci00:09.
0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA

No problem with it so far, I get really good results with my PATA
drives, it seems to be unsignificantly faster than my old board. I got
lockups on high load on the DeskStars with various other kernels, but
as I said before I managed to solve this problem by using the latest
-ac4.

Now the Silicon Image SATA controller:

SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio

That looks different. What is MMIO-DMA, why not BM-DMA? And the BIOS
settings are programmed IO, not DMA... don't know if that's relevant
at all, I'm doing hdparm.

next comes the IBM harddisks plus CD-RW:

hda: C/H/S=39420/16/255 from BIOS ignored
hda: IC35L080AVVA07-0, ATA DISK drive
blk: queue c044c0c0, I/O limit 4095Mb (mask 0xffffffff)
hdc: IC35L080AVVA07-0, ATA DISK drive
hdd: SAMSUNG CD-R/RW SW-408B, ATAPI CD/DVD-ROM drive
blk: queue c044c51c, I/O limit 4095Mb (mask 0xffffffff)

nice.

WD Raptors:

hde: WDC WD360GD-00FNA0, ATA DISK drive
blk: queue c044c978, I/O limit 4095Mb (mask 0xffffffff)
hdg: WDC WD360GD-00FNA0, ATA DISK drive
blk: queue c044cdd4, I/O limit 4095Mb (mask 0xffffffff)

fine.

ide stuff:

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xf8808080-0xf8808087,0xf880808a on irq 18
ide3 at 0xf88080c0-0xf88080c7,0xf88080ca on irq 18

ide0 and ide1 are PATA. both on different interrupts. ide2 and ide3
share the same... could THAT be the pitfall I'm stepping into, the
reason why one Raptor alone is faster than one DeskStar alone, but the
WD RAID is slower than the IBM RAID?

BTW, it *really* is slower. No test, wether it's hdparm -t, bonnie++
or my own tests with various applications, does not give a bad result
for the Raptor RAID compared to the DeskStar RAID.

Well, I just have no idea. IDE stuff is something I have no clue of. I
tried different things, with or without APIC, ACPI, hdparm... most of
those experiments do nothing at all, only with hdparm I managed to get
it even slower.

And to make it complete, here's the output of hdparm -i for one
DeskStar (/dev/hda) and one Raptor (/dev/hde):

/dev/hda:

 Model=IC35L080AVVA07-0, FwRev=VA4OA52A, SerialNo=VNC402A4CMNT6A
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
 BuffType=DualPortCache, BuffSize=1863kB, MaxMultSect=16, MultSect=16
 CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=160836480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5

/dev/hde:

 Model=WDC WD360GD-00FNA0, FwRev=35.06K35, SerialNo=WD-WMAH91116490
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=74
 BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=72303840
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:  1 2 3 4 5 6

I would really appreciate some help there...

Regards,
Julien

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129762AbRBYVG4>; Sun, 25 Feb 2001 16:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129759AbRBYVGr>; Sun, 25 Feb 2001 16:06:47 -0500
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:35571 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S129762AbRBYVGf>; Sun, 25 Feb 2001 16:06:35 -0500
Message-ID: <3A9973D8.37AD1C52@bigfoot.com>
Date: Sun, 25 Feb 2001 13:06:32 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre8+IDE i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ide / usb problem
In-Reply-To: <20010224073003.A285@ix.netcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...
> It happens when dma is enabled by hdparm -d1 /dev/hda or when dma is
> enabled automatically by the kernel.
> 
> I have an Abit kt7 mb with the kt133 chipset,Athlon 900 , 128MB mem,
> quantum fireball 20G disk, gcc 2-95-2 , glibc 2-2-1.
> 
> There are no problems with dma disabled.
> 
> I was not sure if the VIA82CXXX option should be set with the via kt133
> chipset , but setting it results in hundreds of
>     hda: dma_intr:status=0x51 { DriveReady SeekComplete Error }
>     hda: dma_intr:error=0x84 { DriveStatusError BadCRC }
> mesages along with the uhci: errors mentioned above.
...

Try passing kernel params (eg- idebus=33 ide0=ata66 ide1=ata6) rather
than relying on hdparm to set up disks.

I'm on 2.2.19pre8 + ide.2.2.18.1221 but same board and cables, zero
errors.  Also run a check with nothing but graphics, kbd, disks.  KA7
seems to be particularly edgy with some addon cards (ES1370 & Promise
controller in my case) and <300W power (compared to P3B-F).

rgds,
tim

# hdparm -iv /dev/hdc

/dev/hdc:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2501/255/63, sectors = 40188960, start = 0

 Model=IBM-DTLA-307020, FwRev=TX3OA50C, SerialNo=YH0YHF45553
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=40188960
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5 

# hdparm -tT /dev/hdc

/dev/hdc:
 Timing buffer-cache reads:   128 MB in  0.94 seconds =136.17 MB/sec
 Timing buffered disk reads:  64 MB in  1.87 seconds = 34.22 MB/sec

# lspci
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0391 (rev
02)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8391
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
00:08.0 FireWire (IEEE 1394): Texas Instruments TSB12LV23 OHCI Compliant
IEEE-1394 Controller
00:09.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
00:0b.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
20)
01:00.0 VGA compatible controller: nVidia Corporation Riva TNT2 Model 64
(rev 11)


CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_PCI_EXPERIMENTAL=y
CONFIG_BLK_DEV_VIA82CXXX=y


Linux version 2.2.19pre8+IDE (root@abit) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #8 Thu Feb 22 18:12:29 PST 2001
USER-provided physical RAM map:
 USER: 0009f000 @ 00000000 (usable)
 USER: 1ff00000 @ 00100000 (usable)
Detected 800062 kHz processor.
ide_setup: idebus=33
ide_setup: ide0=ata66
ide_setup: ide1=ata66
Console: colour VGA+ 80x25
Calibrating delay loop... 1595.80 BogoMIPS
Memory: 517196k/524288k available (1120k kernel code, 412k reserved,
5512k data, 48k init)
Dentry hash table entries: 65536 (order 7, 512k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 131072 (order 7, 512k)
CPU: L1 I Cache: 64K  L1 D Cache: 64K
CPU: L2 Cache: 512K
CPU: AMD Athlon(tm) Processor stepping 02
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfb4d0
...
Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VT 8371
 Chipset Core ATA-66
VP_IDE: ATA-66/100 forced bit set (WARNING)!!
Split FIFO Configuration:  8 Primary buffers, threshold = 1/2
                           8 Second. buffers, threshold = 1/2
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
ide0: VIA Bus-Master (U)DMA Timing Config Success
VP_IDE: ATA-66/100 forced bit set (WARNING)!!
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
ide1: VIA Bus-Master (U)DMA Timing Config Success
hda: IBM-DTLA-307020, ATA DISK drive
hdb: YAMAHA CRW4416E, ATAPI CDROM drive
hdc: IBM-DTLA-307020, ATA DISK drive
hdd: HP COLORADO 20GB, ATAPI TAPE drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: IBM-DTLA-307020, 19623MB w/1916kB Cache, CHS=2501/255/63, UDMA(66)
hdc: IBM-DTLA-307020, 19623MB w/1916kB Cache, CHS=39870/16/63, UDMA(66)
...

--

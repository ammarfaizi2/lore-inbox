Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbSBJWBL>; Sun, 10 Feb 2002 17:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbSBJWAx>; Sun, 10 Feb 2002 17:00:53 -0500
Received: from iggy.triode.net.au ([203.63.235.1]:29677 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP
	id <S281214AbSBJWAi>; Sun, 10 Feb 2002 17:00:38 -0500
Date: Mon, 11 Feb 2002 08:59:56 +1100
From: Linux Kernel Mailing List <kernel@iggy.triode.net.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALI 15X3 DMA Freeze
Message-ID: <20020211085956.A23445@iggy.triode.net.au>
In-Reply-To: <20020210154209.A15150@iggy.triode.net.au> <E16ZvhB-0003lm-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16ZvhB-0003lm-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Feb 10, 2002 at 03:15:13PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I dont have IDE DMA discabled in the BIOS. That is just 
something that the ide patch  (ide.2.4.17.02072002.patch)
printed out. How can I prove that the reporting of
IDE DMA disabled is a bug in the patch? 

As you can see below, hdparm lets me turn DMA on, 
its just that the machine looks up before I
can compile a single Linux kernel.

Here are the boot messages from a vanilla 2.4.18-pre9 boot

[root@solaris root]# dmesg|more
Linux version 2.4.18-pre9 (root@solaris.triode.net.au) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Sun Feb 10 16:59:03 EST 2002

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 20
PCI: No IRQ known for interrupt pin A of device 00:04.0.
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
ALI15X3: ATA-66/100 forced bit set (WARNING)!!
    ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:pio, hdd:DMA
hda: IC35L040AVER07-0, ATA DISK drive
hdb: CDU5211, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63
hdb: ATAPI 52X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2

[root@solaris root]# cat /etc/redhat-release 
Red Hat Linux release 7.2 (Enigma)

[root@solaris root]# hdparm -I /dev/hda
/dev/hda:
 Model=CI530L04VARE700-                        , FwRev=REO44AA6, SerialNo=        S PXXTRT3479
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=80418240
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255)
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4 ATA-5 

[root@solaris root]# hdparm /dev/hda
 /dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 5005/255/63, sectors = 80418240, start = 0

[root@solaris root]# hdparm -d1 /dev/hda
/dev/hda:
 setting using_dma to 1 (on)
 using_dma    =  1 (on)

[root@solaris root]# hdparm /dev/hda
/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 5005/255/63, sectors = 80418240, start = 0


Let me know what to check next.

Cheers.  Paul





On Sun, Feb 10, 2002 at 03:15:13PM +0000, Alan Cox wrote:
> > Feb 10 15:25:10 solaris kernel: ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
> > Feb 10 15:25:10 solaris kernel: ALI15X3: simplex device:  DMA disabled
> > Feb 10 15:25:10 solaris kernel: ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
> 
> Why do you have the IDE DMA disabled in the BIOS ? Is that a setting you
> made or something your bios knows about your hardware ?

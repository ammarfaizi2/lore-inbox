Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274784AbRIZCSN>; Tue, 25 Sep 2001 22:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274789AbRIZCSE>; Tue, 25 Sep 2001 22:18:04 -0400
Received: from jgateadsl.cais.net ([205.252.5.196]:34833 "EHLO
	tyan.doghouse.com") by vger.kernel.org with ESMTP
	id <S274784AbRIZCRs>; Tue, 25 Sep 2001 22:17:48 -0400
Date: Tue, 25 Sep 2001 22:18:17 -0400 (EDT)
From: Maxwell Spangler <maxwax@mindspring.com>
X-X-Sender: <maxwell@tyan.doghouse.com>
To: David Grant <davidgrant79@hotmail.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Ward <gward@python.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
In-Reply-To: <OE326eDIBlgb8hMppUY00003821@hotmail.com>
Message-ID: <Pine.LNX.4.33.0109252208100.7042-100000@tyan.doghouse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, David Grant wrote:

> Those messages are almost identical to the ones I get.  Except it happens to
> me when I try to install Linux.  Just curious, Max, when did this start
> happening?

I'd like to say when I started using Andre Hedrick unified EIDE driver a long
time ago in order to use the Promise cards, but I'm not sure about this.

I'm no kernel guy, but I suspect this is simply a case when the drive isn't
ready for a command and the driver is not capable of waiting for it or
preparing it to be ready--it's just trying, failing and moving on.

The system is still useable, but I want to work in DMA mode--can't afford to
give up the CPU time working in PIO mode.

>  You say it's an otherwise rock solid system, but was there ever
> a time when it didn't do this?

No archive of logs to go through, but I do believe there was a time when I
didn't get this.. 2.2 kernels with the onboard PIIX4 controller and without
the unified EIDE driver..?  Hard to say--a while ago at least.

>  Some people have suspected (with my system)
> that the problem may come from IRQ sharing problems.  It looks like Max
> isn't using any IRQ sharing with his Promise card, but he is with his Intel
> on-board IDE controller, from the lspci listing.

[maxwell@tyan /proc]$ cat interrupts
           CPU0       CPU1
  0:    4590063    5120609    IO-APIC-edge  timer
  1:      18970      19924    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          1    IO-APIC-edge  rtc
 15:       8538       8467    IO-APIC-edge  ide1
 16:       3035       3139   IO-APIC-level  BusLogic BT-958
 17:    2545359    2636066   IO-APIC-level  eth0
 18:     122943     123120   IO-APIC-level  ide2, ide3
 19:      86785      89530   IO-APIC-level  es1371, usb-uhci
NMI:          0          0
LOC:    9710744    9710742
ERR:          0
MIS:          0

>  So my other question for
> Max is, where are your two hard drives connected to???  I hope I don't sound
> completely like I don't know what I'm talking about.

# dmesg (edited):

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
PDC20262: IDE controller on PCI bus 00 dev 90
PDC20262: chipset revision 1
PDC20262: not 100%% native mode: will probe irqs later
PDC20262: ROM enabled at 0xfebd0000
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xef00-0xef07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xef08-0xef0f, BIOS settings: hdg:DMA, hdh:pio
hdc: ATAPI CD-ROM DRIVE 40X MAXIMUM, ATAPI CD/DVD-ROM drive
hde: IBM-DJNA-372200, ATA DISK drive
hdg: IBM-DPTA-372050, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xefe0-0xefe7,0xeff2 on irq 18
ide3 at 0xefa8-0xefaf,0xefa6 on irq 18
hde: 44150400 sectors (22605 MB) w/1966KiB Cache, CHS=43800/16/63, UDMA(33)
hdg: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=39770/16/63, UDMA(66)
hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hde: [PTBL] [2748/255/63] hde1 hde2 hde3 < hde5 hde6 hde7 hde8 hde9 >
 hdg: hdg1

My EIDE cdrom is on the onbard PIIX4 controller, part of the BX chipset, and
my two 22 and 20G IBM drives are on the Promise Ultra66 controller's primary
and secondary channels as masters--no slaves on either channel.

fwiw:

[root@tyan /root]# hdparm -v /dev/hde

/dev/hde:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2748/255/63, sectors = 44150400, start = 0
[root@tyan /root]# hdparm -v /dev/hdg

/dev/hdg:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 39770/16/63, sectors = 40088160, start = 0
[root@tyan /root]#

I don't mess with these much.. Anybody want to suggest anything, I'll try it,
but I'm happy with moderate performance that's reliable...

-------------------------------------------------------------------------------
Maxwell Spangler
Program Writer
Greenbelt, Maryland, U.S.A.
Washington D.C. Metropolitan Area


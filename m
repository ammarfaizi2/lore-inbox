Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSLYL0y>; Wed, 25 Dec 2002 06:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSLYL0y>; Wed, 25 Dec 2002 06:26:54 -0500
Received: from smtp01.uc3m.es ([163.117.136.121]:51213 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S261302AbSLYL0w>;
	Wed, 25 Dec 2002 06:26:52 -0500
Date: Wed, 25 Dec 2002 12:34:59 +0100
Message-Id: <200212251134.gBPBYxJ29966@oboe.it.uc3m.es>
From: "Peter T. Breuer" <ptb@it.uc3m.es>
To: Nico Schottelius <schottelius@wdt.de>
Subject: Re: [BUG] 2.4 series: IDE driver
Cc: linux-kernel@vger.kernel.org
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Dr. David Alan Gilbert [Tue, Dec 24, 2002 at 11:50:54PM +0000]:
>> * Nico Schottelius (schottelius@wdt.de) wrote:
>>=20
>> > If I change the notebook it runs fine.
>> > If I change the harddisks it works fine.
>> > If I use 2.5 series kernels it works fine.
>>=20
>> > ALI15X3: IDE controller at PCI slot 00:10.0
>> > ALI15X3: chipset revision 195
>> > ALI15X3: not 100% native mode: will probe irqs later
>> >     ide0: BM-DMA at 0x6050-0x6057, BIOS settings: hda:DMA, hdb:pio
>> >     ide1: BM-DMA at 0x6058-0x605f, BIOS settings: hdc:DMA, hdd:pio

>> I have heard it said that DMA on the ALI chipset is a bit touchy (not
>> sure if driver or hardware) - it is worth trying with the DMA off.

That's curious. I have a toshiba portege 4000 with this chipset and
yes, dma occasionally conks out on this machine (kernel 2.4.19).

It sometimes recovers after disabling dma (automatically, kernel
message) and about 20mins of impatience (me) with an ide incomplete
command notice

  Uniform Multi-Platform E-IDE driver Revision: 6.31
  ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
  ALI15X3: IDE controller on PCI bus 00 dev 20
  PCI: No IRQ known for interrupt pin A of device 00:04.0.
  ALI15X3: chipset revision 195
  ALI15X3: not 100% native mode: will probe irqs later
      ide0: BM-DMA at 0xeff0-0xeff7, BIOS settings: hda:DMA, hdb:pio
      ide1: BM-DMA at 0xeff8-0xefff, BIOS settings: hdc:DMA, hdd:pio
  hda: IC25N020ATDA04-0, ATA DISK drive
  ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
  hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
  ide1 at 0x170-0x177,0x376 on irq 15
  hda: 39070080 sectors (20004 MB) w/1806KiB Cache, CHS=2432/255/63, UDMA(33)
  Partition check:
   /dev/ide/host0/bus0/target0/lun0: p1 p2 p4 < p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 >

I'm afraid most of the kernel error messages never makes it to the logs, but
it's started with

   Dec 24 20:58:00 betty kernel: hda: DMA disabled

and then, for example:

   Dec 23 11:47:20 betty kernel: hda: DMA disabled
   Dec 23 11:47:20 betty kernel: hda: ide_set_handler: handler not null; old=c01c19
e0, new=c01c6d44
   Dec 23 11:47:20 betty kernel: bug: kernel timer added twice at c01c1856.
   Dec 23 11:48:42 betty kernel: SysRq : Changing Loglevel

Here's a recovery, 23 mins later:

   Dec 23 12:11:09 betty kernel: hda: dma_intr: status=0x58 { DriveReady SeekComple
te DataRequest }
   Dec 23 12:12:20 betty last message repeated 3 times
   Dec 23 12:12:20 betty kernel: hda: DMA disabled
   Dec 23 12:12:20 betty kernel: ide0: reset: success
   Dec 23 12:12:20 betty kernel: OK

 
> dma works fine on all other constellations, but I will try it without
> dma as soon as 2.4.20 is compiled...

I am running with hdpam -d0 for safety.


Peter

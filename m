Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSHHEPw>; Thu, 8 Aug 2002 00:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317373AbSHHEPw>; Thu, 8 Aug 2002 00:15:52 -0400
Received: from [61.140.110.4] ([61.140.110.4]:5248 "EHLO systemx.zsu.edu.cn")
	by vger.kernel.org with ESMTP id <S317354AbSHHEPv>;
	Thu, 8 Aug 2002 00:15:51 -0400
Date: Thu, 8 Aug 2002 12:19:22 +0000 (UTC)
From: Bruce M Beach <brucemartinbeach@21cn.com>
X-X-Sender: bmbeach@systemx.zsu.edu.cn
To: linux-kernel@vger.kernel.org
Subject: IDE numbers
Message-ID: <Pine.LNX.4.43.0208081211180.224-100000@systemx.zsu.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Hello All

  I'm just sending these numbers because they are interesting. I bought
  a couple of SCSI drives(seagate) a while ago  so I thought I would try
  a simple performance test. I copied  a 9.2Gb file (using G=1024^3) and
  timed it in the following manner:

  1) Partition to Partition(IDE)  hda1 to hda3  # wd drive
  2) Partition to SCSI drive hda2 to sda1       # wd to seagate
  3) SCSI drive to SCSI drive sda1 to sdb1      # seagate to seagate

  and got the following numbers

  time cp TEMP.tar ... hda3->hda1   49m18.320s ~  3,339,200.9 bytes/s
  time cp TEMP.tar ... hdc1->sda1   51m16.493s
  time cp TEMP.tar ... sda1->scb1    5m41.388s ~ 28,936,063   bytes/s

  At first I thought the IDE numbers were a little bit slow but thought
  the transfer must read and write the 9.2Gb so maybe I should double
  the rate and after all the 33 Mhz is just the IDE bus rate. I was suprised
  at the IDE -> SCSI transfer time except the the SCSI transport(adaptec) is
  on another PCI bus and maybe there is significant latency across the
  bridge.  The real surprise was the SCSI -> SCSI and the ultimate result
  of this little experiment was that I bought 2 more SCSI drives.

  I looked around a little bit to see if dmesg had anything to say
  and found the following lines:

  ...
  Real Time Clock Driver v1.10e
  Non-volatile memory driver v1.1
  block: 128 slots per queue, batch=32
  Uniform Multi-Platform E-IDE driver Revision: 6.31
  ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
  PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=248b
  PCI: Device 00:1f.1 not available because of resource collisions
  PCI_IDE: chipset revision 2
  PCI_IDE: not 100% native mode: will probe irqs later
      ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
      ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
  hda: ST360021A, ATA DISK drive
  hdb: 16X10, ATAPI CD/DVD-ROM drive
  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
  hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=7297/255/63
  Partition check:
   /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
  ...

  What 'PCI: Device 00:1f.1' is I couldn't determine except for a binary
  in /proc/bus/pci/00/1f.1. The PCI slots share resources across
  several bus's, (i.e. Slots 1 & 2 share with the SCSI trasport)
  and the only anomaly is that due to the onboard video having only 4Mb
  ram and there being no AGP slot, there is a PCI video card
  on bus 3.
  Please cc any comments to me.

  Bruce
`


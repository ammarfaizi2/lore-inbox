Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131739AbRCTGqq>; Tue, 20 Mar 2001 01:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131741AbRCTGqg>; Tue, 20 Mar 2001 01:46:36 -0500
Received: from femail4.sdc1.sfba.home.com ([24.0.95.84]:8098 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S131739AbRCTGqW>; Tue, 20 Mar 2001 01:46:22 -0500
From: "Jason Gillis" <gillisja@home.com>
To: <linux-kernel@vger.kernel.org>
Cc: <jgillis@acm.org>
Subject: timeout waiting for DMA...
Date: Mon, 19 Mar 2001 22:48:59 -0800
Message-ID: <NBBBLPKBFDKECAONPJJDEEFCCHAA.gillisja@home.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

   I'm seeing the "timeout waiting for DMA" problems that I've noticed
several others are running up against.  I have a UDMA-66 drive that I
have _full_ of data.  After some amount of disk activity (some can be
very little [a few minutes], or a long time [hours]), I get the
following on the console (copied the best I can):

ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x50 { DriveReady SeekComplete }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: DMA disabled
hdb: DMA disabled
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x50 { DriveReady SeekComplete }
ide0: reset timed out, status=0xd0
hdb: status timeout: status=0xd0 { Busy }
hdb: drive not ready for command
hdc: timeout waiting for DMA

   The IDE controller in question is a Promise 20262 Ultra/66 controller.

   I'd appreciate any suggestions that I can get at this point.  I've
spent lots of time building the 2.4.2 kernel, and that didn't seem to
help.  I had previously been using the 2.2.17 kernel with the latest
IDE patch from people/hedrick to no avail.

   At this point, I'd be more than happy to test out new IDE drivers,
if that's what things take.

   Included below is some info from my system.  I'm not sure what's
useful, so I probably put more here than I needed to.  If there's
something missing, please let me know.  Also, I'm not subscribed to
the list, so a CC back to me would be appreciated!

   Jason
   jgillis@acm.org

===========================

[root@excedrin jgillis]# cat /proc/dma
 4: cascade
 5: GFA1/CS4231 record
 7: CS4231 playback
[root@excedrin jgillis]# cat /proc/interrupts
           CPU0       CPU1
  0:     635966     747681    IO-APIC-edge  timer
  1:          2          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
 10:       2936       2947   IO-APIC-level  ide0, ide1
 11:          0          0    IO-APIC-edge  InterWave
 12:       9391       9560   IO-APIC-level  eth1
 14:      16727      17082   IO-APIC-level  eth0
NMI:    1383582    1383582
LOC:    1383678    1383677
ERR:          0

===========================

[root@excedrin jgillis]# uname -a
Linux excedrin 2.4.2 #1 SMP Sun Mar 18 10:10:31 PST 2001 i686 unknown


===========================
Stuff from dmesg:


ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller on PCI bus 00 dev 39
PCI: Enabling device 00:07.1 (0000 -> 0001)
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
PIIX3: neither IDE port enabled (BIOS)
PDC20262: IDE controller on PCI bus 00 dev 70
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0xac00-0xac07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xac08-0xac0f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU M1623TAU, ATA DISK drive
hdb: Maxtor 86480D6, ATA DISK drive
hdc: WDC WD450AA, ATA DISK drive
ide0 at 0x9c00-0x9c07,0xa002 on irq 10
ide1 at 0xa400-0xa407,0xa802 on irq 10
hda: 3324996 sectors (1702 MB) w/128KiB Cache, CHS=3298/16/63, DMA
hdb: 12594960 sectors (6449 MB) w/256KiB Cache, CHS=13328/15/63, UDMA(33)
hdc: 87930864 sectors (45021 MB) w/2048KiB Cache, CHS=87233/16/63, UDMA(66)
Partition check:
 hda: [PTBL] [824/64/63] hda1 hda2
 hdb: [PTBL] [784/255/63] hdb1
 hdc: [PTBL] [5473/255/63] hdc1


===========================

[root@excedrin jgillis]# cat /proc/pci
...
  Bus  0, device  14, function  0:
    Unknown mass storage controller: Promise Technology, Inc. 20262 (rev 1).
      IRQ 10.
      Master Capable.  Latency=64.
      I/O at 0x9c00 [0x9c07].
      I/O at 0xa000 [0xa003].
      I/O at 0xa400 [0xa407].
      I/O at 0xa800 [0xa803].
      I/O at 0xac00 [0xac3f].
      Non-prefetchable 32 bit memory at 0xe2000000 [0xe201ffff].

===========================

[root@excedrin jgillis]# /sbin/hdparm -i /dev/hda

/dev/hda:

 Model=FUJITSU M1623TAU, FwRev=5243, SerialNo=00002003
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=3298/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=0(?), BuffSize=128kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=2(fast)
 CurCHS=3298/16/63, CurSects=-1176502222, LBA=yes
 LBA CHS=824/64/63 Remapping, LBA=yes, LBAsects=3324996
 tDMA={min:120,rec:120}, DMA modes: sword0 sword1 sword2 mword0 mword1
*mword2
 IORDY=yes, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4

[root@excedrin jgillis]# /sbin/hdparm -i /dev/hdb

/dev/hdb:

 Model=Maxtor 86480D6, FwRev=NAVX171F, SerialNo=L6066EZA
 Config={ Fixed }
 RawCHS=13328/15/63, TrkSize=0, SectSize=0, ECCbytes=20
 BuffType=3(DualPortCache), BuffSize=256kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=2(fast)
 CurCHS=13328/15/63, CurSects=789577920, LBA=yes
 LBA CHS=784/255/63 Remapping, LBA=yes, LBAsects=12594960
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 *mode2

[root@excedrin jgillis]# /sbin/hdparm -i /dev/hdc

/dev/hdc:

 Model=WDC WD450AA, FwRev=10.09K11, SerialNo=WD-WMA2E1006236
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=0(slow)
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes
 LBA CHS=1023/256/63 Remapping, LBA=yes, LBAsects=87930864
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 mode2

[root@excedrin jgillis]#

===========================


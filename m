Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129595AbQK3PyE>; Thu, 30 Nov 2000 10:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129891AbQK3Pxz>; Thu, 30 Nov 2000 10:53:55 -0500
Received: from mx3.port.ru ([194.67.23.37]:12300 "EHLO mx3.port.ru")
        by vger.kernel.org with ESMTP id <S129595AbQK3Pxs>;
        Thu, 30 Nov 2000 10:53:48 -0500
From: "Guennadi Liakhovetski" <gvlyakh@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: DMA for triton again...
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 143.167.4.62 via proxy [143.167.1.16]
Reply-To: "Guennadi Liakhovetski" <gvlyakh@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E141VYN-000PiF-00@f11.mail.ru>
Date: Thu, 30 Nov 2000 18:23:19 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody

I know this subject has been discussed multiple times already, I've read a lot of posts about it, but still haven't been able to fix my particular case. So, here we go:

computer: Chipset 430FX / Triton / PIIX, disk Western Digital Caviar AC21600H Firmware code F6 (no UDMA, some WD docs show DMA mw2, some PIO4...), kernel 2.2.17 with ide patch and PIIX enabled, DMA by default, generic DMA, and couple others. Did not try 'bad DMA-firmware (EXPERIMENTAL)'. dmesg (relevant - in my view - lines):

 Linux version 2.2.17 (root@risky) (gcc version 2.7.2.3) #22 Wed Nov 29 23:04:12
 GMT 2000
 Detected 74540 kHz processor.
 ...
 Memory: 47168k/49152k available (828k kernel code, 412k reserved, 700k data,
 44k init)
 ...
 CPU: Intel Pentium 75 - 200 stepping 05
 ...
 PCI: PCI BIOS revision 2.10 entry at 0xfcb81
 PCI: Using configuration type 1
 PCI: Probing PCI hardware
 ...
 Uniform Multi-Platform E-IDE driver Revision: 6.30
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 PIIX: IDE controller on PCI bus 00 dev 38
 PIIX: chipset revision 2
 PIIX: not 100% native mode: will probe irqs later
 PIIX: neither IDE port enabled (BIOS)
 hda: WDC AC21600H, ATA DISK drive
 hdc: BCD-16X 1997-03-25, ATAPI CDROM drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 ide1 at 0x170-0x177,0x376 on irq 15
 hda: WDC AC21600H, 1549MB w/128kB Cache, CHS=787/64/63
 ...
 Partition check:
  hda: hda1 hda2 hda3
 VFS: Mounted root (ext2 filesystem) readonly.
 ...

BIOS DOES identify the hard disk and the CD-ROM correctly, although it is pretty old and no newer version is available. hdparm -d1 returns:
 /dev/hda:
  setting using_dma to 1 (on)
  HDIO_SET_DMA failed: Operation not permitted
  using_dma    =  0 (off)
 hdparm -I:
 /dev/hda:

  Model=DW CCA1206H0                            , FwRev=420.P980,
 SerialNo=DWW-3M63
  Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
  RawCHS=3148/16/63, TrkSize=57600, SectSize=600, ECCbytes=22
  BuffType=3(DualPortCache), BuffSize=128kB, MaxMultSect=16, MultSect=16
  DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=0(slow)
  CurCHS=3148/16/63, CurSects=3173184, LBA=yes, LBAsects=3173184
  DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=0(slow)
  CurCHS=3148/16/63, CurSects=3173184, LBA=yes, LBAsects=3173184
  tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2
  IORDY=on/off, tPIO={min:160,w/IORDY:120}, PIO modes: mode3 mode4

(yesterday I installed hdparm-3.9, now output is in slightly different format, but the same contents). hdparm -v reports dma off. lspci looks fine... hdparm -tT gives 4.8MB/s. I just downloaded a patch by Andre Hedrick for hdparm-3.9a (why 'a', BTW? is it the patch to hdparm-3.9 actually?). Will try it tonight - would that help? I'll rather stop trying to foresee what information is needed here, it is already TOO long, sorry.

Thanks in advance
Guennadi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

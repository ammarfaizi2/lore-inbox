Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSHRTK7>; Sun, 18 Aug 2002 15:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSHRTK7>; Sun, 18 Aug 2002 15:10:59 -0400
Received: from tomts16.bellnexxia.net ([209.226.175.4]:31126 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S315717AbSHRTK4>; Sun, 18 Aug 2002 15:10:56 -0400
Subject: 2.4.18-rc3aa3: dma_intr: status=0x51 errors
From: Shane <shane@zeke.yi.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 15:10:09 -0400
Message-Id: <1029697810.2904.15.camel@mars.goatskin.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just tried running Cerberus for 15-20s and I got these errors in the
logs. I do use the nasty binary drivers but I replicated the errors from
a fresh boot without them ever being loaded. Can someone tell me what
these errors mean? And are they dangerous? Are there some docs on these
error codes such that I could translate them myself without having to
bother you guys?

The motherboard is an MSI KT133A
I use LVM on that drive and ext3
The controller the drive is on is a Promise Ultra 133 TX2
The drive is:

/dev/hdg:

 Model=MAXTOR 6L080J4, FwRev=A93.0500, SerialNo=664133005196
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1819kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156355584
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
 AdvancedPM=no WriteCache=enabled
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3
ATA-4 ATA-5 


Aug 18 14:49:58 mars kernel: invalidate: busy buffer
Aug 18 14:49:58 mars last message repeated 21 times
Aug 18 14:50:01 mars CROND[1863]: (root) CMD (/usr/lib/sa/sa1 1 1)
Aug 18 14:50:50 mars kernel: hdg: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Aug 18 14:50:50 mars kernel: hdg: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=61193, sector=61192
Aug 18 14:50:50 mars kernel: end_request: I/O error, dev 22:00 (hdg),
sector 61192
Aug 18 14:50:55 mars kernel: hdg: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Aug 18 14:50:55 mars kernel: hdg: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=61195, sector=61194
Aug 18 14:50:55 mars kernel: end_request: I/O error, dev 22:00 (hdg),
sector 61194

I also ran badblocks -v -s -n -b 4096 -c 128 /dev/hdg1 65000 55000 and
it found nothing.

More info:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 40)
00:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 74)
00:0c.0 Multimedia video controller: Brooktree Corporation Bt848 TV with
DMA push (rev 12)
00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
05)
00:0d.1 Input device controller: Creative Labs SB Live! (rev 05)
00:0e.0 Unknown mass storage controller: Promise Technology, Inc.:
Unknown device 4d69 (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX)
(rev a1)

Regards,

Shane


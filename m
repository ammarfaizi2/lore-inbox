Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbREHH73>; Tue, 8 May 2001 03:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbREHH7T>; Tue, 8 May 2001 03:59:19 -0400
Received: from ha1.rdc2.nsw.optushome.com.au ([203.164.2.50]:46034 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S131563AbREHH7J>; Tue, 8 May 2001 03:59:09 -0400
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
From: "Joel Beach" <joelbeach@optushome.com.au>
To: linux-kernel@vger.kernel.org
Subject: ide messages in log. Hard disk dying or linux ide problem?
X-Mailer: Pronto v2.2.3 On linux/mysql
Date: 08 May 2001 03:01:41 EST
Reply-To: "Joel Beach" <joelbeach@optushome.com.au>
Message-Id: <20010508075901.MQOW13554.mss.rdc2.nsw.optushome.com.au@kinslayer>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Until three or four weeks ago, I have been running kernel 2.4.2 with no
problems. However, my hard disk now seems to be playing up. In my system log, I
get the following messages.

May  3 08:13:14 kinslayer kernel: hda: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=3790389, sector=3790208
May  3 08:13:14 kinslayer kernel: end_request: I/O error, dev 03:01 (hda),
sector 3790208
May  3 08:22:34 kinslayer kernel: hda: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=4614116, sector=4613824
May  3 08:22:34 kinslayer kernel: end_request: I/O error, dev 03:01 (hda),
sector 4613824

This only seems to affect access to my mounted FAT32 partition. Sometimes,
windows itself won't load because it can't find the registry file. 

The problem manifests itself when the computer is first turned on. You can tell
immediately if the problem is going to happen as the BIOS autodetect of the
hard drive takes a long time. The access noise is also quite peculiar, with
three low pitched accesses, followed by three high pitched accesses.

The problem seems to disappear after the computer has been used for a while,
which seems to suggest flakey hardware to me.

Are there any bugs in the linux ide code that would cause a FAT32 to behave
badly for all systems accessing it? What does error 0x40 mean is going wrong?

Joel

Here follows the output of hdparm for the output drive.

/dev/hda:

 Model=WDC WD136BA, FwRev=P74OA30A, SerialNo=WD-WM9530127556
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=1961kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=26712000
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 ATA-4 
 Kernel Drive Geometry LogicalCHS=1662/255/63 PhysicalCHS=26500/16/63

/proc/pci gives this.

PCI devices found:
  Bus  0, device   0, function	0:
    Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System
Controller (rev 35).
      Master Capable.  Latency=120.  
      Prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
      Prefetchable 32 bit memory at 0xeddff000 [0xeddfffff].
      I/O at 0xd600 [0xd603].
  Bus  0, device   1, function	0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP Bridge (rev
1).
      Master Capable.  Latency=120.  Min Gnt=10.
  Bus  0, device   7, function	0:
    ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA (rev 1).
  Bus  0, device   7, function	1:
    IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE (rev 3).
      Master Capable.  Latency=32.  
      I/O at 0xf000 [0xf00f].
  Bus  0, device   7, function	3:
    Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 3).
      Master Capable.  Latency=120.  
  Bus  0, device  10, function	0:
    Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine 10/100] (rev
6).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=118.Max Lat=152.
      I/O at 0xd800 [0xd87f].
      Non-prefetchable 32 bit memory at 0xefffef80 [0xefffefff].
  Bus  0, device  11, function	0:
    Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 7).
      IRQ 9.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=20.
      I/O at 0xda00 [0xda1f].
  Bus  0, device  11, function	1:
    Input device controller: Creative Labs SB Live! (rev 7).
      Master Capable.  Latency=64.  
      I/O at 0xde00 [0xde07].
  Bus  0, device  12, function	0:
    SCSI storage controller: Adaptec AHA-2930CU (rev 3).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=4.
      I/O at 0xdc00 [0xdcff].
      Non-prefetchable 32 bit memory at 0xeffff000 [0xefffffff].
  Bus  1, device   5, function	0:
    VGA compatible controller: nVidia Corporation GeForce 256 DDR (rev 16).
      IRQ 11.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xee000000 [0xeeffffff].
      Prefetchable 32 bit memory at 0xd8000000 [0xdfffffff].


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265069AbUEYTle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbUEYTle (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbUEYTle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:41:34 -0400
Received: from watterson.webonastick.com ([64.253.116.248]:55706 "EHLO
	watterson.webonastick.com") by vger.kernel.org with ESMTP
	id S265069AbUEYTlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:41:07 -0400
Date: Tue, 25 May 2004 15:41:06 -0400
To: linux-kernel@vger.kernel.org
Subject: HPT374: 2.4.26 still has DMA timeouts
Message-ID: <20040525194106.GA28052@webonastick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Ignore-This-Line: 1
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: dse@webonastick.com (Darren Stuart Embry)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running the 2.4.26 kernel for the past few weeks on a system
with an EPoX 8K9A3+ motherboard with an onboard HPT374 we're using for
software RAID 1.  hpt366 is compiled in on our kernel.

We've been having intermittent dma timeouts previous to upgrading to
2.4.26, and we still have them even though 2.4.26 was supposed to fix
the dma timeouts.

The last couple times this happened were on Seagate drives, but this
also happened on a WD drive, so I feel safe ruling out the drives.

These problems only started happening back in December, so I'm not ready
to rule out the hardware itself.

If any more information is required, I'll be more than happy to provide
it.

Thanks a bunch,
Darren

=== kernel log ===
May 16 02:45:31 www kernel: hdg: dma_timer_expiry: dma status == 0x20
May 16 02:45:31 www kernel: hdg: timeout waiting for DMA
May 16 02:45:31 www kernel: hdg: timeout waiting for DMA
May 16 02:45:31 www kernel: hdg: (hpt374_ide_dma_test_irq) called while not waiting
May 16 02:45:31 www kernel: hdg: status timeout: status=0xd0 { Busy }
May 16 02:45:31 www kernel: 
May 16 02:45:31 www kernel: hdg: drive not ready for command
May 16 02:46:06 www kernel: ide3: reset timed-out, status=0x80
May 16 02:46:06 www kernel: hdg: status timeout: status=0x80 { Busy }
May 16 02:46:06 www kernel: 
May 16 02:46:06 www kernel: hdg: drive not ready for command
May 16 02:46:36 www kernel: ), sector 318896
May 16 02:46:36 www kernel: end_request: I/O error, dev 22:01 (hdg), sector 324344
May 16 02:46:36 www kernel: end_request: I/O error, dev 22:01 (hdg), sector 326728
May 16 02:46:36 www kernel: end_request: I/O error, dev 22:01 (hdg), sector 328184
May 16 02:46:36 www kernel: end_request: I/O error, dev 22:01 (hdg), sector 2621592
May 16 02:46:36 www kernel: end_request: I/O error, dev 22:01 (hdg), sector 2883768
May 16 02:46:36 www kernel: raid1: ide/host2/bus1/target0/lun0/part1: rescheduling block 2883768
May 16 02:46:36 www kernel: end_request: I/O error, dev 22:01 (hdg), sector 3932160
May 16 02:46:36 www kernel: end_request: I/O error, dev 22:01 (hdg), sector 3932392
May 16 02:46:36 www kernel: end_request: I/O error, dev 22:01 (hdg), sector 4079384
May 16 02:46:36 www kernel: end_request: I/O error, dev 22:01 (hdg), sector 7340336
May 16 02:46:36 www kernel: end_request: I/O error, dev 22:01 (hdg), sector 10486064
May 16 02:46:36 www kernel: end_request: I/O error, dev 22:01 (hdg), sector 11534824
May 16 02:46:36 www kernel: end_request: I/O error, dev 22:01 (hdg), sector 12594816
May 16 02:46:36 www kernel: raid1: ide/host2/bus1/target0/lun0/part1: rescheduling block 12594816
...(lots of similar logs)...
May 16 02:46:36 www kernel: raid1: ide/host4/bus0/target0/lun0/part1: redirecting sector 203161792 to another mirror
May 16 02:46:36 www kernel: raid1: ide/host4/bus0/target0/lun0/part1: redirecting sector 206362664 to another mirror
May 16 02:46:36 www kernel: raid1: ide/host4/bus0/target0/lun0/part1: redirecting sector 206362672 to another mirror
May 16 02:46:36 www kernel: raid1: ide/host4/bus0/target0/lun0/part1: redirecting sector 206362680 to another mirror
...(lots of similar logs)...
May 16 02:46:37 www kernel: md: recovery thread got woken up ...
May 16 02:46:37 www kernel: md0: no spare disk to reconstruct array! -- continuing in degraded mode
May 16 02:46:37 www kernel: md: recovery thread finished ...

=== dmesg after reboot ===
HPT374: IDE controller at PCI slot 00:0e.0
HPT374: chipset revision 7
HPT374: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:DMA, hdh:pio
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0xcc00-0xcc07, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdk:DMA, hdl:pio
hda: WDC WD800JB-00ETA0, ATA DISK drive
hdc: LITE-ON LTR-52246S, ATAPI CD/DVD-ROM drive
hdg: ST3120026A, ATA DISK drive
blk: queue c02fcffc, I/O limit 4095Mb (mask 0xffffffff)
hdi: WDC WD1200JB-00DUA3, ATA DISK drive
blk: queue c02fd450, I/O limit 4095Mb (mask 0xffffffff)
hdk: ST3120026A, ATA DISK drive
blk: queue c02fd8a4, I/O limit 4095Mb (mask 0xffffffff)

=== /etc/raidtab ===
raiddev /dev/md0
        raid-level 1
        nr-raid-disks 2
        nr-spare-disks 1
        chunk-size 4
        persistent-superblock 1
        device /dev/hdi1
        raid-disk 0
        device /dev/hdg1
        raid-disk 1
        device /dev/hdk1
        spare-disk 0

=== hdparm -i /dev/hd[gik] ===
/dev/hdg:
 Model=ST3120026A, FwRev=3.06, SerialNo=3JT35Z5H
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=234441648
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive Supports : mediumATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6 
/dev/hdi:
 Model=WDC WD1200JB-00DUA3, FwRev=75.13B75, SerialNo=WD-WMAEC1013797
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=74
 BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=234441648
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6 
/dev/hdk:
 Model=ST3120026A, FwRev=3.06, SerialNo=3JT3748P
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=234441648
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive Supports : mediumATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6 

=== /proc/pci ===
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge (rev 0).
      Master Capable.  Latency=8.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (rev 0).
      Master Capable.  No bursts.  Min Gnt=4.
  Bus  0, device   8, function  0:
    VGA compatible controller: Tseng Labs Inc ET6000 (rev 48).
      IRQ 10.
      Non-prefetchable 32 bit memory at 0xe8000000 [0xe8ffffff].
      I/O at 0xa000 [0xa0ff].
  Bus  0, device  10, function  0:
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 12).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xea020000 [0xea020fff].
      I/O at 0xa400 [0xa43f].
      Non-prefetchable 32 bit memory at 0xea000000 [0xea01ffff].
  Bus  0, device  14, function  0:
    RAID bus controller: Triones Technologies, Inc. HPT374 (rev 7).
      IRQ 11.
      Master Capable.  Latency=120.  Min Gnt=8.Max Lat=8.
      I/O at 0xa800 [0xa807].
      I/O at 0xac00 [0xac03].
      I/O at 0xb000 [0xb007].
      I/O at 0xb400 [0xb403].
      I/O at 0xb800 [0xb8ff].
  Bus  0, device  14, function  1:
    RAID bus controller: Triones Technologies, Inc. HPT374 (#2) (rev 7).
      IRQ 11.
      Master Capable.  Latency=120.  Min Gnt=8.Max Lat=8.
      I/O at 0xbc00 [0xbc07].
      I/O at 0xc000 [0xc003].
      I/O at 0xc400 [0xc407].
      I/O at 0xc800 [0xc803].
      I/O at 0xcc00 [0xccff].
  Bus  0, device  16, function  0:
    USB Controller: VIA Technologies, Inc. USB (rev 128).
      IRQ 10.
      Master Capable.  Latency=32.  
      I/O at 0xd000 [0xd01f].
  Bus  0, device  16, function  1:
    USB Controller: VIA Technologies, Inc. USB (#2) (rev 128).
      IRQ 11.
      Master Capable.  Latency=32.  
      I/O at 0xd400 [0xd41f].
  Bus  0, device  16, function  2:
    USB Controller: VIA Technologies, Inc. USB (#3) (rev 128).
      IRQ 5.
      Master Capable.  Latency=32.  
      I/O at 0xd800 [0xd81f].
  Bus  0, device  16, function  3:
    USB Controller: VIA Technologies, Inc. USB 2.0 (rev 130).
      IRQ 11.
      Master Capable.  Latency=32.  
      Non-prefetchable 32 bit memory at 0xea021000 [0xea0210ff].
  Bus  0, device  17, function  0:
    ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge (rev 0).
  Bus  0, device  17, function  1:
    IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 6).
      IRQ 10.
      Master Capable.  Latency=32.  
      I/O at 0xdc00 [0xdc0f].
  Bus  0, device  17, function  5:
    Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 80).
      IRQ 5.
      I/O at 0xe000 [0xe0ff].
  Bus  0, device  18, function  0:
    Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 116).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=3.Max Lat=8.
      I/O at 0xe400 [0xe4ff].
      Non-prefetchable 32 bit memory at 0xea022000 [0xea0220ff].

-- 
Darren Stuart Embry
http://www.webonastick.com/

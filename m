Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTDEJlg (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 04:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTDEJlg (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 04:41:36 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:17551 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id S261321AbTDEJld (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 04:41:33 -0500
Date: Sat, 5 Apr 2003 11:53:15 +0200 (CEST)
From: kernel@ddx.a2000.nu
To: linux-kernel@vger.kernel.org
Subject: onboard ICH4 seen as ICH3 (ultra100 controller onboard) (2.4.20/2.4.21-pre7)
Message-ID: <Pine.LNX.4.53.0304051145500.32647@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mainbord is an intel se7500cw2 (dual xeon)
same problem with 2.4.20 and 2.4.21-pre7

ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH3: IDE controller at PCI slot 00:1f.1
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x7040-0x7047, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x7048-0x704f, BIOS settings: hdc:pio, hdd:pio


but this isn't an ICH3, but an ICH4 :

]$ cat /proc/ide/piix

Controller: 0

                                Intel PIIX4 Ultra 100 Chipset.
--------------- Primary Channel ---------------- Secondary Channel
-------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1
------
DMA enabled:    yes              no              yes               no
UDMA enabled:   yes              no              yes               no
UDMA enabled:   2                X               2                 X
UDMA
DMA
PIO

speed detection is also wrong :

hda: 351651888 sectors (180046 MB) w/2048KiB Cache, CHS=21889/255/63,
UDMA(33)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 351651888 sectors (180046 MB) w/2048KiB Cache, CHS=21889/255/63,
UDMA(33)

while same harddrives (and same cables) on promise Ultra100 controller :

hde: attached ide-disk driver.
hde: host protected area => 1
hde: 351651888 sectors (180046 MB) w/2048KiB Cache, CHS=21889/255/63,
UDMA(100)


]$ cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. e7500 [Plumas] DRAM Controller (rev 3).
  Bus  0, device   0, function  1:
    Class ff00: Intel Corp. e7500 [Plumas] DRAM Controller Error Reporting
(rev 3).
  Bus  0, device   2, function  0:
    PCI bridge: Intel Corp. e7500 [Plumas] HI_B Virtual PCI Bridge (F0)
(rev 3).
      Master Capable.  Latency=64.  Min Gnt=6.
  Bus  0, device  29, function  0:
    USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 2).
      IRQ 10.
      I/O at 0x7000 [0x701f].
  Bus  0, device  29, function  1:
    USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 2).
      IRQ 5.
      I/O at 0x7020 [0x703f].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 66).
      Master Capable.  No bursts.  Min Gnt=14.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801CA ISA Bridge (LPC) (rev 2).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801CA IDE U100 (rev 2).
      I/O at 0x7040 [0x704f].
      Non-prefetchable 32 bit memory at 0x20000000 [0x200003ff].
  Bus  0, device  31, function  3:
    SMBus: Intel Corp. 82801CA/CAM SMBus (rev 2).
      IRQ 11.
      I/O at 0x7060 [0x707f].
  Bus  1, device  28, function  0:
    PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 3).
      Non-prefetchable 32 bit memory at 0xfb100000 [0xfb100fff].
  Bus  1, device  30, function  0:
    PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (#2) (rev 3).
      Non-prefetchable 32 bit memory at 0xfb101000 [0xfb101fff].
  Bus  1, device  29, function  0:
    PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 3).
      Master Capable.  Latency=64.  Min Gnt=38.
  Bus  1, device  31, function  0:
    PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (#2) (rev 3).
      Master Capable.  Latency=64.  Min Gnt=38.
  Bus  2, device   1, function  0:
    RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 1).
      IRQ 10.
      Master Capable.  Latency=72.  Min Gnt=9.
      I/O at 0x8000 [0x800f].
      Non-prefetchable 32 bit memory at 0xfb200000 [0xfb20000f].
      Non-prefetchable 32 bit memory at 0xfb800000 [0xfbffffff].
  Bus  2, device   2, function  0:
    PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 6).
      Master Capable.  Latency=64.  Min Gnt=4.
  Bus  3, device   1, function  0:
    RAID bus controller: Promise Technology, Inc. 20268R (rev 2).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=18.
      I/O at 0x9000 [0x9007].
      I/O at 0x9010 [0x9013].
      I/O at 0x9020 [0x9027].
      I/O at 0x9030 [0x9033].
      I/O at 0x9040 [0x904f].
      Non-prefetchable 32 bit memory at 0xfc000000 [0xfc00ffff].
  Bus  3, device   2, function  0:
    RAID bus controller: Promise Technology, Inc. 20268R (#2) (rev 2).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=18.
      I/O at 0x9080 [0x9087].
      I/O at 0x9090 [0x9093].
      I/O at 0x90a0 [0x90a7].
      I/O at 0x90b0 [0x90b3].
      I/O at 0x90c0 [0x90cf].
      Non-prefetchable 32 bit memory at 0xfc010000 [0xfc01ffff].
  Bus  4, device   1, function  0:
    Ethernet controller: Intel Corp. 82545EM Gigabit Ethernet Controller
(rev 1).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=255.
      Non-prefetchable 64 bit memory at 0xfc100000 [0xfc11ffff].
      I/O at 0xa000 [0xa03f].
  Bus  5, device   2, function  0:
    SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 0).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=8.
      I/O at 0xb000 [0xb0ff].
      Non-prefetchable 32 bit memory at 0xfc220000 [0xfc220fff].
  Bus  5, device   3, function  0:
    VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).
      IRQ 11.
      Master Capable.  Latency=66.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
      I/O at 0xb400 [0xb4ff].
      Non-prefetchable 32 bit memory at 0xfc221000 [0xfc221fff].
  Bus  5, device   6, function  0:
    RAID bus controller: Promise Technology, Inc. 20267 (rev 2).
      IRQ 11.
      Master Capable.  Latency=64.
      I/O at 0xb850 [0xb857].
      I/O at 0xb844 [0xb847].
      I/O at 0xb848 [0xb84f].
      I/O at 0xb840 [0xb843].
      I/O at 0xb800 [0xb83f].
      Non-prefetchable 32 bit memory at 0xfc200000 [0xfc21ffff].

]$ cat /proc/ide/ide0/config
pci bus 00 device f9 vendor 8086 device 248b channel 0
86 80 8b 24 07 00 80 02 02 8a 01 01 00 00 00 00
01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
41 70 00 00 00 00 00 20 00 00 00 00 86 80 19 34
00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
07 a3 07 a3 00 00 00 00 05 00 02 02 00 00 00 00
00 00 00 00 00 04 00 00 00 00 00 00 00 00 00 00
08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 47 0f 00 00 00 00 00 00

]$ cat /proc/ide/ide1/config
pci bus 00 device f9 vendor 8086 device 248b channel 1
86 80 8b 24 07 00 80 02 02 8a 01 01 00 00 00 00
01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
41 70 00 00 00 00 00 20 00 00 00 00 86 80 19 34
00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
07 a3 07 a3 00 00 00 00 05 00 02 02 00 00 00 00
00 00 00 00 00 04 00 00 00 00 00 00 00 00 00 00
08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 47 0f 00 00 00 00 00 00


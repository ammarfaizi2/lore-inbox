Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTDDWd3 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 17:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbTDDWd3 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 17:33:29 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:142 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id S261380AbTDDWd0 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 17:33:26 -0500
Date: Sat, 5 Apr 2003 00:44:59 +0200 (CEST)
From: kernel@ddx.a2000.nu
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, jonathan@explainerdc.com
Subject: Re: Linux 2.4.21-pre7
In-Reply-To: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.53.0304050039390.15373@ddx.a2000.nu>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.21-pre7, same problem Jonathan Vardy described yesterday
Promise controllers are not working :

ICH3: IDE controller at PCI slot 00:1f.1
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x7040-0x7047, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x7048-0x704f, BIOS settings: hdc:pio, hdd:pio
PDC20270: IDE controller at PCI slot 03:01.0
PDC20270: chipset revision 2
PDC20270: not 100% native mode: will probe irqs later
PDC20270: neither IDE port enabled (BIOS)
PDC20270: neither IDE port enabled (BIOS)
PDC20267: IDE controller at PCI slot 05:06.0
PCI: Found IRQ 11 for device 05:06.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: neither IDE port enabled (BIOS)

(PDC20270= fasttrak tx4/ PDC20267= onboard ultra100)

works ok in 2.4.20

]$ cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:      34480          0          0          0          XT-PIC  timer
  1:          3          0          0          0          XT-PIC  keyboard
  2:          0          0          0          0          XT-PIC  cascade
  5:       2762          0          0          0          XT-PIC  aic7xxx
  8:          1          0          0          0          XT-PIC  rtc
 10:       4180          0          0          0          XT-PIC  3ware
Storage Controller, eth0
 12:          0          0          0          0          XT-PIC  PS/2
Mouse
 14:         18          0          0          0          XT-PIC  ide0
 15:         18          0          0          0          XT-PIC  ide1
NMI:          0          0          0          0
LOC:      34354      34363      34364      34364
ERR:          0
MIS:          0

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




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289775AbSAWLAs>; Wed, 23 Jan 2002 06:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289685AbSAWLAi>; Wed, 23 Jan 2002 06:00:38 -0500
Received: from pacujo.datastreet.com ([208.179.44.95]:21764 "EHLO
	lumo.pacujo.nu") by vger.kernel.org with ESMTP id <S289789AbSAWLA0>;
	Wed, 23 Jan 2002 06:00:26 -0500
To: linux-kernel@vger.kernel.org
CC: miles@megapathdsl.net.marko
Subject: IRQ routing conflict
From: Marko Rauhamaa <marko@pacujo.nu>
Date: 23 Jan 2002 02:58:46 -0800
Message-ID: <m3hepd1ggp.fsf@lumo.pacujo.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A google search revealed
(http://www.cs.helsinki.fi/linux/linux-kernel/2001-44/1775.html)
that you have recently had similar trouble as I have with PCI
interrupts. Have you found a resolution to the trouble?

My new laptop is mostly working, but I can't get my sound card to
produce a sound. I'm suspecting that the sound driver is not receiving
interrupts. I can hear the clicking when the driver is loaded -- and I
have used aumix to set the volume. Both ALSA and OSS (commercial) fail
the same way.

I'm running 2.4.17 with SuSE 7.3.

Here's a snippet from dmesg:
========================================================================
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:0a.0
IRQ routing conflict for 00:07.5, have irq 5, want irq 11
PCI: Sharing IRQ 11 with 00:0b.0
Yenta IRQ list 0408, PCI irq11
           :           :           :
           :           :           :
PCI: Found IRQ 11 for device 00:07.5
IRQ routing conflict for 00:07.5, have irq 5, want irq 11
PCI: Sharing IRQ 11 with 00:0a.0
PCI: Sharing IRQ 11 with 00:0b.0
spurious 8259A interrupt: IRQ7.
========================================================================

Here are my interrupts:
========================================================================
           CPU0
  0:     270804          XT-PIC  timer
  1:       4191          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       5014          XT-PIC  ray_cs
  5:       7287          XT-PIC  VIA686A
  8:          2          XT-PIC  rtc
  9:      18085          XT-PIC  usb-uhci
 11:       1831          XT-PIC  eth0, Texas Instruments PCI1410 PC card Cardbus Controller
 14:      47416          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0
LOC:     270729
ERR:         77
========================================================================

And here's /proc/pci:
========================================================================
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 128).
      Master Capable.  Latency=8.  
      Prefetchable 32 bit memory at 0xec000000 [0xefffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 66).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=64.  
      I/O at 0x1840 [0x184f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 26).
      IRQ 9.
      Master Capable.  Latency=64.  
      I/O at 0x1800 [0x181f].
  Bus  0, device   7, function  4:
    Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 64).
  Bus  0, device   7, function  5:
    Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 80).
      IRQ 5.
      I/O at 0x1000 [0x10ff].
      I/O at 0x1854 [0x1857].
      I/O at 0x1850 [0x1853].
  Bus  0, device   9, function  0:
    Communication controller: Conexant HSF 56k HSFi Modem (rev 1).
      IRQ 4.
      Master Capable.  Latency=64.  
      Non-prefetchable 32 bit memory at 0xe8000000 [0xe800ffff].
      I/O at 0x1858 [0x185f].
  Bus  0, device  10, function  0:
    CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 1).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0xffbfe000 [0xffbfefff].
  Bus  0, device  11, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0x1400 [0x14ff].
      Non-prefetchable 32 bit memory at 0xe8010000 [0xe80100ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: PCI device 5333:8d02 (S3 Inc.) (rev 1).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xe8100000 [0xe817ffff].
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
========================================================================

Should I return the laptop to the shop? (It's a Compaq Presario 700Z).


Marko

-- 
Marko Rauhamaa    mailto:marko@pacujo.nu     http://www.pacujo.nu/marko/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271021AbUJUWJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271021AbUJUWJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271020AbUJUWJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:09:46 -0400
Received: from mailgate1.uni-kl.de ([131.246.120.5]:12526 "EHLO
	mailgate1.uni-kl.de") by vger.kernel.org with ESMTP id S271009AbUJUWHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:07:55 -0400
Date: Fri, 22 Oct 2004 00:04:38 +0200
From: Eduard Bloch <edi@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [2.6.9-rc?] long pause after IDE detection
Message-ID: <20041021220438.GA13864@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a strange problem since 2.6.9-rc3 or so: after the first two IDE
interfaces of my laptop have been detected, it waits for about 30
seconds to continue. It does simply nothing in the meantime. This began
with 2.6.9-rc3 or maybe earlier but I do not have such problem with
2.6.8.1. I also get the attached output. I have no idea how it gets the
idea that there are ide2..5. I will also attach some hardware data.  It
is a Toshiba laptop, Satellite Pro 2100.

Thanks,
Eduard.

# kernel log
Probing IDE interface ide0...
hda: IC25N030ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-C2612, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
...

lspci
0000:00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
0000:00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 42)
0000:00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio Controller (rev 02)
0000:00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 420 Go] (rev a3)
0000:02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
0000:02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller (rev 42)
0000:02:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
0000:02:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
0000:02:0d.0 System peripheral: Toshiba America Info Systems SD TypA Controller (rev 03)

# ide config
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

# /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 4).
      Prefetchable 32 bit memory at 0xe0000000 [0xefffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 4).
      Master Capable.  Latency=64.  Min Gnt=8.
  Bus  0, device  29, function  0:
    USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 2).
      IRQ 11.
      I/O at 0xefe0 [0xefff].
  Bus  0, device  29, function  1:
    USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 2).
      IRQ 11.
      I/O at 0xef80 [0xef9f].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801 PCI Bridge (rev 66).
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 2).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801CAM IDE U100 (rev 2).
      IRQ 11.
      I/O at 0xcfa0 [0xcfaf].
      Non-prefetchable 32 bit memory at 0x30000000 [0x300003ff].
  Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio Controller (rev 2).
      IRQ 11.
      I/O at 0xce00 [0xceff].
      I/O at 0xcdc0 [0xcdff].
  Bus  0, device  31, function  6:
    Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 2).
      IRQ 11.
      I/O at 0xca00 [0xcaff].
      I/O at 0xc980 [0xc9ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV17 [GeForce4 420 Go] (rev 163).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
      Prefetchable 32 bit memory at 0xdc000000 [0xdfffffff].
      Prefetchable 32 bit memory at 0xdbf80000 [0xdbffffff].
  Bus  2, device   7, function  0:
    FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (rev 0).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=4.
      Non-prefetchable 32 bit memory at 0xfceff800 [0xfcefffff].
      Non-prefetchable 32 bit memory at 0xfcef8000 [0xfcefbfff].
  Bus  2, device   8, function  0:
    Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller (rev 66).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xfcef7000 [0xfcef7fff].
      I/O at 0xdf40 [0xdf7f].
  Bus  2, device  11, function  0:
    CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 50).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=128.Max Lat=5.
      Non-prefetchable 32 bit memory at 0x30001000 [0x30001fff].
  Bus  2, device  11, function  1:
    CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (#2) (rev 50).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=128.Max Lat=5.
      Non-prefetchable 32 bit memory at 0x30002000 [0x30002fff].
  Bus  2, device  13, function  0:
    System peripheral: Toshiba America Info Systems SD TypA Controller (rev 3).
      IRQ 11.
      Non-prefetchable 32 bit memory at 0xfcef6e00 [0xfcef6fff].

# /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Mobile Intel(R) Pentium(R) 4 - M CPU 1.90GHz
stepping	: 7
cpu MHz		: 1894.168
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 3751.93

-- 
Die Asiaten haben den Weltmarkt mit unlauteren Methoden erobert: sie
arbeiten während der Arbeitszeit.
		-- Ephraim Kishon (alias Ferenc Hoffmann)

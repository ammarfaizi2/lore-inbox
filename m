Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291117AbSAaPq3>; Thu, 31 Jan 2002 10:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291116AbSAaPqS>; Thu, 31 Jan 2002 10:46:18 -0500
Received: from OL10K-24.207.148.94.charter-stl.com ([24.207.148.94]:2688 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S291115AbSAaPqH>;
	Thu, 31 Jan 2002 10:46:07 -0500
Message-Id: <200201311547.g0VFlCk00985@linux.local>
Content-Type: text/plain; charset=US-ASCII
From: Its Squash <squash2@dropnet.net>
Reply-To: squash2@dropnet.net
To: linux-kernel@vger.kernel.org
Subject: (ide_setup_pci_device:) Could not enable device (2.5.3 final - ICH3 + CMD646)
Date: Thu, 31 Jan 2002 09:47:12 -0600
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My laptop will not boot on the current 2.5 kernels. It worked fine on 2.5.1. When docked, there is an additional IDE controller. The system boots fine if undocked.

The pertinant part of dmesg from 2.5.1:
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3: IDE controller on PCI slot 00:1f.1
PCI: Device 00:1f.1 not available because of resource collisions
ICH3: chipset revision 1
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x4060-0x4067, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4068-0x406f, BIOS settings: hdc:DMA, hdd:pio
CMD646: IDE controller on PCI slot 05:07.0
PCI: Device 05:07.0 not available because of resource collisions
CMD646: Missing I/O address #0
CMD646: device disabled (BIOS)


on 2.5.3:
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx 
ICH3: IDE controller on PCI slot 00:1f.1 
PCI: Device 00:1f.1 not available because of resource collisions 
ICH3: (ide_setup_pci_device:) Could not enable device 
CMD646: IDE controller on PCI slot 05:07.0 
CMD646: chipset revision 7 
CMD646: chipset revision 0x07, UltraDMA Capable 
CMD646: 100% native mode on irq 11 
    ide0: BM-DMA at 0x2040-0x2047, BIOS settings: hda:pio, hdb:pio 
    ide1: BM-DMA at 0x2048-0x204f, BIOS settings: hdc:pio, hdd:pio 
ide2: ports already in use, skipping probe 

I tried booting with pci=biosirq, and I get the same output from 2.5.3. 2.5.1 gives me:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3: IDE controller on PCI slot 00:1f.1
PCI: Device 00:1f.1 not available because of resource collisions
ICH3: chipset revision 1
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x5060-0x5067, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x5068-0x506f, BIOS settings: hdc:DMA, hdd:pio
CMD646: IDE controller on PCI slot 05:07.0
CMD646: chipset revision 7
CMD646: 100% native mode on irq 11
    ide2: BM-DMA at 0x2040-0x2047, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x2048-0x204f, BIOS settings: hdg:pio, hdh:pio


output of lspci while docked:
00:00.0 Host bridge: Intel Corporation: Unknown device 3575 (rev 02)
00:01.0 PCI bridge: Intel Corporation: Unknown device 3576 (rev 02)
00:1d.0 USB Controller: Intel Corporation: Unknown device 2482 (rev 01)
00:1d.1 USB Controller: Intel Corporation: Unknown device 2484 (rev 01)
00:1d.2 USB Controller: Intel Corporation: Unknown device 2487 (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI (-M) (rev 41)
00:1f.0 ISA bridge: Intel Corporation: Unknown device 248c (rev 01)
00:1f.1 IDE interface: Intel Corporation: Unknown device 248a (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4c59
02:03.0 CardBus bridge: Texas Instruments PCI1420
02:03.1 CardBus bridge: Texas Instruments PCI1420
02:04.0 Communication controller: Lucent Microelectronics LT WinModem (rev 02)
02:07.0 PCI bridge: Intel Corporation 82380FB (rev 01)
02:08.0 Ethernet controller: Intel Corporation 82801CAM (ICH3) Chipset Ethernet Controller (rev 41)
02:09.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
05:07.0 Class ffff: CMD Technology Inc PCI0646 (rev ff)
05:08.0 Class ffff: Intel Corporation 82557 [Ethernet Pro 100] (rev ff)

with pci=biosirq:
00:00.0 Host bridge: Intel Corporation: Unknown device 3575 (rev 02)
00:01.0 PCI bridge: Intel Corporation: Unknown device 3576 (rev 02)
00:1d.0 USB Controller: Intel Corporation: Unknown device 2482 (rev 01)
00:1d.1 USB Controller: Intel Corporation: Unknown device 2484 (rev 01)
00:1d.2 USB Controller: Intel Corporation: Unknown device 2487 (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI (-M) (rev 41)
00:1f.0 ISA bridge: Intel Corporation: Unknown device 248c (rev 01)
00:1f.1 IDE interface: Intel Corporation: Unknown device 248a (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4c59
02:03.0 CardBus bridge: Texas Instruments PCI1420
02:03.1 CardBus bridge: Texas Instruments PCI1420
02:04.0 Communication controller: Lucent Microelectronics LT WinModem (rev 02)
02:07.0 PCI bridge: Intel Corporation 82380FB (rev 01)
02:08.0 Ethernet controller: Intel Corporation 82801CAM (ICH3) Chipset Ethernet Controller (rev 41)
02:09.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
05:07.0 IDE interface: CMD Technology Inc PCI0646 (rev 07)
05:08.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)



Any help is appreciated.

Josh

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270207AbRIFJvX>; Thu, 6 Sep 2001 05:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272441AbRIFJvM>; Thu, 6 Sep 2001 05:51:12 -0400
Received: from p071.n01.ham.access.is-europe.net ([195.179.168.71]:1028 "HELO
	spot.local") by vger.kernel.org with SMTP id <S270207AbRIFJu4>;
	Thu, 6 Sep 2001 05:50:56 -0400
Date: Thu, 6 Sep 2001 11:52:22 +0200
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Problems with ALI15X3 IDE driver in 2.4.9
Message-ID: <20010906115222.A337@munich.netsurf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.9 i686
X-Species: Snow Leopard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I'm experiencing the following problems with the ALI IDE driver. The
board used is a Asus P5A-B (lspci, see end of mail). The kernel was upgraded
from 2.4.5 to 2.4.9. The new Kernel shows three problems that seem to be
related to the IDE interface more or less.

	1. There is a strange probe for device "hde". There is no other IDE 
controller in the system.

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0.
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALL ST1.6A, ATA DISK drive
hdb: IBM-DTLA-305030, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hde: probing with STATUS(0xff) instead of ALTSTATUS(0x08)
hde: IRQ probe failed (0xfffffef8)
hde: probing with STATUS(0xff) instead of ALTSTATUS(0x75)
hde: IRQ probe failed (0xfffffef8)
hde: no response (status = 0xff), resetting drive
hde: IRQ probe failed (0xfffffef8)
hde: no response (status = 0xff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 3153024 sectors (1614 MB) w/81KiB Cache, CHS=782/64/63, UDMA(33)
hdb: 60036480 sectors (30739 MB) w/380KiB Cache, CHS=3737/255/63, UDMA(33)


	2. There are occasional "timeout waiting for DMA" messages in the 
syslog and the system freezes for a couple of seconds.

Sep  6 11:32:21 spot kernel: hda: timeout waiting for DMA
Sep  6 11:32:21 spot kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Sep  6 11:32:21 spot kernel: hda: status error: status=0x5a { DriveReady SeekComplete DataRequest Index }
Sep  6 11:32:21 spot kernel: hda: drive not ready for command


	3. The system has an ancient floppy tape drive that uses the ftape 
driver. It used to work fine until now. As of 2.4.9 the system completely 
locks up when I try to access the tape drive. No syslog messages, only reset 
brings it back alive.


	All this never showed up in 2.4.5 as I can remember. Nothing in the 
system's hardware configuration was changed. I'll be thankful for any ideas, 
especially the tape drive problem. Below is the output of lspci.

Bye

Oliver


00:00.0 Host bridge: Acer Laboratories Inc. M1541 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. M5243 (rev 04)
00:02.0 USB Controller: Acer Laboratories Inc. M5237 (rev 03)
00:03.0 Bridge: Acer Laboratories Inc. M7101
00:07.0 ISA bridge: Acer Laboratories Inc. M1533 (rev c3)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 8029
00:0a.0 Ethernet controller: Silicon Integrated Systems: Unknown device 0900 (rev 02)
00:0b.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz] (rev 02)
00:0f.0 IDE interface: Acer Laboratories Inc. M5229 (rev c1)



-- 
Oliver Feiler                                               kiza@gmx.net
http://www.lionking.org/~kiza/pgpkey              PGP key ID: 0x561D4FD2
http://www.lionking.org/~kiza/

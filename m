Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319026AbSIDDKS>; Tue, 3 Sep 2002 23:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319027AbSIDDKS>; Tue, 3 Sep 2002 23:10:18 -0400
Received: from [199.106.20.3] ([199.106.20.3]:16349 "EHLO chaos.wsm.com")
	by vger.kernel.org with ESMTP id <S319026AbSIDDKR>;
	Tue, 3 Sep 2002 23:10:17 -0400
Subject: 2.4.18 & 2.4.19 IDE chipset clash? Promise PDC20267/SvrWks CSB5
From: Jeff Johnson <jeff@wsm.com>
To: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 03 Sep 2002 20:12:47 -0700
Message-Id: <1031109167.4925.38.camel@eljefe.wsm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

	I am trying to get a kernel running on an Intel SCB2 board. It has
onboard Promise PDC20267 RAID and Serverworks IDE controllers. The
problem I am seeing is when Promise support is compiled into the kernel
the Serverworks IDE chip will appear but fail to become available. The
CDROM drive attached to the Serverworks chip is never visible. If I
disable the Promise chip in the board's bios and boot the same kernel
the serverworks IDE attaches and the CDROM shows up and can be accessed.

	I have tried both 2.4.18 and 2.4.19 source and played with different
config combinations. Nothing I change appears to correct the problem.

	I am pretty sure this is something I am doing and not a bug. If someone
would be kind enough to look at the dmesg and /proc/pci excerpts below
along with the kernel config options below I would be grateful.

Thank You,

Jeff

dmesg excerpt 
-------------
PDC20267: IDE controller on PCI bus 00 dev 10
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xfe7e0000
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide0: BM-DMA at 0x1440-0x1447, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1448-0x144f, BIOS settings: hdc:pio, hdd:DMA
SvrWks CSB5: IDE controller on PCI bus 00 dev 79
PCI: Device 00:0f.1 not available because of resource collisions
SvrWks CSB5: (ide_setup_pci_device:) Could not enable device.
hda: IC35L040AVVN07-0, ATA DISK drive
ide0 at 0x1400-0x1407,0x140a on irq 19
blk: queue c03ced44, I/O limit 4095Mb (mask 0xffffffff)


pci excerpt
-----------
PCI devices found:
  Bus  0, device   2, function  0:
    RAID bus controller: Promise Technology, Inc. 20267 (rev 2).
      IRQ 19.
      Master Capable.  Latency=64.
      I/O at 0x1400 [0x1407].
      I/O at 0x1408 [0x140b].
      I/O at 0x1410 [0x1417].
      I/O at 0x140c [0x140f].
      I/O at 0x1440 [0x147f].
      Non-prefetchable 32 bit memory at 0xfe7a0000 [0xfe7bffff].
  Bus  0, device  15, function  1:
    IDE interface: ServerWorks CSB5 IDE Controller (rev 146).
      Master Capable.  Latency=64.
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0x3a0 [0x3af].
      I/O at 0x410 [0x413].


kernel config
-------------
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_FORCE=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_SVWKS=y
# CONFIG_BLK_DEV_OSB4 is not set
CONFIG_BLK_DEV_ATARAID=y
CONFIG_BLK_DEV_ATARAID_PDC=y



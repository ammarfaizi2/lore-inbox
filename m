Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbUKHVPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbUKHVPl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbUKHVPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:15:40 -0500
Received: from ptr-207-54-98-202.ptr.terago.ca ([207.54.98.202]:36745 "EHLO
	nagios.knad.ca") by vger.kernel.org with ESMTP id S261215AbUKHVOd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:14:33 -0500
Message-ID: <418FE1B3.8020203@kuehne-nagel.com>
Date: Mon, 08 Nov 2004 14:14:27 -0700
From: Robert Toole <robert.toole@kuehne-nagel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: alan@lxorq.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
Subject: IT8212 in 2.6.9-ac6 no raid 0 or raid 1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, thanks for your work on the ITE8212 controllers.

Just tried your ac-6 patch for 2.6.9 on my embedded Raid controller. 
with the controller set up in normal (No raid mode) everything is good.

When I try raid 0 or 1, I get the INVALID GEOMETRY: 0 PHYSICAL HEADS? 
error, and the raid device is not accessible after boot.

Maybe I am just missing something silly in the .config?

I put what I think is relevant below, I would be happy to provide extra 
info as requested and help test patches etc...

Please cc me as I am not subscribed to the list.

Thanks in advance,

Robert Toole
Systems Engineer
KN Logistics / Calgary
robert <dot> toole <at> kuehne <dash> nagel <dot> com

Hardware:

Gigabyte GA7N400M Pro 2 (Rev 2.0) Motherboard (with latest BIOS from 
Giga-byte)
Athlon 2200+


Relevant portion of dmesg:

<--snip-->

IT8212: IDE controller at PCI slot 0000:01:0c.0
ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
IT8212: chipset revision 17
IT8212: 100% native mode on irq 11
     ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
it8212: controller in smart mode.
     ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: Integrated Technology Express Inc, ATA DISK drive
ide2 at 0x9410-0x9417,0x9802 on irq 11
Probing IDE interface ide3...
Probing IDE interface ide3...
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: Host Protected Area detected.
	current capacity is 78240863 sectors (40059 MB)
	native  capacity is 78242976 sectors (40060 MB)
hda: 78240863 sectors (40059 MB) w/2048KiB Cache, CHS=16383/255/63, 
UDMA(100)
hda: cache flushes supported
  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hde: max request size: 128KiB
hde: 0 sectors (0 MB)
hde: cache flushes not supported
hde: INVALID GEOMETRY: 0 PHYSICAL HEADS?

<--snip-->

lspci:

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different 
version?) (rev c1)
0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 
(rev c1)
0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 
(rev c1)
0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 
(rev c1)
0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 
(rev c1)
0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 
(rev c1)
0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4)
0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4)
0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 
AC97 Audio Controler (MCP) (rev a1)
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge 
(rev a3)
0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
0000:01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8169 Gigabit Ethernet (rev 10)
0000:01:0c.0 RAID bus controller: Integrated Technology Express, Inc. 
IT/ITE8212 Dual channel ATA RAID controller (PCI version seems to be 
IT8212, embedded seems (rev 11)
0000:01:0e.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 
IEEE-1394a-2000 Controller (PHY/Link)
0000:02:00.0 VGA compatible controller: ATI Technologies Inc RV280 
[Radeon 9200 SE] (rev 01)
0000:02:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 
SE] (Secondary) (rev 01)

My .config:

<--snip-->

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
CONFIG_BLK_DEV_IT8212=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

<--snip-->




-- 



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVAHWsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVAHWsg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVAHWsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:48:36 -0500
Received: from banana.active-ns.com ([213.230.202.60]:51858 "EHLO
	banana.catalyst2.com") by vger.kernel.org with ESMTP
	id S261181AbVAHWsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:48:14 -0500
Message-ID: <41E06378.3020105@linuxmod.co.uk>
Date: Sat, 08 Jan 2005 22:49:28 +0000
From: Joel Cant <lkml@linuxmod.co.uk>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: IDE PCI controllers problems again
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - banana.catalyst2.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxmod.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Further to my problems with the Promise 20269, i swapped my drives over 
to the ITE8212 non-raid controller in my system, but i seem to be 
getting the same issues, although its much more stable at high loads, 
its still has problems with seeking, and DMA. The drives *should* be ok 
as they are all under 6 months old, and smartctl says theres not 
problems with the devices. But somethings causing a lot of corruption on 
the drives, fsck reports a truckload of errors on boot. kernel version 
is 2.6.10-ac7. I'm not sure what to thing about this, the drives seem to 
be fine if i attatch them to the onboard IDE, So theres summat amiss 
with either the cards or the drivers. Any ideas? any thoughts on what i 
can do to test the cards.

the mucky stuff:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 6E030L0, ATA DISK drive
hdb: WDC WD800JB-00CRA1, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SAMSUNG CD-ROM SH-152A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
IT8212: IDE controller at PCI slot 0000:02:04.0
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 25 (level, low) -> IRQ 25
IT8212: chipset revision 17
it821x: controller in pass through mode.
IT8212: 100% native mode on irq 25
    ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: Maxtor 6B300R0, ATA DISK drive
hdf: Maxtor 6B300R0, ATA DISK drive
ide2 at 0xac00-0xac07,0xa882 on irq 25
Probing IDE interface ide3...
hdg: SAMSUNG SP1604N, ATA DISK drive
ide3 at 0xa800-0xa807,0xa482 on irq 25
PDC20269: IDE controller at PCI slot 0000:03:01.0
ACPI: PCI interrupt 0000:03:01.0[A] -> GSI 28 (level, low) -> IRQ 28
PDC20269: chipset revision 2
PDC20269: ROM enabled at 0xfeaf8000
PDC20269: 100% native mode on irq 28
    ide4: BM-DMA at 0xb400-0xb407, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0xb408-0xb40f, BIOS settings: hdk:pio, hdl:pio
Probing IDE interface ide4...
Probing IDE interface ide5...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 60058656 sectors (30750 MB) w/2048KiB Cache, CHS=59582/16/63
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdb: max request size: 128KiB
hdb: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63
hdb: cache flushes not supported
 hdb: hdb1
hde: max request size: 1024KiB
hde: 586114704 sectors (300090 MB) w/16384KiB Cache, CHS=36483/255/63, 
UDMA(133)
hde: cache flushes supported
 hde: hde1
hdf: max request size: 1024KiB
hdf: 586114704 sectors (300090 MB) w/16384KiB Cache, CHS=36483/255/63, 
UDMA(133)
hdf: cache flushes supported
 hdf: hdf1
hdg: max request size: 1024KiB
hdg: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, 
UDMA(100)
hdg: cache flushes supported
 hdg: hdg1
hdc: ATAPI 52X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 16 (level, low) -> IRQ 16
scsi0 : AdvanSys SCSI 3.3K: PCI Ultra: IO 0x9400-0x940F, IRQ 0x10
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:01:00.0[D] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:01:00.0: Advanced Micro Devices [AMD] AMD-8111 USB
ohci_hcd 0000:01:00.0: irq 19, pci mem 0xfe7fd000
ohci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:01:00.1[D] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:01:00.1: Advanced Micro Devices [AMD] AMD-8111 USB (#2)

<snip>

ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first 
block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 224k freed
Adding 2097136k swap on /dev/hda2.  Priority:-1 extents:1
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
ide3: reset: success
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
ide3: reset: success
hdf: dma_timer_expiry: dma status == 0x60
hdf: dma_timer_expiry: dma status == 0x60
hdf: DMA timeout retry
hdf: timeout waiting for DMA
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
ide2: reset: success
hdf: dma_timer_expiry: dma status == 0x60
hdf: DMA timeout retry
hdf: timeout waiting for DMA
hdf: status error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hdf: drive not ready for command
hde: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hde: DMA disabled
hde: drive not ready for command
ide2: reset: success
hdf: dma_timer_expiry: dma status == 0x40
hdf: DMA timeout retry
hdf: timeout waiting for DMA
hdf: status error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
hdf: drive not ready for command
hdf: dma_timer_expiry: dma status == 0x40
hdf: DMA timeout retry
hdf: timeout waiting for DMA
hdf: status error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
hdf: drive not ready for command
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first 
block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)

ReiserFS: hda1: Using r5 hash to sort names
ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
ReiserFS: hdb1: using ordered data mode
ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first 
block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb1: checking transaction log (hdb1)
ReiserFS: hdb1: Using r5 hash to sort names
ReiserFS: hde1: found reiserfs format "3.6" with standard journal
ReiserFS: hde1: using ordered data mode
ReiserFS: hde1: journal params: device hde1, size 8192, journal first 
block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hde1: checking transaction log (hde1)
ReiserFS: hde1: Using r5 hash to sort names
ReiserFS: hdf1: found reiserfs format "3.6" with standard journal
ReiserFS: hdf1: using ordered data mode
ReiserFS: hdf1: journal params: device hdf1, size 8192, journal first 
block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdf1: checking transaction log (hdf1)
ReiserFS: hdf1: Using r5 hash to sort names
ReiserFS: hdg1: found reiserfs format "3.6" with standard journal
ReiserFS: hdg1ReiserFS: hdg1: journal params: device hdg1, size 8192, 
journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdg1: checking transaction log (hdg1)
ReiserFS: hdg1: Using r5 hash to sort names
 using ordered data mode


Thanks in advance

Joel





Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbULYLnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbULYLnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 06:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbULYLnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 06:43:09 -0500
Received: from mail1.asianet.co.th ([203.144.222.229]:55170 "EHLO
	mail.asianet.co.th") by vger.kernel.org with ESMTP id S261502AbULYLmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 06:42:23 -0500
From: Michael Frank <mhf@berlios.de>
To: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: 2.6.10-rc3 after S3 IDE access and button debounce issues
Date: Thu, 23 Dec 2004 17:14:30 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412231714.33097.mhf@berlios.de>
X-imss-version: 2.12
X-imss-result: Passed
X-imss-scores: Clean:99.90000 C:20 M:1 S:5 R:5
X-imss-settings: Baseline:4 C:3 M:4 S:4 R:4 (0.1000 0.3000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Celeron CPU and the following hw

lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06)
0000:00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a)
0000:00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a)
0000:00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
0000:00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
0000:00:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev02)
0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C3265598/6326 (rev 92)
-------------
dmesg
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:pio, hdd:DMA
Probing IDE interface ide0...
hda: QUANTUM FIREBALL CR8.4A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
hdd: SAMSUNG CD-ROM SC-152C, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
[]
hda: max request size: 128KiB
hda: 16514064 sectors (8455 MB) w/418KiB Cache, CHS=16383/16/63
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 >
--------------

root fs on /dev/ram0, gentoo current linked in via NFS. 
hda5 has empty reiserfs on it.

After playing with S3 for a few cycles which had shown no issues ather then the MCE complaint 
at end of this message:

# mount /dev/hda5 /mnt/gentoo  (Preparing to install gentoo)

Kernel log:

Dec 23 21:07:32 mhfd1 hda: DMA timeout error
Dec 23 21:07:32 mhfd1 hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
Dec 23 21:07:32 mhfd1 
Dec 23 21:07:32 mhfd1 ide: failed opcode was: unknown
Dec 23 21:07:32 mhfd1 hda: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
Dec 23 21:07:32 mhfd1 hda: task_in_intr: error=0x04 { DriveStatusError }
Dec 23 21:07:32 mhfd1 ide: failed opcode was: unknown
Dec 23 21:07:32 mhfd1 hda: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
Dec 23 21:07:32 mhfd1 hda: task_in_intr: error=0x04 { DriveStatusError }
Dec 23 21:07:32 mhfd1 ide: failed opcode was: unknown
Dec 23 21:07:32 mhfd1 hda: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
Dec 23 21:07:32 mhfd1 hda: task_in_intr: error=0x04 { DriveStatusError }
Dec 23 21:07:32 mhfd1 ide: failed opcode was: unknown
Dec 23 21:07:32 mhfd1 hda: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
Dec 23 21:07:32 mhfd1 hda: task_in_intr: error=0x04 { DriveStatusError }
Dec 23 21:07:32 mhfd1 ide: failed opcode was: unknown
Dec 23 21:07:32 mhfd1 ide0: reset: success

(/mnt/gentoo was missing try again)
# mkdir /mnt/gentoo
# mount /dev/hda5 /mnt/gentoo

Dec 23 21:13:26 mhfd1 hda: dma_timer_expiry: dma status == 0x21
Dec 23 21:13:35 mhfd1 hda: DMA timeout error
Dec 23 21:13:35 mhfd1 hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
Dec 23 21:13:35 mhfd1 
Dec 23 21:13:35 mhfd1 ide: failed opcode was: unknown
Dec 23 21:13:56 mhfd1 hda: dma_timer_expiry: dma status == 0x21
Dec 23 21:14:06 mhfd1 hda: DMA timeout error
Dec 23 21:14:06 mhfd1 hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
Dec 23 21:14:06 mhfd1 
Dec 23 21:14:06 mhfd1 ide: failed opcode was: unknown
Dec 23 21:14:32 mhfd1 ReiserFS: hda5: found reiserfs format "3.6" with standard journal
Dec 23 21:14:32 mhfd1 ReiserFS: hda5: using ordered data mode
Dec 23 21:14:32 mhfd1 ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Dec 23 21:14:32 mhfd1 ReiserFS: hda5: checking transaction log (hda5)
Dec 23 21:14:50 mhfd1 ReiserFS: hda5: Using r5 hash to sort names

Untared a stage3 tarball via NFS.

One more S3 cycle 

Dec 23 21:42:03 mhfd1 PM: Preparing system for suspend
Dec 23 21:42:32 mhfd1 PM: Entering state.
Dec 23 21:42:32 mhfd1 hwsleep-0316 [17] acpi_enter_sleep_state: Entering sleep state [S3]
Dec 23 21:42:32 mhfd1 Back to C!
Dec 23 21:42:32 mhfd1 PM: Finishing up.
Dec 23 21:42:32 mhfd1 MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Dec 23 21:42:32 mhfd1 Bank 1: f200000000000000
Dec 23 21:42:33 mhfd1 ACPI: Power Button (FF) [PWRF]
Dec 23 21:42:33 mhfd1 ACPI: Sleep Button (CM) [SLPB]

It went to sleep again right away, even although button module was removed... 

Dec 23 21:42:33 mhfd1 PM: Preparing system for suspend
Dec 23 21:43:02 mhfd1 PM: Entering state.
Dec 23 21:43:02 mhfd1 hwsleep-0316 [23] acpi_enter_sleep_state: Entering sleep state [S3]
Dec 23 21:43:02 mhfd1 Back to C!
Dec 23 21:43:02 mhfd1 PM: Finishing up.
Dec 23 21:43:02 mhfd1 MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Dec 23 21:43:02 mhfd1 Bank 1: f200000000000000
Dec 23 21:43:02 mhfd1 ACPI: Power Button (FF) [PWRF]
Dec 23 21:43:02 mhfd1 ACPI: Sleep Button (CM) [SLPB]

# ls /mnt/gentoo/*

Dec 23 21:43:41 mhfd1 hda: dma_timer_expiry: dma status == 0x21
Dec 23 21:43:51 mhfd1 hda: DMA timeout error
Dec 23 21:43:51 mhfd1 hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
Dec 23 21:43:51 mhfd1 
Dec 23 21:43:51 mhfd1 ide: failed opcode was: unknown

ls completes OK after a while...

What to do about the IDE issue?

I use acpid and power button to initiate S3 and remove button module before S3 
as it improves the situation on hardware which otherwhise ends up in an endless
S3 loop. What to do about the button issue?

Regards
Michael




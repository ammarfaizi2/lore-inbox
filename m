Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbTDKH2i (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 03:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbTDKH2e (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 03:28:34 -0400
Received: from softers.net ([213.139.168.106]:43998 "EHLO mail.softers.net")
	by vger.kernel.org with ESMTP id S264308AbTDKH1a (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 03:27:30 -0400
Message-ID: <3E967135.E87F75E6@softers.net>
Date: Fri, 11 Apr 2003 10:39:33 +0300
From: Jarmo =?iso-8859-2?Q?J=E4rvenp=E4=E4?= 
	<Jarmo.Jarvenpaa@softers.net>
Organization: Softers Oy
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Frank <mflt1@micrologica.com.hk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre7, 2.5.66, IDE Errors during boot - just a nuisance ?
References: <200304101552.25091.mflt1@micrologica.com.hk>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed we have the same problem.

This gives a bit of headache, hda1 and hdc1 are software raid 1 array
and sometimes one disk is dropped from the array due "error" on the
disk.
Hotadd will succeed and no bad blocks on either disk. No problems with
2.4.18. Not tested with .19 nor .20.


BR,
Jarmo


Kernel 2.4.2.21-pre6

lspci:
00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev
03)
00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev
03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
00:0e.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W
[Millennium II]
00:10.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)


dmesg:
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALL_TM3200A, ATA DISK drive
hdb: E295X, ATAPI CD/DVD-ROM drive
blk: queue c02e1ee0, I/O limit 4095Mb (mask 0xffffffff)
hdc: QUANTUM FIREBALL_TM3200A, ATA DISK drive
blk: queue c02e2330, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 6281856 sectors (3216 MB) w/76KiB Cache, CHS=779/128/63, DMA
hdc: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: task_no_data_intr: error=0x04 { DriveStatusError }
hdc: 6281856 sectors (3216 MB) w/76KiB Cache, CHS=6232/16/63, DMA
hdb: ATAPI 16X CD-ROM drive, 240kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:


cat /proc/ide/piix
Controller: 0

                                Intel PIIX4 Ultra 33 Chipset.
--------------- Primary Channel ---------------- Secondary Channel
-------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ----------
drive1 ------
DMA enabled:    yes              yes             yes               no
UDMA enabled:   no               no              no                no
UDMA enabled:   X                X               X                 X
UDMA
DMA
PIO


hdparm -I /dev/hda
/dev/hda:

ATA device, with non-removable media
        Model Number:       QUANTUM FIREBALL_TM3200A
        Serial Number:      295702034106
        Firmware Revision:  A6B.2400
Standards:
        Likely used: 2
Configuration:
        Logical         max     current
        cylinders       6232    6232
        heads           16      16
        sectors/track   63      63
        --
        bytes/track: 32256      bytes/sector: 512
        CHS current addressable sectors:    6281856
        LBA    user addressable sectors:    6281856
        device size with M = 1024*1024:        3067 MBytes
        device size with M = 1000*1000:        3216 MBytes (3 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 76.5kB     bytes avail on r/w long: 4
        Standby timer values: spec'd by Vendor
        R/W multiple sector transfer: Max = 16  Current = 16
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=300ns  IORDY flow control=120ns

hdparm -I /dev/hdc
/dev/hdc:

ATA device, with non-removable media
        Model Number:       QUANTUM FIREBALL_TM3200A
        Serial Number:      295634511413
        Firmware Revision:  A6B.2400
Standards:
        Likely used: 2
Configuration:
        Logical         max     current
        cylinders       6232    6232
        heads           16      16
        sectors/track   63      63
        --
        bytes/track: 32256      bytes/sector: 512
        CHS current addressable sectors:    6281856
        LBA    user addressable sectors:    6281856
        device size with M = 1024*1024:        3067 MBytes
        device size with M = 1000*1000:        3216 MBytes (3 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 76.5kB     bytes avail on r/w long: 4
        Standby timer values: spec'd by Vendor
        R/W multiple sector transfer: Max = 16  Current = 16
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=300ns  IORDY flow control=120ns

Michael Frank wrote:
> 
> Noticed this for some time in 2.5.64 and up, and now also in 2.4.21-pre6 and pre7. It was OK 2.4.20. No functional problems were encountered  with 2.4.21, 2.5.6x so far.
> 
> Its a  P1, lspci follows
> 
> 00:00.0 Host bridge: Intel Corp. 430HX - 82439HX TXC [Triton II] (rev 03)
> 00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
> 00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
> 00:09.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)
> 00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
> 00:0b.0 SCSI storage controller: Adaptec AHA-7850 (rev 01)
> 
> Apr 10 15:17:30 mhfl1 kernel: Linux version 2.4.21-pre7-mhf18-np (mhf@mhfl3) (gcc version 2.95.3 20010315 (release)) #2
> 
> Apr 10 15:12:42 mhfl1 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
> Apr 10 15:12:42 mhfl1 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Apr 10 15:12:42 mhfl1 kernel: PIIX3: IDE controller at PCI slot 00:07.1
> Apr 10 15:12:42 mhfl1 kernel: PIIX3: chipset revision 0
> Apr 10 15:12:42 mhfl1 kernel: PIIX3: not 100%% native mode: will probe irqs later
> Apr 10 15:12:42 mhfl1 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
> Apr 10 15:12:42 mhfl1 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
> Apr 10 15:12:42 mhfl1 kernel: hda: QUANTUM BIGFOOT2550A, ATA DISK drive
> Apr 10 15:12:42 mhfl1 kernel: blk: queue c0347ae0, I/O limit 4095Mb (mask 0xffffffff)
> Apr 10 15:12:42 mhfl1 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Apr 10 15:12:43 mhfl1 kernel: hda: attached ide-disk driver.
> 
> ------------------------------\/
> Apr 10 15:12:43 mhfl1 kernel: hda: task_no_data_intr: status=0x53 { DriveReady SeekComplete Index Error }
> Apr 10 15:12:43 mhfl1 kernel: hda: task_no_data_intr: error=0x04 { DriveStatusError }
> 
> Apr 10 15:12:43 mhfl1 kernel: hda: 5033952 sectors (2577 MB) w/87KiB Cache, CHS=624/128/63, DMA
> Apr 10 15:12:43 mhfl1 kernel: Partition check:
> Apr 10 15:12:43 mhfl1 kernel:  hda: hda1 hda2 hda3
> 
> ----------
> Mar 30 15:46:51 mhfl1 kernel: Linux version 2.5.66-mhf2 (mhf@mhfl2) (gcc version 2.95.3 20010315 (release)) #12 Sat Mar 29
> 
> Mar 30 15:47:05 mhfl1 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> Mar 30 15:47:05 mhfl1 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Mar 30 15:47:05 mhfl1 kernel: PIIX3: IDE controller at PCI slot 00:07.1
> Mar 30 15:47:05 mhfl1 kernel: PIIX3: chipset revision 0
> Mar 30 15:47:05 mhfl1 kernel: PIIX3: not 100%% native mode: will probe irqs later
> Mar 30 15:47:05 mhfl1 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
> Mar 30 15:47:05 mhfl1 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
> Mar 30 15:47:05 mhfl1 kernel: hda: QUANTUM BIGFOOT2550A, ATA DISK drive
> Mar 30 15:47:05 mhfl1 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> 
> ------------------------------\/
> Mar 30 15:47:05 mhfl1 kernel: hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> Mar 30 15:47:05 mhfl1 kernel: hda: task_no_data_intr: error=0x04 { DriveStatusError }
> 
> Mar 30 15:47:05 mhfl1 kernel: hda: 5033952 sectors (2577 MB) w/87KiB Cache, CHS=4994/16/63, DMA
> Mar 30 15:47:05 mhfl1 kernel:  hda: hda1 hda2 hda3
> 
> Regards
> Michael
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131070AbQKNOHi>; Tue, 14 Nov 2000 09:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131039AbQKNOH3>; Tue, 14 Nov 2000 09:07:29 -0500
Received: from [213.212.2.140] ([213.212.2.140]:63443 "EHLO echo.southpole.se")
	by vger.kernel.org with ESMTP id <S131020AbQKNOHO>;
	Tue, 14 Nov 2000 09:07:14 -0500
Date: Tue, 14 Nov 2000 14:40:12 +0100
From: Jakob Sandgren <jakob@southpole.se>
To: linux-kernel@vger.kernel.org
Subject: Problems with ide, DMA with _lots_ of controllers. (2.4.0-test9)
Message-ID: <20001114144010.D23051@southpole.se>
Mail-Followup-To: Jakob Sandgren <jakob@southpole.se>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have some problems with one experimental IDE-RAID machine, however
the problem seem not to be with the RAID setup, actually the ide sub
system. 

Basic system information:
=========================
AMD k6-2 with motherboard ALI15X3 IDE
3*PCI HPT366 IDE cards 
PCI SCSI
PCI NIC

5*Maxtor 93652U8 (as master, one on each channel) on the HPT
controller.

CD-ROM (master) + IBM-DTLA-307015 (master) on the ALI15X3

The 5 maxtor disks is used for the RAID.

Problem description:
====================
With DMA disabled everything is _stable_ but the performance is _bad_:


# hdparm -tT /dev/md0 

/dev/md0:
 Timing buffer-cache reads:   128 MB in  2.26 seconds = 56.64 MB/sec
 Timing buffered disk reads:  64 MB in 23.78 seconds =  2.69 MB/sec


With DMA enabled, performance is a better ~10MB/sec but the system is
very unstable. The system locks within seconds or minutes after the
boot.

The message printed before the system locks is something like this:

hdm: timeout wainting for DMA ide_dmaproc: chipset supported ide_1
dma_timeout func only = 14


Anyone who has a clue about this? Below is some additional
information.

Best Regards,
Jakob Sandgren

Nov  6 12:00:11 heffaklump kernel: pty: 256 Unix98 ptys configured
Nov  6 12:00:11 heffaklump kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Nov  6 12:00:11 heffaklump kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov  6 12:00:11 heffaklump kernel: HPT366: IDE controller on PCI bus 00 dev 48
Nov  6 12:00:11 heffaklump kernel: HPT366: chipset revision 1
Nov  6 12:00:11 heffaklump kernel: HPT366: not 100% native mode: will probe irqs later
Nov  6 12:00:11 heffaklump kernel: HPT366: IDE controller on PCI bus 00 dev 49
Nov  6 12:00:11 heffaklump kernel: HPT366: chipset revision 1
Nov  6 12:00:11 heffaklump kernel: HPT366: not 100% native mode: will probe irqs later
Nov  6 12:00:11 heffaklump kernel: HPT366: IDE controller on PCI bus 00 dev 50
Nov  6 12:00:11 heffaklump kernel: HPT366: chipset revision 1
Nov  6 12:00:11 heffaklump kernel: HPT366: not 100% native mode: will probe irqs later
Nov  6 12:00:11 heffaklump kernel: HPT366: IDE controller on PCI bus 00 dev 51
Nov  6 12:00:11 heffaklump kernel: HPT366: chipset revision 1
Nov  6 12:00:11 heffaklump kernel: HPT366: not 100% native mode: will probe irqs later
Nov  6 12:00:11 heffaklump kernel: HPT366: IDE controller on PCI bus 00 dev 68
Nov  6 12:00:11 heffaklump kernel: HPT366: chipset revision 1
Nov  6 12:00:11 heffaklump kernel: HPT366: not 100% native mode: will probe irqs later
Nov  6 12:00:11 heffaklump kernel: HPT366: IDE controller on PCI bus 00 dev 69
Nov  6 12:00:11 heffaklump kernel: HPT366: chipset revision 1
Nov  6 12:00:11 heffaklump kernel: HPT366: not 100% native mode: will probe irqs later
Nov  6 12:00:11 heffaklump kernel: ALI15X3: IDE controller on PCI bus 00 dev 78
Nov  6 12:00:11 heffaklump kernel: ALI15X3: chipset revision 193
Nov  6 12:00:11 heffaklump kernel: ALI15X3 standard IDE storage device detected
Nov  6 12:00:11 heffaklump kernel: hda: IBM-DTLA-307015, ATA DISK drive
Nov  6 12:00:11 heffaklump kernel: hdc: TOSHIBA CD-ROM XM-6502B, ATAPI CDROM drive
Nov  6 12:00:11 heffaklump kernel: hde: Maxtor 93652U8, ATA DISK drive
Nov  6 12:00:11 heffaklump kernel: hdh: Maxtor 93652U8, ATA DISK drive
Nov  6 12:00:11 heffaklump kernel: hdk: Maxtor 93652U8, ATA DISK drive
Nov  6 12:00:11 heffaklump kernel: hdn: Maxtor 93652U8, ATA DISK drive
Nov  6 12:00:11 heffaklump kernel: hdp: Maxtor 93652U8, ATA DISK drive
Nov  6 12:00:11 heffaklump kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov  6 12:00:11 heffaklump kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov  6 12:00:11 heffaklump kernel: ide2 at 0xb800-0xb807,0xb402 on irq 3
Nov  6 12:00:11 heffaklump kernel: ide3 at 0xa800-0xa807,0xa402 on irq 3
Nov  6 12:00:11 heffaklump kernel: ide5 at 0x8800-0x8807,0x8402 on irq 4
Nov  6 12:00:11 heffaklump kernel: ide6 at 0x7000-0x7007,0x6802 on irq 3
Nov  6 12:00:11 heffaklump kernel: ide7 at 0x6000-0x6007,0x5802 on irq 3
Nov  6 12:00:11 heffaklump kernel: hda: 30003120 sectors (15362 MB) w/1916KiB Cache, CHS=1867/255/63
Nov  6 12:00:11 heffaklump kernel: hde: 71346240 sectors (36529 MB) w/2048KiB Cache, CHS=70780/16/63
Nov  6 12:00:11 heffaklump kernel: hdh: 71346240 sectors (36529 MB) w/2048KiB Cache, CHS=70780/16/63
Nov  6 12:00:11 heffaklump kernel: hdk: 71346240 sectors (36529 MB) w/2048KiB Cache, CHS=70780/16/63
Nov  6 12:00:11 heffaklump kernel: hdn: 71346240 sectors (36529 MB) w/2048KiB Cache, CHS=70780/16/63
Nov  6 12:00:11 heffaklump kernel: hdp: 71346240 sectors (36529 MB) w/2048KiB Cache, CHS=70780/16/63
Nov  6 12:00:11 heffaklump kernel: hdc: ATAPI 40X CD-ROM drive, 256kB Cache
Nov  6 12:00:11 heffaklump kernel: Uniform CD-ROM driver Revision: 3.11
Nov  6 12:00:11 heffaklump kernel: Partition check:
Nov  6 12:00:11 heffaklump kernel:  hda: hda1 hda2 < hda5 hda6 >
Nov  6 12:00:11 heffaklump kernel:  hde: hde1
Nov  6 12:00:11 heffaklump kernel:  hdh: hdh1
Nov  6 12:00:11 heffaklump kernel:  hdk: hdk1
Nov  6 12:00:11 heffaklump kernel:  hdn: hdn1
Nov  6 12:00:11 heffaklump kernel:  hdp: hdp1
Nov  6 12:00:11 heffaklump kernel: Floppy drive(s): fd0 is 1.44M

.......

# cat /proc/interrupts 
           CPU0       
0:   42935593          XT-PIC  timer
1:         21          XT-PIC  keyboard
2:          0          XT-PIC  cascade
3:  339227686          XT-PIC  ide2, ide3, ide6, ide7
4:  121313762          XT-PIC  ide5
10:    2319254          XT-PIC  eth0
11:   10798826          XT-PIC  sym53c8xx
12:          0          XT-PIC  PS/2 Mouse
13:          0          XT-PIC  fpu
14:    4356172          XT-PIC  ide0
15:          4          XT-PIC  ide1
NMI:          0 
ERR:          0
# cat /proc/ide/drivers 
ide-cdrom version 4.58
ide-disk version 1.10


-- 
Jakob Sandgren                  South Pole AB
Phone:  +46 8 56610650          Banvaktsvägen 12
Fax:    +46 8 56610601          SE - 17148 Solna 
e-mail: jakob@southpole.se      www.southpole.se
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

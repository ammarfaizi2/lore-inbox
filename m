Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130762AbRBIVVr>; Fri, 9 Feb 2001 16:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130654AbRBIVV1>; Fri, 9 Feb 2001 16:21:27 -0500
Received: from cs167115-141.austin.rr.com ([24.167.115.141]:33856 "EHLO
	fido2.homeip.net") by vger.kernel.org with ESMTP id <S130113AbRBIVVQ>;
	Fri, 9 Feb 2001 16:21:16 -0500
Message-ID: <3A845F46.F7EAC779@mail.utexas.edu>
Date: Fri, 09 Feb 2001 15:21:10 -0600
From: Philip Langdale <philipl@mail.utexas.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac6 i686)
X-Accept-Language: en, zh, zh-CN, zh-TW
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: vojtech@suse.cz
Subject: Comparatively minor problem with via ide.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just upgraded to an Athlon+KT133 from a P3+pro133 setup.

For the old motherboard which had a 596b southbridge I got
perfect udma66 support form my hard drives. After I switched
over, and without changing anything except switching from
p3 to athlon optimisations, the driver reports my drives running
at udma33. This is despite detecting an 80w cable, using ide0=ata66
and turning word93 checking off. The new southbridge is a 686b.

Also, possibly semi-related; it insists on detecting my ls-120 drive
as udma22 even though mwdma11 is the best it can actually do.

I'm not experiencing any corruption, fingers crossed ( I understand
that that was traced to an acpi conflict? ) but this is nevertheless
incorrect behaviour.

/proc/ide/via:

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.20
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
BM-DMA base:                        0xd000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 80w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA      UDMA      UDMA      UDMA
Address Setup:       30ns      30ns      30ns      60ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      90ns      90ns
Data Active:         90ns      90ns      90ns      90ns
Data Recovery:       30ns      30ns      30ns      90ns
Cycle Time:          60ns      60ns      60ns      90ns
Transfer Rate:   33.3MB/s  33.3MB/s  33.3MB/s  22.2MB/s

and relevant dmesg:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
VP_IDE: ATA-66/100 forced bit set (WARNING)!!
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DPTA-372730, ATA DISK drive
hdb: QUANTUM FIREBALL CX6.4A, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive
hdd: LS-120 VER5 00 UHD Floppy, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 53464320 sectors (27374 MB) w/1961KiB Cache, CHS=3328/255/63, UDMA(33)
hdb: 12594960 sectors (6449 MB) w/418KiB Cache, CHS=784/255/63, UDMA(33)
hdc: ATAPI 32X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: 123264kB, 963/8/32 CHS, 533 kBps, 512 sector size, 720 rpm
ide-floppy: hdd: I/O error, pc = 5a, key =  5, asc = 24, ascq =  0

hdparm reports that the drives are udma66 capable which is correct, but how
do I convince the driver to use it?

thanks,

--phil



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

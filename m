Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318796AbSHWNQD>; Fri, 23 Aug 2002 09:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318798AbSHWNQD>; Fri, 23 Aug 2002 09:16:03 -0400
Received: from msgbas1x.net.europe.agilent.com ([192.25.19.109]:10953 "EHLO
	msgbas1.net.europe.agilent.com") by vger.kernel.org with ESMTP
	id <S318796AbSHWNQC>; Fri, 23 Aug 2002 09:16:02 -0400
Message-ID: <C12D24916888D311BC790090275414BB0B724742@oberon.britain.agilent.com>
From: barrie_spence@agilent.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 - Promise TX2 Ultra133 (pdc20269) sticks at UDMA33
Date: Fri, 23 Aug 2002 15:20:11 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.4.19 with a Promise TX2 Ultra133, but even though the card BIOS reports 
UDMA mode 5/6 on the drives, they are reported as UDMA33 by the kernel.

Trying hdparm -X69 after boot gives the message "Speed warnings UDMA 3/4/5 is not functional."

The IBM drive is only ATA100, but the Maxtor (just fitted) is definitely ATA133.

Any ideas?

Unfortunately, I'm running with XFS, so I'm a bit restricted in what kernel versions I can run.

Thanks,
	Barrie

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20269: IDE controller on PCI bus 00 dev 70
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
PDC20269: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide2: BM-DMA at 0x1000-0x1007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1008-0x100f, BIOS settings: hdg:pio, hdh:pio
PIIX4: IDE controller on PCI bus 00 dev 91
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x10a0-0x10a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x10a8-0x10af, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DTTA-371440, ATA DISK drive
hde: IC35L080AVVA07-0, ATA DISK drive
hdg: MAXTOR 6L080J4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0x10c0-0x10c7,0x10b6 on irq 18
ide3 at 0x10b8-0x10bf,0x10b2 on irq 18
hda: 28229040 sectors (14453 MB) w/462KiB Cache, CHS=28005/16/63, UDMA(33)
hde: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=159560/16/63,
UDMA(33)
hdg: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63,
UDMA(33)
 hda: hda1
 hde: hde1
 hdg: unknown partition table
:
:
ide3: Speed warnings UDMA 3/4/5 is not functional.
ide2: Speed warnings UDMA 3/4/5 is not functional.

# hdparm -i /dev/hde

/dev/hde:

 Model=IC35L080AVVA07-0, FwRev=VA4OA50K, SerialNo=VNC400A4G8VSSA
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
 BuffType=DualPortCache, BuffSize=1863kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=160836480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5
 AdvancedPM=yes: disabled (255)
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4 ATA-5

# hdparm -i /dev/hdg

/dev/hdg:

 Model=MAXTOR 6L080J4, FwRev=A93.0500, SerialNo=664212156696
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1819kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=156355584
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6
 AdvancedPM=no
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3 ATA-4
ATA-5


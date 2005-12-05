Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVLEKB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVLEKB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 05:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVLEKB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 05:01:26 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:18158 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751306AbVLEKBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 05:01:25 -0500
From: "Christian Volk" <volk.christian@netcom-sicherheitstechnik.de>
To: <linux-kernel@vger.kernel.org>
Subject: No Hotplug with AHCI (Intel ICH6M) Kernel 2.6.15rc4
Date: Mon, 5 Dec 2005 11:01:20 +0100
Message-ID: <01c301c5f982$d8ddb3c0$0c016696@EW12>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcX5gtdgKmGI3F/SSMesbJ828O2qGQ==
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:1905656f500fac86bf2675c4673a16c5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.15rc4
I am testing the hotplug feature with the Intel ICH6M Chipset and a SATA
harddisk.

I want to use the AHCI driver, because it should support hotplugging.
As you can see, the driver is loadet and the chipset was found correctly.
When I detach the harddisk, there are no kernelmessages indicating hotplug.
The only messages I can see are timeouts from the kernel when writing to
disk(see logfile)
Maybe is it a bug, that the unplugged harddisk is not detected?

Regards
Christian Volk


Lspci ------------------------------------------------------------
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
IDE Controller (rev 04) (prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE
Controller
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at f000 [size=16]
00: 86 80 6f 26 05 00 80 02 04 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 86 80 6f 26
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller
(rev 04) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Intel Corporation 82801FBM (ICH6M) SATA Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at e500 [size=8]
        Region 1: I/O ports at e600 [size=4]
        Region 2: I/O ports at e700 [size=8]
        Region 3: I/O ports at e800 [size=4]
        Region 4: I/O ports at e900 [size=16]
        Region 5: Memory at d02c5000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 53 26 07 00 b0 02 04 8f 01 01 00 00 00 00
10: 01 e5 00 00 01 e6 00 00 01 e7 00 00 01 e8 00 00
20: 01 e9 00 00 00 50 2c d0 00 00 00 00 86 80 53 26
30: 00 00 00 00 70 00 00 00 00 00 00 00 0b 02 00 00
----------------------------------------------------------------------


Booting ------------------------------------------------------------
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

ICH6: IDE controller at PCI slot 0000:00:1f.1

ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11

PCI: setting IRQ 11 as level-triggered

ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) ->
IRQ 11

ICH6: chipset revision 4

ICH6: not 100% native mode: will probe irqs later

    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:DMA

    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio

hdb: WDC WD1200JB-00DUA0, ATA DISK drive

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

hdb: max request size: 1024KiB

hdb: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(33)

hdb: cache flushes supported

 hdb: hdb1 hdb2

ide-floppy driver 0.99.newide

ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11

ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKD] -> GSI 11 (level, low) ->
IRQ 11

ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0x5 impl IDE
mode

ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part 

ata1: SATA max UDMA/133 cmd 0xE002E100 ctl 0x0 bmdma 0x0 irq 11

ata2: SATA max UDMA/133 cmd 0xE002E180 ctl 0x0 bmdma 0x0 irq 11

ata3: SATA max UDMA/133 cmd 0xE002E200 ctl 0x0 bmdma 0x0 irq 11

ata4: SATA max UDMA/133 cmd 0xE002E280 ctl 0x0 bmdma 0x0 irq 11

ata1: no device found (phy stat 00000000)

scsi0 : ahci

ata2: no device found (phy stat 00000000)

scsi1 : ahci

ata3: dev 0 ATA-6, max UDMA/133, 312581808 sectors: LBA48

ata3: dev 0 configured for UDMA/133

scsi2 : ahci

ata4: no device found (phy stat 00000000)

scsi3 : ahci

  Vendor: ATA       Model: WDC WD1600SD-01K  Rev: 08.0

  Type:   Direct-Access                      ANSI SCSI revision: 05

--------------------------------------------------------------

Messeges on writing to unplugged disk ------------------------
ata3: handling error/timeout
ata3: port reset, p_is 0 is 0 pis 0 cmd 4017 tf d0 ss 11 se 0
ata3: status=0x50 { DriveReady SeekComplete }
sda: Current: sense key: No Sense
    Additional sense: No additional sense information
ata3: handling error/timeout
ata3: port reset, p_is 0 is 0 pis 0 cmd c017 tf 7f ss 0 se 0
ata3: status=0x50 { DriveReady SeekComplete }
--------------------------------------------------------------


____________
Virus checked by G DATA AntiVirusKit
Version: AVK 16.2020 from 05.12.2005
Virus news: www.antiviruslab.com


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318261AbSHDXFG>; Sun, 4 Aug 2002 19:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318262AbSHDXFG>; Sun, 4 Aug 2002 19:05:06 -0400
Received: from babsi.intermeta.de ([212.34.181.3]:34057 "EHLO
	mail.intermeta.de") by vger.kernel.org with ESMTP
	id <S318261AbSHDXFF>; Sun, 4 Aug 2002 19:05:05 -0400
Date: Mon, 5 Aug 2002 01:08:05 +0200
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc5-ac1 and Intel SCB2 (OSB5) trouble
Message-ID: <20020805010805.B2727@forge.intermeta.de>
Reply-To: hps@intermeta.de
References: <aih3v2$11l$1@forge.intermeta.de> <1028402593.1760.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028402593.1760.16.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, LKM,

just to let you know, that -ac2 fixed all the IDE problems with the
OSB5 board. Onboard IDE works finde, pdcraid too (but I need
CONFIG_PDC202XX_FORCE=y to enable the drives).

lspci -vvx :

--- cut ---
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 92) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Intel Corp.: Unknown device 3410
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Region 0: I/O ports at 1418 [size=8]
        Region 1: I/O ports at 1420 [size=4]
        Region 2: I/O ports at 1428 [size=8]
        Region 3: I/O ports at 1424 [size=4]
        Region 4: I/O ports at 03a0 [size=16]
        Region 5: I/O ports at 0410 [size=4]
00: 66 11 12 02 05 01 00 02 92 8f 01 01 08 40 80 00
10: 19 14 00 00 21 14 00 00 29 14 00 00 25 14 00 00
20: a1 03 00 00 11 04 00 00 00 00 00 00 86 80 10 34
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
--- cut ---

IDE:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20267: IDE controller on PCI bus 00 dev 10
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xfe8e0000
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0x1440-0x1447, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1448-0x144f, BIOS settings: hdg:pio, hdh:pio
SvrWks CSB5: IDE controller on PCI bus 00 dev 79
SvrWks CSB5: chipset revision 146
SvrWks CSB5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x03a0-0x03a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x03a8-0x03af, BIOS settings: hdc:pio, hdd:pio
hde: IC35L040AVVA07-0, ATA DISK drive
hdg: IC35L040AVVA07-0, ATA DISK drive
ide4: ports already in use, skipping probe
ide5: ports already in use, skipping probe
ide2 at 0x1400-0x1407,0x140a on irq 19
ide3 at 0x1410-0x1417,0x140e on irq 19
hde: host protected area => 1
hde: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=79780/16/63, UDMA(100)
hdg: host protected area => 1
hdg: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=79780/16/63, UDMA(100)
ide-floppy driver 0.99.newide
Partition check:
 hde: [PTBL] [5005/255/63] hde1
 hdg: [PTBL] [5005/255/63] hdg1
 ataraid/d0: ataraid/d0p1
Drive 0 is 39266 Mb (33 / 0) 
Drive 1 is 39266 Mb (34 / 0) 
Raid1 array consists of 2 drives. 
Promise Fasttrak(tm) Softwareraid driver for linux version 0.03beta


(this is 2.4.19-ac2 with the kernel-2.4.18-i686-smp.config from the RH
2.4.18-5 RPM plus:

CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_ROOT_NFS=y
CONFIG_EEPRO100=y

CONFIG_PDC202XX_FORCE=y

	Regards
		Henning



On Sat, Aug 03, 2002 at 08:23:13PM +0100, Alan Cox wrote:
> On Sat, 2002-08-03 at 18:30, Henning P. Schmiedehausen wrote:
> > I fetched 2.4.19-rc5-ac1 and did all my tests with this kernel.
> > 
> > The problem is: The board does contain the Promise RAID Driver
> > BIOS. The customer wants to set up RAID1 with the BIOS and run the box
> > under Linux.
> 
> Include the ataraid driver for striping on the Promise Fasttrak 100. If
> you want to use their own driver boot with ide[n]=off
> 
> > 2.4.19 is also not able to set up the OSB5 chipset IDE controller in
> > DMA mode. (Yes, I run latest BIOS from Intel)
> 
> > PCI: Device 00:0f.1 not available because of resource collisions
> > SvrWks CSB5: (ide_setup_pci_device:) Could not enable device.
> 
> Linux found the OSB5 but found the BIOS had left colliding PCI
> resources. At that point it let that deivce fall back to the generic PIO
> legacy IDE driver instead. 2.4.19-ac1 handles this BIOS problem on the
> i845 chipset boards, it ought to handle it on the non i845 ones
> 
> 
> > 00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 92) (prog-if 8a [Master SecP PriP])
> > 	Subsystem: Intel Corp.: Unknown device 3410
> > 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> > 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > 	Latency: 64, cache line size 08
> > 	Region 0: I/O ports at <unassigned> [size=8]
> > 	Region 1: I/O ports at <unassigned> [size=4]
> > 	Region 2: I/O ports at <unassigned> [size=8]
> > 	Region 3: I/O ports at <unassigned> [size=4]
> > 	Region 4: I/O ports at 03a0 [size=16]
> > 	Region 5: I/O ports at 0410 [size=4]
> 
> I/O ports unassigned. Spank your vendor.
> 
> I am curious why the -ac PCI fixups didn't resolve this problem. Out of
> interest edit pci-i386.c and remove the IDE test in
> pcibios_assign_resources.
> 

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

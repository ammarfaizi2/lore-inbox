Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTKBPJZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 10:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbTKBPJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 10:09:25 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:44975 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP id S261705AbTKBPJM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 10:09:12 -0500
Date: Sun, 2 Nov 2003 16:09:11 +0100
From: uaca@alumni.uv.es
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9: BUG alim15x3.c
Message-ID: <20031102150911.GB14148@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all

I have an ASUS P5A board with the ALI M5229 IDE controller, the kernel 
(2.6.0-test9) doesn't recognize the partition table (so it cannot but 
the root fs of the disk).

I've tried booting with ide0=nodma,notune with the same results. 

Also I tried with not including the alim15x3 driver, also the same results.

This problem doesn't happen with a 2.4.17 kernel

Information on the system follows, I got this with the usual kernel: 2.4.17

I'm tring to boot with initramfs so I can check /proc/ide/ali, with no luck...
I successfully include my own rootfs in the kernel but It tries to mount the
root from an IDE dive and not the initramfs I included... anybody know how
to boot from the embedded file system?

suggestions/comments? I'm not sure who is the current mantainer of this
driver these days...

Thanks in advance

	Ulisses

*******************************************************
epi:~# lspci -vvv
*******************************************************

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP System Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [b0] AGP version 1.0
		Status: RQ=28 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M1541 PCI to AGP Controller (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: de000000-dfffffff
	Prefetchable memory behind bridge: e5f00000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (20000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at dd800000 (32-bit, non-prefetchable) [size=4K]

00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Acer Laboratories Inc. [ALi] ALI M7101 Power Management Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b800 [size=32]

00:0a.0 Multimedia video controller: Brooktree Corporation Bt848 Video Capture (rev 12)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e5000000 (32-bit, prefetchable) [size=4K]

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at b400 [size=16]

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at e6000000 (32-bit, prefetchable) [size=32M]
	Region 2: I/O ports at d800 [size=256]
	Expansion ROM at e5ff0000 [disabled] [size=64K]
	Capabilities: [54] AGP version 1.0
		Status: RQ=7 SBA+ 64bit+ FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

****************************************************************
epi:~# uname -a
****************************************************************

Linux epi 2.4.17 #14 Fri Apr 19 23:26:02 CEST 2002 i586 unknown

****************************************************************
epi:~# hdparm -i /dev/hda
****************************************************************

/dev/hda:

 Model=SAMSUNG SV2044D, FwRev=MM200-52, SerialNo=0228J1FN527449
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=472kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39862368
 IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 
 AdvancedPM=no WriteCache=enabled
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 ATA-4 

*****************************************************************
epi:~# hdparm -i /dev/hda
*****************************************************************
/dev/hda:

non-removable ATA device, with non-removable media
	Model Number:		SAMSUNG SV2044D                         
	Serial Number:		0228J1FN527449	Firmware Revision:	MM200-52
Standards:
	Used: ATA/ATAPI-4 T13 1153D revision 17 
	Supported: 1 2 3 4 & some of 5
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	bytes/track:	34902		(obsolete)
	bytes/sector:	554		(obsolete)
	current sector capacity: 16514064
	LBA user addressable sectors = 39862368
Capabilities:
	LBA, IORDY(cannot be disabled)
	Buffer size: 472.0kB	ECC bytes: 4	Queue depth: 1
	Standby timer values: spec'd by Vendor, no device specific minimum
	r/w multiple sector transfer: Max = 16	Current = 16
	DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	NOP cmd
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	DEVICE RESET cmd
	   *	look-ahead
	   *	write cache
	   *	Power Management feature set
	   *	SMART feature set
HW reset results:
	CBLID- above Vih
	Device num = 1

********************************************************************
epi:/usr/src/linux/scripts# ./ver_linux
********************************************************************
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux epi 2.4.17 #14 Fri Apr 19 23:26:02 CEST 2002 i586 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      found
e2fsprogs              1.27
PPP                    2.4.1
nfs-utils              1.0
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         


***************************************
epi:/proc/ide# cat ali
***************************************
                                Ali M15x3 Chipset.
                                ------------------
PCI Clock: 33.
CD_ROM FIFO:No , CD_ROM DMA:Yes
FIFO Status: contains 0 Words, runs.

-------------------primary channel-------------------secondary channel---------

channel status:       Off                               Off
both channels togth:  Yes                               Yes
Channel state:        OK                                OK            
Add. Setup Timing:    1T                                1T
Command Act. Count:   8T                                8T
Command Rec. Count:   16T                               16T

----------------drive0-----------drive1------------drive0-----------drive1------

DMA enabled:      Yes              No                Yes              No 
FIFO threshold:    4 Words          4 Words           8 Words          4 Words
FIFO mode:        FIFO Off         FIFO Off          FIFO On          FIFO Off
Dt RW act. Cnt     3T               3T                3T               3T
Dt RW rec. Cnt     1T               1T                1T               1T

-----------------------------------UDMA Timings--------------------------------

UDMA:             OK               OK                OK               OK
UDMA timings:     2.5T             2.5T              2.5T             2.5T


*********************************************************************************


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbTJYUDf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 16:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbTJYUDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 16:03:34 -0400
Received: from main.gmane.org ([80.91.224.249]:31897 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262854AbTJYUD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 16:03:29 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: DMA timeouts on SiS IDE (solved?)
Date: Sat, 25 Oct 2003 22:03:25 +0200
Message-ID: <yw1xk76thype.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:NrdaNpw9KltWgvGUOIg/E5F2esM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As I've reported here a few times previously, I've had some trouble
with DMA timeouts on a SiS 5513 IDE controller.  For some reason, I
tried disabling the disk's write cache (hdparm -W0).  This appears to
fix the DMA timeout issue.  Does this seem reasonable at all?  How
does disabling the write cache impact performance?

Hardware involved:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 10)
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
00:02.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 07)
00:02.3 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 07)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI Audio Accelerator (rev a0)
00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 90)
00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
00:0a.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
00:0c.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS650/651/M650/740 PCI/AGP VGA Display Adapter

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
	Subsystem: Asustek Computer, Inc.: Unknown device 1688
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Region 4: I/O ports at b800 [size=16]

SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 961 MuTIOL IDE UDMA100 controller
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATMR04-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ASUS SCB-2408, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3


# hdparm -i /dev/hda

/dev/hda:

 Model=IC25N040ATMR04-0, FwRev=MO2OAD0A, SerialNo=MRG201K2C1L38C
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1740kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78140160
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:  2 3 4 5 6

# hdparm -I /dev/hda

/dev/hda:

ATA device, with non-removable media
        Model Number:       IC25N040ATMR04-0                        
        Serial Number:      MRG201K2C1L38C
        Firmware Revision:  MO2OAD0A
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 3a 
        Supported: 6 5 4 3 
Configuration:
        Logical         max     current
        cylinders       16383   65535
        heads           16      1
        sectors/track   63      63
        --
        CHS current addressable sectors:    4128705
        LBA    user addressable sectors:   78140160
        LBA48  user addressable sectors:   78140160
        device size with M = 1024*1024:       38154 MBytes
        device size with M = 1000*1000:       40007 MBytes (40 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 4      Queue depth: 1
        Standby timer values: spec'd by Vendor, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: 128 (0x80)
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
                Write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command 
           *    Device Configuration Overlay feature set 
           *    48-bit Address feature set 
                Automatic Acoustic Management feature set 
                SET MAX security extension
                Address Offset Reserved Area Boot
           *    SET FEATURES subcommand required to spinup after power up
                Power-Up In Standby feature set
           *    Advanced Power Management feature set
           *    General Purpose Logging feature set
           *    SMART self-test 
           *    SMART error logging 
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        34min for SECURITY ERASE UNIT. 
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct

-- 
Måns Rullgård
mru@kth.se


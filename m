Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTE3SpE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 14:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263915AbTE3SpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 14:45:04 -0400
Received: from ip-64-7-1-79.dsl.lax.megapath.net ([64.7.1.79]:52698 "EHLO
	ip-64-7-1-79.dsl.lax.megapath.net") by vger.kernel.org with ESMTP
	id S263996AbTE3Soh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 14:44:37 -0400
Date: Fri, 30 May 2003 11:57:48 -0700 (PDT)
From: <lk@trolloc.com>
X-X-Sender: <bpape@ip-64-7-1-79.dsl.lax.megapath.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Wm. Josiah Erikson" <josiah@insanetechnology.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: siimage driver status
In-Reply-To: <1054216464.20725.70.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0305301156510.17286-100000@ip-64-7-1-79.dsl.lax.megapath.net>
X-keyboard: Happy Hacking Keyboard Lite
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Iau, 2003-05-29 at 16:00, Wm. Josiah Erikson wrote:
> > Wow. I feel dumb. When I add the -X66 to tell the drive as well, then 
> > everything is peachy. Thanks! :)
> 
> Its hardly obvious. 
> 
> > Now I suppose I just have to figure out how to make that work on boot 
> > (perhaps just to make the BIOS put them in DMA mode)
> 
> One thing I might do is just make the driver ignore the bios policy for
> disk devices. 

I reinstalled my SiImage controller this morning because I hadn't
documented using the -X66 switch during my previous testing.  It actually
makes a bit of a difference- the DMA enables and THEN the machine locks
hard when any reasonable amount of data is written to the drives on the
controller.

I get two console messages before the machine locks hard:
hde: dma_timer_expiry: dma status == 0x22
hde: dma_timer_expiry status = 0xd8 { Busy }

I'd love to get this tracked down...


Brian.

-----------------------

from /var/log/messages

May 30 11:34:38 nfs2 kernel: SiI3112 Serial ATA: IDE controller at PCI slot 05:02.0
May 30 11:34:38 nfs2 kernel: SiI3112 Serial ATA: chipset revision 2
May 30 11:34:38 nfs2 kernel: SiI3112 Serial ATA: not 100%% native mode: will probe irqs later
May 30 11:34:38 nfs2 kernel:     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
May 30 11:34:38 nfs2 kernel:     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio

----
hdparm -X66 -d1 /dev/hde
hdparm -X66 -d1 /dev/hdg

[root@nfs2 settings]# cat /proc/ide/siimage 
Controller: 0
SiI3112 Chipset.
MMIO Base 0xf880d000
MMIO-DMA Base 0xf880d000
MMIO-DMA Base 0xf880d008
--------------- Primary Channel ---------------- Secondary Channel -------------
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
PIO Mode:       ?                ?               ?                 ?




hdparm -I /dev/hde

/dev/hde:

ATA device, with non-removable media
        Model Number:       Maxtor 6Y200P0                          
        Serial Number:      Yv0AXR8E            
        Firmware Revision:  YAR41VW0
Standards:
        Supported: 7 6 5 4 
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   65535
        heads           16      1
        sectors/track   63      63
        --
        CHS current addressable sectors:    4128705
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  402622464
        device size with M = 1024*1024:      196593 MBytes
        device size with M = 1000*1000:      206142 MBytes (206 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific 
minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
           *    SMART feature set
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command 
           *    Device Configuration Overlay feature set 
           *    48-bit Address feature set 
           *    Automatic Acoustic Management feature set 
                SET MAX security extension
                Advanced Power Management feature set
           *    DOWNLOAD MICROCODE cmd
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
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper




/proc/cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 7
cpu MHz		: 2399.366
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 4784.12

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 7
cpu MHz		: 2399.366
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 4797.23

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 7
cpu MHz		: 2399.366
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 4797.23

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 7
cpu MHz		: 2399.366
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 4797.23



lspci -vvv

00:00.0 Host bridge: Intel Corp.: Unknown device 254c (rev 01)
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [40] #09 [1105]

00:00.1 Class ff00: Intel Corp. e7500 [Plumas] DRAM Controller Error Reporting (rev 01)
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 PCI bridge: Intel Corp. e7500 [Plumas] HI_B Virtual PCI Bridge (F0) (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: fc100000-fc2fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:03.0 PCI bridge: Intel Corp. e7500 [Plumas] HI_C Virtual PCI Bridge (F0) (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=04, subordinate=06, sec-latency=0
	I/O behind bridge: 00004000-00005fff
	Memory behind bridge: fc300000-fcffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at 2000 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at 2020 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at 2040 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 42) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=64
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: fd000000-fe0fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CA ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CA IDE U100 (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at 2060 [size=16]
	Region 5: Memory at 80000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at 1100 [size=32]

01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE+ ERO+ RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc101000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=01, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: fc200000-fc2fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE+ ERO+ RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
03:02.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (rev 01)
	Subsystem: Intel Corp. PRO/1000 MT Dual Port Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at fc200000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 3000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

03:02.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (rev 01)
	Subsystem: Intel Corp. PRO/1000 MT Dual Port Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin B routed to IRQ 29
	Region 0: Memory at fc220000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 3040 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

04:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc300000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
04:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=48
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: fc400000-fc4fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE+ ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
04:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc301000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
04:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=04, secondary=06, subordinate=06, sec-latency=48
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: fc500000-fcffffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE+ ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
05:02.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller (rev 02)
	Subsystem: CMD Technology Inc: Unknown device 6112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 01
	Interrupt: pin A routed to IRQ 100
	Region 0: I/O ports at 4020 [size=8]
	Region 1: I/O ports at 4010 [size=4]
	Region 2: I/O ports at 4018 [size=8]
	Region 3: I/O ports at 4014 [size=4]
	Region 4: I/O ports at 4000 [size=16]
	Region 5: Memory at fc400000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

07:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage XL
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 6000 [size=256]
	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


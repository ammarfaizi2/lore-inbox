Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267501AbSKSWWO>; Tue, 19 Nov 2002 17:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267503AbSKSWWN>; Tue, 19 Nov 2002 17:22:13 -0500
Received: from h216-18-124-229.gtconnect.net ([216.18.124.229]:11689 "EHLO
	gateway.max-t.com") by vger.kernel.org with ESMTP
	id <S267501AbSKSWWI>; Tue, 19 Nov 2002 17:22:08 -0500
Message-ID: <3DDAB712.5000602@max-t.com>
Date: Tue, 19 Nov 2002 17:11:30 -0500
From: Stephane Harnois <sharnois@max-t.com>
Reply-To: sharnois@max-t.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: bonding driver hang in 2.4.19
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

	  When booting 2.4.19 on a Dell power edge 4600, the system hang when loading the bonding module.

[2.] Full description of the problem/report:

		The system has 2 E1000 PCI-X, 512 MB of memory.  The sysrq key for reboot only print "resetting",
 need to power cycle.  This limit the information I can include...

[3.] Keywords (i.e., modules, networking, kernel):  modules
[4.] Kernel version (from /proc/version): 2.4.19
[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment

	RedHat 7.1 with xfs install.

[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo):  Dual P4 Xeon at 2.2 Ghz.
[7.3.] Module information (from /proc/modules):
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: ServerWorks CMIC-HE (rev 22)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks CMIC-HE
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 Host bridge: ServerWorks CMIC-HE
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 Host bridge: ServerWorks CMIC-HE
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Dell Computer Corporation: Unknown device 0106
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at fe202000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at ecc0 [size=64]
	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:06.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 0106
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (9750ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 18
	BIST result: 00
	Region 0: I/O ports at e800 [disabled] [size=256]
	Region 1: Memory at fe201000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at fe100000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 0106
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at e400 [size=256]
	Region 2: Memory at fe200000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
	Subsystem: ServerWorks CSB5 South Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 82 [Master PriP])
	Subsystem: ServerWorks CSB5 IDE Controller
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: I/O ports at 08c0 [size=8]
	Region 1: I/O ports at 08c8 [size=4]
	Region 2: I/O ports at 08d0 [size=8]
	Region 3: I/O ports at 08d8 [size=4]
	Region 4: I/O ports at 08b0 [size=16]

00:0f.3 ISA bridge: ServerWorks: Unknown device 0225
	Subsystem: ServerWorks: Unknown device 0230
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:10.0 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

00:10.2 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

00:11.0 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

00:11.2 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

01:06.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5700 Gigabit Ethernet (rev 14)
	Subsystem: Dell Computer Corporation NetXtreme 1000BaseTX
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (16000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at fcf00000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: ce81d8350950dc74  Data: b394

01:08.0 PCI bridge: Intel Corp.: Unknown device 0309 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fcd00000-fcefffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 0106
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 20
	BIST result: 00
	Region 0: I/O ports at dc00 [disabled] [size=256]
	Region 1: Memory at fcdff000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at fce00000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 0106
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin B routed to IRQ 21
	BIST result: 00
	Region 0: I/O ports at d800 [disabled] [size=256]
	Region 1: Memory at fcdfe000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at fce00000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:06.0 PCI bridge: Intel Corp.: Unknown device b154 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=03, secondary=04, subordinate=04, sec-latency=32
	I/O behind bridge: 0000a000-0000bfff
	Memory behind bridge: fae00000-faffffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

04:04.0 Fibre Channel: LSI Logic / Symbios Logic (formerly NCR) FC929 (rev 02)
	Subsystem: Chip Express Corporation: Unknown device 0622
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (7500ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 27
	Region 0: I/O ports at bc00 [size=256]
	Region 1: Memory at faef0000 (64-bit, non-prefetchable) [size=64K]
	Region 3: Memory at faee0000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at faf00000 [disabled] [size=1M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:04.1 Fibre Channel: LSI Logic / Symbios Logic (formerly NCR) FC929 (rev 02)
	Subsystem: Chip Express Corporation: Unknown device 0622
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (7500ns min, 2000ns max), cache line size 08
	Interrupt: pin B routed to IRQ 28
	Region 0: I/O ports at b800 [size=256]
	Region 1: Memory at faed0000 (64-bit, non-prefetchable) [size=64K]
	Region 3: Memory at faec0000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at faf00000 [disabled] [size=1M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:06.0 Fibre Channel: LSI Logic / Symbios Logic (formerly NCR) FC929 (rev 02)
	Subsystem: Chip Express Corporation: Unknown device 0622
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (7500ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 29
	Region 0: I/O ports at b400 [size=256]
	Region 1: Memory at faeb0000 (64-bit, non-prefetchable) [size=64K]
	Region 3: Memory at faea0000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at faf00000 [disabled] [size=1M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:06.1 Fibre Channel: LSI Logic / Symbios Logic (formerly NCR) FC929 (rev 02)
	Subsystem: Chip Express Corporation: Unknown device 0622
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (7500ns min, 2000ns max), cache line size 08
	Interrupt: pin B routed to IRQ 30
	Region 0: I/O ports at b000 [size=256]
	Region 1: Memory at fae90000 (64-bit, non-prefetchable) [size=64K]
	Region 3: Memory at fae80000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at faf00000 [disabled] [size=1M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0e:06.0 Ethernet controller: Intel Corp. 82544EI Gigabit Ethernet Controller (rev 02)
	Subsystem: Intel Corp. PRO/1000 XT Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 43
	Region 0: Memory at f8b60000 (64-bit, non-prefetchable) [size=128K]
	Region 2: Memory at f8b40000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 6ce0 [size=32]
	Expansion ROM at f8a00000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

0e:08.0 Ethernet controller: Intel Corp. 82544EI Gigabit Ethernet Controller (rev 02)
	Subsystem: Intel Corp. PRO/1000 XT Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 39
	Region 0: Memory at f8b20000 (64-bit, non-prefetchable) [size=128K]
	Region 2: Memory at f8b00000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 6cc0 [size=32]
	Expansion ROM at f8a00000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000



[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

		If I comment out the multicast line, it works.

    dev->open = bond_open;
    dev->stop = bond_close;
//  dev->set_multicast_list = set_multicast_list;
    dev->do_ioctl = bond_ioctl;


-- 
Stephane Harnois
Director of Engineering
Maximum Throughput Inc.
mailto:sharnois@max-t.com
Phone: (514) 938-7407
Fax: (514) 938-7408





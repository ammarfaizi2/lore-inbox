Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312716AbSDAXex>; Mon, 1 Apr 2002 18:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312715AbSDAXep>; Mon, 1 Apr 2002 18:34:45 -0500
Received: from host225242.arnet.net.ar ([200.45.225.242]:47519 "HELO
	abyss.thymbra.com") by vger.kernel.org with SMTP id <S312716AbSDAXeh>;
	Mon, 1 Apr 2002 18:34:37 -0500
Subject: IRQ routing conflicts / Assigning IRQ 0 to ethernet
From: Luis Falcon <lfalcon@thymbra.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 01 Apr 2002 20:37:32 -0300
Message-Id: <1017704252.20857.7.camel@abyss>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

It's been a while since I'm trying to get this running, but so far no
luck... 

The laptop is a FIC 360+ ( www.fic.com.tw ) with an on-board ethernet
card. Comparing the pci scanning from other postings, it seems to be the
same as some model of the Gericom family. 

I have tried different kernels and upgraded the BIOS, but still no good
results. Currently I'm using kernel 2.4.19-pre4, but have tried many
others. 
I have also tried different PCI access types on the kernel ( auto,
Direct and BIOS ) and no luck. 

The main problem is that it can't assign an interrupt for the
controller, plus I get irq routing conflicts on other devices...



Here are the logs 

Regards, 
Luis 

[at boot time] 

kernel: PCI: Found IRQ 10 for device 00:0c.0 
kernel: PCI: Sharing IRQ 10 with 00:06.0 
kernel: PCI: Sharing IRQ 10 with 00:0d.0 
kernel: PCI: Found IRQ 4 for device 00:0c.1 
kernel: PCI: Sharing IRQ 4 with 00:07.5 
kernel: IRQ routing conflict for 00:0c.1, have irq 10, want irq 4 



[at insmod tulip ] 

kernel: Linux Tulip driver version 0.9.15-pre10 (Mar 8, 2002) 
kernel: PCI: Enabling device 00:05.0 (0000 -> 0003) 
kernel: PCI: No IRQ known for interrupt pin A of device 00:05.0. Please
try using pci=biosirq. 
kernel: PCI: Setting latency timer of device 00:05.0 to 64 
kernel: eth1: ADMtek Comet rev 17 at 0x1c00, 00:90:96:1D:D9:0F, IRQ 0. 


[from lspci ] 

00:00.0 Host bridge: VIA Technologies, Inc. VT8605 [ProSavage PM133] 
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+ 
Latency: 0 
Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M] 
Capabilities: [a0] AGP version 2.0 
Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2 
Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none> 
Capabilities: [c0] Power Management version 2 
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-) 
Status: D0 PME-Enable- DSel=0 DScale=0 PME- 

00:01.0 PCI bridge: VIA Technologies, Inc. VT8605 [PM133 AGP] (prog-if
00 [Normal decode]) 
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- 
Latency: 0 
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0 
I/O behind bridge: 0000f000-00000fff 
Memory behind bridge: e0100000-e01fffff 
Prefetchable memory behind bridge: f0000000-f7ffffff 
BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B- 
Capabilities: [80] Power Management version 2 
Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-) 
Status: D0 PME-Enable- DSel=0 DScale=0 PME- 

00:05.0 Ethernet controller: Accton Technology Corporation: Unknown
device 1216 (rev 11) 
Subsystem: Accton Technology Corporation: Unknown device 2242 
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- 
Latency: 64 (63750ns min, 63750ns max) 
Interrupt: pin A routed to IRQ 0 
Region 0: I/O ports at 1c00 [size=256] 
Region 1: Memory at 1f000000 (32-bit, non-prefetchable) [size=1K] 
Expansion ROM at <unassigned> [disabled] [size=128K] 
Capabilities: [c0] Power Management version 2 
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA
PME(D0+,D1+,D2+,D3hot+,D3cold+) 
Status: D0 PME-Enable- DSel=0 DScale=0 PME- 

00:06.0 Communication controller: Lucent Microelectronics LT WinModem 
Subsystem: Askey Computer Corp.: Unknown device 4005 
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- 
Interrupt: pin A routed to IRQ 10 
Region 0: Memory at e0000000 (32-bit, non-prefetchable) [disabled]
[size=256] 
Region 1: I/O ports at 1030 [disabled] [size=8] 
Region 2: I/O ports at 1400 [disabled] [size=256] 
Capabilities: [f8] Power Management version 2 
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=160mA
PME(D0-,D1-,D2-,D3hot+,D3cold+) 
Status: D0 PME-Enable- DSel=0 DScale=0 PME- 

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40) 
Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge 
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B- 
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- 
Latency: 0 
Capabilities: [c0] Power Management version 2 
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-) 
Status: D0 PME-Enable- DSel=0 DScale=0 PME- 

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP]) 
Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1890 
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- 
Latency: 64 
Region 4: I/O ports at 1020 [size=16] 
Capabilities: [c0] Power Management version 2 
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-) 
Status: D0 PME-Enable- DSel=0 DScale=0 PME- 

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
(prog-if 00 [UHCI]) 
Subsystem: Unknown device 0925:1234 
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- 
Interrupt: pin D routed to IRQ 5 
Region 4: I/O ports at 1000 [size=32] 
Capabilities: [80] Power Management version 2 
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-) 
Status: D0 PME-Enable- DSel=0 DScale=0 PME- 

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 40) 
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- 
Capabilities: [68] Power Management version 2 
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-) 
Status: D0 PME-Enable- DSel=0 DScale=0 PME- 

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 50) 
Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1840 
Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- 
Interrupt: pin C routed to IRQ 4 
Region 0: I/O ports at 1800 [size=256] 
Region 1: I/O ports at 103c [size=4] 
Region 2: I/O ports at 1038 [size=4] 
Capabilities: [c0] Power Management version 2 
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-) 
Status: D0 PME-Enable- DSel=0 DScale=0 PME- 

00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev
01) 
Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860 
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B- 
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR- 
Latency: 168 
Interrupt: pin A routed to IRQ 10 
Region 0: Memory at 1f001000 (32-bit, non-prefetchable) [size=4K] 
Bus: primary=00, secondary=02, subordinate=05, sec-latency=176 
Memory window 0: 1f400000-1f7ff000 (prefetchable) 
Memory window 1: 1f800000-1fbff000 
I/O window 0: 00004000-000040ff 
I/O window 1: 00004400-000044ff 
BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+ 
16-bit legacy interface ports at 0001 

00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev
01) 
Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860 
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B- 
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR- 
Latency: 168 
Interrupt: pin B routed to IRQ 10 
Region 0: Memory at 1f002000 (32-bit, non-prefetchable) [size=4K] 
Bus: primary=00, secondary=06, subordinate=09, sec-latency=176 
Memory window 0: 1fc00000-1ffff000 (prefetchable) 
Memory window 1: 20000000-203ff000 
I/O window 0: 00004800-000048ff 
I/O window 1: 00004c00-00004cff 
BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+ 
16-bit legacy interface ports at 0001 

00:0d.0 FireWire (IEEE 1394): Lucent Microelectronics: Unknown device
5811 (rev 04) (prog-if 10 [OHCI]) 
Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1881 
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- 
Interrupt: pin A routed to IRQ 10 
Region 0: Memory at e0001000 (32-bit, non-prefetchable) [disabled]
[size=4K] 
Capabilities: [44] Power Management version 2 
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-) 
Status: D0 PME-Enable- DSel=0 DScale=0 PME- 

01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d01 (rev 02)
(prog-if 00 [VGA]) 
Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1830 
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- 
Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- 
Latency: 64 (1000ns min, 63750ns max), cache line size 08 
Interrupt: pin A routed to IRQ 5 
Region 0: Memory at e0100000 (32-bit, non-prefetchable) [size=512K] 
Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M] 
Expansion ROM at <unassigned> [disabled] [size=64K] 
Capabilities: [dc] Power Management version 2 
Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-) 
Status: D0 PME-Enable- DSel=0 DScale=0 PME- 
Capabilities: [80] AGP version 2.0 
Status: RQ=31 SBA- 64bit- FW- Rate=<none> 
Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none> 



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUIOM3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUIOM3e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 08:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUIOM3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 08:29:34 -0400
Received: from holomorphy.com ([207.189.100.168]:42907 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265230AbUIOM3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:29:01 -0400
Date: Wed, 15 Sep 2004 05:28:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
Message-ID: <20040915122852.GQ9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040915113635.GO9106@holomorphy.com> <20040915113833.GA4111@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915113833.GA4111@suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 01:50:03AM -0700, Andrew Morton wrote:
>>> +cfq-iosched-v2.patch
>>>  Major revamp of the CFQ IO scheduler

On Wed, Sep 15 2004, William Lee Irwin III wrote:
>> While editing some files while booted into 2.6.9-rc1-mm5:
>> # ----------- [cut here ] --------- [please bite here ] ---------
>> Kernel BUG at cfq_iosched:1359

On Wed, Sep 15, 2004 at 01:38:34PM +0200, Jens Axboe wrote:
> Hmm, ->allocated is unbalanced. What is your io setup like (adapter,
> etc)?

2 Maxtor Atlas10K 10Krpm U320 disks attached to some aic7902's. No
binary or 3rd-party modules anywhere near the box' fs or even the
network the thing is on. lspci output follows.


-- wli

0000:00:00.0 Host bridge: Intel Corp. Workstation Memory Controller Hub (rev 08)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [40] #09 [a105]

0000:00:00.1 Class ff00: Intel Corp. Memory Controller Hub Error Reporting Register (rev 08)
	Subsystem: Intel Corp. Memory Controller Hub Error Reporting Register
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:03.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port A1 (rev 08) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fa400000-fa8fffff
	Prefetchable memory behind bridge: 00000000bfe00000-00000000bfe00000
	Expansion ROM at 0000d000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
		Address: fee00000  Data: 0000
	Capabilities: [64] #10 [0141]

0000:00:04.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port B0 (rev 08) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fa900000-feafffff
	Prefetchable memory behind bridge: 00000000bff00000-00000000dfe00000
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
		Address: fee00000  Data: 0000
	Capabilities: [64] #10 [0141]

0000:00:08.0 System peripheral: Intel Corp. Memory Controller Hub Extended Configuration Registers (rev 08)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 24d0
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 201
	Region 4: I/O ports at e080 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 24d0
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 209
	Region 4: I/O ports at e400 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 24d0
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 169
	Region 4: I/O ports at e480 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Intel Corp.: Unknown device 24d0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 193
	Region 0: Memory at febff400 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fa300000-fa3fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.2 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corp. 82801EB Ultra ATA Storage Controller
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 169
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at fc00 [size=16]

0000:00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
	Subsystem: Intel Corp.: Unknown device 24d0
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at e800 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio Controller (rev 02)
	Subsystem: Intel Corp.: Unknown device e801
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 217
	Region 0: I/O ports at ec00
	Region 1: I/O ports at e880 [size=64]
	Region 2: Memory at febffc00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at febff800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:02.0 Ethernet controller: Intel Corp. 82541GI Gigabit Ethernet Controller
	Subsystem: Intel Corp.: Unknown device 3408
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 10
	Interrupt: pin A routed to IRQ 217
	Region 0: Memory at fa3e0000 (32-bit, non-prefetchable) [size=180000000]
	Region 1: Memory at fa3c0000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at cc80 [size=64]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
0000:02:00.0 PCI bridge: Intel Corp.: Unknown device 0320 (rev 08) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fa400000-fa6fffff
	Prefetchable memory behind bridge: 00000000bfe00000-00000000bfe00000
	Expansion ROM at 0000d000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [44] #10 [0071]
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [6c] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d8] 
0000:02:00.1 PIC: Intel Corp. PCI Bridge Hub I/OxAPIC Interrupt Controller A (rev 08) (prog-if 20 [IO(X)-APIC])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fa8fe000 (32-bit, non-prefetchable)
	Capabilities: [44] #10 [0001]
	Capabilities: [6c] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:00.2 PCI bridge: Intel Corp.: Unknown device 0321 (rev 08) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [44] #10 [0071]
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [6c] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d8] 
0000:02:00.3 PIC: Intel Corp. PCI Bridge Hub I/OxAPIC Interrupt Controller B (rev 08) (prog-if 20 [IO(X)-APIC])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fa8ff000 (32-bit, non-prefetchable)
	Capabilities: [44] #10 [0001]
	Capabilities: [6c] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:04:03.0 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
	Subsystem: Adaptec: Unknown device ffff
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), cache line size 10
	Interrupt: pin A routed to IRQ 177
	Region 0: I/O ports at d400 [size=180000000]
	Region 1: Memory at fa6fc000 (64-bit, non-prefetchable) [disabled] [size=8K]
	Region 3: I/O ports at d000 [size=256]
	Expansion ROM at ffffffff3ff00000 [disabled]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [94] 
0000:04:03.1 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
	Subsystem: Adaptec: Unknown device ffff
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), cache line size 10
	Interrupt: pin B routed to IRQ 185
	Region 0: I/O ports at dc00 [size=180000000]
	Region 1: Memory at fa6fe000 (64-bit, non-prefetchable) [disabled] [size=8K]
	Region 3: I/O ports at d800 [size=256]
	Expansion ROM at ffffffff3ff00000 [disabled]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [94] 
0000:05:00.0 VGA compatible controller: nVidia Corporation: Unknown device 00fd (rev a2) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=feae0000]
	Region 1: Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Region 2: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] #10 [0011]


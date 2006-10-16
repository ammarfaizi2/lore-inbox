Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161100AbWJPVk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbWJPVk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 17:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161106AbWJPVkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 17:40:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27543 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161100AbWJPVkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 17:40:21 -0400
Date: Mon, 16 Oct 2006 13:30:05 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: MSI messages in 2.6.19-rc2
Message-ID: <20061016133005.08d20b18@freekitty>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this on boot up, doesn't seem to be reliably reproducible.
System ran okay. My guess is it is a mulithread probe issue

[    2.773198] assign_interrupt_mode Found MSI capability
[    2.773227] assign_interrupt_mode Found MSI capability
[    2.773291] kmem_cache_create: duplicate cache msi_cache
[    2.773408] assign_interrupt_mode Found MSI capability
[    2.773485]  [dump_trace+100/461] dump_trace+0x64/0x1cd
[    2.773573] assign_interrupt_mode Found MSI capability
[    2.773644]  [show_trace_log_lvl+18/37] <7>PCI: Setting latency timer of device 0000:00:1c.3 to 64
[    2.773707] assign_interrupt_mode Found MSI capability
[    2.774538] show_trace_log_lvl+0x12/0x25
[    2.774606]  [show_trace+13/16] show_trace+0xd/0x10
[    2.774698]  [dump_stack+25/27] dump_stack+0x19/0x1b
[    2.774794]  [kmem_cache_create+1065/1116] kmem_cache_create+0x429/0x45c
[    2.775078]  [msi_init+90/154] msi_init+0x5a/0x9a
[    2.775554]  [pci_enable_msi+35/546] pci_enable_msi+0x23/0x222
[    2.776041]  [pcie_port_device_register+522/847] pcie_port_device_register+0x20a/0x34f
[    2.776519]  [pcie_portdrv_probe+87/128] pcie_portdrv_probe+0x57/0x80
[    2.777001]  [pci_device_probe+57/91] pci_device_probe+0x39/0x5b
[    2.777467]  [really_probe+60/181] really_probe+0x3c/0xb5
[    2.778074]  [kthread+197/243] kthread+0xc5/0xf3
[    2.778266]  [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
[    2.778360] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
[    2.778403]
[    2.778441] Leftover inexact backtrace:
[    2.778444]
[    2.778517]  [show_trace_log_lvl+18/37] show_trace_log_lvl+0x12/0x25
[    2.778592]  [show_trace+13/16] show_trace+0xd/0x10
[    2.778665]  [dump_stack+25/27] dump_stack+0x19/0x1b
[    2.778738]  [kmem_cache_create+1065/1116] kmem_cache_create+0x429/0x45c
[    2.778817]  [msi_init+90/154] msi_init+0x5a/0x9a
[    2.778896]  [pci_enable_msi+35/546] pci_enable_msi+0x23/0x222
[    2.778970]  [pcie_port_device_register+522/847] pcie_port_device_register+0x20a/0x34f
[    2.779045]  [pcie_portdrv_probe+87/128] pcie_portdrv_probe+0x57/0x80
[    2.779120]  [pci_device_probe+57/91] pci_device_probe+0x39/0x5b
[    2.779193]  [really_probe+60/181] really_probe+0x3c/0xb5
[    2.779267]  [kthread+197/243] kthread+0xc5/0xf3
[    2.779341]  [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
[    2.779414]  =======================
[    2.779455] PCI: MSI cache init failed
[    2.802070] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    2.802247] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A


00:00.0 Host bridge: Intel Corporation 925X/XE Express Memory Controller Hub (rev 04)
	Subsystem: Intel Corporation Unknown device 4356
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information
00: 86 80 84 25 06 01 90 20 04 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 56 43
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation 925X/XE Express PCI Express Root Port (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: cf900000-df9fffff
	Prefetchable memory behind bridge: bf200000-cf2fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40d1
	Capabilities: [a0] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s, Port 2
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 75.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [140] Unknown (5)
00: 86 80 85 25 07 05 10 00 04 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 90 90 00 00
20: 90 cf 90 df 20 bf 20 cf 00 00 00 00 00 00 00 00
30: 00 00 00 00 88 00 00 00 00 00 00 00 ff 01 0a 00

00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 03)
	Subsystem: Intel Corporation Unknown device e404
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at dfff8000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express Unknown type IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled CommClk- ExtSynch-
		Link: Speed unknown, Width x0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)
00: 86 80 68 26 06 00 10 00 03 00 03 04 10 00 00 00
10: 04 80 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 04 e4
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00

00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: dfd00000-dfdfffff
	Prefetchable memory behind bridge: 00000000cf600000-00000000cf600000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 1, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40d9
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)
00: 86 80 60 26 07 05 10 00 03 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 05 05 00 b0 b0 00 00
20: d0 df d0 df 61 cf 61 cf 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 06 00

00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: dfc00000-dfcfffff
	Prefetchable memory behind bridge: 00000000cf500000-00000000cf500000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 2, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40e1
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)
00: 86 80 62 26 07 05 10 00 03 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 04 04 00 a0 a0 00 00
20: c0 df c0 df 51 cf 51 cf 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 02 06 00

00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dfb00000-dfbfffff
	Prefetchable memory behind bridge: 00000000cf400000-00000000cf400000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 3
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 3, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40e9
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)
00: 86 80 64 26 06 05 10 00 03 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 03 03 00 f0 00 00 20
20: b0 df b0 df 41 cf 41 cf 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 03 06 00

00:1c.3 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 4 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dfa00000-dfafffff
	Prefetchable memory behind bridge: 00000000cf300000-00000000cf300000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 4
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 4, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 4032
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)
00: 86 80 66 26 06 05 10 00 03 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f0 00 00 20
20: a0 df a0 df 31 cf 31 cf 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 04 06 00

00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation Unknown device 4356
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 58
	Region 4: I/O ports at cc00 [size=32]
00: 86 80 58 26 05 00 80 02 03 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 cc 00 00 00 00 00 00 00 00 00 00 86 80 56 43
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00

00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation Unknown device 4356
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 193
	Region 4: I/O ports at d000 [size=32]
00: 86 80 59 26 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 86 80 56 43
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00

00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation Unknown device 4356
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 185
	Region 4: I/O ports at d400 [size=32]
00: 86 80 5a 26 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d4 00 00 00 00 00 00 00 00 00 00 86 80 56 43
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 03 00 00

00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation Unknown device 4356
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 169
	Region 4: I/O ports at d800 [size=32]
00: 86 80 5b 26 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d8 00 00 00 00 00 00 00 00 00 00 86 80 56 43
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00

00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Intel Corporation Unknown device 4356
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 58
	Region 0: Memory at dffff800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port
00: 86 80 5c 26 06 01 90 02 03 20 03 0c 00 00 00 00
10: 00 f8 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 56 43
30: 00 00 00 00 50 00 00 00 00 00 00 00 09 01 00 00

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dfe00000-dfefffff
	Prefetchable memory behind bridge: 00000000cf700000-00000000cf700000
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]
00: 86 80 4e 24 07 01 10 00 d3 01 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 06 06 20 f0 00 80 22
20: e0 df e0 df 71 cf 71 cf 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 06 02

00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 03)
	Subsystem: Intel Corporation Unknown device 4356
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 40 26 07 01 00 02 03 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 56 43
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corporation Unknown device 4356
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 185
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]
00: 86 80 6f 26 05 00 88 02 03 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 86 80 56 43
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00

00:1f.2 SATA controller: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW) SATA Controller (rev 03) (prog-if 01 [AHCI 1.0])
	Subsystem: Intel Corporation Unknown device 4356
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 193
	Region 0: I/O ports at ec00 [size=8]
	Region 1: I/O ports at e800 [size=4]
	Region 2: I/O ports at e400 [size=8]
	Region 3: I/O ports at e000 [size=4]
	Region 4: I/O ports at dc00 [size=16]
	Region 5: Memory at dffffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 52 26 07 00 b0 02 03 01 06 01 00 00 00 00
10: 01 ec 00 00 01 e8 00 00 01 e4 00 00 01 e0 00 00
20: 01 dc 00 00 00 fc ff df 00 00 00 00 86 80 56 43
30: 00 00 00 00 70 00 00 00 00 00 00 00 0a 02 00 00

00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
	Subsystem: Intel Corporation Unknown device 4356
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at c800 [size=32]
00: 86 80 6a 26 01 01 80 02 03 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c8 00 00 00 00 00 00 00 00 00 00 86 80 56 43
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)] (prog-if 00 [VGA])
	Subsystem: VISIONTEK Unknown device 0401
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 9800 [size=256]
	Region 2: Memory at d0000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at df9e0000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <128ns, L1 <2us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <128ns, L1 <1us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
	Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [100] Advanced Error Reporting
00: 02 10 60 5b 07 01 10 00 00 00 00 03 10 00 80 00
10: 08 00 00 c0 01 98 00 00 00 00 00 d0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 45 15 01 04
30: 00 00 9e df 50 00 00 00 00 00 00 00 0b 01 00 00

01:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
	Subsystem: VISIONTEK Unknown device 0400
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Region 0: Memory at df9d0000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <128ns, L1 <2us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <128ns, L1 <1us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
00: 02 10 70 5b 04 00 10 00 00 00 80 03 10 00 00 00
10: 00 00 9d df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 45 15 00 04
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 00 00

04:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8050 PCI-E ASF Gigabit Ethernet Controller (rev 17)
	Subsystem: Intel Corporation D925XCVLK mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 74
	Region 0: Memory at dfcfc000 (64-bit, non-prefetchable) [size=16K]
	Region 2: I/O ports at a800 [size=256]
	Expansion ROM at dfcc0000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
		Address: 00000000fee00000  Data: 404a
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
		Link: Latency L0s <256ns, L1 unlimited
		Link: ASPM Disabled RCB 128 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [100] Advanced Error Reporting
00: ab 11 61 43 07 05 10 00 17 00 00 02 10 00 00 00
10: 04 c0 cf df 00 00 00 00 01 a8 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 63 30
30: 00 00 cc df 48 00 00 00 00 00 00 00 03 01 00 00

05:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8052 PCI-E ASF Gigabit Ethernet Controller (rev 22)
	Subsystem: Marvell Technology Group Ltd. Marvell RDK-8052
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 66
	Region 0: Memory at dfdfc000 (64-bit, non-prefetchable) [size=16K]
	Region 2: I/O ports at b800 [size=256]
	Expansion ROM at dfdc0000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
		Address: 00000000fee00000  Data: 4042
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
		Link: Latency L0s <256ns, L1 unlimited
		Link: ASPM Disabled RCB 128 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [100] Advanced Error Reporting
00: ab 11 60 43 07 05 10 00 22 00 00 02 10 00 00 00
10: 04 c0 df df 00 00 00 00 01 b8 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ab 11 21 52
30: 00 00 dc df 48 00 00 00 00 00 00 00 0b 01 00 00


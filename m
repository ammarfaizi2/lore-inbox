Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWI2AwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWI2AwP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWI2AwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:52:15 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:27061 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751228AbWI2AwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:52:13 -0400
Date: Thu, 28 Sep 2006 17:52:06 -0700
From: Sukadev Bhattiprolu <sukadev@us.ibm.com>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Auke Kok <auke-jan.h.kok@intel.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network problem with 2.6.18-mm1 ?
Message-ID: <20060929005205.GA3876@us.ibm.com>
References: <20060928013724.GA22898@us.ibm.com> <451B2D29.9040306@intel.com> <20060928185222.GB3352@us.ibm.com> <4807377b0609281410p28d445c8mc32e7d2cb71221ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <4807377b0609281410p28d445c8mc32e7d2cb71221ab@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Jesse Brandeburg [jesse.brandeburg@gmail.com] wrote:
| On 9/28/06, Sukadev Bhattiprolu <sukadev@us.ibm.com> wrote:
| >Thanks. See below for additional info
| >
| >Auke Kok [auke-jan.h.kok@intel.com] wrote:
| >| Sukadev Bhattiprolu wrote:
| >| >
| >| >I am unable to get networking to work with 2.6.18-mm1 on my system.
| >| >
| >| >But 2.6.18 kernel on same system works fine. Here is some info about
| >| >the system/debug attempts. Attached are the lspci output and config.
| >| >
| >| >Appreciate any help. Please let me know if you need more info.
| 
| It seems you're having interrupt delivery problems or interrupts are
| getting lost.
| rx_missed_errors indicates frames that were dropped due to the e1000
| adapter's fifo getting full and over flowing.
| >rx_no_buffer_count: 310
| >rx_missed_errors: 5865
| rx_no_buffer_count indicates that the driver didn't return buffers to
| the hardware soon enough, but the hardware was able to store the
| packet (at the time of reception) in the fifo to try again.
| 
| Both these indicate to me that there is something wrong with
| interrupts.  Maybe interrupt sharing
| 
| can you possibly try a back to back connection with another linux box
| and run tcpdump on both ends then ping?  it will tell us if traffic is
| truely getting out and coming in okay.

Unfortunately, I can't try this week, but can try it early next week.

| 
| also please send output of lspci -vv and cat /proc/interrupts

lspci-vv.out is attached. Here is the /proc/interrupts:

$ cat /proc/interrupts

           CPU0       CPU1
  0:      18316          0   IO-APIC-edge     timer
  2:          0          0    XT-PIC-level    cascade
  4:       1023          0   IO-APIC-edge     serial
  8:          0          0   IO-APIC-edge     rtc
 17:       3380          0   IO-APIC-fasteoi  libata
 19:        174          0   IO-APIC-fasteoi  ohci_hcd:usb1, ohci_hcd:usb2
 28:          0          0   IO-APIC-fasteoi  eth0
NMI:         96         35
LOC:      18251      18524
ERR:          0

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Description: lspci-vv.txt
Content-Disposition: attachment; filename="lspci-vv.txt"

$ lspci -vv

0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: e8100000-e81fffff
	Prefetchable memory behind bridge: 88000000-880fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [c0] #08 [0086]
	Capabilities: [f0] #08 [8000]

0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
	Subsystem: IBM: Unknown device 7468
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: IBM: Unknown device 7469
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1020 [size=16]

0000:00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
	Subsystem: IBM: Unknown device 746a
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 0
	Region 0: I/O ports at 1000 [size=32]

0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
	Subsystem: IBM: Unknown device 746b
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] 	Capabilities: [b8] #08 [8000]
	Capabilities: [c0] #08 [004a]

0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at 88100000 (64-bit, non-prefetchable) [size=4K]

0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: e8200000-e82fffff
	Prefetchable memory behind bridge: 00000000f0000000-00000000f7f00000
	BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [a0] 	Capabilities: [b8] #08 [8000]

0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at 88101000 (64-bit, non-prefetchable) [size=4K]

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]

0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at e8100000 (32-bit, non-prefetchable) [size=4K]

0000:01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at e8101000 (32-bit, non-prefetchable) [size=4K]

0000:01:06.0 Mass storage controller: Silicon Image, Inc. SiI 3512 [SATALink/SATARaid] Serial ATA Controller (rev 01)
	Subsystem: IBM: Unknown device 3512
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 2020 [size=8]
	Region 1: I/O ports at 2014 [size=4]
	Region 2: I/O ports at 2018 [size=8]
	Region 3: I/O ports at 2010 [size=4]
	Region 4: I/O ports at 2000 [size=16]
	Region 5: Memory at e8102000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at 88000000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:03:03.0 Ethernet controller: Intel Corporation 82544EI Gigabit Ethernet Controller (Copper) (rev 02)
	Subsystem: Intel Corporation PRO/1000 XT Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at e8240000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at e8220000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 3400 [size=32]
	Expansion ROM at e8260000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=2 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=2, DMOST=0, DMCRS=1, RSCEM-
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

0000:03:04.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 029a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 29
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at e8200000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at e8280000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--jI8keyz6grp/JLjh--

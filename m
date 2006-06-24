Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933211AbWFXHlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933211AbWFXHlc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 03:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933212AbWFXHlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 03:41:32 -0400
Received: from aa001msr.fastwebnet.it ([85.18.95.64]:33766 "EHLO
	aa001msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S933211AbWFXHlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 03:41:31 -0400
Date: Sat, 24 Jun 2006 09:36:59 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Jeff Garzik <jeff@garzik.org>
Cc: Hamish <hamish@travellingkiwi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SATA hangs...
Message-ID: <20060624093659.7bc2a4a0@localhost>
In-Reply-To: <449C6023.9010204@garzik.org>
References: <200606232134.42231.hamish@travellingkiwi.com>
	<449C6023.9010204@garzik.org>
X-Mailer: Sylpheed-Claws 2.3.0-rc3 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 17:41:55 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> > I'm having problems with a SATA drive on an ASUS A8V deluxe 
> > motherboard under kernel 2.6.17... In fact it's happened under 
> > every (Vanilla) kernel I've ever run on this server (Back to 2.6.14).
> > (It's just over a year old. It didn't used to experience the same load
> > as it does now, so I'm currently assuming it's load related...

I think I've hit something similar yesterday, with 2.6.17.1...

It's happened just after I've hit "Enter" to log in with KDM (--> KDE),
other services were starting in background (network, spamassassin) -->
high disk load.

I don't remember the exact messages but I'm pretty sure that every disk
access failed.

After a brutal reboot (Alt + SysRq + B) I've got these problems very
early (when ext3 was trying (and failing) to replay journal).

I was already thinking about an hardware failure, then I've tried
powering off/on and voilà... everything worked again.


I don't know much more because it's happened just once, and maybe it was
just a temporary hardware failure.

Anyway...

MB:
	Asus K8V SE Delux (Via K8T800)
SATA disk:
	Seagate Barracuda 7200rpm 80GB


tux paolo # lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
        Subsystem: ASUSTeK Computer Inc. K8V Deluxe/K8V-X motherboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
        Capabilities: [c0] HyperTransport: Slave or Primary Interface
                !!! Possibly incomplete decoding
                Command: BaseUnitID=0 UnitCnt=3 MastHost- DefDir-
                Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
                Link Config 0: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
                Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0
                Link Config 1: MLWI=8bit MLWO=8bit LWI=8bit LWO=8bit
                Revision ID: 1.02
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] HyperTransport: Interrupt Discovery and Configuration

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890 South] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fd100000-fd6fffff
        Prefetchable memory behind bridge: d5000000-f4ffffff
        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
        Subsystem: ASUSTeK Computer Inc. Marvell 88E8001 Gigabit Ethernet Controller (Asus)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (5750ns min, 7750ns max), Cache Line Size 10
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at fdc00000 (32-bit, non-prefetchable) [size=16K]
        Region 1: I/O ports at c800 [size=256]
        Expansion ROM at fdb00000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data

00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at c400 [size=256]
        Region 1: Memory at fda00000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V Deluxe/K8V-X/A8V Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin B routed to IRQ 19
        Region 0: I/O ports at e800 [size=8]
        Region 1: I/O ports at e400 [size=4]
        Region 2: I/O ports at e000 [size=8]
        Region 3: I/O ports at d800 [size=4]
        Region 4: I/O ports at d400 [size=16]
        Region 5: I/O ports at d000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 19
        Region 4: I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 10
        Interrupt: pin A routed to IRQ 20
        Region 4: I/O ports at b000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 10
        Interrupt: pin A routed to IRQ 20
        Region 4: I/O ports at b400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 10
        Interrupt: pin B routed to IRQ 20
        Region 4: I/O ports at b800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 10
        Interrupt: pin B routed to IRQ 20
        Region 4: I/O ports at c000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 10
        Interrupt: pin C routed to IRQ 20
        Region 0: Memory at fd900000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V Deluxe motherboard (ADI AD1980 codec [SoundMAX])
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 21
        Region 0: I/O ports at ec00 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Controller (rev 80)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 0
        Region 0: I/O ports at 1000 [disabled] [size=256]
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] HyperTransport: Host or Secondary Interface
                !!! Possibly incomplete decoding
                Command: WarmRst+ DblEnd-
                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
                Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
                Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
        Subsystem: PC Partner Limited Unknown device 7c26
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size 10
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at a000 [size=256]
        Region 2: Memory at fd600000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at fd500000 [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)
        Subsystem: PC Partner Limited Unknown device 7c27
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size 10
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at fd400000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


tux paolo # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 12
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 0
cpu MHz         : 2202.857
cache size      : 512 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 4408.95
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp


tux paolo # cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-1ff2ffff : System RAM
  00200000-00481729 : Kernel code
  0048172a-005870d7 : Kernel data
1ff30000-1ff3ffff : ACPI Tables
1ff40000-1ffeffff : ACPI Non-volatile Storage
1fff0000-1fffffff : reserved
d5000000-f4ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.1
  e8000000-efffffff : 0000:01:00.0
    e8000000-efffffff : radeonfb framebuffer
f8000000-fbffffff : 0000:00:00.0
  f8000000-fbffffff : aperture
fd100000-fd6fffff : PCI Bus #01
  fd400000-fd40ffff : 0000:01:00.1
  fd500000-fd51ffff : 0000:01:00.0
  fd600000-fd60ffff : 0000:01:00.0
    fd600000-fd60ffff : radeonfb mmio
fd900000-fd9000ff : 0000:00:10.4
  fd900000-fd9000ff : ehci_hcd
fda00000-fda000ff : 0000:00:0e.0
  fda00000-fda000ff : 8139too
fdb00000-fdb1ffff : 0000:00:0a.0
fdc00000-fdc03fff : 0000:00:0a.0
  fdc00000-fdc03fff : skge
fff80000-ffffffff : reserved


tux paolo # cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0295-0296 : w83627hf
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-0407 : vt596_smbus
0800-0803 : PM1a_EVT_BLK
0804-0805 : PM1a_CNT_BLK
0808-080b : PM_TMR
0810-0815 : ACPI CPU throttle
0820-0823 : GPE0_BLK
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:11.6
a000-afff : PCI Bus #01
  a000-a0ff : 0000:01:00.0
b000-b01f : 0000:00:10.0
  b000-b01f : uhci_hcd
b400-b41f : 0000:00:10.1
  b400-b41f : uhci_hcd
b800-b81f : 0000:00:10.2
  b800-b81f : uhci_hcd
c000-c01f : 0000:00:10.3
  c000-c01f : uhci_hcd
c400-c4ff : 0000:00:0e.0
  c400-c4ff : 8139too
c800-c8ff : 0000:00:0a.0
  c800-c8ff : skge
d000-d0ff : 0000:00:0f.0
  d000-d0ff : sata_via
d400-d40f : 0000:00:0f.0
  d400-d40f : sata_via
d800-d803 : 0000:00:0f.0
  d800-d803 : sata_via
e000-e007 : 0000:00:0f.0
  e000-e007 : sata_via
e400-e403 : 0000:00:0f.0
  e400-e403 : sata_via
e800-e807 : 0000:00:0f.0
  e800-e807 : sata_via
ec00-ecff : 0000:00:11.5
  ec00-ecff : VIA8237
fc00-fc0f : 0000:00:0f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1


tux paolo # cat /proc/interrupts
           CPU0
  0:    3216509    IO-APIC-edge  timer
  1:       8175    IO-APIC-edge  i8042
  8:          0    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:     138694    IO-APIC-edge  i8042
 14:      28535    IO-APIC-edge  ide0
 15:      28740    IO-APIC-edge  ide1
 16:     239113   IO-APIC-level  radeon@pci:0000:01:00.0
 17:          0   IO-APIC-level  skge
 18:     285843   IO-APIC-level  eth1
 19:      81929   IO-APIC-level  libata
 20:          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4, uhci_hcd:usb5
 21:        350   IO-APIC-level  VIA8237
NMI:        333
LOC:    3215915
ERR:          0
MIS:          0

-- 
	Paolo Ornati
	Linux 2.6.17.1 on x86_64

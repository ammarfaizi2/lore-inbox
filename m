Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293483AbSCEREV>; Tue, 5 Mar 2002 12:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293504AbSCEREN>; Tue, 5 Mar 2002 12:04:13 -0500
Received: from rs3bt.ILP.Physik.Uni-Essen.DE ([132.252.76.146]:4229 "EHLO
	rs3bt.ilp.physik.uni-essen.de") by vger.kernel.org with ESMTP
	id <S293483AbSCERDz>; Tue, 5 Mar 2002 12:03:55 -0500
Date: Tue, 5 Mar 2002 18:03:50 +0100 (CET)
From: Christoph Seifert <seifert@ILP.Physik.Uni-Essen.DE>
To: linux-kernel@vger.kernel.org
Subject: Problems using ISA card
Message-ID: <Pine.LNX.3.96.1020305172319.12258A-100000@wap8.ilp.physik.uni-essen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
Acessing memory on PC31 ISA cards does work with 2.2.x, but not with
2.4.x and higher
[2.] Full description of the problem/report:
Measurement program tries to use home-made(and rebuilt for 2.4.x) kernel
module to access so called Dual-Port RAM on the measurement card at
address 0xd8000. The kernel reacts with a message, that the the page
request for virtual memory at address 000d8000 could not be fulfilled.
The measurement program crashes and the kernel resources are not freed
again . rmmod mod does not work, as the device is still seen as to
busy.
I report this as bug, as I think that there should be
backward-compatibility in memory access. I don't get any clue from
/var/log/messages as to why the request could not be fulfilled, e.g.
whether the requested memory space is protected by some other part for
e.g. a PCI card or whether it can't find any memory in that space.
I tried some different 2.4.x kernels with the same result.
There is no difference in hardware or BIOS settings for 2.2.x and 2.4.x
verions. The only difference is using a device with major number 240 
instead of 254.

Thank you very much in adance for some clue for a work-around.

[3.] Keywords (i.e., modules, networking, kernel):
ISA, memory
[4.] Kernel version (from /proc/version): 2.4.x
[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo): AMD-K7(tm) Processor
[7.3.] Module information (from /proc/modules): specialized homemade
kernel module
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0280-029f : reserved
03c0-03df : vga+
03f8-03ff : serial(auto)
d400-d47f : eth0
dc00-dcfe : aic7xxx
ffa0-ffa7 : ide0
ffa8-ffaf : ide1

no iomem

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate]
System Controller (rev 23)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable)
	Region 1: Memory at eddff000 (32-bit, prefetchable)
	Region 2: I/O ports at d800 [disabled]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP
Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: ede00000-efefffff
	Prefetchable memory behind bridge: d9c00000-ddcfffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:04.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d400
	Region 1: Memory at efffef80 (32-bit, non-prefetchable)
	Expansion ROM at effc0000 [disabled]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 15)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 06) (prog-if
00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at d000

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
10)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:09.0 SCSI storage controller: Adaptec AIC-7881U
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at dc00
	Region 1: Memory at effff000 (32-bit, non-prefetchable)
	Expansion ROM at effe0000 [disabled]

01:05.0 VGA compatible controller: nVidia Corporation Riva TnT2 [NV5] (rev
11) (prog-if 00 [VGA])
	Subsystem: Elsa AG: Unknown device 0c28
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ee000000 (32-bit, non-prefetchable)
	Region 1: Memory at da000000 (32-bit, prefetchable)
	Expansion ROM at efef0000 [disabled]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


[7.6.] SCSI information (from /proc/scsi/scsi)
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-40TS   Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):




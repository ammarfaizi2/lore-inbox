Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUBTPmw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 10:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbUBTPmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 10:42:12 -0500
Received: from m013-078.nv.iinet.net.au ([203.217.13.78]:61199 "EHLO
	mail.adixein.com") by vger.kernel.org with ESMTP id S261298AbUBTPgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 10:36:55 -0500
From: "Elliot Mackenzie" <macka@adixein.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Panic booting from USB disk in ioremap.c (line 81)
Date: Sat, 21 Feb 2004 01:37:47 +1000
Keywords: macka@adixein.com
Message-ID: <000b01c3f7c7$7eaf8310$4301a8c0@waverunner>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Penguins:

We have a problem booting vanilla 2.6.2 and 2.6.3 kernels from a USB
disk (Transcend JetFlash, both 128MB USB 2 and 256MB USB 1). During what
appears to be PCI device enumeration, we get the following panic:

kernel BUG at arch/i386/mm/ioremap.c:81!
invalid operand: 0000 [#1]
CPU: 0
EIP:	0060:[<c011913c>]		Not tainted
EFLAGS: 00010206
EIP is at remap_area_pages+0x34/0x1f1
eax: c0101000    ebx: edeb0000   ecx: bc6b0000   edx: c0101ce8
esi: 0dffc0000   edi: ce800000   ebp: 00000000   esp: cde55f48
ds:  007b    es: 007b   ss: 0068
Process swapper (pid: 1, theadinfo=cde54000 task=cdfb3900)
Stack:  c01490cd cdffb100 000000d0 c0101cec edeb0000 0dffc000 bc6b0000
c0101ce8
        c014913d edeb0000 0dffc000 ce800000 00000000 c01193d3 ce800000
3f7fc000
        edeb0000 00000000 00000000 00000024 ce800000 edeafed7 c03e9249
0dffc000
Call Trace:
 [<c01490cd>] __get_vm_area+0xb5/0xf3
 [<c014913d>] get_vm_area+0x32/0x36
 [<c01193d3>] __ioremap+0xda/0x104
 [<c03e9249>] sbf_init+0x167/0x180
 [<c03e46f1>] do_init_calls+0x28/0x93
 [<c012ca28>] init_workqueues+0xf/0x27
 [<c01050bc>] init+0x30/0x134
 [<c010508c>] init+0x0/0x134
 [<c0109255>] kernel_thread_helper+0x5/0xb

Code: 0f 0b 51 00 8b 4d 32 c0 ba 00 e0 ff ff 21 e0 83 40 14 01 8b
 <0>Kernel panic: Attempted to kill init!

This does not occur when booting from the hard disk, or when booting 2.4
series kernels (tried 2.4.18 through 2.4.22).

Hardware info: P4-based Intel Celeron, motherboard is SiS chipset.

We have tried to circumvent the problem by changing the kernel PCI
probing from "Any" to "BIOS" and "Direct".

The bootloader is SysLinux (1.66), using an initrd image.  Kernel
parameters are set to run a serial console, but other than that, it's
just kernel and initrd.

Output from lspci (-vvv), /proc/cpuinfo and /proc/iomem from a working
2.4 kernel on the same machine is below.  The kernel was compiled with
gcc 3.2.

Can anyone provide some further insight into this problem, point us in
the right direction, or let us know if this is indeed a bug?

Cheers,
Elliot Mackenzie & Doug Turk.


===IOMEM===
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0dffbfff : System RAM
  00100000-0022e791 : Kernel code
  0022e792-00286343 : Kernel data
0dffc000-0dffefff : ACPI Tables
0dfff000-0dffffff : ACPI Non-volatile Storage
e5800000-e5800fff : PCI device 1039:0900
  e5800000-e5800fff : sis900
e6000000-e6000fff : PCI device 1039:7002
  e6000000-e6000fff : ehci-hcd
e6800000-e6800fff : PCI device 1039:7001
  e6800000-e6800fff : usb-ohci
e7000000-e7000fff : PCI device 1039:7001
  e7000000-e7000fff : usb-ohci
e7800000-e7ffffff : PCI Bus #01
  e7800000-e781ffff : PCI device 1039:6325
e8000000-ebffffff : PCI device 1039:0650
f0000000-febfffff : PCI Bus #01
  f0000000-f7ffffff : PCI device 1039:6325
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

===CPUINFO===
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Celeron(R) CPU 2.60GHz
stepping	: 9
cpu MHz		: 2600.205
cache size	: 8 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 5190.45

===LSPCI===
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 80)
	Subsystem: Asustek Computer, Inc.: Unknown device 8079
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e8000000 (32-bit, non-prefetchable)
[size=64M]
	Capabilities: [c0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual
PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e7800000-e7ffffff
	Prefetchable memory behind bridge: f0000000-febfffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL
Media IO] (rev 25)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
(prog-if 80 [Master])
	Subsystem: Asustek Computer, Inc.: Unknown device 807a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Interrupt: pin ? routed to IRQ 11
	Region 4: I/O ports at a400 [size=16]

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
SiS7012 PCI Audio Accelerator (rev a0)
	Subsystem: Asustek Computer, Inc.: Unknown device 80b0
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at 9400 [size=256]
	Region 1: I/O ports at 9000 [size=128]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB
Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 807a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at e7000000 (32-bit, non-prefetchable)
[size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB
Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 807a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at e6800000 (32-bit, non-prefetchable)
[size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0
(prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 807a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at e6000000 (32-bit, non-prefetchable)
[size=4K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
10/100 Ethernet (rev 91)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at 8800 [size=256]
	Region 1: Memory at e5800000 (32-bit, non-prefetchable)
[size=4K]
	Expansion ROM at effe0000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
SiS650/651/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 8079
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	BIST result: 00
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at e7800000 (32-bit, non-prefetchable)
[size=128K]
	Region 2: I/O ports at d800 [size=128]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>





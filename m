Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287632AbSADLgA>; Fri, 4 Jan 2002 06:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288603AbSADLfw>; Fri, 4 Jan 2002 06:35:52 -0500
Received: from dns.uniserv-online.de ([195.243.52.35]:5637 "EHLO
	mailsweep.uniserv.de") by vger.kernel.org with ESMTP
	id <S287632AbSADLfc>; Fri, 4 Jan 2002 06:35:32 -0500
Message-ID: <741F3BC653A2D311B20E009027C3333D51D7C1@EXCHANGE>
From: ulf.gruene@uniserv.de
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel 2.4.10pre12, ... 2.4.17 freeze on a specific type
	 of  i386 hardware
Date: Fri, 4 Jan 2002 12:35:17 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I have the problem described below with kernels since 2.4.10-pre12.
If you need any more information please let me know. If you have
any sugestions, it is possible to do more experiments, because the 
machines are not yet used for production.

Ulf


[1.] One line summary of the problem:    
     Kernel 2.4.10pre12, ... 2.4.17 freeze on a specific type of 
     i386 hardware

[2.] Full description of the problem/report:
     We have several Fujitsu-Siemens machines (type i815e, lspci see
     below) that freeze with "newer" kernels after 30 to 120 minutes.
     There is no load on these machines (except me pressing enter from
     time to time to see if it is still alive).
     I tried 3 of these machines. All have the same problem.
     No messages appear in the syslog.
     Magic-SysRq does not work when the machine is frozen.

[3.] Keywords (i.e., modules, networking, kernel):
     kernel, freeze

[4.] Kernel version (from /proc/version):
     By binary search I found the kernel version that introduced the bug:
     2.4.10-pre11 is OK (after making it compilabe by adding the file 
     compiler.h and inserting some 4 #includes in the mm subdir),
     2.4.10-pre12 shows the problem.
     To track the problem further down, I applied only part of the patch
     from pre11 to pre12. The original patch accessed 142 files and I 
     narrowed it down to changes in one or more of the following 45 files:
          linux-2.4.10-pre12/Makefile
          linux-2.4.10-pre12/arch/i386/config.in
          linux-2.4.10-pre12/arch/i386/defconfig
          linux-2.4.10-pre12/arch/i386/kernel/Makefile
          linux-2.4.10-pre12/arch/i386/kernel/apic.c
          linux-2.4.10-pre12/arch/i386/kernel/apm.c
          linux-2.4.10-pre12/arch/i386/kernel/dmi_scan.c
          linux-2.4.10-pre12/arch/i386/kernel/i386_ksyms.c
          linux-2.4.10-pre12/arch/i386/kernel/i8259.c
          linux-2.4.10-pre12/arch/i386/kernel/io_apic.c
          linux-2.4.10-pre12/arch/i386/kernel/irq.c
          linux-2.4.10-pre12/arch/i386/kernel/mpparse.c
          linux-2.4.10-pre12/arch/i386/kernel/nmi.c
          linux-2.4.10-pre12/arch/i386/kernel/process.c
          linux-2.4.10-pre12/arch/i386/kernel/ptrace.c
          linux-2.4.10-pre12/arch/i386/kernel/setup.c
          linux-2.4.10-pre12/arch/i386/kernel/smp.c
          linux-2.4.10-pre12/arch/i386/kernel/smpboot.c
          linux-2.4.10-pre12/arch/i386/kernel/time.c
          linux-2.4.10-pre12/arch/i386/kernel/traps.c
          linux-2.4.10-pre12/arch/i386/lib/usercopy.c
          linux-2.4.10-pre12/drivers/char/keyboard.c
          linux-2.4.10-pre12/drivers/char/pc_keyb.c
          linux-2.4.10-pre12/include/asm-i386/apic.h
          linux-2.4.10-pre12/include/asm-i386/io_apic.h
          linux-2.4.10-pre12/include/asm-i386/irq.h
          linux-2.4.10-pre12/include/asm-i386/mpspec.h
          linux-2.4.10-pre12/include/asm-i386/page.h
          linux-2.4.10-pre12/include/linux/compiler.h
          linux-2.4.10-pre12/include/linux/elf.h
          linux-2.4.10-pre12/include/linux/irq.h
          linux-2.4.10-pre12/include/linux/list.h
          linux-2.4.10-pre12/include/linux/major.h
          linux-2.4.10-pre12/include/linux/mm.h
          linux-2.4.10-pre12/include/linux/nmi.h
          linux-2.4.10-pre12/include/linux/pci.h
          linux-2.4.10-pre12/include/linux/prefetch.h
          linux-2.4.10-pre12/include/linux/sched.h
          linux-2.4.10-pre12/include/linux/sysctl.h
          linux-2.4.10-pre12/include/linux/sysrq.h
          linux-2.4.10-pre12/kernel/fork.c
          linux-2.4.10-pre12/kernel/ptrace.c
          linux-2.4.10-pre12/kernel/sched.c
          linux-2.4.10-pre12/kernel/sys.c
          linux-2.4.10-pre12/kernel/sysctl.c

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
     No Oops available

[6.] A small shell script or example program which triggers the
     problem (if possible)
     Just don't do anything on the machine. Boot and it freezes after 30
     to 120 minutes.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

This is basically an out-of-the-box SuSE 7.2 machine.
(Btw. SuSE 7.3 with the SuSE 2.4.10 kernel freezes too. That's
the reason why I installed the 7.2 version)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux aspbatch 2.4.10-pre12 #1 Fri Dec 28 12:53:41 CET 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.4
util-linux             2.11b
mount                  2.11b
modutils               2.4.5
e2fsprogs              1.19
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.25
isdn4k-utils           3.1pre1a
Linux C Library        x    1 root     root      1343073 May 11  2001
/lib/libc.so.6
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 994.469
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips	: 1985.74

[7.3.] Module information (from /proc/modules):
I don't use modules. Everything is compiled in the kernel.

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-10ff : Intel Corporation 82801BA(M) AC'97 Audio
1400-141f : Intel Corporation 82801BA(M) USB (Hub A)
1800-180f : Intel Corporation 82801BA(M) SMBus
1c00-1c1f : Intel Corporation 82801BA(M) USB (Hub B)
2000-203f : Intel Corporation 82801BA(M) AC'97 Audio
2400-240f : Intel Corporation 82801BA IDE U100
  2400-2407 : ide0
  2408-240f : ide1
3000-3fff : PCI Bus #01
  3400-343f : Intel Corporation 82801BA(M) Ethernet
    3400-343f : eepro100
  3800-383f : 3Com Corporation 3c905 100BaseTX [Boomerang]
    3800-383f : 01:0b.0

/proc/iomem:
00000000-0009ebff : System RAM
0009ec00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cffff : reserved
000f0000-000fffff : System ROM
00100000-1feeffff : System RAM
  00100000-0027a74b : Kernel code
  0027a74c-002e00df : Kernel data
1fef0000-1fefefff : ACPI Tables
1feff000-1fefffff : ACPI Non-volatile Storage
1ff00000-1fffffff : reserved
f4000000-f407ffff : PCI device 8086:1132 (Intel Corporation)
f4100000-f41fffff : PCI Bus #01
  f4100000-f4100fff : Intel Corporation 82801BA(M) Ethernet
    f4100000-f4100fff : eepro100
f8000000-fbffffff : PCI device 8086:1132 (Intel Corporation)
ffb80000-ffbfffff : reserved
fff00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and
Memory Controller Hub (rev 02)
	Subsystem: Siemens Nixdorf AG: Unknown device 005a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [88] #09 [f104]

00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset
Graphics Controller] (rev 02) (prog-if 00 [VGA])
	Subsystem: Siemens Nixdorf AG: Unknown device 004c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI (rev
02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f4100000-f41fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82820 820 (Camino 2) Chipset ISA
Bridge (ICH2) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation 82820 820 (Camino 2) Chipset IDE
U100 (rev 02) (prog-if 80 [Master])
	Subsystem: Siemens Nixdorf AG: Unknown device 0055
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at 2400 [size=16]

00:1f.2 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB
(Hub A) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Siemens Nixdorf AG: Unknown device 0055
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 1400 [size=32]

00:1f.3 SMBus: Intel Corporation 82820 820 (Camino 2) Chipset SMBus (rev 02)
	Subsystem: Siemens Nixdorf AG: Unknown device 0055
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 1800 [size=16]

00:1f.4 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB
(Hub B) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Siemens Nixdorf AG: Unknown device 0055
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at 1c00 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation 82820 820 (Camino 2)
Chipset AC'97 Audio Controller (rev 02)
	Subsystem: Siemens Nixdorf AG: Unknown device 0056
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 1000 [size=256]
	Region 1: I/O ports at 2000 [size=64]

01:08.0 Ethernet controller: Intel Corporation 82820 820 (Camino 2) Chipset
Ethernet (rev 01)
	Subsystem: Intel Corporation: Unknown device 3013
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 3400 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:0b.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 3800 [size=64]
	Expansion ROM at <unassigned> [disabled] [size=64K]

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices: none

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:
-- 
Ulf Grüne
E-Mail: ulf.gruene@uniserv.de    Tel.: 07231/936-2123   Fax: 07231/936-2500

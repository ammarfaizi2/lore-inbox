Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129738AbQLLRwo>; Tue, 12 Dec 2000 12:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130036AbQLLRwd>; Tue, 12 Dec 2000 12:52:33 -0500
Received: from postoffice.mail.cornell.edu ([132.236.56.7]:65190 "EHLO
	postoffice.mail.cornell.edu") by vger.kernel.org with ESMTP
	id <S129738AbQLLRwZ>; Tue, 12 Dec 2000 12:52:25 -0500
Message-Id: <4.3.2.7.2.20001212121416.00af26f0@postoffice.mail.cornell.edu>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 12 Dec 2000 12:22:23 -0500
To: linux-kernel@vger.kernel.org
From: Aron Rosenberg <amr42@cornell.edu>
Subject: PROBLEM: SMP, SCSI and test11,12 cause repeatable oops
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All, this is my first bug report so bear with me (I'm trying to 
follow the directions.) This was sent to linux-smp, linux-scsi, but no answer

Alright, I hope this helps everybody!

Aron Rosenberg
amr42@cornell.edu
Video Conferencing for Linux
http://cu30.sourceforge.net

<begin Bug report>
[1] SMP machine keeps oops'in and crashing on heavy/any SCSI disk access. 
This can be reproduced on low, medium and high CPU usage. File system is ext2.

[2] The kernel will oops and panic when in a shell a user tries to do a 
large file operation on a SCSI disk in an SMP kernel. The best and easiest 
way is to try and unpack the kernel sources. The machine will oops a little 
bit into it. This is easily repeatable on both test11, test11-pre8 and 
test12 in SMP mode. Does not happen in UP mode.

[3] Keywords: smp kernel

[4] version 2.4.0test11,test11-pre8, test12

[5] oops message and stack trace derefernced

Unable to handle Kernel NULL pointer dereference  at virtual address 0000003d
*pde = 00000000
Eip: 0010:[<c01331bc>]
Using defaults from ksymoops -t elf32-i386 -a i386
Eflags: 00010007
eax: 000000001 ebx: c122d628  ecx:00000046 eax: 000000001
esi: c832fc20 eti: 00000202 ebp: c832fc68 esp: c166de50
ds: 0018  es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c166d000)
Stack: c832fc20 d7eb20ac d7eb2000 00000050 c019a52d c832fc20 00000001 d7eb2000
  d7eb2000 00000000 c02db174 c019a829 d7eb2000 00000001 000000f8 00000001
  00000001 00000001 d7eb2000 000000f8 c166df08 c02db178 c02db17c 0000001f
Call Trace: [<c019a52d>] [<c019a829>] [<c01b8b9c>] [<c0199b1a>] [<c01abae0>]
  [<c01a0524>] [<c01abda1>]
  [<c010be61>] [<c010c056>] [<c0108934>] [<c0108934>] [<c010a7d8>] 
[<c018934>] [<c0108934>] [<c0100018>]
  [<c0108960>] [<c01089c2>] [<c01c6ea5>] [<c0171572>]
Code: 81 78 3c 48 31 13 c0 75 06 f6 40 18 04 75 5d 8b 40 28 39 f0

 >>EIP; c01331bc <end_buffer_io_async+74/f4>   <=====
Trace; c019a52d <__scsi_end_request+99/144>
Trace; c019a829 <scsi_io_completion+169/34c>
Trace; c01b8b9c <rw_intr+154/15c>
Trace; c0199b1a <scsi_old_done+5a6/5c4>
Trace; c01abae0 <aic7xxx_isr+d8/310>
Trace; c01a0524 <aic7xxx_done_cmds_complete+28/38>
Trace; c01abda1 <do_aic7xxx_isr+89/ac>
Trace; c010be61 <handle_IRQ_event+51/7c>
Trace; c010c056 <do_IRQ+9a/ec>
Trace; c0108934 <default_idle+0/34>
Trace; c0108934 <default_idle+0/34>
Trace; c010a7d8 <ret_from_intr+0/20>
Trace; 0c018934 Before first symbol
Trace; c0108934 <default_idle+0/34>
Trace; c0100018 <startup_32+18/cc>
Trace; c0108960 <default_idle+2c/34>
Trace; c01089c2 <cpu_idle+3a/50>
Trace; c01c6ea5 <vgacon_cursor+1e9/1f4>
Trace; c0171572 <set_cursor+6e/84>
Code;  c01331bc <end_buffer_io_async+74/f4>
0000000000000000 <_EIP>:
Code;  c01331bc <end_buffer_io_async+74/f4>   <=====
    0:   81 78 3c 48 31 13 c0      cmpl   $0xc0133148,0x3c(%eax)   <=====
Code;  c01331c3 <end_buffer_io_async+7b/f4>
    7:   75 06                     jne    f <_EIP+0xf> c01331cb 
<end_buffer_io_async+83/f4>
Code;  c01331c5 <end_buffer_io_async+7d/f4>
    9:   f6 40 18 04               testb  $0x4,0x18(%eax)
Code;  c01331c9 <end_buffer_io_async+81/f4>
    d:   75 5d                     jne    6c <_EIP+0x6c> c0133228 
<end_buffer_io_async+e0/f4>
Code;  c01331cb <end_buffer_io_async+83/f4>
    f:   8b 40 28                  mov    0x28(%eax),%eax
Code;  c01331ce <end_buffer_io_async+86/f4>
   12:   39 f0                     cmp    %esi,%eax

Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!

1 warning issued.  Results may not be reliable.
-------------------------------------------------------------
I had to copy down by hand, so I hope everything is correct.

Repeat of the oops on no cpu use.

Unable to handle Kernel NULL pointer dereference  at virtual address 0000003d
*pde = 00000000
Eip: 0010:[<c01331bc>]
Using defaults from ksymoops -t elf32-i386 -a i386
Eflags: 00010007
eax: 000000001 ebx: c12aefe4  ecx:00000046 eax: 000000001
esi: ca1abd40 eti: 00000202 ebp: ca1abd88 esp: c166de50
ds: 0018  es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c166d000)
Stack: c832fc20 d7eb20ac d7eb2000 00000050 c019a52d c832fc20 00000001 d7eb2000
  d7eb2000 00000000 c02db174 c019a829 d7eb2000 00000001 000000f8 00000001
  00000001 00000001 d7eb2000 000000f8 c166df08 c02db178 c02db17c 0000001f
Call Trace: [<c019a52d>] [<c019a829>] [<c01b8b9c>] [<c0199b1a>] [<c01abae0>]
  [<c01a0524>] [<c01abda1>]
  [<c010be61>] [<c010c056>] [<c0108934>] [<c0108934>] [<c010a7d8>] 
[<c018934>] [<c0108934>] [
<c0100018>]
  [<c0108960>] [<c01089c2>] [<c01c6ea5>] [<c0171572>]
Code: 81 78 3c 48 31 13 c0 75 06 f6 40 18 04 75 5d 8b 40 28 39 f0

 >>EIP; c01331bc <end_buffer_io_async+74/f4>   <=====
Trace; c019a52d <__scsi_end_request+99/144>
Trace; c019a829 <scsi_io_completion+169/34c>
Trace; c01b8b9c <rw_intr+154/15c>
Trace; c0199b1a <scsi_old_done+5a6/5c4>
Trace; c01abae0 <aic7xxx_isr+d8/310>
Trace; c01a0524 <aic7xxx_done_cmds_complete+28/38>
Trace; c01abda1 <do_aic7xxx_isr+89/ac>
Trace; c010be61 <handle_IRQ_event+51/7c>
Trace; c010c056 <do_IRQ+9a/ec>
Trace; c0108934 <default_idle+0/34>
Trace; c0108934 <default_idle+0/34>
Trace; c010a7d8 <ret_from_intr+0/20>
Trace; 0c018934 Before first symbol
Trace; c0108934 <default_idle+0/34>
Trace; c0100018 <startup_32+18/cc>
Trace; c0108960 <default_idle+2c/34>
Trace; c01089c2 <cpu_idle+3a/50>
Trace; c01c6ea5 <vgacon_cursor+1e9/1f4>
Trace; c0171572 <set_cursor+6e/84>
Code;  c01331bc <end_buffer_io_async+74/f4>
0000000000000000 <_EIP>:
Code;  c01331bc <end_buffer_io_async+74/f4>   <=====
    0:   81 78 3c 48 31 13 c0      cmpl   $0xc0133148,0x3c(%eax)   <=====
Code;  c01331c3 <end_buffer_io_async+7b/f4>
    7:   75 06                     jne    f <_EIP+0xf> c01331cb 
<end_buffer_io_async+83/f4>
Code;  c01331c5 <end_buffer_io_async+7d/f4>
    9:   f6 40 18 04               testb  $0x4,0x18(%eax)
Code;  c01331c9 <end_buffer_io_async+81/f4>
    d:   75 5d                     jne    6c <_EIP+0x6c> c0133228 
<end_buffer_io_async+e0/f4>
Code;  c01331cb <end_buffer_io_async+83/f4>
    f:   8b 40 28                  mov    0x28(%eax),%eax
Code;  c01331ce <end_buffer_io_async+86/f4>
   12:   39 f0                     cmp    %esi,%eax

Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!

1 warning issued.  Results may not be reliable.

[6] How to produce
This all happen on heavy disk usage of the SCSI system. If I try to compile 
the test11 kernel on a test11 boot with make -j3 or -j4 things will 
segfault out and once it oops'ed. This particular oops happened when 
untarring/verify a 358 meg file on the SCSI drive. There is also low to 
medium processor usage happening. I can reproduce this on an idle machine 
too. The file is a 358 meg script file/tar ball which causes the kernel to 
oops by running cksum or md5sum verify. Also will panic on untarring a 
kernel source.

[7.0] Machine type
Dell Precision Workstation 610 MT
Bios: A09
Processors: 2 Pentium II Xeon 400's
Memory 396megs
Disks: 1 IDE 2gig main boot, 1 SCSI-2 attached host 9gig.

[7.1] Linux amr42a 2.4.0-test11 #1 SMP Wed Dec 6 19:33:04 EST 2000 i686 unknown
Kernel modules         2.3.11
Gnu C                  egcs-2.91.66
Gnu Make               3.77
Binutils               2.10.0.24
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.9
Procps                 2.0.7
Mount                  2.9v
Net-tools              1.55
Kbd                    command
Sh-utils               2.0
Modules Loaded

[7.2] /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 398.000780
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 796.26

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 398.000780
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 796.26

[7.3] No modules loaded.
[7.4] /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0800-083f : Intel Corporation 82371AB PIIX4 ACPI
0840-085f : Intel Corporation 82371AB PIIX4 ACPI
0cf8-0cff : PCI conf1
dc00-dc7f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
   dc00-dc7f : eth0
dce0-dcff : Intel Corporation 82371AB PIIX4 USB
e000-efff : PCI Bus #02
   e800-e8ff : Adaptec AIC-7880U
     e800-e8fe : aic7xxx
   ec00-ecff : Adaptec AHA-2940U2/W / 7890
     ec00-ecfe : aic7xxx
ffa0-ffaf : Intel Corporation 82371AB PIIX4 IDE
   ffa0-ffa7 : ide0

/proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Extension ROM
000cc800-000ccfff : Extension ROM
000cd000-000cffff : Extension ROM
000f0000-000fffff : System ROM
00100000-17ffdfff : System RAM
   00100000-0025193f : Kernel code
   00251940-0026777f : Kernel data
17ffe000-17ffffff : reserved
f0000000-f3ffffff : Intel Corporation 440GX - 82443GX Host bridge
f5000000-f5ffffff : PCI Bus #02
f6000000-f6ffffff : PCI Bus #01
f9000000-faffffff : PCI Bus #02
   f9ffe000-f9ffefff : Adaptec AIC-7880U
   f9fff000-f9ffffff : Adaptec AHA-2940U2/W / 7890
fb000000-fdffffff : PCI Bus #01
   fb800000-fbffffff : Texas Instruments TVP4020 [Permedia 2]
   fc000000-fc7fffff : Texas Instruments TVP4020 [Permedia 2]
   fcfe0000-fcffffff : Texas Instruments TVP4020 [Permedia 2]
fe000000-fe00007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
ffe00000-ffffffff : reserved

[7.5]
00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
	Subsystem: Dell Computer Corporation: Unknown device 4087
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge (prog-if 
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fb000000-fdffffff
	Prefetchable memory behind bridge: f6000000-f6ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 19
	Region 4: I/O ports at dce0 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 24)
	Subsystem: Dell Computer Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at dc00 [size=128]
	Region 1: Memory at fe000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at f8000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) 
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: f9000000-faffffff
	Prefetchable memory behind bridge: 00000000f5000000-00000000f5f00000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

01:00.0 VGA compatible controller: Texas Instruments TVP4020 [Permedia 2] 
(rev 01) (prog-if 00 [VGA])
	Subsystem: Diamond Multimedia Systems FIRE GL 1000 PRO
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fcfe0000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at fc000000 (32-bit, non-prefetchable) [size=8M]
	Region 2: Memory at fb800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at 80000000 [disabled] [size=64K]
	Capabilities: [40] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:0a.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
	Subsystem: Dell Computer Corporation: Unknown device 0087
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (9750ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 18
	BIST result: 00
	Region 0: I/O ports at ec00 [size=256]
	Region 1: Memory at f9fff000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at fa000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0e.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)
	Subsystem: Adaptec AIC-7880P Ultra/Ultra Wide SCSI Chipset
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at f9ffe000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fa000000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6] /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: QUANTUM  Model: VIKING II 9.1WLS Rev: 3506
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
   Vendor: NEC      Model: CD-ROM DRIVE:465 Rev: 1.03
   Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7] /proc/interupts
            CPU0       CPU1
   0:      40942      31267    IO-APIC-edge  timer
   1:          2          0    IO-APIC-edge  keyboard
   2:          0          0          XT-PIC  cascade
  14:     130167     103226    IO-APIC-edge  ide0
  17:       1626       1404   IO-APIC-level  eth0
  18:       3210       3195   IO-APIC-level  aic7xxx, aic7xxx
NMI:      72143      72143
LOC:      72125      72124
ERR:          0

<end bug report> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261956AbSJECfk>; Fri, 4 Oct 2002 22:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261957AbSJECfk>; Fri, 4 Oct 2002 22:35:40 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:50639 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S261956AbSJECfd> convert rfc822-to-8bit; Fri, 4 Oct 2002 22:35:33 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: linux-kernel@vger.kernel.org
Subject: Linux-2.4.20-pre8-aa2 oops report.
Date: Sat, 5 Oct 2002 12:47:14 +1000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210051247.14368.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
	2.4.20-pre8aa2 Kernel oopsed couple of times.

[2.] Full description of the problem/report:
	Same as above.

[3.] Keywords (i.e., modules, networking, kernel):
	I am no kernel developer, but I suspect it may be due to XFree86, 
AGPGART/DRM/Radeon. I may be wrong though, please feel to correct me.

[4.] Kernel version (from /proc/version):
Linux version 2.4.20-pre8aa2 (hari@localhost.localdomain) (gcc version 3.2 
20020903 (Red Hat Linux 8.0 3.2-7)) #3 Thu Oct 3 21:07:54 EST 2002

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
ksymoops 2.4.5 on i686 2.4.20-pre8aa2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre8aa2/ (default)
     -m /boot/System.map-2.4.20-pre8aa2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct  5 11:46:39 localhost kernel: kernel BUG at memory.c:419!
Oct  5 11:46:39 localhost kernel: invalid operand: 0000 2.4.20-pre8aa2 #3 Thu 
Oct 3 21:07:54 EST 2002
Oct  5 11:46:39 localhost kernel: CPU:    0
Oct  5 11:46:39 localhost kernel: EIP:    0010:[<c01270f6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct  5 11:46:39 localhost kernel: EFLAGS: 00210246
Oct  5 11:46:39 localhost kernel: eax: cb988000   ebx: 00000000   ecx: 
cabe4740   edx: 00000000
Oct  5 11:46:39 localhost kernel: esi: cb988000   edi: 00000000   ebp: 
00000000   esp: cbcfde84
Oct  5 11:46:39 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct  5 11:46:39 localhost kernel: Process gnome-session (pid: 5481, 
stackpage=cbcfd000)
Oct  5 11:46:39 localhost kernel: Stack: cabe4740 cb988400 00200292 00003000 
da97e4c0 00000000 cabe4740 00000000 
Oct  5 11:46:39 localhost kernel:        c012a5b5 cabe4740 00000000 00000000 
00000000 cabe4740 cbcfc000 cbcfdf30 
Oct  5 11:46:39 localhost kernel:        0000000b c0116a36 cabe4740 00200202 
cabe4740 c011b807 cabe4740 c158f270 
Oct  5 11:46:39 localhost kernel: Call Trace:    [<c012a5b5>] [<c0116a36>] 
[<c011b807>] [<c01213cc>] [<c01215a4>]
Oct  5 11:46:39 localhost kernel:   [<c0108c54>] [<c0113c60>] [<c0108f38>]
Oct  5 11:46:39 localhost kernel: Code: 0f 0b a3 01 42 4c 1f c0 89 f6 8b 44 24 
24 89 74 24 04 89 5c 


>>EIP; c01270f6 <zap_page_range+26/b0>   <=====

>>eax; cb988000 <END_OF_CODE+53341a9/????>
>>ecx; cabe4740 <END_OF_CODE+45908e9/????>
>>esi; cb988000 <END_OF_CODE+53341a9/????>
>>esp; cbcfde84 <END_OF_CODE+56aa02d/????>

Trace; c012a5b5 <exit_mmap+b5/130>
Trace; c0116a36 <mmput+56/d0>
Trace; c011b807 <do_exit+87/260>
Trace; c01213cc <sig_exit+9c/a0>
Trace; c01215a4 <dequeue_signal+64/d0>
Trace; c0108c54 <do_signal+1b4/2a0>
Trace; c0113c60 <do_page_fault+0/5a0>
Trace; c0108f38 <signal_return+14/18>

Code;  c01270f6 <zap_page_range+26/b0>
00000000 <_EIP>:
Code;  c01270f6 <zap_page_range+26/b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01270f8 <zap_page_range+28/b0>
   2:   a3 01 42 4c 1f            mov    %eax,0x1f4c4201
Code;  c01270fd <zap_page_range+2d/b0>
   7:   c0 89 f6 8b 44 24 24      rorb   $0x24,0x24448bf6(%ecx)
Code;  c0127104 <zap_page_range+34/b0>
   e:   89 74 24 04               mov    %esi,0x4(%esp,1)
Code;  c0127108 <zap_page_range+38/b0>
  12:   89 5c 00 00               mov    %ebx,0x0(%eax,%eax,1)

Oct  5 11:46:39 localhost kernel:  kernel BUG at memory.c:419!
Oct  5 11:46:39 localhost kernel: invalid operand: 0000 2.4.20-pre8aa2 #3 Thu 
Oct 3 21:07:54 EST 2002
Oct  5 11:46:39 localhost kernel: CPU:    0
Oct  5 11:46:39 localhost kernel: EIP:    0010:[<c01270f6>]    Not tainted
Oct  5 11:46:39 localhost kernel: EFLAGS: 00210246
Oct  5 11:46:39 localhost kernel: eax: c51a5000   ebx: 00000000   ecx: 
c2ec2a80   edx: 00000000
Oct  5 11:46:39 localhost kernel: esi: c51a5000   edi: 00000000   ebp: 
00000000   esp: d160df48
Oct  5 11:46:39 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct  5 11:46:39 localhost kernel: Process gnome-session (pid: 5371, 
stackpage=d160d000)
Oct  5 11:46:39 localhost kernel: Stack: c158e380 c013b2cc 00200296 00003000 
dbe63ac0 00000000 c2ec2a80 00000000 
Oct  5 11:46:39 localhost kernel:        c012a5b5 c2ec2a80 00000000 00000000 
00000000 c2ec2a80 d160c000 bffff5fc 
Oct  5 11:46:39 localhost kernel:        00000100 c0116a36 c2ec2a80 00200206 
c2ec2a80 c011b807 c2ec2a80 00001569 
Oct  5 11:46:39 localhost kernel: Call Trace:    [<c013b2cc>] [<c012a5b5>] 
[<c0116a36>] [<c011b807>] [<c011ba13>]
Oct  5 11:46:39 localhost kernel:   [<c0108eff>]
Oct  5 11:46:39 localhost kernel: Code: 0f 0b a3 01 42 4c 1f c0 89 f6 8b 44 24 
24 89 74 24 04 89 5c 


>>EIP; c01270f6 <zap_page_range+26/b0>   <=====

>>eax; c51a5000 <[agpgart].bss.end+10701e5/1b9b265>
>>ecx; c2ec2a80 <[serial].bss.end+8e659d/1ac3b9d>
>>esi; c51a5000 <[agpgart].bss.end+10701e5/1b9b265>
>>esp; d160df48 <END_OF_CODE+afba0f1/????>

Trace; c013b2cc <fput+cc/120>
Trace; c012a5b5 <exit_mmap+b5/130>
Trace; c0116a36 <mmput+56/d0>
Trace; c011b807 <do_exit+87/260>
Trace; c011ba13 <sys_exit+13/20>
Trace; c0108eff <system_call+33/38>

Code;  c01270f6 <zap_page_range+26/b0>
00000000 <_EIP>:
Code;  c01270f6 <zap_page_range+26/b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01270f8 <zap_page_range+28/b0>
   2:   a3 01 42 4c 1f            mov    %eax,0x1f4c4201
Code;  c01270fd <zap_page_range+2d/b0>
   7:   c0 89 f6 8b 44 24 24      rorb   $0x24,0x24448bf6(%ecx)
Code;  c0127104 <zap_page_range+34/b0>
   e:   89 74 24 04               mov    %esi,0x4(%esp,1)
Code;  c0127108 <zap_page_range+38/b0>
  12:   89 5c 00 00               mov    %ebx,0x0(%eax,%eax,1)


1 warning issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)
	Unfortunately No.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux localhost.localdomain 2.4.20-pre8aa2 #3 Thu Oct 3 21:07:54 EST 2002 i686 
athlon i386 GNU/Linux

Gnu C                  gcc (GCC) 3.2 20020903 (Red Hat Linux 8.0 3.2-7) 
Copyright (C) 2002 Free Software Foundation, Inc. This is free software; see 
the source for copying conditions. There is NO warranty; not even for 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         ipt_state ip_conntrack ppp_deflate zlib_inflate 
zlib_deflate ppp_async ppp_generic slhc sr_mod emu10k1 ac97_codec soundcore 
radeon agpgart af_packet iptable_filter ip_tables serial floppy ide-scsi 
scsi_mod ide-cd cdrom raid0 md rtc unix

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1200.075
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2392.06

[7.3.] Module information (from /proc/modules):
ipt_state               1080  36 (autoclean)
ip_conntrack           25152   1 (autoclean) [ipt_state]
ppp_deflate             4472   0 (autoclean)
zlib_inflate           21060   0 (autoclean) [ppp_deflate]
zlib_deflate           20632   0 (autoclean) [ppp_deflate]
ppp_async               9344   1 (autoclean)
ppp_generic            19604   3 (autoclean) [ppp_deflate ppp_async]
slhc                    6832   1 (autoclean) [ppp_generic]
sr_mod                 15960   0 (autoclean)
emu10k1                63488   0 (autoclean)
ac97_codec             13320   0 (autoclean) [emu10k1]
soundcore               5988   4 (autoclean) [emu10k1]
radeon                 87416   3
agpgart                19996   3
af_packet              11464   0 (autoclean)
iptable_filter          2412   1 (autoclean)
ip_tables              14328   2 [ipt_state iptable_filter]
serial                 50404   1 (autoclean)
floppy                 55868   0 (autoclean)
ide-scsi               10512   0
scsi_mod               96788   2 [sr_mod ide-scsi]
ide-cd                 33412   0
cdrom                  32608   0 [sr_mod ide-cd]
raid0                   3912   4 (autoclean)
md                     56544   4 [raid0]
rtc                     8532   0 (autoclean)
unix                   17832 149 (autoclean)

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
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
c000-cfff : PCI Bus #01
  c000-c0ff : ATI Technologies Inc Radeon VE QY
d000-d003 : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller
d400-d40f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d400-d407 : ide0
  d408-d40f : ide1
d800-d81f : VIA Technologies, Inc. USB
dc00-dc1f : VIA Technologies, Inc. USB (#2)
e000-e01f : Creative Labs SB Live! EMU10k1
  e000-e01f : EMU10K1
e400-e407 : Creative Labs SB Live! MIDI/Game Port

/proc/iomem:
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
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
c000-cfff : PCI Bus #01
  c000-c0ff : ATI Technologies Inc Radeon VE QY
d000-d003 : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller
d400-d40f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d400-d407 : ide0
  d408-d40f : ide1
d800-d81f : VIA Technologies, Inc. USB
dc00-dc1f : VIA Technologies, Inc. USB (#2)
e000-e01f : Creative Labs SB Live! EMU10k1
  e000-e01f : EMU10K1
e400-e407 : Creative Labs SB Live! MIDI/Game Port
[hari@localhost linux-2.4.20-pre8]$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-001eae83 : Kernel code
  001eae84-0021a73f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System 
Controller
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : ATI Technologies Inc Radeon VE QY
e0000000-e1ffffff : PCI Bus #01
  e1000000-e100ffff : ATI Technologies Inc Radeon VE QY
e2000000-e2000fff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System 
Controller
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System 
Controller (rev 12)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at e2000000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at d000 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP Bridge 
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e0000000-e1ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE 
(rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d400 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e000 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
06)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at e400 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY (prog-if 
00 [VGA])
	Subsystem: Unknown device 1787:0202
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=15 SBA+ AGP+ 64bit- FW- Rate=x1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: RICOH    Model: CD-R/RW MP7083A  Rev: 1.20
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
None.

[X.] Other notes, patches, fixes, workarounds:
	I see the following syslog messages between the oops
Oct  5 11:46:39 localhost gdm(pam_unix)[5359]: session closed for user hari
Oct  5 11:46:39 localhost gdm[5359]: gdm_slave_xioerror_handler: Fatal X error 
- Restarting :0

I was using XFree86 (the one with Red Hat 8) on 2D at the time of oops, no 3D 
activities (the only 3D usage of this computer is playing tuxracer game :)

I was doing heavy file system activities just before the oops, I was trying to 
measure Ext3 and Raid0 performance by creating nearly 5-6 GB file using dd. I 
will see if I can reproduce this on mainline, RH kernel etc.

<rant>
This is the second crash ever happened to me (the first one was the pesky 
netfilter oops may be due to NAT, which didn't make it to the system logs, 
and I am still waiting for it to happen again now that I have kernel 
debugging/sysrq enabled). I am genuinely worried about the stability of my 
favourite OS.
</rant>

Anyway thanks guys, you are all doing a wonderful job on the Linux kernel 
project. Please CC me if you can as I am not subscribed to LKML, but I 
regularly read the web archives.
-- 
Hari
harisri@bigpond.com


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292362AbSCAVvK>; Fri, 1 Mar 2002 16:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292565AbSCAVvE>; Fri, 1 Mar 2002 16:51:04 -0500
Received: from heavymetal.isc.de ([195.64.96.45]:18295 "EHLO mail1.isys.net")
	by vger.kernel.org with ESMTP id <S292362AbSCAVur>;
	Fri, 1 Mar 2002 16:50:47 -0500
Message-ID: <3C7FF7E8.9020200@gmx.net>
Date: Fri, 01 Mar 2002 22:51:36 +0100
From: Fredo David <FredoDavid@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Win98; de-DE; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: de,en,no
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: IDS2000 crashed during kernel oops.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[1.] One line summary of the problem:

	IDS.2000 crashed during a kernel oops.


[2.] Full description of the problem/report:

During a Kernel- Update from 2.2.16 to 2.2.19 with SuSE Linux 7.0 we ran
into the following problem. We use an Informix DB with raw devices.
The Database IDS.2000, running on a Linux 2.2.19 machine crashes during
a DB- backup with onbar -b -w or during a DB- Log- Backup with onbar -b
-l on a tape.

	The last message in the online.log and bar_act.log:
2002-03-01 11:40:41   Checkpoint Completed:  duration was 0 seconds.
2002-03-01 11:40:41   Checkpoint loguniq 2347, logpos 0x150018
2002-03-01 11:40:43   Level 0 Archive started on rootdbs, xsvblobdbs,
			physdbs, logdbs, xsvdbs

2002-03-01 11:40:43   Fatal error in ADM VP at mt.c:11462
2002-03-01 11:40:43   Unexpected virtual processor termination, pid=439,
			exit = 0xb
2002-03-01 11:40:44   PANIC: Attempting to bring system down
2002-03-01 11:40:44   semctl: errno = 22
2002-03-01 11:40:44   semctl: errno = 22
Every time I started the DB again, when running onbar -b -l on tape, the
IDS crashes.



[3.] Keywords
	
IDS.2000 Informix oops rawio 	


[4.] Kernel version

Linux version 2.2.19 (root@srvixdb1) (gcc version 2.95.2 19991024
(release)) #2 	Wed Feb 27 15:43:48 CET 2002


[5.] Output of Oops.message(if applicable) with symbolic information
resolved

Mar  1 11:40:43 srvixdb1 kernel: Unable to handle kernel paging request
at virtual address b000e400
Mar  1 11:40:43 srvixdb1 kernel: current->tss.cr3 = 28e7c000, %cr3 =
28e7c000
Mar  1 11:40:43 srvixdb1 kernel: *pde = 00000000
Mar  1 11:40:43 srvixdb1 kernel: Oops: 0002
Mar  1 11:40:43 srvixdb1 kernel: CPU:    0
Mar  1 11:40:43 srvixdb1 kernel: EIP: 0010:[kiobuf_copy_bounce+155/204]
Mar  1 11:40:43 srvixdb1 kernel: EFLAGS: 00010206
Mar  1 11:40:43 srvixdb1 kernel: eax: b000e000   ebx: 00000400   ecx:
00000300   	edx: 00000c00
Mar  1 11:40:43 srvixdb1 kernel: esi: cdbef400   edi: b000e400   ebp:
0000f800   esp: 	e8e7be1c
Mar  1 11:40:43 srvixdb1 kernel: ds: 0018   es: 0018   ss: 0018
Mar  1 11:40:43 srvixdb1 kernel: Process oninit (pid: 439, process nr:
54, 	stackpage=e8e7b000)
Mar  1 11:40:43 srvixdb1 kernel: Stack: 00000000 00000001 c02eaa40
c02c6e00 	e8e7be48 00000000 00000c00 f0463000
Mar  1 11:40:43 srvixdb1 kernel:        00000000 c012a954 f0463000
00000001 	0000f800 00000000 00000c00 f0463000
Mar  1 11:40:43 srvixdb1 kernel:        0000f800 00000000 f0463000
00003a03 	0003f967 c012ac55 00000000 00000001
Mar  1 11:40:43 srvixdb1 kernel: Call Trace: [<f0463000>]
[cleanup_bounce_buffers+60/92] [<f0463000>] [<f0463000>] [<f0463000>]
[brw_kiovec+737/764] [<f04631ac>]
Mar  1 11:40:43 srvixdb1 kernel: Code: f3 a5 f6 c2 02 74 02 66 a5 f6 c2
01 74 01 a4 	89 f6 29 d5 31
Using defaults from ksymoops -t elf32-i386 -a i386
	
Trace; f0463000 <[eepro100].data.end+13edd/1ef31>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
     0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)
Code;  00000002 Before first symbol
     2:   f6 c2 02                  test   $0x2,%dl
Code;  00000005 Before first symbol
     5:   74 02                     je     9 <_EIP+0x9> 00000009 Before
first symbol
Code;  00000007 Before first symbol
     7:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  00000009 Before first symbol
     9:   f6	c2 01                  test   $0x1,%dl
Code;  0000000c Before first symbol
     c:   74 01                     je     f <_EIP+0xf> 0000000f Before
first symbol
Code;  0000000e Before first symbol
     e:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  0000000f Before first symbol
     f:   89 f6                     mov    %esi,%esi
Code;  00000011 Before first symbol
    11:   29 d5                     sub    %edx,%ebp
Code;  00000013 Before first symbol
    13:   31 00                     xor    %eax,(%eax)


[6.] A small shell script or example program which triggers the
problem(if possible)

	None


[7.] Environment

[7.1.] Software(add the output of the ver_linux script here)

/usr/src/linux-2.2.19.SuSE/scripts/ver_linux

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux srvixdb1 2.2.19 #2 Wed Feb 27 15:43:48 CET 2002 i686 unknown

	Gnu C                  2.95.2
	Gnu make               3.79.1
	binutils               2.9.5.0.24
	util-linux             2.10m
	modutils               2.3.11
	e2fsprogs              1.18
	Linux C Library        x   1 root     root      4070406 Jul 30  2000
/lib/libc.so.6
	Dynamic linker (ldd)   2.1.3
	Procps                 2.0.6
	Net-tools              1.56
	Kbd                    0.99
	Sh-utils               2.0
	Modules Loaded         ipv6 eepro100 serial usbcore gdth

[7.2.] Processor information:

	cat /proc/cpuinfo

	processor	: 0
	vendor_id	: GenuineIntel
	cpu family	: 6
	model		: 8
	model name	: Pentium III (Coppermine)
	stepping	: 6
	cpu MHz		: 930.930
	cache size	: 256 KB
	fdiv_bug	: no
	hlt_bug		: no
	sep_bug		: no
	f00f_bug	: no
	coma_bug	: no
	fpu		: yes
	fpu_exception	: yes
	cpuid level	: 2
	wp		: yes
	flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 	pse36 mmx
fxsr xmm
	bogomips	: 1854.66
	
[7.3.] Module information

	cat /proc/modules

	ipv6                  100328  -1 (autoclean)
	eepro100               17432   1 (autoclean)
	serial                 42804   0 (autoclean)
	usbcore                44008   0 (unused)
	gdth                   78128   3
	
[7.4.] Loaded driver and hardware information

	cat /proc/ioports

	0000-001f : dma1
	0020-003f : pic1
	0040-005f : timer
	0060-006f : keyboard
	0070-007f : rtc
	0080-008f : dma page reg
	00a0-00bf : pic2
	00c0-00df : dma2
	00f0-00ff : fpu
	01f0-01f7 : ide0
	02f8-02ff : serial(auto)
	03c0-03df : vga+
	03f6-03f6 : ide0
	03f8-03ff : serial(auto)
	f0451000-f045101f : Intel Speedo3 Ethernet

[7.5.] PCI information

	lspci -vvv

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1621 (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 	ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 	<TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable)
	Capabilities: [b0] AGP version 1.0
		Status: RQ=27 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [a4] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME	(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247 (rev 01) (prog-if
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 	ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 	<TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: f2000000-f3efffff
	Prefetchable memory behind bridge: f5f00000-f7ffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi]:
Unknown device 	5451 (rev 01)
	Subsystem: Asustek Computer, Inc.: Unknown device 8021
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 	ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR+ <PERR+
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d800
	Region 1: Memory at f1800000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2	+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV]
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1533 Aladdin IV ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 	ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME	(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 	ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f5000000 (32-bit, prefetchable)
	Region 1: I/O ports at d400
	Region 2: Memory at f1000000 (32-bit, non-prefetchable)

00:0b.0 SCSI storage controller: ICP Vortex Computersysteme GmbH:
Unknown device 013a
	Subsystem: ICP Vortex Computersysteme GmbH: Unknown device 013a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 	ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f4000000 (32-bit, prefetchable)
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME	(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3)
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 	ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at d000
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME	(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Asustek Computer, Inc.: Unknown device 8021
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

00:14.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
(prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8021
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 	ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f0800000 (32-bit, non-prefetchable)
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME	(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Riva TNT2 (rev 20)
(prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 8021
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 	ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f2000000 (32-bit, non-prefetchable)
	Region 1: Memory at f6000000 (32-bit, prefetchable)
	Expansion ROM at f5ff0000 [disabled]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME	(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information

	cat /proc/scsi/scsi

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
    Vendor: ICP      Model: Host Drive  #00  Rev:
    Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
    Vendor: ICP      Model: Host Drive  #01  Rev:
    Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
    Vendor: ICP      Model: Host Drive  #02  Rev:
    Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
    Vendor: ICP      Model: Host Drive  #04  Rev:
    Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 01 Id: 04 Lun: 00
    Vendor: HP       Model: C5683A           Rev: C005
    Type:   Sequential-Access                ANSI SCSI revision: 02


Any help would be appreciated.

Fredo



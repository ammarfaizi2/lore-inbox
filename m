Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266944AbSLDIOv>; Wed, 4 Dec 2002 03:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbSLDIOv>; Wed, 4 Dec 2002 03:14:51 -0500
Received: from 12-253-132-99.client.attbi.com ([12.253.132.99]:28032 "EHLO
	luke.no-ip.org") by vger.kernel.org with ESMTP id <S266944AbSLDIOs>;
	Wed, 4 Dec 2002 03:14:48 -0500
Subject: PROBLEM: "kernel BUG" in syslog
From: Luke Q <lcampagn@mines.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1038990133.709.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 04 Dec 2002 01:22:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently had an interesting problem.. the local terminal on my
Debian/Unstable went blank suddenly, so I headed over to my trusty music
server to see if I could log in remotely and kill off X (which is
usually the cause of problems like this) ..after logging in, I found
that most commands would run alright (sudo, ls, df..) but using kill
would freeze the terminal completely. An inspection of my kernel logs
showed a bunch of these: 

Dec  2 23:56:02 localhost kernel: kernel BUG at page_alloc.c:102!
Dec  2 23:56:02 localhost kernel: invalid operand: 0000
Dec  2 23:56:02 localhost kernel: CPU:    0
Dec  2 23:56:02 localhost kernel: EIP:    0010:[__free_pages_ok+68/652]    Tainted: PF
Dec  2 23:56:02 localhost kernel: EFLAGS: 00010282
Dec  2 23:56:02 localhost kernel: eax: c12b2070   ebx: c11da5f0   ecx: c11da60c   edx: c029c780
Dec  2 23:56:02 localhost kernel: esi: 00000000   edi: 00000018   ebp: 000001f8   esp: c15a9f14
Dec  2 23:56:02 localhost kernel: ds: 0018   es: 0018   ss: 0018
Dec  2 23:56:02 localhost kernel: Process kswapd (pid: 4, stackpage=c15a9000)
Dec  2 23:56:02 localhost kernel: Stack: d804e3e0 c11da5f0 00000018 000001f8 c0132c8c c11da5f0 000001d0 00000018 
Dec  2 23:56:02 localhost kernel:        000001f8 c01311ec d804e3e0 c11da5f0 c0128fc2 c0129fc3 c0128ffb 00000020 
Dec  2 23:56:02 localhost kernel:        000001d0 00000020 00000006 00000006 c15a8000 00002ed3 000001d0 c029c914 
Dec  2 23:56:02 localhost kernel: Call Trace:    [try_to_free_buffers+144/228] [try_to_release_page+68/72] [shrink_cache+490/764] [__free_pages+27/28] [shrink_cache+547/764]
Dec  2 23:56:02 localhost kernel:   [shrink_caches+88/128] [try_to_free_pages_zone+58/92] [kswapd_balance_pgdat+65/140] [kswapd_balance+26/48] [kswapd+153/188] [kernel_thread+40/56]
Dec  2 23:56:02 localhost kernel: 
Dec  2 23:56:02 localhost kernel: Code: 0f 0b 66 00 d3 b2 24 c0 89 d8 2b 05 f0 c4 2f c0 69 c0 a3 8b 

I eventually just rebooted the machine. Unfortunately, I have no idea
what triggered the bug. Cron reported that sendmail segfaulted at about
the same time, but I suspect that was only a result of the bug, and not
a cause. 


Here's the output of ver_linux: 

Linux rock 2.4.20 #2 Sat Nov 30 14:55:48 MST 2002 i686 unknown unknown
GNU/Linux
 
Gnu C                  2.95.4
Gnu make               3.80
util-linux             2.11x
mount                  2.11x
modutils               2.4.21
e2fsprogs              1.32
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.0
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.3
Modules Loaded         ipt_LOG iptable_filter ip_tables printer vfat fat
analog emu10k1-gp gameport joydev input emu10k1 ac97_codec sound
soundcore usb-uhci ide-cd cdrom


/proc/cpuinfo:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 930.338
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr sse
bogomips	: 1854.66


lspci -vvv

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [88] #09 [f104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x4

00:01.0 PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fc900000-fe9fffff
	Prefetchable memory behind bridge: e4600000-f46fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fea00000-feafffff
	Prefetchable memory behind bridge: f4700000-f47fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corp.: Unknown device 4541
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4541
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at ef80 [size=32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 02)
	Subsystem: Intel Corp.: Unknown device 4541
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at efa0 [size=16]

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX] (rev a1) (prog-if 00 [VGA])
	Subsystem: nVidia Corporation: Unknown device 004a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at fe9f0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x4

02:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs CT4780 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at df80 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at dff0 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0b.0 Multimedia video controller: Brooktree Corporation Bt848 Video Capture (rev 12)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f47ff000 (32-bit, prefetchable) [size=4K]

02:0c.0 Communication controller: Lucent Microelectronics 56k WinModem (rev 01)
	Subsystem: Zoom Telephonics Inc: Unknown device 9300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at feaffc00 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at dfe0 [size=8]
	Region 2: I/O ports at d800 [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 6c)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at dc00 [size=128]
	Region 1: Memory at feaff800 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-





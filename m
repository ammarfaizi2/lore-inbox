Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262683AbRE0BXF>; Sat, 26 May 2001 21:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262684AbRE0BWz>; Sat, 26 May 2001 21:22:55 -0400
Received: from zeus.kernel.org ([209.10.41.242]:11711 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262683AbRE0BWv>;
	Sat, 26 May 2001 21:22:51 -0400
Date: Sun, 27 May 2001 03:20:34 +0200 (CEST)
From: <josn@N-O-S-P-A-M.gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: "kernel BUG at inode.c:486!"
Message-ID: <Pine.LNX.4.31.0105270205250.2540-100000@voyager.josnland>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Indexing as suggested in 'REPORTING-BUGS'.

[1.] One line summary
I get "kernel BUG at inode.c:486" when using NFS.

[2.] Full description
I can reproducibly generate a problem when I try to build a kernel,
located on a NFS drive. The kernel build failes when compiling the first
source; the kernel logs 'kernel BUG at inode.c:486!'. The message is
apparently generated because inode->i_data.nrpages is unexpectedly
non-zero in linux/fs/inode.c The problem has occurred on kernel 2.4.5,
and also on kernel 2.4.5-pre4. I didnt get it on kernel 2.4.5-pre3.
Almost any other things on the same NFS drive seem to work fine.

[3.] keywords
kernel bug, inode, nfs

[4.] Kernel versions
system getting the kernel problem:
"Linux version 2.4.5 (josn@voyager) (gcc version 2.95.2 19991024 (release)) #1 Sun May 27 00:50:28 CEST 2001"
system used as fileserver:
"Linux version 2.4.5-pre3 (josn@voyager) (gcc version 2.95.2 19991024 (release))
#6 Thu May 17 00:42:13 CEST 2001"

[5.] Kernel logging involved
    May 27 01:34:43 voyager kernel: kernel BUG at inode.c:486!
    May 27 01:34:43 voyager kernel: invalid operand: 0000
    May 27 01:34:43 voyager kernel: CPU:    0
    May 27 01:34:43 voyager kernel: EIP:    0010:[clear_inode+51/280]
    May 27 01:34:43 voyager kernel: EFLAGS: 00010286
    May 27 01:34:43 voyager kernel: eax: 0000001b   ebx: c4badc00   ecx: c6a96000   edx: c7f70ea0
    May 27 01:34:43 voyager kernel: esi: c90bb1e0   edi: c4be7160   ebp: c6a97fa4   esp: c6a97eec
    May 27 01:34:43 voyager kernel: ds: 0018   es: 0018   ss: 0018
    May 27 01:34:43 voyager kernel: Process make (pid: 2198, stackpage=c6a97000)
    May 27 01:34:43 voyager kernel: Stack: c01e0955 c01e09b4 000001e6 c4badc00 c013f677 c4badc00 c4bac340 c4badc00
    May 27 01:34:43 voyager kernel:        c90afb1a c4badc00 c013d256 c4bac340 c4badc00 c4bac340 00000000 c0135d0c
    May 27 01:34:43 voyager kernel:        c4bac340 c6a97f68 c013642a c4be7160 c6a97f68 00000000 c7b29000 00000000
    May 27 01:34:43 voyager kernel: Call Trace: [iput+311/332] [usbcore:usb_devfs_handle_Re9c5f87f+610906/44386086] [dput+214/324] [cached_lookup+72/84] [path_walk+1334/1932] [getname+90/152] [__user_walk+60/88]
    May 27 01:34:43 voyager kernel:        [sys_stat64+22/120] [sys_close+67/84] [system_call+51/56]
    May 27 01:34:43 voyager kernel:
    May 27 01:34:43 voyager kernel: Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 19 68 e8 01 00 00 68
Since I dont think the kernel messages after the 'kernel BUG' message is
really is really interesting anymore, I did nothing to decode them. On
request, I will.

[6.] example of what I did

    # logged in as non-root
    # fstab contains: 'ds9:/ /router nfs defaults,noauto,user,exec'
    mount /router
    cd /router/usr/src
    mkdir linux-2.4.5
    cd linux-2.4.5
    tar xIf /archive/linux/kernel/linux-2.4.5.tar.bz2
    cd linux; cp -al . ../voyager
    cd ../voyager
    cp ../../linux-2.4.5-pre4/voyager/.config .
    rm /usr/src/linux
    ln -s /router/usr/src/linux-2.4.5/voyager /usr/src/linux
    make dep
    make bzImage # 'kernel BUG' IS LOGGED; gcc gets sig11 on first compile

[7.1]

Output of ver_linux
	If some fields are empty or look unusual you may have an old version.
	Compare to the current minimal requirements in Documentation/Changes.

	Linux voyager 2.4.5 #1 Sun May 27 00:50:28 CEST 2001 i686 unknown

	Gnu C                  2.95.2
	Gnu make               3.79.1
	binutils               2.10.0.33
	util-linux             2.10q
	mount                  2.10q
	modutils               2.4.2
	e2fsprogs              1.19
	pcmcia-cs              3.1.26
	PPP                    2.3.11
	Linux C Library        x    1 root     root      1382179 Jan 19 07:14 /lib/libc.so.6
	Dynamic linker (ldd)   2.2
	Procps                 2.0.7
	Net-tools              1.57
	Kbd                    1.02
	Sh-utils               2.0
	Modules Loaded         audio soundcore nfs lockd sunrpc af_packet xirc2ps_cs ds i82365 pcmcia_core ipv6 mousedev hid input usb-uhci apm nls_iso8859-15 nls_cp850 vfat fat usbcore unix

[7.2] Output of /proc/cpuinfo

	processor	: 0
	vendor_id	: GenuineIntel
	cpu family	: 6
	model		: 8
	model name	: Pentium III (Coppermine)
	stepping	: 3
	cpu MHz		: 597.791
	cache size	: 256 KB
	fdiv_bug	: no
	hlt_bug		: no
	f00f_bug	: no
	coma_bug	: no
	fpu		: yes
	fpu_exception	: yes
	cpuid level	: 2
	wp		: yes
	flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
	bogomips	: 1192.75

[7.3] Module info

	audio                  35584   0 (autoclean) (unused)
	soundcore               3856   0 (autoclean) [audio]
	nfs                    72448   1 (autoclean)
	lockd                  48304   1 (autoclean) [nfs]
	sunrpc                 58432   1 (autoclean) [nfs lockd]
	af_packet               8368   1 (autoclean)
	xirc2ps_cs             14688   1
	ds                      6944   2 [xirc2ps_cs]
	i82365                 23504   2
	pcmcia_core            50304   0 [xirc2ps_cs ds i82365]
	ipv6                  124016  -1 (autoclean)
	mousedev                4000   1
	hid                    11744   0 (unused)
	input                   3360   0 [mousedev hid]
	usb-uhci               20832   0 (unused)
	apm                     8464   2
	nls_iso8859-15          3392   2 (autoclean)
	nls_cp850               3584   2 (autoclean)
	vfat                    8752   2 (autoclean)
	fat                    30624   0 (autoclean) [vfat]
	usbcore                47312   1 (autoclean) [audio hid usb-uhci]
	unix                   14688  98 (autoclean)

[7.4] loaded driver and hardware info

	0000-001f : dma1
	0020-003f : pic1
	0040-005f : timer
	0060-006f : keyboard
	0080-008f : dma page reg
	00a0-00bf : pic2
	00c0-00df : dma2
	00f0-00ff : fpu
	01f0-01f7 : ide0
	0300-030f : xirc2ps_cs
	03c0-03df : vesafb
	03f6-03f6 : ide0
	0cf8-0cff : PCI conf1
	1000-103f : Intel Corporation 82440MX AC'97 Audio Controller
	1400-14ff : Intel Corporation 82440MX AC'97 Audio Controller
	1800-180f : Intel Corporation 82440MX EIDE Controller
	  1800-1807 : ide0
	1c00-1c1f : Intel Corporation 82440MX USB Universal Host Controller
	  1c00-1c1f : usb-uhci
	2000-20ff : PCI device 1813:4000 (Ambient Technologies Inc)

	00000000-0009f7ff : System RAM
	0009f800-0009ffff : reserved
	000a0000-000bffff : Video RAM area
	000c0000-000c7fff : Video ROM
	000f0000-000fffff : System ROM
	00100000-07feffff : System RAM
	  00100000-001d58eb : Kernel code
	  001d58ec-00218393 : Kernel data
	07ff0000-07fffbff : ACPI Tables
	07fffc00-07ffffff : ACPI Non-volatile Storage
	10000000-10000fff : Ricoh Co Ltd RL5c476 II
	  10000000-10000fff : i82365
	10001000-10001fff : Ricoh Co Ltd RL5c476 II (#2)
	  10001000-10001fff : i82365
	a0000000-a0000fff : card services
	f8000000-fbffffff : Silicon Motion, Inc. SM720 Lynx3DM
	  f8200000-f89fffff : vesafb
	fc000000-fc000fff : PCI device 1813:4000 (Ambient Technologies Inc)
	fff80000-ffffffff : reserved

[7.5] PCI info

	00:00.0 Host bridge: Intel Corporation 82440MX I/O Controller (rev 01)
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
		Latency: 64

	00:00.1 Multimedia audio controller: Intel Corporation 82440MX AC'97 Audio Controller
		Subsystem: Asustek Computer, Inc.: Unknown device 1333
		Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Interrupt: pin B routed to IRQ 5
		Region 0: I/O ports at 1400 [size=256]
		Region 1: I/O ports at 1000 [size=64]

	00:02.0 VGA compatible controller: Silicon Motion, Inc. SM720 Lynx3DM (rev b1) (prog-if 00 [VGA])
		Subsystem: Asustek Computer, Inc.: Unknown device 1332
		Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 64
		Interrupt: pin A routed to IRQ 11
		Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
		Capabilities: [40] Power Management version 1
			Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Capabilities: [50] AGP version 2.0
			Status: RQ=0 SBA- 64bit- FW- Rate=<none>
			Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

	00:07.0 ISA bridge: Intel Corporation 82440MX PCI to ISA Bridge (rev 01)
		Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 0

	00:07.1 IDE interface: Intel Corporation 82440MX EIDE Controller (prog-if 80 [Master])
		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 64
		Region 4: I/O ports at 1800 [size=16]

	00:07.2 USB Controller: Intel Corporation 82440MX USB Universal Host Controller (prog-if 00 [UHCI])
		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 64
		Interrupt: pin D routed to IRQ 11
		Region 4: I/O ports at 1c00 [size=32]

	00:07.3 Bridge: Intel Corporation 82440MX Power Management Controller
		Control: I/O+ Mem+ BusMaster- SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 64
		Interrupt: pin D routed to IRQ 11
		Region 4: I/O ports at 1c00 [size=32]

	00:07.3 Bridge: Intel Corporation 82440MX Power Management Controller
		Control: I/O+ Mem+ BusMaster- SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

	00:09.0 Communication controller: Ambient Technologies Inc: Unknown device 4000 (rev 02)
		Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Interrupt: pin A routed to IRQ 9
		Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=4K]
		Region 1: I/O ports at 2000 [size=256]
		Capabilities: [60] Power Management version 2
			Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-

	00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
		Subsystem: Asustek Computer, Inc.: Unknown device 1386
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 168
		Interrupt: pin A routed to IRQ 11
		Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
		Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
		Memory window 0: 00000000-00000000
		Memory window 1: 00000000-00000000
		I/O window 0: 00000000-00000003
		I/O window 1: 00000000-00000003
		BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
		16-bit legacy interface ports at 0001

	00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
		Subsystem: Asustek Computer, Inc.: Unknown device 1386
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 168
		Interrupt: pin B routed to IRQ 9
		Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
		Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
		Memory window 0: 00000000-00000000
		Memory window 1: 00000000-00000000
		I/O window 0: 00000000-00000003
		I/O window 1: 00000000-00000003
		BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
		16-bit legacy interface ports at 0001

[7.6.] scsi info

No scsi

[7.7.]

The fileserver system uses the user-space nfs server.
Both systems are built using the SuSE 7.1 distribution.


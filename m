Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270764AbTHCUxU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 16:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271007AbTHCUxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 16:53:20 -0400
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:457 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id S270764AbTHCUw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:52:57 -0400
From: jt.holmes@att.net
To: linux-kernel@vger.kernel.org
Subject: Pcmcia Insertion causes Scheduler to hard Loop
Date: Sun, 03 Aug 2003 20:52:54 +0000
X-Mailer: AT&T Message Center Version 1 (Jul 29 2003)
X-Authenticated-Sender: anQuaG9sbWVzQGF0dC5uZXQ=
Message-Id: <S270764AbTHCUw5/20030803205257Z+6756@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This post may be a little long but to   the best of my knowledge
it follows the entire  posting script rules, which say to include
99% of the following

I only have  dial-up line so cannot take the  lkml feed, but just 
post the reply in the  lkml and  I will look for it, but a CC would
also be nice.
jt

Problem:
	2.6.0-test1  w/gregs  2.6.0-test2  pci patches (8 of them)

	Insert Pcmcia card attached to external IDE drive enclosure and 
	scheduler goes into an unstoppable hard loop.

Description:
	DnBoy Pcmcia card attached to IDE enclosure, with 12G Toshiba 2.5
	inch drive, worked fine in 2.4.18-3 (RH)  and did not encounter
	this problem until 2.6.0-test1


	I can see some of what is happening in kernel/sched.c, but it is a 
	little too deep for me just yet.

	Did apply  Greg's  pci patches  01 thru 08  Latest July, 2003

	Output captured and is at the end of this post.

cat /proc/version

	Linux version 2.6.0-test3 (root@jtlin60) (gcc version 2.95.3 20010315 
	(release)) #1 Sun Aug 3 07:14:31 EDT 2003


OOPS

	No oops, this is not that sort of problem


Output of 
ver_linux

	If some fields are empty or look unusual you may have an old version.
	Compare to the current minimal requirements in Documentation/Changes.
	 
	Linux jtlin60 2.6.0-test3 #1 Sun Aug 3 07:14:31 EDT 2003 i686 unknown
	 
	Gnu C                  2.95.3
	Gnu make               3.79.1
	util-linux             2.11n
	mount                  2.11n
	e2fsprogs              1.27
	reiserfsprogs          3.x.0j
	pcmcia-cs              3.1.22
	quota-tools            3.01.
	PPP                    2.4.1
	isdn4k-utils           3.1pre1
	Linux C Library        2.2.5
	Dynamic linker (ldd)   2.2.5
	Procps                 2.0.7
	Net-tools              1.60
	Console-tools          0.3.3
	Sh-utils               2.0.11
	Modules Loaded         binfmt_misc ds yenta_socket pcmcia_core 
	                        parport_pc parport
Output of 
cat /proc/cpuinfo

	processor	: 0
	vendor_id	: GenuineIntel
	cpu family	: 6
	model		: 8
	model name	: Pentium III (Coppermine)
	stepping	: 6
	cpu MHz		: 361.530
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
	bogomips	: 684.03



Output of
cat /proc/modules

	binfmt_misc 7816 0 - Live 0xcc894000
	ds 10464 4 - Live 0xcc8ad000
	yenta_socket 9696 1 - Live 0xcc890000
	pcmcia_core 54208 2 ds,yenta_socket, Live 0xcc8b9000
	parport_pc 22436 0 - Live 0xcc8a1000
	parport 33408 1 parport_pc, Live 0xcc897000


Output of
cat /proc/ioports

	0000-001f : dma1
	0020-0021 : pic1
	0040-005f : timer
	0060-006f : keyboard
	0080-008f : dma page reg
	00a0-00a1 : pic2
	00c0-00df : dma2
	00f0-00ff : fpu
	0170-0177 : ide1
	01f0-01f7 : ide0
	02f8-02ff : Lucent Microelectron 56k WinModem
	0376-0376 : ide1
	0378-037a : parport0
	037b-037f : parport0
	03c0-03df : vga+
	03f6-03f6 : ide0
	0cf8-0cff : PCI conf1
	1000-10ff : PCI CardBus #02
	  1000-107f : 3Com Corporation 3CCFE575CT Cyclone C
	1400-14ff : PCI CardBus #02
	1800-18ff : PCI CardBus #06
	1c00-1cff : Lucent Microelectron 56k WinModem
	2000-20ff : PCI CardBus #06
	fe00-fe3f : Intel Corp. 82371AB/EB/MB PIIX4 
	fe60-fe7f : Intel Corp. 82371AB/EB/MB PIIX4 
	fefc-feff : Yamaha Corporation YMF-744B [DS-1S Audi
	ff00-ff3f : Yamaha Corporation YMF-744B [DS-1S Audi
	ff60-ff7f : Toshiba America Info FIR Port Type-DO
	ff80-ff9f : Intel Corp. 82371AB/EB/MB PIIX4 
	fff0-ffff : Intel Corp. 82371AB/EB/MB PIIX4 
	  fff0-fff7 : ide0
	  fff8-ffff : ide1

Output of
cat /proc/iomem

	00000000-0009fbff : System RAM
	0009fc00-0009ffff : reserved
	000a0000-000bffff : Video RAM area
	000c0000-000c7fff : Video ROM
	000e8000-000ebfff : reserved
	000f0000-000fffff : System ROM
	00100000-0bfdffff : System RAM
	  00100000-0023d76f : Kernel code
	  0023d770-002e417f : Kernel data
	0bfe0000-0bfeffff : ACPI Tables
	0bff0000-0bffffff : reserved
	10000000-10000fff : Toshiba America Info ToPIC95 PCI to Cardb
	10001000-10001fff : Toshiba America Info ToPIC95 PCI to Cardb (#2)
	100a0000-100b6dff : reserved
	100b6e00-100b6fff : ACPI Non-volatile Storage
	100b7000-100fffff : reserved
	10400000-107fffff : PCI CardBus #02
	  10400000-1041ffff : 3Com Corporation 3CCFE575CT Cyclone C
	10800000-10bfffff : PCI CardBus #02
	  10800000-1080007f : 3Com Corporation 3CCFE575CT Cyclone C
	  10800080-108000ff : 3Com Corporation 3CCFE575CT Cyclone C
	10c00000-10ffffff : PCI CardBus #06
	11000000-113fffff : PCI CardBus #06
	e0000000-e7ffffff : Intel Corp. 440BX/ZX/DX - 82443B
	efff8000-efffffff : Yamaha Corporation YMF-744B [DS-1S Audi
	f0000000-f7ffffff : PCI Bus #01
	  f0000000-f7ffffff : S3 Inc. 86C270-294 Savage/MX
	ffefff00-ffefffff : Lucent Microelectron 56k WinModem
	fff80000-ffffffff : reserved

Output of
lspci -vvv

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Subsystem: Toshiba America Info Systems Toshiba Tecra 8100 Laptop System Chipset
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f0000000-f7ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:05.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:05.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at fff0 [size=16]

00:05.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ff80 [size=32]

00:05.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:07.0 Communication controller: Lucent Microelectronics 56k WinModem (rev 01)
	Subsystem: Toshiba America Info Systems Internal V.90 Modem
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at ffefff00 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at 02f8 [size=8]
	Region 2: I/O ports at 1c00 [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=160mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 IRDA controller: Toshiba America Info Systems FIR Port Type-DO
	Subsystem: Toshiba America Info Systems FIR Port Type-DO
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ff60 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1+,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 20)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 20)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=0
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00002000-000020ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio Controller] (rev 02)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at efff8000 (32-bit, non-prefetchable) [size=32K]
	Region 1: I/O ports at ff00 [size=64]
	Region 2: I/O ports at fefc [size=4]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/MX-MV (rev 11) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=128M]
	Expansion ROM at 000c0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 1.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:00.0 Ethernet controller: 3Com Corporation 3CCFE575CT Cyclone CardBus (rev 10)
	Subsystem: 3Com Corporation FE575C-3Com 10/100 LAN CardBus-Fast Ethernet
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1000 [disabled] [size=128]
	Region 1: Memory at 10800000 (32-bit, non-prefetchable) [disabled] [size=128]
	Region 2: Memory at 10800080 (32-bit, non-prefetchable) [disabled] [size=128]
	Expansion ROM at 10400000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-


Output of 
/proc/scsi
	/proc/scsi does not exist


Output of  
cardmgr -V
	cardmgr version 3.1.22


Output of  
lsmod
	Module                  Size  Used by
	ide_cs                  5760  0 
	ide_cd                 35200  0 
	cdrom                  30656  1 ide_cd
	pci_hotplug             8452  0 
	nfs                    58792  1 
	nfsd                   59872  8 [unsafe]
	exportfs                4640  1 nfsd
	lockd                  46048  3 nfs,nfsd,[unsafe]
	sunrpc                108544  5 nfs,nfsd,lockd
	3c59x                  35080  0 
	mousedev                7104  1 
	usbmouse                4064  0 
	uhci_hcd               26024  0 
	usbcore                89012  4 usbmouse,uhci_hcd
	binfmt_misc             7816  0 
	ds                     10464  5 ide_cs
	yenta_socket            9696  1 
	pcmcia_core            54208  3 ide_cs,ds,yenta_socket
	parport_pc             22436  0 
	parport                33408  1 parport_pc


Output of  

tail -f /var/log/messages
	While inserting the  PCMCIA Card

	The  Call Trace sequence will continue on and on forever, I have to 
	power down the machine, remove the PCMCIA card (as this also 
	happens on boot up) and once the machine boots, then things are 
	again stable.


Aug  3 07:33:39 jtlin60 kernel: hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Aug  3 07:33:39 jtlin60 kernel: Uniform CD-ROM driver Revision: 3.12
Aug  3 07:38:53 jtlin60 login(pam_unix)[947]: session opened for user root by (uid=0)
Aug  3 07:38:53 jtlin60  -- root[947]: ROOT LOGIN ON tty2
Aug  3 07:39:06 jtlin60 nfs: Starting NFS services:  succeeded
Aug  3 07:39:06 jtlin60 nfs: rpc.rquotad startup succeeded
Aug  3 07:39:07 jtlin60 nfs: rpc.mountd startup succeeded
Aug  3 07:39:07 jtlin60 kernel: Module nfsd cannot be unloaded due to unsafe usage in include/linux/module.h:482
Aug  3 07:39:07 jtlin60 kernel: Module lockd cannot be unloaded due to unsafe usage in include/linux/module.h:482
Aug  3 07:39:07 jtlin60 nfs: rpc.nfsd startup succeeded

PCMCIA card inserted here


Aug  3 07:41:42 jtlin60 cardmgr[641]: initializing socket 1
Aug  3 07:41:42 jtlin60 cardmgr[641]: socket 1: ATA/IDE Fixed Disk
Aug  3 07:41:42 jtlin60 kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Aug  3 07:42:01 jtlin60 kernel: hde: TOSHIBA MK1214GAP, ATA DISK drive
Aug  3 07:42:01 jtlin60 kernel: ide2 at 0x180-0x187,0x386 on irq 5
Aug  3 07:42:01 jtlin60 kernel: hde: max request size: 128KiB
Aug  3 07:42:02 jtlin60 kernel: hde: host protected area => 1
Aug  3 07:42:02 jtlin60 kernel: hde: 23579136 sectors (12073 MB), CHS=23392/16/63
Aug  3 07:42:02 jtlin60 kernel:  hde:<3>bad: scheduling while atomic!
Aug  3 07:42:02 jtlin60 kernel: Call Trace:
Aug  3 07:42:02 jtlin60 kernel:  [<c011502d>] schedule+0x2d/0x2ec
Aug  3 07:42:02 jtlin60 kernel:  [<c01ba3e0>] blk_run_queues+0x68/0x7c
Aug  3 07:42:02 jtlin60 kernel:  [<c0115d8e>] io_schedule+0xe/0x18
Aug  3 07:42:02 jtlin60 kernel:  [<c0141984>] __wait_on_buffer+0x98/0xb0
Aug  3 07:42:02 jtlin60 kernel:  [<c0116364>] autoremove_wake_function+0x0/0x38
Aug  3 07:42:02 jtlin60 kernel:  [<c0116364>] autoremove_wake_function+0x0/0x38
Aug  3 07:42:02 jtlin60 kernel:  [<c014458f>] sync_dirty_buffer+0x7f/0x90
Aug  3 07:42:02 jtlin60 kernel:  [<c01788d9>] journal_commit_transaction+0x9b9/0xe30
Aug  3 07:42:02 jtlin60 kernel:  [<c0116364>] autoremove_wake_function+0x0/0x38
Aug  3 07:42:02 jtlin60 kernel:  [<c0116364>] autoremove_wake_function+0x0/0x38
Aug  3 07:42:02 jtlin60 kernel:  [<c011dc59>] update_wall_time+0xd/0x38
Aug  3 07:42:03 jtlin60 kernel:  [<c011df1d>] do_timer+0x4d/0xec
Aug  3 07:42:03 jtlin60 kernel:  [<c010dd3b>] timer_interrupt+0x1f/0x100
Aug  3 07:42:03 jtlin60 kernel:  [<c011aa81>] do_softirq+0x51/0xac
Aug  3 07:42:03 jtlin60 kernel:  [<c010a76d>] do_IRQ+0xdd/0xf0
Aug  3 07:42:03 jtlin60 kernel:  [<c0115302>] default_wake_function+0x16/0x18
Aug  3 07:42:03 jtlin60 kernel:  [<c0115285>] schedule+0x285/0x2ec
Aug  3 07:42:03 jtlin60 kernel:  [<c017a86f>] kjournald+0xa7/0x1c8
Aug  3 07:42:03 jtlin60 kernel:  [<c017a7c8>] kjournald+0x0/0x1c8
Aug  3 07:42:04 jtlin60 kernel:  [<c0116364>] autoremove_wake_function+0x0/0x38
Aug  3 07:42:04 jtlin60 kernel:  [<c0116364>] autoremove_wake_function+0x0/0x38
Aug  3 07:42:04 jtlin60 kernel:  [<c017a7b0>] commit_timeout+0x0/0x10
Aug  3 07:42:04 jtlin60 kernel:  [<c0107079>] kernel_thread_helper+0x5/0xc
Aug  3 07:42:02 jtlin60 cardmgr[641]: executing: './ide start hde'
Aug  3 07:42:04 jtlin60 kernel: 
Aug  3 07:42:04 jtlin60 kernel: bad: scheduling while atomic!
Aug  3 07:42:04 jtlin60 kernel: Call Trace:
Aug  3 07:42:05 jtlin60 kernel:  [<c011502d>] schedule+0x2d/0x2ec
Aug  3 07:42:05 jtlin60 kernel:  [<c017a92e>] kjournald+0x166/0x1c8
Aug  3 07:42:05 jtlin60 kernel:  [<c017a7c8>] kjournald+0x0/0x1c8
Aug  3 07:42:05 jtlin60 kernel:  [<c0116364>] autoremove_wake_function+0x0/0x38
Aug  3 07:42:05 jtlin60 kernel:  [<c0116364>] autoremove_wake_function+0x0/0x38
Aug  3 07:42:05 jtlin60 kernel:  [<c017a7b0>] commit_timeout+0x0/0x10
Aug  3 07:42:05 jtlin60 kernel:  [<c0107079>] kernel_thread_helper+0x5/0xc
Aug  3 07:42:06 jtlin60 kernel: 
Aug  3 07:42:06 jtlin60 kernel: ke_function+0x0/0x38
Aug  3 07:42:06 jtlin60 kernel:  [<c0116364>] autoremove_wake_function+0x0/0x38
Aug  3 07:42:06 jtlin60 kernel:  [<c0178677>] journal_commit_transaction+0x757/0xe30
Aug  3 07:42:06 jtlin60 kernel:  [<c0129db7>] __print_symbol+0x103/0x110
Aug  3 07:42:06 jtlin60 kernel:  [<c01b50f8>] vt_console_print+0x2b0/0x2c4
Aug  3 07:42:07 jtlin60 kernel:  [<c0118087>] __call_console_drivers+0x3b/0x50
Aug  3 07:42:07 jtlin60 kernel:  [<c01180ec>] _call_console_drivers+0x50/0x58
Aug  3 07:42:07 jtlin60 kernel:  [<c01181d0>] call_console_drivers+0xdc/0xe4
Aug  3 07:42:07 jtlin60 kernel:  [<c01183bd>] release_console_sem+0x31/0x8c
Aug  3 07:42:07 jtlin60 kernel:  [<c0118343>] printk+0xff/0x110
Aug  3 07:42:07 jtlin60 kernel:  [<c01094e4>] show_trace+0x84/0x8c
Aug  3 07:42:07 jtlin60 kernel:  [<c0115285>] schedule+0x285/0x2ec
Aug  3 07:42:08 jtlin60 kernel:  [<c017a86f>] kjournald+0xa7/0x1c8
Aug  3 07:42:08 jtlin60 kernel:  [<c017a7c8>] kjournald+0x0/0x1c8
Aug  3 07:42:08 jtlin60 kernel:  [<c0116364>] autoremove_wake_function+0x0/0x38
Aug  3 07:42:08 jtlin60 kernel:  [<c0116364>] autoremove_wake_function+0x0/0x38
Aug  3 07:42:08 jtlin60 kernel:  [<c017a7b0>] commit_timeout+0x0/0x10
Aug  3 07:42:08 jtlin60 kernel:  [<c0107079>] kernel_thread_helper+0x5/0xc
Aug  3 07:42:08 jtlin60 kernel: 
Aug  3 07:42:09 jtlin60 kernel: bad: scheduling while atomic!
Aug  3 07:42:09 jtlin60 kernel: Call Trace:
Aug  3 07:42:09 jtlin60 kernel:  [<c011502d>] schedule+0x2d/0x2ec
Aug  3 07:42:09 jtlin60 kernel:  [<c01ba3e0>] blk_run_queues+0x68/0x7c
Aug  3 07:42:09 jtlin60 kernel:  [<c0115d8e>] io_sc

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278331AbRJOWSC>; Mon, 15 Oct 2001 18:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278447AbRJOWRy>; Mon, 15 Oct 2001 18:17:54 -0400
Received: from malign.rad.washington.edu ([128.208.68.7]:1216 "EHLO
	malign.rad.washington.edu") by vger.kernel.org with ESMTP
	id <S278331AbRJOWRj>; Mon, 15 Oct 2001 18:17:39 -0400
Date: Mon, 15 Oct 2001 15:18:09 -0700
From: "David S." <davids@idiom.com>
To: linux-kernel@vger.kernel.org
Subject: Anomalous results from access(2)
Message-ID: <20011015151809.D372@malign.rad.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.]	Anomalous results from access(2)

[2.]	When by root run against files in the ext2 file system, access(2)
	reports non-executable files as executable.  For a non-privileged
	user, access(2) reports non-executable files as non-executable.
	Also, stat(2) and the 'test -x' shell facility report non-executable
	files as such for either root or a non-privileged user, and all of
	access(2), stat(2), and 'test -x' give consistent results for root
	and ordinary users when the files in question live in NFS.

[3.]	access(2), ext2 file system

[4.]	Linux version 2.4.9 (root@blofeld) (gcc version 2.95.3 20010315 (release)) #1 Fri Oct 12 15:50:50 PDT 2001
	(also seen in kernels 2.4.5 and 2.2.16)

[5.]	Not applicable

[6.]	#include <sys/types.h>
	#include <sys/stat.h>
	#include <stdio.h>
	#include <unistd.h>
	
	int main(int argc, char *argv[])
	{
	   struct stat sb;
	
	   char *path = argv[1];
	
	   if (stat(path, &sb) == 0)
	   {
	      if (access(path, X_OK) == 0)
	         printf("'access' thinks %s is executable\n", path);
	      else
	         printf("'access' thinks %s is not executable\n", path);
	
	      if (sb.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH)) 
	         printf("'stat' thinks %s is executable\n", path);
	      else
	         printf("'stat' thinks %s is not executable\n", path);
	   }
	   return 0;
	}

[7.]

[7.1.]	Gnu C                  2.95.3
	Gnu make               3.79.1
	binutils               2.11.90.0.19
	util-linux             2.11f
	mount                  2.11b
	modutils               2.4.6
	e2fsprogs              1.22
	reiserfsprogs          3.x.0j
	Linux C Library        2.2.3
	Dynamic linker (ldd)   2.2.3
	Procps                 2.0.7
	Net-tools              1.60
	Kbd                    1.06
	Sh-utils               2.0
	Modules Loaded         nfs autofs nfsd lockd sunrpc ipv6 eepro100 rtc unix

[7.2.]	processor       : 0
	vendor_id       : AuthenticAMD
	cpu family      : 6
	model           : 3
	model name      : AMD Duron(tm) Processor
	stepping        : 1
	cpu MHz         : 800.033
	cache size      : 64 KB
	fdiv_bug        : no
	hlt_bug         : no
	f00f_bug        : no
	coma_bug        : no
	fpu             : yes
	fpu_exception   : yes
	cpuid level     : 1
	wp              : yes
	flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat p
	se36 mmx fxsr syscall mmxext 3dnowext 3dnow
	bogomips        : 1595.80
	
[7.3.]	nfs                    74992   1 (autoclean)
	autofs                 10944   2 (autoclean)
	nfsd                   69536   0 (autoclean)
	lockd                  50896   1 (autoclean) [nfs nfsd]
	sunrpc                 63120   1 (autoclean) [nfs nfsd lockd]
	ipv6                  133344  -1 (autoclean)
	eepro100               16016   1
	rtc                     5472   0 (autoclean)
	unix                   15296  23 (autoclean)

[7.4]	0000-001f : dma1
	0020-003f : pic1
	0040-005f : timer
	0060-006f : keyboard
	0070-007f : rtc
	0080-008f : dma page reg
	00a0-00bf : pic2
	00c0-00df : dma2
	00f0-00ff : fpu
	0170-0177 : ide1
	0376-0376 : ide1
	03c0-03df : vesafb
	0cf8-0cff : PCI conf1
	4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	9000-900f : VIA Technologies, Inc. Bus Master IDE
	  9000-9007 : ide0
	  9008-900f : ide1
	9400-941f : VIA Technologies, Inc. UHCI USB
	9800-981f : VIA Technologies, Inc. UHCI USB (#2)
	9c00-9cff : VIA Technologies, Inc. AC97 Audio Controller
	a000-a003 : VIA Technologies, Inc. AC97 Audio Controller
	a400-a403 : VIA Technologies, Inc. AC97 Audio Controller
	ac00-ac07 : Promise Technology, Inc. 20267
	  ac00-ac07 : ide2
	b000-b003 : Promise Technology, Inc. 20267
	  b002-b002 : ide2
	b400-b407 : Promise Technology, Inc. 20267
	b800-b803 : Promise Technology, Inc. 20267
	bc00-bc3f : Promise Technology, Inc. 20267
	  bc00-bc07 : ide2
	  bc08-bc0f : ide3
	  bc10-bc3f : PDC20267
	c000-c03f : Intel Corporation 82559 InBusiness 10/100
	  c000-c03f : eepro100
	c400-c43f : Intel Corporation 82559 InBusiness 10/100 (#2)
	  c400-c43f : eepro100


	00000000-0009fbff : System RAM
	0009fc00-0009ffff : reserved
	000a0000-000bffff : Video RAM area
	000c0000-000c7fff : Video ROM
	000d0000-000d1fff : Extension ROM
	000f0000-000fffff : System ROM
	00100000-0ffeffff : System RAM
	  00100000-001c1b31 : Kernel code
	  001c1b32-0020543f : Kernel data
	0fff0000-0fff2fff : ACPI Non-volatile Storage
	0fff3000-0fffffff : ACPI Tables
	d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
	d4000000-d5ffffff : PCI Bus #01
	  d4000000-d4ffffff : nVidia Corporation Vanta [NV6]
	d6000000-d7ffffff : PCI Bus #01
	  d6000000-d7ffffff : nVidia Corporation Vanta [NV6]
	    d6000000-d63fffff : vesafb
	d9000000-d90fffff : Intel Corporation 82559 InBusiness 10/100
	d9100000-d91fffff : Intel Corporation 82559 InBusiness 10/100 (#2)
	d9200000-d921ffff : Promise Technology, Inc. 20267
	d9220000-d9220fff : Intel Corporation 82559 InBusiness 10/100 (#2)
	  d9220000-d9220fff : eepro100
	d9221000-d9221fff : Intel Corporation 82559 InBusiness 10/100
	  d9221000-d9221fff : eepro100
	ffff0000-ffffffff : reserved

[7.5.]	00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
		Latency: 0
		Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
		Capabilities: [a0] AGP version 2.0
			Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
			Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
		Capabilities: [c0] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	
	00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 [Normal decode])
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
		Latency: 0
		Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
		I/O behind bridge: 0000f000-00000fff
		Memory behind bridge: d4000000-d5ffffff
		Prefetchable memory behind bridge: d6000000-d7ffffff
		BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	
	00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
		Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 0
	
	00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (prog-if 8a [Master SecP PriP])
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 32
		Region 4: I/O ports at 9000 [size=16]
		Capabilities: [c0] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	
	00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 00 [UHCI])
		Subsystem: Unknown device 0925:1234
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 32, cache line size 08
		Interrupt: pin D routed to IRQ 10
		Region 4: I/O ports at 9400 [size=32]
		Capabilities: [80] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	
	00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 00 [UHCI])
		Subsystem: Unknown device 0925:1234
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 32, cache line size 08
		Interrupt: pin D routed to IRQ 10
		Region 4: I/O ports at 9800 [size=32]
		Capabilities: [80] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	
	00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
		Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Interrupt: pin ? routed to IRQ 9
		Capabilities: [68] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	
	00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo Super AC97/Audio] (rev 20)
		Subsystem: Micro-star International Co Ltd: Unknown device 3300
		Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Interrupt: pin C routed to IRQ 5
		Region 0: I/O ports at 9c00 [size=256]
		Region 1: I/O ports at a000 [size=4]
		Region 2: I/O ports at a400 [size=4]
		Capabilities: [c0] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	
	00:08.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 4d30 (rev 02)
		Subsystem: Promise Technology, Inc.: Unknown device 4d33
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 32
		Interrupt: pin A routed to IRQ 11
		Region 0: I/O ports at ac00 [size=8]
		Region 1: I/O ports at b000 [size=4]
		Region 2: I/O ports at b400 [size=8]
		Region 3: I/O ports at b800 [size=4]
		Region 4: I/O ports at bc00 [size=64]
		Region 5: Memory at d9200000 (32-bit, non-prefetchable) [size=128K]
		Expansion ROM at <unassigned> [disabled] [size=64K]
		Capabilities: [58] Power Management version 1
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	
	00:09.0 Ethernet controller: Intel Corporation 82559 InBusiness 10/100 (rev 08)
		Subsystem: Intel Corporation 82559 InBusiness 10/100
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 32 (2000ns min, 14000ns max), cache line size 08
		Interrupt: pin A routed to IRQ 5
		Region 0: Memory at d9221000 (32-bit, non-prefetchable) [size=4K]
		Region 1: I/O ports at c000 [size=64]
		Region 2: Memory at d9000000 (32-bit, non-prefetchable) [size=1M]
		Expansion ROM at <unassigned> [disabled] [size=1M]
		Capabilities: [dc] Power Management version 2
			Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
			Status: D0 PME-Enable- DSel=0 DScale=2 PME-
	
	00:0a.0 Ethernet controller: Intel Corporation 82559 InBusiness 10/100 (rev 08)
		Subsystem: Intel Corporation 82559 InBusiness 10/100
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 32 (2000ns min, 14000ns max), cache line size 08
		Interrupt: pin A routed to IRQ 10
		Region 0: Memory at d9220000 (32-bit, non-prefetchable) [size=4K]
		Region 1: I/O ports at c400 [size=64]
		Region 2: Memory at d9100000 (32-bit, non-prefetchable) [size=1M]
		Expansion ROM at <unassigned> [disabled] [size=1M]
		Capabilities: [dc] Power Management version 2
			Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
			Status: D0 PME-Enable- DSel=0 DScale=2 PME-
	
	01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 32 (1250ns min, 250ns max)
		Interrupt: pin A routed to IRQ 9
		Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=16M]
		Region 1: Memory at d6000000 (32-bit, prefetchable) [size=32M]
		Expansion ROM at <unassigned> [disabled] [size=64K]
		Capabilities: [60] Power Management version 1
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Capabilities: [44] AGP version 2.0
			Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
			Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	
[7.6.]	Not applicable

[7.7.]	As a point of comparison, access(2) gives consistent results in
	NetBSD 1.5.1 for root and ordinary users, with files in either
	ffs or NFS.


David S.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266957AbSKUSUi>; Thu, 21 Nov 2002 13:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbSKUSUi>; Thu, 21 Nov 2002 13:20:38 -0500
Received: from mail.airnet.com.au ([202.174.32.5]:54021 "HELO
	mail.airnet.com.au") by vger.kernel.org with SMTP
	id <S266957AbSKUSU2> convert rfc822-to-8bit; Thu, 21 Nov 2002 13:20:28 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: anomaly <anomaly@airnet.com.au>
Reply-To: anomaly@airnet.com.au
To: linux-kernel@vger.kernel.org
Subject: 2.5.48 kernel bug re: module instalation
Date: Fri, 22 Nov 2002 04:55:01 +0100
User-Agent: KMail/1.4.3
Cc: anomaly@airnet.com.au
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211220455.01818.anomaly@airnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug report form as per www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html:

[1.] One line summary of the problem:
	running the make modules_install script for the 2.5.48 release doesn't 
properly populate the 2.5.48 module directory

[2.] Full description of the problem/report:
	2.4.19, 2.5.45, and 2.5.47 all build and install ok on my system, yet 
2.5.48's make modules_install doesn't build
	modules.dep or create the /lib/modules/2.5.48/ properly, leaving out every 
entry in the /lib/modules/2.5.48/ directory
	and only creating the kernel/ and build/ directory under it.  listings below

[3.] Keywords (i.e., modules, networking, kernel):
	modules, make, 2.5.48

[4.] Kernel version (from /proc/version):
	current: 2.4.19 and 2.5.47, building 2.5.48

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
     problem (if possible)
	make modules ; make modules_install

[7.] Environment
	a debian based distribution using gcc 2.95.4, also tried on slackware boxes 
using gcc 2.95.2, 2.95.3, and 3.1 with same result

[7.1.] Software (add the output of the ver_linux script here)

	Linux beer 2.5.47 #1 Thu Nov 21 03:48:50 CET 2002 i586 unknown unknown 
GNU/Linux

	Gnu C                  2.95.4
	Gnu make               3.79.1
	util-linux             2.11n
	mount                  2.11n
	modutils               2.4.15
	e2fsprogs              1.27
	reiserfsprogs          3.6.2
	xfsprogs               2.1.2
	pcmcia-cs              3.2.1
	PPP                    2.4.1
	isdn4k-utils           3.1pre4
	Linux C Library        2.2.5
	Dynamic linker (ldd)   2.2.5
	Procps                 2.0.7
	Net-tools              1.60
	Console-tools          0.2.3
	Sh-utils               2.0.12
	Modules Loaded         ppp_async bsd_comp ppp_deflate zlib_inflate 
zlib_deflate ppp_generic slhc

[7.2.] Processor information (from /proc/cpuinfo):

	processor       : 0
	vendor_id       : AuthenticAMD
	cpu family      : 5
	model           : 8
	model name      : AMD-K6(tm) 3D processor
	stepping        : 12
	cpu MHz         : 333.346
	cache size      : 64 KB
	fdiv_bug        : no
	hlt_bug         : no
	f00f_bug        : no
	coma_bug        : no
	fpu             : yes
	fpu_exception   : yes
	cpuid level     : 1
	wp              : yes
	flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow 
k6_mtrr
	bogomips        : 659.45

[7.3.] Module information (from /proc/modules):

	ppp_async               6432   1
	bsd_comp                3904   0
	ppp_deflate             2816   0
	zlib_inflate           18432   0 [ppp_deflate]
	zlib_deflate           17632   0 [ppp_deflate]
	ppp_generic            16652   3 [ppp_async bsd_comp ppp_deflate]
	slhc                    4640   0 [ppp_generic]

while using 2.5.47

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

	0000-001f : dma1
	0020-003f : pic1
	0040-005f : timer
	0060-006f : keyboard
	0080-008f : dma page reg
	00a0-00bf : pic2
	00c0-00df : dma2
	00f0-00ff : fpu
	01f0-01f7 : ide0
	02f8-02ff : serial
	0378-037a : parport0
	037b-037f : parport0
	03c0-03df : vesafb
	03f6-03f6 : ide0
	03f8-03ff : serial
	0cf8-0cff : PCI conf1
	e000-e0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
	  e000-e0ff : 8139too
	f000-f00f : ALi Corporation M5229 IDE
	  f000-f007 : ide0
	  f008-f00f : ide1

	00000000-0009fbff : System RAM
	0009fc00-0009ffff : reserved
	000a0000-000bffff : Video RAM area
	000c0000-000c7fff : Video ROM
	000f0000-000fffff : System ROM
	00100000-03feffff : System RAM
	  00100000-0034aaf8 : Kernel code
	  0034aaf9-0043e13f : Kernel data
	03ff0000-03ff2fff : ACPI Non-volatile Storage
	03ff3000-03ffffff : ACPI Tables
	d8000000-dfffffff : PCI Bus #01
	  d8000000-dfffffff : S3 Inc. Savage 4
	    d8000000-d87fffff : vesafb
	e0000000-e3ffffff : ALi Corporation M1541
	e4000000-e5ffffff : PCI Bus #01
	  e5000000-e507ffff : S3 Inc. Savage 4
	e6000000-e6007fff : Yamaha Corporation YMF-724F [DS-1 Audio Controller]
	  e6000000-e6007fff : YMFPCI
	e6008000-e60080ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
	  e6008000-e60080ff : 8139too
	e6009000-e6009fff : ALi Corporation USB 1.1 Controller
	  e6009000-e6009fff : ohci-hcd
	ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

	00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
 	       Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP 
System Controller
	        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	        Latency: 32
	        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	        Capabilities: [b0] AGP version 1.0
	                Status: RQ=27 SBA+ 64bit- FW- Rate=x1,x2
	                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

	00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if 00 
[Normal decode])
	        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	        Latency: 32
	        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	        I/O behind bridge: 0000f000-00000fff
	        Memory behind bridge: e4000000-e5ffffff
	        Prefetchable memory behind bridge: d8000000-dfffffff
	        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

	00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) 
(prog-if 10 [OHCI])
	        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	        Latency: 32 (20000ns max), cache line size 08
	        Interrupt: pin A routed to IRQ 10
	        Region 0: Memory at e6009000 (32-bit, non-prefetchable) [size=4K]

	00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge 
[Aladdin IV] (rev c3)
	        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort+ <MAbort+ >SERR- <PERR-
	        Latency: 0

	00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 
10)
	        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	        Latency: 32 (8000ns min, 16000ns max)
	        Interrupt: pin A routed to IRQ 10
	        Region 0: I/O ports at e000 [size=256]
	        Region 1: Memory at e6008000 (32-bit, non-prefetchable) [size=256]

	00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1) 
(prog-if fa)
	        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	        Latency: 32 (500ns min, 1000ns max)
	        Interrupt: pin A routed to IRQ 255
	        Region 4: I/O ports at f000 [size=16]

	00:10.0 Multimedia audio controller: Yamaha Corporation YMF-724F [DS-1 Audio 
Controller] (rev 03)
	        Subsystem: Yamaha Corporation DS-XG PCI Audio CODEC
	        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
 	  	Latency: 32 (1250ns min, 6250ns max)
  		Interrupt: pin A routed to IRQ 11
		Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=32K]
    		Capabilities: [50] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

	01:00.0 VGA compatible controller: S3 Inc. Savage 4 (rev 02) (prog-if 00 
[VGA]
		Subsystem: S3 Inc. 86C394-397 Savage4
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
		Latency: 248 (1000ns min, 63750ns max), cache line size 08
	        Interrupt: pin A routed to IRQ 5
	        Region 0: Memory at e5000000 (32-bit, non-prefetchable) [size=512K]
 	   	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
  	   	Expansion ROM at <unassigned> [disabled] [size=64K]
   	   	Capabilities: [dc] Power Management version 1
    	   	Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	        Capabilities: [80] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)

	Attached devices:
	Host: scsi2 Channel: 00 Id: 00 Lun: 00
	  Vendor: Generic  Model: USB Storage-SMC  Rev: 0090
	  Type:   Direct-Access                    ANSI SCSI revision: 02
	Host: scsi2 Channel: 00 Id: 00 Lun: 01
	  Vendor: Generic  Model: USB Storage-CFC  Rev: 0090
	  Type:   Direct-Access                    ANSI SCSI revision: 02
	Host: scsi2 Channel: 00 Id: 00 Lun: 02
	  Vendor: Generic  Model: USB Storage-MMC  Rev: 0090
	  Type:   Direct-Access                    ANSI SCSI revision: 02
	Host: scsi2 Channel: 00 Id: 00 Lun: 03
	  Vendor: Generic  Model: USB Storage-MSC  Rev: 0090
	  Type:   Direct-Access                    ANSI SCSI revision: 02	

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

listing of /lib/modules/2.5.47/ after a build, correctly populated

	root@beer:/lib/modules# ls 2.5.47/
	build        modules.generic_string  modules.parportmap  modules.usbmap
	kernel       modules.ieee1394map     modules.pcimap
	modules.dep  modules.isapnpmap       modules.pnpbiosmap

listing of /lib/modules/2.5.48/ after a build, incompletely populated

	root@beer:/lib/modules# ls 2.5.48/
	build  kernel

listing of /lib/modules/2.5.47/kernel/

	root@beer:/lib/modules# ls 2.5.47/kernel/
	drivers  lib

(and appropriate modules under drivers/)

listing of /lib/modules/2.5.48/kernel/

	root@beer:/lib/modules# ls 2.5.48/kernel/
	8139too.o   dummy.o  ne.o           pppox.o      zlib_deflate.o
	8390.o      ipaq.o   ppp_async.o    sha1.o       zlib_inflate.o
	blowfish.o  loop.o   ppp_deflate.o  sha256.o
	bsd_comp.o  md4.o    ppp_generic.o  slhc.o
	crc32.o     md5.o    ppp_synctty.o  tcrypt.o
	des.o       mii.o    pppoe.o        usbserial.o

(This just doesn't look right at all)


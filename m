Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312381AbSEUJse>; Tue, 21 May 2002 05:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312411AbSEUJse>; Tue, 21 May 2002 05:48:34 -0400
Received: from ua.fm ([195.248.191.78]:19886 "EHLO ua.fm")
	by vger.kernel.org with ESMTP id <S312381AbSEUJs2>;
	Tue, 21 May 2002 05:48:28 -0400
From: <alex-n@ua.fm>
Subject: BUG?
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.5.7
Date: Tue, 21 May 2002 12:48:19 +0300
Message-ID: <web-10136453@ua.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sirs,
this can be lamer's question (I'm sorry rite now!), but...

The report itself is:

################################################################################

[1.] Linux crashes at the 'interactive startup' boot stage.

[2.] Once the system is trying to boot, first stage (which is
     *before* msg 'Interactive startup') it is all O.K. Once the
     'Interactive startup' stage begins, the bootstrap process
     fails with diffirent msgs; all of them begins with "Unable
     to handle kernel paging request at address..." or "Unable
     to handle kernel dereference at address..." (first 'reason'
     is in the majority of cases, the second is quite unusual).

     It seems to me that this is a trouble with initrd.img,
     because once I've recompiled kernel with ALL OPTIONS (not
     suitable to my hardware, i.e. SCSI adapters) turned OFF,
     the problem remains.
     
     I've notices that sometimes such a trouble is 'reached'
     with 'IH' flag of 'EFLAGS' (bit no 10) set to zero. As far
     as I know it's status, it tells CPU ignore any interrupt
     requests... The keyboard stops functioning on such a crashes
     as usual, but there was TWO TIMES the keyboard remains it's
     working state like an echo, not like control-device. :-\
     May be, it's lamer's notice, I do not know, but I thought
     this may be useful...
     
     I thouht that hardware configuration may be useful too:
        M/B: GigaByte GA-7ZX-H
	     Chipset: VIA Apollo KT133A
	     Features: VIA AC'97 audio on VT82C686B
	CPU: AMD Athlon Thunderbird 900 MHz, FSB 100 MHz
	RAM: IBM 256 Mb PC-133

[3.] boot process, initrd, rc.sysinit

[4.] Kernel version (from /proc/version):
     Linux version 2.4.7-10BOOT (bhcompile@stripples.devel.redhat.com)
     (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) 
     #1 Thu Sep 6 16:15:00 EDT 2001

[5.] Output of Oops.. message (if applicable) with symbolic information

     resolved (see Documentation/oops-tracing.txt)

    OK, I'm adding one example (hand-written).

    ---8<-----------------------------------------------------------------------
    <1>Unable to handle kernel paging request at virtual address
0ec3df54
    
    Printing eip:
    c012b69f
    *pde=00000000
    CPU: 0
    EIP: 0010:[<c012b69f>]
    EFLAGS: 00010006
    
    eax: cfcfcfcf   ebx: cfcfcfcf    ecx: 00000282    edx: cfa4a000
    esi: c1723e6c   edi: cfbde200    ebp: cfd27bc0    esp: cfa47d58
    
    ds:  0018
    es:  0018
    ss:  0018
    
    Process rc.sysinit (pid: 29, stackpage=cfa47000)
    
    Stack:  c0230979  c011b03e  c022c9c7  00000000  cfa47df4  fffffff4
 c0146fb8
            c1723e6c  000000f0  c1757e88  cfbe5005  11163d8b  00000005
 cfa47df4
	    fffffff1  cfbde200  cfd27bc0  c013ed7c  cfd27bc0  cfa47df4
 fffffdce
	    cfd27bc0  cfa14df4  00000000
	    
    Call trace:  [<c0230979>]  [<c022b03c>]  [<c022c9c7>]  [<c0146fb8>]
                 [<c013ed7c>]  [<c013f4a6>]  [<c018c1a3>]  [<c013d0f5>]
		 [<c013dabc>]  [<c012e6be>]  [<c0204daf>]  [<c0123c0a>]
		 [<c0123c7d>]  [<c012439c>]  [<c0113450>]  [<c01135ca>]
		 [<c011f717>]  [<c011fad3>]  [<c013eade>]  [<c0105b60>]
		 [<c0106f2b>]
		 
    Code: 8b 44 82 18 0f af 5a 0c 89 42 14 03 5a 0c 40 75 05 8b 02 89
    
    /etc/rc.sysinit: line 49: 29 Segmentation failt /bin/dmesg -n
$LOGLEVEL
    ---8<-----------------------------------------------------------------------

[6.] A small shell script or example program which triggers the
     problem (if possible)

     SORRY, it's impossible. I've made about two hundred tried but
     I've never got just "localhost login:" message... >:-(((

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
       If some fields are empty or look unusual you may have an old
version.
       Compare to the current minimal requirements in
Documentation/Changes.
 
       Linux localhost.localdomain 2.4.7-10BOOT
       #1 Thu Sep 6 16:15:00 EDT 2001 i686 unknown
 
	Gnu C                  2.96
	Gnu make               3.79.1
	binutils               2.11.90.0.8
	util-linux             2.11f
	mount                  2.11g
	modutils               2.4.6
	e2fsprogs              tune2fs
	reiserfsprogs          3.x.0j
	PPP                    2.4.1
	isdn4k-utils           3.1pre1
	Linux C Library        2.2.4
	Dynamic linker (ldd)   2.2.4
	Procps                 2.0.7
	Net-tools              1.60
	Console-tools          0.3.3
	Sh-utils               2.0.11
	Modules Loaded         reiserfs ext3 jbd vfat msdos fat raid5 
	                       xor raid1 raid0 usb-storage keybdev hid 
			       input usb-uhci usbcore sr_mod sd_mod scsi_mod

[7.2.] Processor information (from /proc/cpuinfo):
       processor	: 0
       vendor_id	: AuthenticAMD
       cpu family	: 6
       model		: 4
       model name	: AMD Athlon(tm) Processor
       stepping		: 2
       cpu MHz		: 902.081
       cache size	: 256 KB
       fdiv_bug		: no
       hlt_bug		: no
       f00f_bug		: no
       coma_bug		: no
       fpu		: yes
       fpu_exception	: yes
       cpuid level	: 1
       wp		: yes
       flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr 
                          pge mca cmov pat pse36 mmx fxsr syscall
mmxext 
			  3dnowext 3dnow
       bogomips		: 1795.68

[7.3.] Module information (from /proc/modules):
       reiserfs              142480   0 (unused)
       ext3                   57456   0
       jbd                    34560   0 [ext3]
       vfat                    8400   1
       msdos                   4624   0 (unused)
       fat                    29152   0 [vfat msdos]
       raid5                  16080   0 (unused)
       xor                     5488   0 [raid5]
       raid1                  11872   0 (unused)
       raid0                   3056   0 (unused)
       usb-storage            32544   0 (unused)
       keybdev                 1584   0 (unused)
       hid                    18224   0 (unused)
       input                   3136   0 [keybdev hid]
       usb-uhci               20080   0 (unused)
       usbcore                47552   1 [usb-storage hid usb-uhci]
       sr_mod                 12944   0 (unused)
       sd_mod                 10368   0 (unused)
       scsi_mod               49488   2 [usb-storage sr_mod sd_mod]

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
       /proc/ioports output:
	    0000-001f : dma1
	    0020-003f : pic1
	    0040-005f : timer
	    0060-006f : keyboard
	    0080-008f : dma page reg
	    00a0-00bf : pic2
	    00c0-00df : dma2
	    00f0-00ff : fpu
	    0170-0177 : ide1
	    01f0-01f7 : ide0
	    02f8-02ff : serial(auto)
	    0376-0376 : ide1
	    03c0-03df : vesafb
	    03f6-03f6 : ide0
	    03f8-03ff : serial(auto)
	    0400-040f : PCI device 1106:3057
	    0c00-0c7f : PCI device 1106:3057
	    0cf8-0cff : PCI conf1
	    a000-afff : PCI Bus #01
	    cc00-cc1f : PCI device 1106:3038
	      cc00-cc1f : usb-uhci
	    d000-d01f : PCI device 1106:3038
	      d000-d01f : usb-uhci
	    d400-d403 : PCI device 1106:3058
	    d800-d803 : PCI device 1106:3058
	    dc00-dcff : PCI device 1106:3058
	    ffa0-ffaf : PCI device 1106:0571
	      ffa0-ffa7 : ide0
	      ffa8-ffaf : ide1

       /proc/iomem output:

	    00000000-0009fbff : System RAM
	    0009fc00-0009ffff : reserved
	    000a0000-000bffff : Video RAM area
	    000c0000-000c7fff : Video ROM
	    000f0000-000fffff : System ROM
	    00100000-0ffeffff : System RAM
	      00100000-0021680f : Kernel code
	      00216810-0022cd8b : Kernel data
	    0fff0000-0fff7fff : ACPI Tables
	    0fff8000-0fffffff : ACPI Non-volatile Storage
	    cdc00000-ddcfffff : PCI Bus #01
	      d0000000-d7ffffff : PCI device 10de:0110
	        d0000000-d1ffffff : vesafb
	    dde00000-dfefffff : PCI Bus #01
	      de000000-deffffff : PCI device 10de:0110
	    e0000000-e3ffffff : PCI device 1106:0305
	    ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133
AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: dde00000-dfefffff
	Prefetchable memory behind bridge: cdc00000-ddcfffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super
South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at cc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 50)
	Subsystem: Giga-byte Technology: Unknown device a000
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at d800 [size=4]
	Region 2: I/O ports at d400 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 (rev a1)
(prog-if 00 [VGA])
	Subsystem: LeadTek Research Inc.: Unknown device 2830
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at dfef0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)

       Attached devices: none

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

	---       
       
[X.] Other notes, patches, fixes, workarounds:

     I've tried recompile the kernel from rescue shell, but nothing has
changed.
     
################################################################################
     
     
Thank you in advance.
With kindest regards, Alex Nedovizij.
----
Optimag : Canon PowerShot Pro 90IS : $995
http://pc.optimag.net/browse/27/77/433.html

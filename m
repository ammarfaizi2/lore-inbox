Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314503AbSD1V1t>; Sun, 28 Apr 2002 17:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSD1V1s>; Sun, 28 Apr 2002 17:27:48 -0400
Received: from cable-0441.grnco.net ([65.70.17.141]:39296 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S314503AbSD1V1q>; Sun, 28 Apr 2002 17:27:46 -0400
Subject: Problem: Kernel Oops while trying to ping, kernel 2.4.18.
From: Kyle <khan_5@linuxfreemail.com>
To: linux kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 28 Apr 2002 16:27:42 -0500
Message-Id: <1020029262.13018.7.camel@athlon>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Oops while trying to ping, kernel 2.4.18.

I brought down eth0, brought it back up, and adjusted routing tables,
and then tried to ping my ISP, connected to eth0.  At the time I had
only the usbnet module loaded, and I had usb0 up, which is a usb
connection to my iPAQ handheld running linux, kernel 2.4.16.  When I ran
ping, right after the PING ip.address... line, I got a kernel oops.  My
first thought was a problem with usbnet, as if I do some heavy activity
over the usb0 link such as X through ssh I occasionally get a lockup. 
(Can't do anything, see no oops or anything, can't ssh in).

Modules loaded at time: usbnet
Networking info: eth0 was up, 3com 3c905b card.  lo was up.  eth0 was
up, usb connection.
Kernel 2.4.18.

/proc/version says: 
Linux version 2.4.18 (root@athlon) (gcc version 2.96 20000731 (Red Hat
Linux 7.1 2.96-98)) #1 Sat Apr 20 17:09:55 CDT 2002

Running ksymoops on the oops says:
ksymoops 2.4.1 on i686 2.4.18.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /usr/src/linux/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address
00000000
Oops: 0002
EIP: 0010:[<e0878901>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
ds: 0018 es: 0018 ss: 0018
Process ping (pid: 1786, stackpage=ddf15000)
Stack: df35d900 df342800 e0878b9d df342800 df35d900 df35d92c ffffff98
df31b940
dfedf1b8 c185fa00 c022e7f0 df31b940 00000000 00000001 00000000 df31b940
dfedf1b8 c184e344 c184e344 c022e900 df31b940 00000282 00000000 0000d800
Call trace: [<e0878b9d>]  [<c022e7f0>] [<c022e900>] [<c022e9a7>]
[<c0107fa9>]
        [<c0108118>] [<c010a0f8>]
Code: 89 01 83 bb e8 01 00 00 01 75 1c 8d 93 f0 01 00 00 31 c0 0f

>>EIP; e0878901 <END_OF_CODE+21b04/????>   <=====
Trace; e0878b9d <END_OF_CODE+21da0/????>
Trace; c022e7f0 <uhci_call_completion+110/170>
Trace; c022e900 <uhci_remove_pending_qhs+50/70>
Trace; c022e9a7 <uhci_interrupt+87/e0>
Trace; c0107fa9 <handle_IRQ_event+39/60>
Trace; c0108118 <do_IRQ+68/b0>
Trace; c010a0f8 <call_do_IRQ+5/d>
Code;  e0878901 <END_OF_CODE+21b04/????>
00000000 <_EIP>:
Code;  e0878901 <END_OF_CODE+21b04/????>   <=====
   0:   89 01                     mov    %eax,(%ecx)   <=====
Code;  e0878903 <END_OF_CODE+21b06/????>
   2:   83 bb e8 01 00 00 01      cmpl   $0x1,0x1e8(%ebx)
Code;  e087890a <END_OF_CODE+21b0d/????>
   9:   75 1c                     jne    27 <_EIP+0x27> e0878928
<END_OF_CODE+21b2b/????>
Code;  e087890c <END_OF_CODE+21b0f/????>
   b:   8d 93 f0 01 00 00         lea    0x1f0(%ebx),%edx
Code;  e0878912 <END_OF_CODE+21b15/????>
  11:   31 c0                     xor    %eax,%eax
Code;  e0878914 <END_OF_CODE+21b17/????>
  13:   0f 00 00                  sldt   (%eax)

<0>Kernel panic: Aiee, killing interrupt handler!

ver_linux says: 
Linux athlon 2.4.18 #1 Sat Apr 20 17:09:55 CDT 2002 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.13
e2fsprogs              1.26
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         usbnet

/proc/cpuinfo says:
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) XP 1600+
stepping	: 2
cpu MHz		: 1405.730
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 2804.94

/proc/modules says:
usbnet                  7496   0 (unused)

/proc/ioports says:
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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c800-c8ff : PCI device 1002:5157 (ATI Technologies Inc)
d800-d81f : VIA Technologies, Inc. UHCI USB
  d800-d81f : usb-uhci
dc00-dc1f : VIA Technologies, Inc. UHCI USB (#2)
  dc00-dc1f : usb-uhci
e000-e0ff : VIA Technologies, Inc. AC97 Audio Controller
e400-e47f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  e400-e47f : 00:0a.0
e800-e81f : Creative Labs SB Live! EMU10k1
  e800-e81f : EMU10K1
ec00-ec07 : Creative Labs SB Live!
fc00-fc0f : VIA Technologies, Inc. Bus Master IDE

/proc/iomem says:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0027cbd8 : Kernel code
  0027cbd9-002ded97 : Kernel data
1fff0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
cfc00000-dfcfffff : PCI Bus #01
  d0000000-d7ffffff : PCI device 1002:5157 (ATI Technologies Inc)
dfe00000-dfefffff : PCI Bus #01
  dfef0000-dfefffff : PCI device 1002:5157 (ATI Technologies Inc)
dfffff80-dfffffff : 3Com Corporation 3c905B 100BaseTX [Cyclone]
e0000000-e7ffffff : VIA Technologies, Inc. VT8367 [KT266]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

lspci -vvv says:
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: dfe00000-dfefffff
	Prefetchable memory behind bridge: cfc00000-dfcfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Multimedia audio controller: Creative Labs SB Live! EMU10000
(rev 08)
	Subsystem: Creative Labs: Unknown device 8064
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e800 [size=32]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 Input device controller: Creative Labs SB Live! (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at ec00 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at e400 [size=128]
	Region 1: Memory at dfffff80 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at dffc0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 14
	Region 4: I/O ports at fc00 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 40)
	Subsystem: Micro-star International Co Ltd: Unknown device 4720
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at e000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device
5157 (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 6666
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at c800 [size=256]
	Region 2: Memory at dfef0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at dfec0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Motherboard is a MSI KT3 Ultra (Via KT333+Via VT8233a).  IDE drives,
.5gb ECC DDR ram, expansion cards are: Radeon 7500 in AGP, 3c905b NIC in
pci, SB Live! in pci, no ISA slots.  I've only had the lockups when
doing X over ssh in kernels 2.4.18 and 2.4.17 I think.  This box locks,
but the iPAQ is fine.  

/proc/interrupts says:
           CPU0       
  0:     457183          XT-PIC  timer
  1:      18261          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       3383          XT-PIC  usb-uhci, usb-uhci, eth0
  9:          2          XT-PIC  acpi
 10:    1456960          XT-PIC  EMU10K1
 12:      59379          XT-PIC  PS/2 Mouse
 14:      86176          XT-PIC  ide0
 15:         35          XT-PIC  ide1
NMI:          0 
ERR:          0

relevant parts of kernel config file:
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_USB=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_USBNET=m

/proc/driver/uhci/hc0 says:
HC status
  usbcmd    =     0008   Maxp32 EGSM 
  usbstat   =     0020   HCHalted 
  usbint    =     000f
  usbfrnum  =   (0)438
  flbaseadd = 01840000
  sof       =       40
  stat1     =     0480   
  stat2     =     0480   
Frame List
Skeleton TD's
- skel_term_td
    [c18451b0] link (018451b0) e0 Length=0 MaxLen=7ff DT0 EndPt=0
Dev=7f, PID=69(IN) (buf=00000000)
Skeleton QH's

/proc/driver/uhci/hc1 says:
HC status
  usbcmd    =     00c1   Maxp64 CF RS 
  usbstat   =     0000   
  usbint    =     000f
  usbfrnum  =   (0)048
  flbaseadd = 1fed8000
  sof       =       40
  stat1     =     0491   PortConnected 
  stat2     =     0480   
Frame List
Skeleton TD's
- skel_term_td
    [dfede1b0] link (1fede1b0) e0 Length=0 MaxLen=7ff DT0 EndPt=0
Dev=7f, PID=69(IN) (buf=00000000)
Skeleton QH's

Thats everything in the suggested bug form and everything else I can
think of, will be glad to provide any other info.

Thanks very much!
Kyle Liddell

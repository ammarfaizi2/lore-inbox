Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbSLBAhd>; Sun, 1 Dec 2002 19:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262905AbSLBAhd>; Sun, 1 Dec 2002 19:37:33 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:48472 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S262871AbSLBAh1>; Sun, 1 Dec 2002 19:37:27 -0500
Subject: [2.4.20] Warning: kfree_skb on hard IRQ d0845d25
From: Harm Verhagen <h.verhagen@chello.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1038789874.1613.24.camel@pchome.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 (1.2.0-3) 
Date: 02 Dec 2002 01:44:34 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Booting into 2.4.20 I found the following warning in my logs:
"Warning: kfree_skb on hard IRQ d0845d25"

Does it ring a bell?
Is it bad ?

Kind regards,
Harm Verhagen

[1.] One line summary of the problem:
Enabling my USB ethernet card gives the warning above.
    
[2.] Full description of the problem/report:

Steps to reproduce:
1) boot into single mode  linux 2.4.20
2) ifup eth0   (my usb ethernet card, using the kaweth.o driver)
3) Warnings are printed.

I did not get these warnings with 2.4.19.
Btw, I had to add the the following line to get the device working with
2.4.19 to get the device recognized.

--- linux-2.4.19/drivers/usb/kaweth.c.org	Fri Jul 19 01:38:13 2002
+++ linux-2.4.19/drivers/usb/kaweth.c	Tue Jul 23 22:58:15 2002
@@ -143,6 +143,7 @@
 	{ USB_DEVICE(0x10bd, 0x1427) }, /* ASANTE USB To Ethernet Adapter */
 	{ USB_DEVICE(0x1342, 0x0204) }, /* Mobility USB-Ethernet Adapter */
 	{ USB_DEVICE(0x13d2, 0x0400) }, /* Shark Pocket Adapter */
+	{ USB_DEVICE(0x1485, 0x0001) }, /* Silicom USB-Ethernet Adapter */
 	{ USB_DEVICE(0x1645, 0x0005) }, /* Entrega E45 */ 
 	{ USB_DEVICE(0x1645, 0x0008) }, /* Entrega USB Ethernet Adapter */ 
 	{ USB_DEVICE(0x1645, 0x8005) }, /* PortGear Ethernet Adapter */ 


[3.] Keywords (i.e., modules, networking, kernel):
 kernel, USB

[4.] Kernel version (from /proc/version):
Linux version 2.4.20 (root@pchome) (gcc version 3.2 20020903 (Red Hat
Linux 8.0 3.2-7)) #4 Mon Dec 2 01:03:00 CET 2002

2.4.20: no patches at all.

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

No Oops.
I added a show_stack(NULL); where the kernel prints the "Warning:
kfree_skb on hard..." message

Warning: kfree_skb on hard IRQ d0845d25
c0299ef4 d0845d25 00000000 00000000 d0845d25 cf9f42c0 cf6711c0 cf6711c0 
       00000000 00000000 00000000 cff6199c 00000003 cff61980 cff6199c
d0845e93 
       cff61980 cf5c1444 00000282 00000000 0001000f 0000a800 cff26d00
04000001 
Call Trace:    [<d0845d25>] [<d0845d25>] [<d0845e93>] [<c010a3f5>]
[<c010a574>]
  [<c0106ea0>] [<c010cb18>] [<c0106ea0>] [<c0106ec3>] [<c0106f32>]
[<c0105000>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; d0845d25 <[usb-uhci]process_urb+185/260>
Trace; d0845d25 <[usb-uhci]process_urb+185/260>
Trace; d0845e93 <[usb-uhci]uhci_interrupt+93/170>
Trace; c010a3f5 <handle_IRQ_event+45/70>
Trace; c010a574 <do_IRQ+64/a0>
Trace; c0106ea0 <default_idle+0/30>
Trace; c010cb18 <call_do_IRQ+5/d>
Trace; c0106ea0 <default_idle+0/30>
Trace; c0106ec3 <default_idle+23/30>
Trace; c0106f32 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>


[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux localhost.localdomain 2.4.20 #4 Mon Dec 2 01:03:00 CET 2002 i686
athlon i386 GNU/Linux
 
Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
reiserfsprogs          3.6.2
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         iptable_filter ip_tables ide-scsi ide-cd cdrom
usb-storage scsi_mod kaweth mousedev keybdev hid input ehci-hcd usb-uhci
usbcore ext3 jbd

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(TM) XP 1800+
stepping	: 2
cpu MHz		: 1532.941
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
bogomips	: 3060.53


[7.3.] Module information (from /proc/modules):
iptable_filter          2412   0 (autoclean) (unused)
ip_tables              14648   1 [iptable_filter]
ide-scsi               10512   0
ide-cd                 33412   0
cdrom                  33312   0 [ide-cd]
usb-storage            61488   0
scsi_mod              106676   2 [ide-scsi usb-storage]
kaweth                 18648   1
mousedev                5428   0 (unused)
keybdev                 2880   0 (unused)
hid                    22020   0 (unused)
input                   5696   0 [mousedev keybdev hid]
ehci-hcd               17160   0 (unused)
usb-uhci               26156   0 (unused)
usbcore                76960   1 [usb-storage kaweth hid ehci-hcd
usb-uhci]
ext3                   69664   5
jbd                    51604   5 [ext3]
[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
a400-a41f : VIA Technologies, Inc. USB (#4)
  a400-a41f : usb-uhci
a800-a81f : VIA Technologies, Inc. USB (#3)
  a800-a81f : usb-uhci
b000-b00f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  b000-b007 : ide0
  b008-b00f : ide1
b400-b43f : Ensoniq 5880 AudioPCI
b800-b87f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
d000-d0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
d400-d41f : VIA Technologies, Inc. USB (#2)
  d400-d41f : usb-uhci
d800-d81f : VIA Technologies, Inc. USB
  d800-d81f : usb-uhci


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffbfff : System RAM
  00100000-00228f0b : Kernel code
  00228f0c-002970e3 : Kernel data
0fffc000-0fffefff : ACPI Tables
0ffff000-0fffffff : ACPI Non-volatile Storage
d4800000-d480007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
d5000000-d50000ff : Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+
d5800000-d58000ff : VIA Technologies, Inc. USB 2.0
  d5800000-d58000ff : ehci-hcd
d6000000-d75fffff : PCI Bus #01
  d6000000-d6ffffff : nVidia Corporation NV17 [GeForce4 MX440]
d7700000-dfffffff : PCI Bus #01
  d7800000-d787ffff : nVidia Corporation NV17 [GeForce4 MX440]
  d8000000-dfffffff : nVidia Corporation NV17 [GeForce4 MX440]
e0000000-e7ffffff : VIA Technologies, Inc. VT8367 [KT266]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
	Subsystem: Asustek Computer, Inc. A7V333
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT333 AGP] (prog-if
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: d6000000-d75fffff
	Prefetchable memory behind bridge: d7700000-dfffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00
[UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00
[UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if
20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at d5800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at d5000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b800 [size=128]
	Region 1: Memory at d4800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at b400 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master
IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at b000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00
[UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at a800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00
[UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at a400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4
MX440] (rev a3) (prog-if 00 [VGA])
	Subsystem: LeadTek Research Inc.: Unknown device 2870
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 2: Memory at d7800000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at d77e0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

-- 
Harm Verhagen <h.verhagen@chello.nl>


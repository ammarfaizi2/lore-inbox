Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313071AbSC0TSC>; Wed, 27 Mar 2002 14:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313078AbSC0TRz>; Wed, 27 Mar 2002 14:17:55 -0500
Received: from ucs.co.za ([196.23.43.2]:19979 "EHLO ucs.co.za")
	by vger.kernel.org with ESMTP id <S313071AbSC0TRj>;
	Wed, 27 Mar 2002 14:17:39 -0500
Subject: VIA text console corruption and fix.
From: Berend De Schouwer <bds@jhb.ucs.co.za>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 27 Mar 2002 21:17:30 +0200
Message-Id: <1017256651.18224.40.camel@bds.ucs.co.za>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The VIA bug-fix that got added in 2.4.18 still has issues.  I've
included as good a bug report as I can, and a patch that "works for me".

[1.] One line summary of the problem:    

The text console gets corrupted on some VIA motherboards in 2.4.18

[2.] Full description of the problem/report:

When booting kernel 2.4.18, before /sbin/init is run, the text console
becomes corrupted and unreadable.  Vertical lines appear on the screen
in a multitude of colours.  The X server will still start, and run as
normal.  You can login over ssh.

[3.] Keywords (i.e., modules, networking, kernel):

kernel, console, VIA

[4.] Kernel version (from /proc/version):

2.4.18-pre1 and later.  Absent in 2.4.17 and earlier.

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)

Just boot.

[7.] Environment

I have 3000+ identical VIA KT133/Duron 750MHz machines.  In 20% of these
the bug is visible, in the others, it isn't.  The machines run in an
LTSP-ish configuration.  The machines are supposed to be identical (they
were bought together), but have different revisions of BIOS versions,
etc.  They have on-board S3 Savage cards that steal RAM from the main
RAM.

[7.1.] Software (add the output of the ver_linux script here)

Linux version 2.4.18 (root@ucs.co.za) (gcc version 2.96 20000731 (Red
Hat Linux 7.1 2.96-85)) #12 Wed Mar 27 22:34:33 SAST 2002

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11f
mount                  2.11b
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0f
pcmcia-cs              3.1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         8139too

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 3
model name	: AMD Duron(tm) Processor
stepping	: 1
cpu MHz		: 756.765
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1510.60

[7.3.] Module information (from /proc/modules):

parport_pc             21952   1 (autoclean)
lp                      6048   0 (autoclean)
parport                24512   1 (autoclean) [parport_pc lp]
8139too                13168   2 (autoclean)
mii                     1072   0 (autoclean) [8139too]

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
/proc/ioports 
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
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
a000-a0ff : Realtek Semiconductor Co., Ltd. RTL-8139 (#2)
  a000-a0ff : 8139too
a400-a4ff : Realtek Semiconductor Co., Ltd. RTL-8139
  a400-a4ff : 8139too
b000-b003 : VIA Technologies, Inc. AC97 Audio Controller
b400-b403 : VIA Technologies, Inc. AC97 Audio Controller
b800-b8ff : VIA Technologies, Inc. AC97 Audio Controller
d000-d01f : VIA Technologies, Inc. UHCI USB (#2)
d400-d41f : VIA Technologies, Inc. UHCI USB
d800-d80f : VIA Technologies, Inc. Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
e200-e27f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

/proc/iomem 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-077fbfff : System RAM
  00100000-0023ca1c : Kernel code
  0023ca1d-002952d7 : Kernel data
077fc000-077fefff : ACPI Tables
077ff000-077fffff : ACPI Non-volatile Storage
d6000000-d60000ff : Realtek Semiconductor Co., Ltd. RTL-8139 (#2)
  d6000000-d60000ff : 8139too
d6800000-d68000ff : Realtek Semiconductor Co., Ltd. RTL-8139
  d6800000-d68000ff : 8139too
d7000000-d7dfffff : PCI Bus #01
  d7000000-d707ffff : S3 Inc. ProSavage KM133
d7f00000-dfffffff : PCI Bus #01
  d8000000-dfffffff : S3 Inc. ProSavage KM133
e0000000-efffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 81)
	Subsystem: Asustek Computer, Inc.: Unknown device 8041
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 40
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: d7000000-d7dfffff
	Prefetchable memory behind bridge: d7f00000-dfffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e7
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
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e7
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 50)
	Subsystem: Asustek Computer, Inc.: Unknown device 4005
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 0
	Region 0: I/O ports at b800 [size=256]
	Region 1: I/O ports at b400 [size=4]
	Region 2: I/O ports at b000 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at a400 [size=256]
	Region 1: Memory at d6800000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a000 [size=256]
	Region 1: Memory at d6000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8a26 (prog-if
00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 8041
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d7000000 (32-bit, non-prefetchable) [size=512K]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at d7ff0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


[7.6.] SCSI information (from /proc/scsi/scsi)

N/A

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

At the end, I've included /proc/cpuinfo, /proc/ioports, /proc/iomem, and
lspci from a machine that is supposedly identical, but doesn't have the
bug.  I've been playing with BIOS settings (enabling/disabling USB,
Audio, etc.), but I think I have them similar again.  There are some
differences: different IRQs.

[X.] Other notes, patches, fixes, workarounds:

The following patch fixes it for me:

--- arch/i386/kernel/pci-pc.c.orig	Wed Mar 27 21:09:26 2002
+++ arch/i386/kernel/pci-pc.c	Wed Mar 27 22:34:24 2002
@@ -1114,6 +1114,7 @@
  *
  * VIA 8363,8622,8361 Northbridges:
  *  - bits  5, 6, 7 at offset 0x55 need to be turned off
+ *    BUG?: Turning bit 5 off breaks some motherboards.
  * VIA 8367 (KT266x) Northbridges:
  *  - bits  5, 6, 7 at offset 0x95 need to be turned off
  */
@@ -1129,8 +1130,8 @@
 
 	pci_read_config_byte(d, where, &v);
 	if (v & 0xe0) {
-		printk("Disabling VIA memory write queue: [%02x] %02x->%02x\n",
where, v, v & 0x1f);
-		v &= 0x1f; /* clear bits 5, 6, 7 */
+		printk("Disabling VIA memory write queue: [%02x] %02x->%02x\n",
where, v, v & 0x3f);
+		v &= 0x3f; /* clear bits 6,7 */
 		pci_write_config_byte(d, where, v);
 	}
 }



So here is the /proc info from a working machine:

/proc/cpuinfo 
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 3
model name	: AMD Duron(tm) Processor
stepping	: 1
cpu MHz		: 756.763
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1510.60


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
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
a800-a8ff : Realtek Semiconductor Co., Ltd. RTL-8139 (#2)
  a800-a8ff : 8139too
b000-b0ff : Realtek Semiconductor Co., Ltd. RTL-8139
  b000-b0ff : 8139too
b400-b43f : Ensoniq 5880 AudioPCI
d000-d01f : VIA Technologies, Inc. UHCI USB (#2)
d400-d41f : VIA Technologies, Inc. UHCI USB
d800-d80f : VIA Technologies, Inc. Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
e200-e27f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]


/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-077fbfff : System RAM
  00100000-0023ca1c : Kernel code
  0023ca1d-002952d7 : Kernel data
077fc000-077fefff : ACPI Tables
077ff000-077fffff : ACPI Non-volatile Storage
ee000000-ee0000ff : Realtek Semiconductor Co., Ltd. RTL-8139 (#2)
  ee000000-ee0000ff : 8139too
ee800000-ee8000ff : Realtek Semiconductor Co., Ltd. RTL-8139
  ee800000-ee8000ff : 8139too
ef000000-efdfffff : PCI Bus #01
  ef000000-ef07ffff : S3 Inc. ProSavage KM133
eff00000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : S3 Inc. ProSavage KM133
f8000000-fbffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
ffff0000-ffffffff : reserved


lspci -vvv:
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 81)
	Subsystem: Asustek Computer, Inc.: Unknown device 8041
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 40
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: ef000000-efdfffff
	Prefetchable memory behind bridge: eff00000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e7
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
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e7
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Multimedia audio controller: Ensoniq CT5880 [AudioPCI] (rev 03)
	Subsystem: Asustek Computer, Inc.: Unknown device 803a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at b400 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at b000 [size=256]
	Region 1: Memory at ee800000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a800 [size=256]
	Region 1: Memory at ee000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8a26 (prog-if
00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 8041
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ef000000 (32-bit, non-prefetchable) [size=512K]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at efff0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


-- 
Berend De Schouwer


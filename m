Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267731AbSLSXBN>; Thu, 19 Dec 2002 18:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267733AbSLSXBN>; Thu, 19 Dec 2002 18:01:13 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:49034 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S267731AbSLSXAy>; Thu, 19 Dec 2002 18:00:54 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: "David A. Chappel" <bobzibub_NoSpam_@attbi.com>
Reply-To: bobzibub@attbi.com
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Oops during high ide io loads.
Date: Thu, 19 Dec 2002 16:05:00 -0700
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212191605.00586.bobzibub_NoSpam_@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops occurs under high disk load under stock 2.4.20 kernel  
(Alan's version  too.)
=========================================================

Oops occurs under high disk usage.  Simultaniously ripping of 
one cd and creating another iso file off of an nfs share.  
(oggenc, cdparanoia, mkisofs, xcdroast)  I use and have ide-scsi 
compiled into my kernel and have an all-ide system.
=========================================================
[root@Perky root]# cat /proc/version
Linux version 2.4.20 (root@Perky.Davids.local) (gcc version 2.96 
20000731 (Red Hat Linux 7.1 2.96-98)) #11 SMP Thu Dec 19 
13:00:17 MST 2002
=========================================================

I was able to get a couple pictures:  ; )
http://home.attbi.com/~bobzibub/oops/oops1.jpg
http://home.attbi.com/~bobzibub/oops/oops2.jpg

Stack: 00000000 ffffffff ffffffff ffffffff ffffffff 00000001 
00000000 de4c0000 de4c1e98 c02c0b95 de4c1e3c 00000001 00000001
c02dfc0c 00000000 de4c0000 de4c1e98 ffffffff ffff0018 ffff0018
ffffffef c0114425 00000010 00000282
Call Trace:    [<c0115525>]

Code: f7 f1 50 e8 99 fd ff ff 8b 83 40 df 30 c0 89 83 c0 de 30
c0
<1>Unable to handle kernel paging requiest at virtual address
e0000000 printing eip:
c0209847
*pde = 00000000
=========================================================

[root@Perky root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 998.374
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep 
mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1992.29

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 998.374
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep 
mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1992.29
=========================================================

[root@Perky root]# cat /proc/modules

=========================================================


(The CDs/ hard drives are attached to the HPT370 not the VIA 
adapter)

[root@Perky root]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(auto)
0378-037a : parport0
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
c000-c00f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  c000-c007 : ide0
  c008-c00f : ide1
c400-c41f : VIA Technologies, Inc. USB
  c400-c41f : usb-uhci
c800-c81f : VIA Technologies, Inc. USB (#2)
  c800-c81f : usb-uhci
cc00-ccff : Linksys Network Everywhere Fast Ethernet 10/100 
model NC100
  cc00-ccff : tulip
d000-d03f : Ensoniq 5880 AudioPCI
  d000-d03f : es1371
d400-d407 : Triones Technologies, Inc. HPT366/368/370/370A/372
  d400-d407 : ide2
d800-d803 : Triones Technologies, Inc. HPT366/368/370/370A/372
  d802-d802 : ide2
dc00-dc07 : Triones Technologies, Inc. HPT366/368/370/370A/372
  dc00-dc07 : ide3
e000-e003 : Triones Technologies, Inc. HPT366/368/370/370A/372
  e002-e002 : ide3
e400-e4ff : Triones Technologies, Inc. HPT366/368/370/370A/372
  e400-e407 : ide2
  e408-e40f : ide3
  e410-e4ff : HPT370A

=========================================================

[root@Perky root]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002b9a95 : Kernel code
  002b9a96-0034f45f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
c0000000-cfffffff : VIA Technologies, Inc. VT82C693A/694x 
[Apollo PRO133x]
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation NV25 [GeForce4 Ti4400]
  d8000000-d807ffff : nVidia Corporation NV25 [GeForce4 Ti4400]
e0000000-e1ffffff : PCI Bus #01
  e0000000-e0ffffff : nVidia Corporation NV25 [GeForce4 Ti4400]
e3000000-e30003ff : Linksys Network Everywhere Fast Ethernet 
10/100 model NC100
  e3000000-e30003ff : tulip
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
[root@Perky root]#

=========================================================

[root@Perky root]# lspci -vvv
bash: lspci: command not found
[root@Perky root]# /sbin/lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo 
PRO] (rev c4)
        Subsystem: ABIT Computer Corp.: Unknown device a204
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at c0000000 (32-bit, prefetchable) 
[size=256M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, 
sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- 
FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo 
Super South] (rev 40)
        Subsystem: ABIT Computer Corp.: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE 
(rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at c000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at c400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super 
ACPI] (rev 40)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 11
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Bridgecom, Inc: Unknown device 0985 
(rev 11)
        Subsystem: Bridgecom, Inc: Unknown device 0574
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min, 63750ns max), cache line size 
08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at cc00 [size=256]
        Region 1: Memory at e3000000 (32-bit, non-prefetchable) 
[size=1K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Multimedia audio controller: Ensoniq CT5880 [AudioPCI] 
(rev 02)
        Subsystem: Ensoniq: Unknown device 8001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow 
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at d000 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Unknown mass storage controller: HighPoint Technologies, 
Inc. HPT366/370 UltraDMA 66/100 IDE Controller (rev 04)
        Subsystem: HighPoint Technologies, Inc.: Unknown device 
0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 
08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d400 [size=8]
        Region 1: I/O ports at d800 [size=4]
        Region 2: I/O ports at dc00 [size=8]
        Region 3: I/O ports at e000 [size=4]
        Region 4: I/O ports at e400 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation: Unknown 
device 0251 (rev a2) (prog-if 00 [VGA])
        Subsystem: VISIONTEK: Unknown device 003c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) 
[size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) 
[size=128M]
        Region 2: Memory at d8000000 (32-bit, prefetchable) 
[size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[root@Perky root]#
=========================================================

<Extract from System.map>
c0208a30 T ide_scan_pio_blacklist
c0208ab0 T ide_get_best_pio_mode
c0208c10 t init_hwif_data
c0208de0 T drive_is_flashcard
c0208f10 T ide_system_bus_speed
c0208f80 T ide_input_data           <-------------------
c0209060 T ide_output_data
c0209130 T atapi_input_bytes
c02091a0 T atapi_output_bytes
c0209210 T drive_is_ready
c0209260 T ide_end_request
c0209370 T ide_set_handler
c0209450 T current_capacity
c0209480 T ide_geninit
c0209510 t atapi_reset_pollfunc
c02095e0 t reset_pollfunc
c0209740 t check_dma_crc
c02097c0 t pre_reset
=========================================================

(gdb) disassemble ide_input_data

Dump of assembler code for function ide_input_data:
0xc0208f80 <ide_input_data>:	push   %ebp
0xc0208f81 <ide_input_data+1>:	mov    %esp,%ebp
0xc0208f83 <ide_input_data+3>:	push   %edi
0xc0208f84 <ide_input_data+4>:	push   %esi
0xc0208f85 <ide_input_data+5>:	push   %ebx
0xc0208f86 <ide_input_data+6>:	sub    $0xc,%esp
0xc0208f89 <ide_input_data+9>:	mov    0x8(%ebp),%esi
0xc0208f8c <ide_input_data+12>:	mov    0xc(%ebp),%edi
0xc0208f8f <ide_input_data+15>:	mov    0x10(%ebp),%ebx
0xc0208f92 <ide_input_data+18>:	mov    0xfc(%esi),%edx
0xc0208f98 <ide_input_data+24>:	mov    0x320(%edx),%eax
0xc0208f9e <ide_input_data+30>:	mov    %edx,%ecx
0xc0208fa0 <ide_input_data+32>:	test   %eax,%eax
0xc0208fa2 <ide_input_data+34>:	je     0xc0208fb0 
<ide_input_data+48>
0xc0208fa4 <ide_input_data+36>:	push   %ebx
0xc0208fa5 <ide_input_data+37>:	push   %edi
0xc0208fa6 <ide_input_data+38>:	push   %esi
0xc0208fa7 <ide_input_data+39>:	push   $0x0
0xc0208fa9 <ide_input_data+41>:	call   *%eax
0xc0208fab <ide_input_data+43>:	jmp    0xc020904a 
<ide_input_data+202>
0xc0208fb0 <ide_input_data+48>:	movzbl 0xd5(%esi),%eax
0xc0208fb7 <ide_input_data+55>:	test   %al,%al
0xc0208fb9 <ide_input_data+57>:	je     0xc0208ff0 
<ide_input_data+112>
0xc0208fbb <ide_input_data+59>:	and    $0x2,%eax
0xc0208fbe <ide_input_data+62>:	je     0xc0208fe0 
<ide_input_data+96>
0xc0208fc0 <ide_input_data+64>:	pushf  
0xc0208fc1 <ide_input_data+65>:	popl   0xffffffe8(%ebp)
0xc0208fc4 <ide_input_data+68>:	cli    
0xc0208fc5 <ide_input_data+69>:	mov    0xfc(%esi),%esi
0xc0208fcb <ide_input_data+75>:	movzwl 0xc(%esi),%edx
0xc0208fcf <ide_input_data+79>:	in     (%dx),%al
0xc0208fd0 <ide_input_data+80>:	in     (%dx),%al
0xc0208fd1 <ide_input_data+81>:	in     (%dx),%al
0xc0208fd2 <ide_input_data+82>:	movzwl 0x8(%esi),%edx
0xc0208fd6 <ide_input_data+86>:	mov    %ebx,%ecx
0xc0208fd8 <ide_input_data+88>:	repz insl (%dx),%es:(%edi)
0xc0208fda <ide_input_data+90>:	pushl  0xffffffe8(%ebp)
0xc0208fdd <ide_input_data+93>:	popf   
0xc0208fde <ide_input_data+94>:	jmp    0xc020904a 
<ide_input_data+202>
0xc0208fe0 <ide_input_data+96>:	movzwl 0x8(%edx),%edx
0xc0208fe4 <ide_input_data+100>:	mov    %ebx,%ecx
0xc0208fe6 <ide_input_data+102>:	repz insl (%dx),%es:(%edi)
0xc0208fe8 <ide_input_data+104>:	jmp    0xc020904a 
<ide_input_data+202>
0xc0208fea <ide_input_data+106>:	lea    0x0(%esi),%esi
0xc0208ff0 <ide_input_data+112>:	cmpb   $0x0,0xba(%esi)
0xc0208ff7 <ide_input_data+119>:	je     0xc0209040 
<ide_input_data+192>
0xc0208ff9 <ide_input_data+121>:	dec    %ebx
0xc0208ffa <ide_input_data+122>:	cmp    $0xffffffff,%ebx
0xc0208ffd <ide_input_data+125>:	je     0xc020904a 
<ide_input_data+202>
0xc0208fff <ide_input_data+127>:	jmp    0xc0209010 
<ide_input_data+144>
0xc0209001 <ide_input_data+129>:	mov    0xfc(%esi),%ecx
0xc0209007 <ide_input_data+135>:	mov    %esi,%esi
0xc0209009 <ide_input_data+137>:	lea    0x0(%edi,1),%edi
0xc0209010 <ide_input_data+144>:	movzwl 0x8(%ecx),%edx
0xc0209014 <ide_input_data+148>:	in     (%dx),%ax
0xc0209016 <ide_input_data+150>:	out    %al,$0x80
0xc0209018 <ide_input_data+152>:	mov    %ax,(%edi)
0xc020901b <ide_input_data+155>:	add    $0x2,%edi
0xc020901e <ide_input_data+158>:	mov    0xfc(%esi),%eax
0xc0209024 <ide_input_data+164>:	movzwl 0x8(%eax),%edx
0xc0209028 <ide_input_data+168>:	in     (%dx),%ax
0xc020902a <ide_input_data+170>:	out    %al,$0x80
0xc020902c <ide_input_data+172>:	mov    %ax,(%edi)
0xc020902f <ide_input_data+175>:	dec    %ebx
0xc0209030 <ide_input_data+176>:	add    $0x2,%edi
0xc0209033 <ide_input_data+179>:	cmp    $0xffffffff,%ebx
0xc0209036 <ide_input_data+182>:	jne    0xc0209001 
<ide_input_data+129>
0xc0209038 <ide_input_data+184>:	jmp    0xc020904a 
<ide_input_data+202>
0xc020903a <ide_input_data+186>:	lea    0x0(%esi),%esi
0xc0209040 <ide_input_data+192>:	movzwl 0x8(%edx),%edx
0xc0209044 <ide_input_data+196>:	lea    (%ebx,%ebx,1),%ecx

0xc0209047 <ide_input_data+199>:	repz insw (%dx),%es:(%edi)     

0xc020904a <ide_input_data+202>:	lea    0xfffffff4(%ebp),%esp
0xc020904d <ide_input_data+205>:	pop    %ebx
0xc020904e <ide_input_data+206>:	pop    %esi
0xc020904f <ide_input_data+207>:	pop    %edi
0xc0209050 <ide_input_data+208>:	pop    %ebp
0xc0209051 <ide_input_data+209>:	ret    
End of assembler dump.
=========================================================

I was running TOP remotely at the time too...


  1:44pm  up 16 min,  4 users,  load average: 2.10, 1.78, 1.02
53 processes: 50 sleeping, 3 running, 0 zombie, 0 stopped
CPU0 states: 56.0% user, 26.2% system, 55.1% nice, 16.4% idle
CPU1 states: 24.5% user, 30.3% system, 23.3% nice, 44.2% idle
Mem:   515348K av,  484460K used,   30888K free,       0K shrd,  
 22104K buff
Swap:  409616K av,       0K used,  409616K free           
423944K cached
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME 
COMMAND
[garbled due to disconnect] 0  2004 2004   824 R N  97.9  0.3   
0:17 oggenc
 5519 root      15  10  2608 2576   504 S N   7.5  0.4   0:01 
cdparanoia
 5520 root       9   0  4020 4020  3224 S     2.1  0.7   0:00 
gaim
 2967 root       9   0   848  848   560 D     1.5  0.1   0:11 
mkisofs
 2463 root       9   0  5160 5160  3084 R     1.1  1.0   0:03 
xcdroast
 2347 root       9   0  2336 2316  1700 S     0.9  0.4   0:01 
sshd
 3269 root       9   0  1040 1040   836 R     0.3  0.2   0:01 
top
   12 root       9   0     0    0     0 SW    0.1  0.0   0:00 
kjournald
  904 root       9   0  1804 1804  1296 S     0.1  0.3   0:00 
cupsd
    1 root       8   0   520  520   452 S     0.0  0.1   0:04 
init
    2 root       9   0     0    0     0 SW    0.0  0.0   0:00 
keventd
    3 root      18  19     0    0     0 SWN   0.0  0.0   0:00 
ksoftirqd_CPU0
    4 root      18  19     0    0     0 SWN   0.0  0.0   0:00 
ksoftirqd_CPU1
    5 root       9   0     0    0     0 SW    0.0  0.0   0:00 
kswapd
    6 root       9   0     0    0     0 SW    0.0  0.0   0:00 
bdflush


=========================================================

Please let me know if you'd like me to reproduce it and follow 
some procedure.

Thanks!
-bobzibub



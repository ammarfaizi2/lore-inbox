Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267101AbTBHVU3>; Sat, 8 Feb 2003 16:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbTBHVU3>; Sat, 8 Feb 2003 16:20:29 -0500
Received: from pool-138-88-82-224.res.east.verizon.net ([138.88.82.224]:41355
	"EHLO intarweb.us") by vger.kernel.org with ESMTP
	id <S267101AbTBHVUX>; Sat, 8 Feb 2003 16:20:23 -0500
Date: Sat, 8 Feb 2003 16:30:03 -0500
From: Jp Calderone <exarkun@intarweb.us>
To: linux-kernel@vger.kernel.org
Subject: OOPS:  Reading files on an ext2 fs on a CD mounted loopback crashes the system
Message-ID: <20030208213003.GA1461@meson.dyndns.org>
Reply-To: exarkun@intarweb.us
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

  Reading files on an ext2 fs on a CD mounted loopback crashes the system.

[2.] Full description of the problem/report:

  I have an ext2 fs that has been burned directly to a CD.   Mounting
/dev/cdrom (/dev/hdc) loopback is successful, and it is possible to `cd'
around the filesystem, as well as `cat' some files successfully.  When
trying a recursive copy (`cp -r') from the CD to a location on the hard
drive, or even a simple shell script for-loop to copy multiple files, the
kernel "oopses", keyboard leds invert or begin to flicker, and soon
afterwards the system becomes unresponsive.

[3.] Keywords (i.e., modules, networking, kernel):

  cdrom, loopback filesystem, ext2

[4.] Kernel version (from /proc/version):

  Linux version 2.4.19 (pkg@meson) (gcc version 2.95.3 20010315 (release))
#4 Mon Dec 9 11:44:05 EST 2002

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

ksymoops 2.4.8 on i686 2.4.19.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /usr/src/linux/System.map (default)

Feb  7 22:53:34 quantum kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Feb  7 22:53:34 quantum kernel: dc84c529
Feb  7 22:53:34 quantum kernel: *pde = 00000000
Feb  7 22:53:34 quantum kernel: Oops: 0000
Feb  7 22:53:34 quantum kernel: CPU:    0
Feb  7 22:53:34 quantum kernel: EIP:    0010:[rtc:__insmod_rtc_O/lib/modules/2.4.19/kernel/drivers/char/rtc.o+-15063/96]    Not tainted
Feb  7 22:53:34 quantum kernel: EFLAGS: 00010202
Feb  7 22:53:34 quantum kernel: eax: 00000008   ebx: 00000028   ecx: 00000002   edx: 00000004
Feb  7 22:53:34 quantum kernel: esi: 00000000   edi: c0252a54   ebp: c0252a00   esp: d1fa3e70
Feb  7 22:53:34 quantum kernel: ds: 0018   es: 0018   ss: 0018
Feb  7 22:53:34 quantum kernel: Process tar (pid: 5454, stackpage=d1fa3000)
Feb  7 22:53:34 quantum kernel: Stack: 00000800 dae36200 00010067 00000004 00000001 00000000 c0252a50 c0252600
Feb  7 22:53:34 quantum kernel:        c0252200 00000400 00000400 c0252000 dc84c73b dae36200 00000800 dae36200
Feb  7 22:53:34 quantum kernel:        dae3eeb4 dae3630c dae3ee60 00000000 dc835d2d dae36200 00000282 d1fa3f04
Feb  7 22:53:34 quantum kernel: Call Trace:    [rtc:__insmod_rtc_O/lib/modules/2.4.19/kernel/drivers/char/rtc.o+-14533/96] [rtc:__insmod_rtc_O/lib/modules/2.4.19/kernel/drivers/char/rtc.o+-107219/96] [rtc:__insmod_rtc_O/lib/modules/2.4.19/kernel/drivers/char/rtc.o+-5856/96] [generic_unplug_device+32/40] [__run_task_queue+76/96]
Feb  7 22:53:34 quantum kernel: Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 8b 54 24 34 0f b7 82
Using defaults from ksymoops -t elf32-i386 -a i386


>>edi; c0252a54 <__initcall_end+4c/5f8>
>>ebp; c0252a00 <__initcall_netlink_proto_init+0/4>
>>esp; d1fa3e70 <_end+11d23968/1c57fb58>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)
Code;  00000002 Before first symbol
   2:   a8 02                     test   $0x2,%al
Code;  00000004 Before first symbol
   4:   74 02                     je     8 <_EIP+0x8> 00000008 Before first symbol
Code;  00000006 Before first symbol
   6:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  00000008 Before first symbol
   8:   a8 01                     test   $0x1,%al
Code;  0000000a Before first symbol
   a:   74 01                     je     d <_EIP+0xd> 0000000d Before first symbol
Code;  0000000c Before first symbol
   c:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  0000000d Before first symbol
   d:   8b 54 24 34               mov    0x34(%esp,1),%edx
Code;  00000011 Before first symbol
  11:   0f b7 82 00 00 00 00      movzwl 0x0(%edx),%eax

Feb  7 22:57:42 quantum kernel:  <1>Unable to handle kernel paging request at virtual address fffffffc
Feb  7 22:57:42 quantum kernel: c0111d18
Feb  7 22:57:42 quantum kernel: *pde = 00001063
Feb  7 22:57:42 quantum kernel: Oops: 0000
Feb  7 22:57:42 quantum kernel: CPU:    0
Feb  7 22:57:42 quantum kernel: EIP:    0010:[__wake_up+40/152]    Not tainted
Feb  7 22:57:42 quantum kernel: EFLAGS: 00010013
Feb  7 22:57:42 quantum kernel: eax: 00000001   ebx: 00000000   ecx: db6b2000   edx: d879b160
Feb  7 22:57:42 quantum kernel: esi: 00000046   edi: 00000000   ebp: db6b3e4c   esp: db6b3e34
Feb  7 22:57:42 quantum kernel: ds: 0018   es: 0018   ss: 0018
Feb  7 22:57:42 quantum kernel: Process giFT (pid: 25779, stackpage=db6b3000)
Feb  7 22:57:42 quantum kernel: Stack: c10a8010 c14d0420 db6b3e98 c14d0424 00000282 00000003 00000000 c0122dcc
Feb  7 22:57:42 quantum kernel:        c10a8010 00000000 c0122622 00000000 db6b3e98 00000000 db77f4f0 00000000
Feb  7 22:57:42 quantum kernel:        00000001 db6b3e98 00000000 db77f4f0 c01226bd 00000000 00000000 db77f440
Feb  7 22:57:42 quantum kernel: Call Trace:    [unlock_page+96/100] [truncate_list_pages+330/420] [truncate_inode_pages+65/104] [vmtruncate+157/292] [inode_setattr+35/176]
Feb  7 22:57:42 quantum kernel: Code: 8b 4b fc 8b 01 85 45 fc 74 4e 31 c0 9c 5e fa c7 01 00 00 00


>>ecx; db6b2000 <_end+1b431af8/1c57fb58>
>>edx; d879b160 <_end+1851ac58/1c57fb58>
>>ebp; db6b3e4c <_end+1b433944/1c57fb58>
>>esp; db6b3e34 <_end+1b43392c/1c57fb58>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx
Code;  00000003 Before first symbol
   3:   8b 01                     mov    (%ecx),%eax
Code;  00000005 Before first symbol
   5:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  00000008 Before first symbol
   8:   74 4e                     je     58 <_EIP+0x58> 00000058 Before first symbol
Code;  0000000a Before first symbol
   a:   31 c0                     xor    %eax,%eax
Code;  0000000c Before first symbol
   c:   9c                        pushf  
Code;  0000000d Before first symbol
   d:   5e                        pop    %esi
Code;  0000000e Before first symbol
   e:   fa                        cli    
Code;  0000000f Before first symbol
   f:   c7 01 00 00 00 00         movl   $0x0,(%ecx)


[6.] [ not applicable ]

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux meson 2.4.19 #4 Mon Dec 9 11:44:05 EST 2002 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.80
util-linux             2.11h
mount                  2.11h
modutils               2.4.7
e2fsprogs              1.23
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Linux C++ Library      3.0.0
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         ipv6 agpgart ymfpci ac97_codec soundcore ide-scsi iptable_filter ipt_MASQUERADE iptable_nat ip_conntrack ip_tables af_packet ppp_synctty ppp_async ppp_generic slhc rtc sr_mod cdrom scsi_mod ne 8390 unix

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 400.917
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 799.53


[7.3.] Module information (from /proc/modules):

ipv6                  122976  -1
agpgart                15696   3 (autoclean)
ymfpci                 39856   0
ac97_codec              9584   0 [ymfpci]
soundcore               3472   2 [ymfpci]
ide-scsi                7328   0
iptable_filter          1696   1 (autoclean)
ipt_MASQUERADE          1168   1 (autoclean)
iptable_nat            13008   1 (autoclean) [ipt_MASQUERADE]
ip_conntrack           12960   1 (autoclean) [ipt_MASQUERADE iptable_nat]
ip_tables              10272   5 [iptable_filter ipt_MASQUERADE iptable_nat]
af_packet              11200   2 (autoclean)
ppp_synctty             4704   0 (unused)
ppp_async               6224   1
ppp_generic            18096   3 [ppp_synctty ppp_async]
slhc                    4320   0 [ppp_generic]
rtc                     5696   0
sr_mod                 11504   0 (autoclean) (unused)
cdrom                  26816   0 (autoclean) [sr_mod]
scsi_mod               80336   2 (autoclean) [ide-scsi sr_mod]
ne                      6448   1
8390                    5840   0 [ne]
unix                   13312 107 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0280-029f : eth0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
5000-501f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
c000-cfff : PCI Bus #01
d000-dfff : PCI Bus #02
e000-e01f : Intel Corp. 82371AB/EB/MB PIIX4 USB
f000-f00f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

/proc/iomem

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1bfeffff : System RAM
  00100000-001daa6b : Kernel code
  001daa6c-0021604b : Kernel data
1bff0000-1bff2fff : ACPI Non-volatile Storage
1bff3000-1bffffff : ACPI Tables
e0000000-e3ffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
e4000000-e5ffffff : PCI Bus #01
  e4000000-e4ffffff : nVidia Corporation Vanta [NV6]
e6000000-e7ffffff : PCI Bus #01
  e6000000-e7ffffff : nVidia Corporation Vanta [NV6]
e8000000-e80fffff : PCI Bus #02
  e8000000-e8003fff : Texas Instruments TSB12LV26 IEEE-1394 Controller (Link)
  e8004000-e8004fff : NEC Corporation USB (#2)
  e8005000-e80050ff : NEC Corporation USB 2.0
  e8006000-e80067ff : Texas Instruments TSB12LV26 IEEE-1394 Controller (Link)
  e8007000-e8007fff : NEC Corporation USB
e8100000-e8107fff : Yamaha Corporation YMF-724
  e8100000-e8107fff : ymfpci
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x2

00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: e6000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:02.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:02.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:02.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e000 [size=32]

00:02.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0e.0 PCI bridge: Hint Corp: Unknown device 0021 (rev 13) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 02
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e8000000-e80fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [90] #06 [0000]
	Capabilities: [a0] Vital Product Data

00:0f.0 Multimedia audio controller: Yamaha Corporation YMF-724 (rev 03)
	Subsystem: Yamaha Corporation YMF724-Based PCI Audio Adapter
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8100000 (32-bit, non-prefetchable) [size=32K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 11) (prog-if 00 [VGA])
	Subsystem: Creative Labs CT6892 RIVA TNT2 Value
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e6000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at e5000000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x2

02:08.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Adaptec: Unknown device 0235
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at e8007000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Adaptec: Unknown device 0235
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin B routed to IRQ 9
	Region 0: Memory at e8004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.2 USB Controller: NEC Corporation: Unknown device 00e0 (rev 01) (prog-if 20)
	Subsystem: Adaptec: Unknown device 02e0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8500ns max), cache line size 08
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at e8005000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0b.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020 (prog-if 10 [OHCI])
	Subsystem: Texas Instruments: Unknown device 8010
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8006000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATAPI    Model: CD-ROM 36X       Rev: T6A3
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1210A Rev: 1.02
  Type:   CD-ROM                           ANSI SCSI revision: 02


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

/proc/ide/hdc/driver

ide-scsi version 0.9

[X.] Other notes, patches, fixes, workarounds:

   This seems completely reproducable on my system.  I don't know if it is
related to the contents of this individual CD or a more general problem, as
this is the only CD I have ever been foolish enough to place an ext2 fs
upon.  I can make the cd image available if necessary.

  Please CC further questions or responses to me, as I am not subscribed to
the list.  Thanks in advance!

  Jean-Paul Calderone

--
Seduced, shaggy Samson snored.
She scissored short.  Sorely shorn,
Soon shackled slave, Samson sighed,
Silently scheming,
Sightlessly seeking
Some savage, spectacular suicide.
                -- Stanislaw Lem, "Cyberiad"
--
 up 0:28, 7 users, load average: 0.09, 0.07, 0.09

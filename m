Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275601AbTHOA6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 20:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275607AbTHOA6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 20:58:19 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:16000
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S275601AbTHOA6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 20:58:01 -0400
Date: Thu, 14 Aug 2003 20:57:24 -0500 (CDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: oops during make install
Message-ID: <Pine.LNX.4.44.0308142049070.15038-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got the following while doing make install from the latest bk pull.

  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
  OBJCOPY arch/i386/boot/compressed/vmlinux.bin
  GZIP    arch/i386/boot/compressed/vmlinux.bin.gz
  LD      arch/i386/boot/compressed/piggy.o
  LD      arch/i386/boot/compressed/vmlinux
  OBJCOPY arch/i386/boot/vmlinux.bin
  BUILD   arch/i386/boot/bzImage
Root device is (3, 8)
Boot sector 512 bytes.
Setup is 4847 bytes.
System is 1117 kB
Kernel: arch/i386/boot/bzImage is ready
sh arch/i386/boot/install.sh 2.6.0-test3-0814 arch/i386/boot/bzImage 
System.map ""
Unable to handle kernel paging request at virtual address d6990188
 printing eip:
c01456ea
*pde = 00059067
*pte = 16990000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01456ea>]    Not tainted
EFLAGS: 00010246
EIP is at __filemap_fdatawrite+0x7a/0x1e0
eax: d6990180   ebx: 00000000   ecx: df975978   edx: 00000001
esi: c64fb0c0   edi: df975960   ebp: c496ff00   esp: c496fe98
ds: 007b   es: 007b   ss: 0068
Process losetup (pid: 15028, threadinfo=c496e000 task=d5e85000)
Stack: 00000000 d6990030 0000007b 00000fc8 c496feb4 00000086 00000000 
00000000
       00000001 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
       00000001 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
Call Trace:
 [<c0145869>] filemap_fdatawrite+0x19/0x20
 [<c016eef6>] sync_blockdev+0x26/0x50
 [<c017933d>] blkdev_put+0x16d/0x180
 [<c016e30b>] __fput+0xeb/0x100
 [<c016c6fb>] filp_close+0x4b/0x80
 [<c016c81d>] sys_close+0xed/0x1f0
 [<c0109f4f>] syscall_call+0x7/0xb

Code: 8b 40 08 85 c0 74 0f 31 c0 83 c4 5c 5b 5e 5f c9 c3 90 8d 74
 /sbin/mkinitrd: line 606: 15028 Segmentation fault      losetup -d $LODEV

[root@dad root]# cat /proc/version
Linux version 2.6.0-test2-0808 (tmolina@dad) (gcc version 3.2 20020903 
(Red Hat Linux 8.0 3.2-7)) #1 Fri Aug 8 18:02:46 CDT 2003

[tmolina@dad linux-2.5-tm]$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux dad 2.6.0-test2-0808 #1 Fri Aug 8 18:02:46 CDT 2003 i686 athlon i386 
GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
nfs-utils              1.0.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         loop snd_pcm_oss snd_mixer_oss snd_ymfpci 
snd_ac97_codec snd_pcm snd_opl3_lib snd_timer snd_hwdep snd_page_alloc 
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore parport_pc lp 
parport af_packet iptable_filter ip_tables hid uhci_hcd usbcore rtc unix

[root@dad root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1343.306
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2637.82

[root@dad root]# cat /proc/modules
loop 19336 1 - Live 0xe1154000
snd_pcm_oss 64580 0 - Live 0xe113d000
snd_mixer_oss 22336 1 snd_pcm_oss, Live 0xe1172000
snd_ymfpci 74880 0 - Live 0xe11ac000
snd_ac97_codec 59396 1 snd_ymfpci, Live 0xe1112000
snd_pcm 126144 2 snd_pcm_oss,snd_ymfpci, Live 0xe10f2000
snd_opl3_lib 15104 1 snd_ymfpci, Live 0xe10ed000
snd_timer 36416 2 snd_pcm,snd_opl3_lib, Live 0xe112a000
snd_hwdep 10688 1 snd_opl3_lib, Live 0xe10ce000
snd_page_alloc 12804 2 snd_ymfpci,snd_pcm, Live 0xe10df000
snd_mpu401_uart 11520 1 snd_ymfpci, Live 0xe10ca000
snd_rawmidi 32256 1 snd_mpu401_uart, Live 0xe10d6000
snd_seq_device 9476 2 snd_opl3_lib,snd_rawmidi, Live 0xe10c6000
snd 67652 11 
snd_pcm_oss,snd_mixer_oss,snd_ymfpci,snd_ac97_codec,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device, 
Live 0xe10b4000
soundcore 10496 1 snd, Live 0xe10b0000
parport_pc 24432 1 - Live 0xe10a9000
lp 10528 0 - Live 0xe10d2000
parport 34816 2 parport_pc,lp, Live 0xe109f000
af_packet 29124 2 - Live 0xe10e4000
iptable_filter 2880 0 - Live 0xe1092000
ip_tables 17872 1 iptable_filter, Live 0xe108c000
hid 27520 0 - Live 0xe103c000
uhci_hcd 43016 0 - Live 0xe1030000
usbcore 125204 4 hid,uhci_hcd, Live 0xe1010000
rtc 21720 0 - Live 0xe1045000
unix 30028 24 - Live 0xe1094000

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
6800-683f : Promise Technology,  20265
7000-7003 : Promise Technology,  20265
7400-7407 : Promise Technology,  20265
7800-7803 : Promise Technology,  20265
8000-8007 : Promise Technology,  20265
8400-843f : Intel Corp. 82557/8/9 [Ethernet 
  8400-843f : e100
8800-8803 : Yamaha Corporation YMF-754 [DS-1E Audio
9000-903f : Yamaha Corporation YMF-754 [DS-1E Audio
  9000-9003 : YMFPCI OPL3
  9020-9021 : YMFPCI MPU401
9400-94ff : Ambient Technologies HaM plus Data Fax Mo (#2)
b000-b01f : VIA Technologies, In USB (#2)
  b000-b01f : uhci-hcd
b400-b41f : VIA Technologies, In USB
  b400-b41f : uhci-hcd
b800-b80f : VIA Technologies, In VT82C586/B/686A/B PI
  b800-b807 : ide0
  b808-b80f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2
e200-e27f : VIA Technologies, In VT82C686 [Apollo Sup
e800-e80f : VIA Technologies, In VT82C686 [Apollo Sup

[root@dad root]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c8000-000c8fff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffebfff : System RAM
  00100000-002cb41b : Kernel code
  002cb41c-0036217f : Kernel data
1ffec000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
e0000000-e001ffff : Promise Technology,  20265
e0800000-e08fffff : Intel Corp. 82557/8/9 [Ethernet
  e0800000-e08fffff : e100
e1000000-e1000fff : Intel Corp. 82557/8/9 [Ethernet
  e1000000-e1000fff : e100
e1800000-e1807fff : Yamaha Corporation YMF-754 [DS-1E Audio
  e1800000-e1807fff : YMFPCI
e2000000-e2000fff : Ambient Technologies HaM plus Data Fax Mo (#2)
e2800000-e4dfffff : PCI Bus #01
  e2800000-e2800fff : ATI Technologies Inc 3D Rage Pro AGP 1X/2
  e3000000-e3ffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2
    e3000000-e37fffff : vesafb
e5000000-e50fffff : Ambient Technologies HaM plus Data Fax Mo
e5f00000-e5ffffff : PCI Bus #01
e6000000-e7ffffff : VIA Technologies, In VT8363/8365 [KT133/K
ffff0000-ffffffff : reserved

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e6000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e2800000-e4dfffff
	Prefetchable memory behind bridge: e5f00000-e5ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at b800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 3
	Region 4: I/O ports at b400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 3
	Region 4: I/O ports at b000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Network controller: Ambient Technologies Inc: Unknown device 4100 (rev 01)
	Subsystem: Unknown device 16ef:8a00
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at e5000000 (64-bit, prefetchable) [disabled] [size=1M]
	Capabilities: [e0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=375mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Communication controller: Ambient Technologies Inc: Unknown device 4100 (rev 01)
	Subsystem: Unknown device 16ef:8a00
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at e2000000 (64-bit, non-prefetchable) [disabled] [size=4K]
	Region 2: I/O ports at 9400 [disabled] [size=256]
	Capabilities: [e0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=320mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E Audio Controller]
	Subsystem: Yamaha Corporation DS-XG PCI Audio Codec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (1250ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e1800000 (32-bit, non-prefetchable) [size=32K]
	Region 1: I/O ports at 9000 [size=64]
	Region 2: I/O ports at 8800 [size=4]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at e1000000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 8400 [size=64]
	Region 2: Memory at e0800000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
	Subsystem: Promise Technology, Inc. Ultra100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 8000 [size=8]
	Region 1: I/O ports at 7800 [size=4]
	Region 2: I/O ports at 7400 [size=8]
	Region 3: I/O ports at 7000 [size=4]
	Region 4: I/O ports at 6800 [size=64]
	Region 5: Memory at e0000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 5c) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage Pro Turbo AGP 2X
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Region 0: Memory at e3000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at e2800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at e5fe0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>



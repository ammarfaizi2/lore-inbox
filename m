Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264752AbRF1WPV>; Thu, 28 Jun 2001 18:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbRF1WPL>; Thu, 28 Jun 2001 18:15:11 -0400
Received: from superglide.netfx-2000.net ([216.179.176.9]:55054 "EHLO
	superglide.netfx-2000.net") by vger.kernel.org with ESMTP
	id <S264709AbRF1WPA>; Thu, 28 Jun 2001 18:15:00 -0400
Date: Thu, 28 Jun 2001 15:14:58 -0700
Message-Id: <200106282214.f5SMEw107141@superglide.netfx-2000.net>
Content-Type: text/plain
Content-Disposition: inline
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel bug at page_alloc.c:81
From: khan_55@linuxfreemail.com
Reply-To: khan_55@linuxfreemail.com
X-Mailer: mailgate
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1	After a 'shutdown -h now', I get a kernel bug at page_alloc.c:81
2	After being in X (only happens after being in X), I get out of X, and as root I do a 'shutdown -h now'.  It goes through the shutdown process normally, and then after it prints "Syncing hardware clock to system time [ OK ]", I get:

Turning off swap:  kernel BUG at page_alloc.c:81!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c012a38f>]
EFLAGS: 00010286
eax: 0000001f ebx:00000000 ecx: 0000001 edx: c026e0c8
esi: c1159dd4 edi: 00000000 ebp: 00000000 esp:c5e6bf3c
ds:0018 es:0018 ss:0018
Process swapoff (pid:11402,stackpage=c5e6b000
Stack:	c0227f86 c022801a 00000051 00000000 c1159dd4 c1159dd4 c012884c c1159dd4
	0000000 c1159dd4 0007d100 000007d1 c012b899 c1159dd4 c02d1180 ffffffff
	c02d1180 000065ef ffffffea c012ba93 00000000 c7ecb420 c1256ec0 c4051d3c
Call Trace: [<c012884c>] [<c012b899>] [<c012ba93>] [<c0106c47>]
Code: 0f 0b 83 c4 0c 8b 46 18 83 e0 20 74 16 6a 53 68 1a 80 22 c0
/etc/rc0.d/S01halt: line 4: 11402 Segmentation fault $*

After that, it does the rest of the shutdown process normally.
3	kernel
4	/proc/version:  Linux version 2.4.5 (root@p450) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #1 Mon Jun 25 15:27:28 CDT 2001
5	no oops
6	no script
7	I am using a Pentium II 450Mhz box with 128mb of ram and 128mb of swap.  I have a Intel 440BX AGPset motherboard.  Turtle Beach sound with Aureal chipset, nVIDIA GeForce 256 DDR video (AGP).  3c905b NIC.  I think all the cards are PCI, modem might be ISA.  Hard drives are IDE.
7.1	ver_linux output:
Linux p450 2.4.5 #1 Mon Jun 25 15:27:28 CDT 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10s
mount                  2.10r
modutils               2.4.2
e2fsprogs              1.19
PPP                    2.4.1
Linux C Library        > libc.2.2
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ipt_state ipt_limit iptable_filter ipt_LOG ipt_MASQUERADE ipt_REDIRECT iptable_nat ip_conntrack ip_tables ppp_deflate au8820 ppp_async ppp_generic slhc NVdriver

7.2	/proc/cpuinfo:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 448.069
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
bogomips	: 894.56
7.3	/proc/modules:
ipt_state                864   3 (autoclean)
ipt_limit               1136  33 (autoclean)
iptable_filter          1952   0 (autoclean) (unused)
ipt_LOG                 3568   1
ipt_MASQUERADE          1392   1
ipt_REDIRECT             992   0 (unused)
iptable_nat            14800   0 [ipt_MASQUERADE ipt_REDIRECT]
ip_conntrack           13760   2 [ipt_state ipt_MASQUERADE ipt_REDIRECT iptable_nat]
ip_tables              10688   9 [ipt_state ipt_limit iptable_filter ipt_LOG ipt_MASQUERADE ipt_REDIRECT iptable_nat]
ppp_deflate            41120   1 (autoclean)
au8820                115856   2
ppp_async               6288   1
ppp_generic            13232   3 [ppp_deflate ppp_async]
slhc                    4896   1 [ppp_generic]
NVdriver              659072  15
7.4	/proc/ioports:
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
0213-0213 : isapnp read
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0778-077a : parport0
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
1000-107f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  1000-107f : eth0
1080-109f : Intel Corporation 82371AB PIIX4 USB
  1080-109f : usb-uhci
10a0-10af : Intel Corporation 82371AB PIIX4 IDE
  10a0-10a7 : ide0
  10a8-10af : ide1
10b0-10b7 : Aureal Semiconductor Vortex 1
10b8-10bf : Aureal Semiconductor Vortex 1
7000-701f : Intel Corporation 82371AB PIIX4 ACPI
8000-803f : Intel Corporation 82371AB PIIX4 ACPI
	/proc/iomem:
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-040fdbff : System RAM
  00100000-0021fc83 : Kernel code
  0021fc84-00281ff7 : Kernel data
040fdc00-040ff7ff : ACPI Tables
040ff800-040ffbff : ACPI Non-volatile Storage
040ffc00-07ffffff : System RAM
e8000000-e801ffff : Aureal Semiconductor Vortex 1
e8020000-e8020fff : Zoran Corporation ZR36120
e8021000-e802107f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
e9000000-e9ffffff : PCI Bus #01
  e9000000-e9ffffff : nVidia Corporation GeForce 256 DDR
ec000000-efffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : nVidia Corporation GeForce 256 DDR
fffe7800-ffffffff : reserved
7.5	lspci -vvv:
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e9000000-e9ffffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 10a0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 1080 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0e.0 Multimedia video controller: Zoran Corporation ZR36120 (rev 03)
	Subsystem: quadrant international Cinemaster C DVD Decoder
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 4000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e8020000 (32-bit, non-prefetchable) [size=4K]

00:0f.0 Multimedia audio controller: Aureal Semiconductor Vortex 1 (rev 02)
	Subsystem: Voyetra Technologies Montego
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 3000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=128K]
	Region 1: I/O ports at 10b8 [size=8]
	Region 2: I/O ports at 10b0 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1000 [size=128]
	Region 1: Memory at e8021000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation GeForce 256 DDR (rev 10) (prog-if 00 [VGA])
	Subsystem: Guillemot Corporation: Unknown device 5021
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e9000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
7.6	no SCSI
7.7	My memory usage in 2.4.5 is much greater than in 2.2.19-7.0.1, which was my previous kernel.  I had no problems with that kernel.  Usually I could be in X and after several hours my memory usage would be around 90% of RAM used and around 30% or so swap used.  Now, after an hour and 8 minutes, my ram is around 95%+ used and swap is around 80% used.  I'd say in another hour I will get the swap filled completely.  Memory usage is also up when X is not running.
I've tried to make the bug happen on purpose, but it hasn't.  It has happened a few times before though.  It usually happens when root does a shutdown -r now, but it happened once with a regular user doing a 'halt'.  Below is all the memory related files I can guess at in /proc.  Thanks

uptime says: 11:23am  up  1:10,  4 users,  load average: 0.10, 0.09, 0.13

and /proc/mem says:
        total:    used:    free:  shared: buffers:  cached:
Mem:  129765376 126853120  2912256        0 35401728 53997568
Swap: 106885120 87973888 18911232
MemTotal:       126724 kB
MemFree:          2844 kB
MemShared:           0 kB
Buffers:         34572 kB
Cached:          52732 kB
Active:          67672 kB
Inact_dirty:     18372 kB
Inact_clean:      1260 kB
Inact_target:       32 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126724 kB
LowFree:          2844 kB
SwapTotal:      104380 kB
SwapFree:        18468 kB
/proc/swaps says:
Filename			Type		Size	Used	Priority
/dev/hda5                       partition	104380	85912	-1
vmstat says:
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0  85912   2856  32756  54488  12  17    78    33  440   523   6   3  91
Here's what the /proc/sys/vm/ files say:
bdflush:
30	64	64	256	500	3000	60	0	0
buffermem:
2	10	60
freepages:
352	704	1056
kswapd:
512	32	8
overcommit_memory:
0
page-cluster:
4
pagecache:
2	15	75
pagetable_cache:
25	50


Get your own FREE E-mail address at http://www.linuxfreemail.com
Linux FREE Mail is 100% FREE, 100% Linux, and 100% yours!

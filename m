Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132852AbRDQXWB>; Tue, 17 Apr 2001 19:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132807AbRDQXVw>; Tue, 17 Apr 2001 19:21:52 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:49160 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S132852AbRDQXVh>; Tue, 17 Apr 2001 19:21:37 -0400
Date: Wed, 18 Apr 2001 01:21:18 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Kernel oops in kmalloc (network?) - 2.4.3-ac7
Message-ID: <Pine.LNX.4.33.0104180059050.12372-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I just got an oops with 2.4.3-ac7:

[1.] Kernel oops'es and KDE hangs.
[2.] While compiling gcc, suddenly KDE hangs. I was able to change to a
console to investigate the problem. It appears that the dying process
was kwin as X and other parts of KDE still is responsive. The kernel
seems to run happily on after the oops.

[3.] Keywords: kmalloc, unix sockets, oops
[4.] Kernel version (from /proc/version):

Linux version 2.4.3-ac7 (root@grignard) (gcc version 2.95.3 20010315
(release)) #2 man apr 16 15:03:36 CEST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

ksymoops 2.3.7 on i586 2.4.3-ac7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3-ac7/ (default)
     -m /boot/System.map (specified)

Reading Oops report from the terminal
CPU:    0
EIP:    0010:[<c0124953>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 0000001b   ebx: c1227768   ecx: c01fcca0   edx: 000018ef
esi: c1a5a000   edi: 00001000   ebp: 00000246   esp: c4611e9c
ds: 0018   es: 0018   ss: 0018
Process kdeinit (pid: 10521, stackpage=c4611000)
Stack: c01d1c8f 000004dc c2d3f97c c024b020 00000007 00000002 00001000
c1a5a000
       c0193ac6 0000083c 00000007 c4b943e0 00000000 c4610000 c01932cc
00000800
       00000007 c4611f4c 000007e8 c4b940b4 c22fca9c c01c357f c4b943e0
000007e8
Call Trace: [<c0193ac6>] [<c01932cc>] [<c01c357f>] [<c0191234>]
[<c019143f>] [<c012cb1a>] [<c0106a63>]
Code: 0f 0b 83 c4 08 f6 43 11 04 74 55 b8 a5 c2 0f 17 87 46 00 3d

>>EIP; c0124953 <kmalloc+123/1c0>   <=====
Trace; c0193ac6 <alloc_skb+de/190>
Trace; c01932cc <sock_alloc_send_skb+68/f0>
Trace; c01c357f <unix_stream_sendmsg+10b/2ec>
Trace; c0191234 <sock_sendmsg+68/88>
Trace; c019143f <sock_write+a3/ac>
Trace; c012cb1a <sys_write+8e/c4>
Trace; c0106a63 <system_call+33/40>
Code;  c0124953 <kmalloc+123/1c0>
00000000 <_EIP>:
Code;  c0124953 <kmalloc+123/1c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0124955 <kmalloc+125/1c0>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c0124958 <kmalloc+128/1c0>
   5:   f6 43 11 04               testb  $0x4,0x11(%ebx)
Code;  c012495c <kmalloc+12c/1c0>
   9:   74 55                     je     60 <_EIP+0x60> c01249b3
<kmalloc+183/1c0>
Code;  c012495e <kmalloc+12e/1c0>
   b:   b8 a5 c2 0f 17            mov    $0x170fc2a5,%eax
Code;  c0124963 <kmalloc+133/1c0>
  10:   87 46 00                  xchg   %eax,0x0(%esi)
Code;  c0124966 <kmalloc+136/1c0>
  13:   3d 00 00 00 00            cmp    $0x0,%eax


[6.] A small shell script or example program which triggers the
     problem (if possible)

none.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux grignard 2.4.3-ac7 #2 man apr 16 15:03:36 CEST 2001 i586 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11a
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0j
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         nfsd lockd sunrpc autofs4 af_packet 3c59x ntfs
nls_iso8859-15 nls_cp865 vfat fat


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 9
model name      : AMD-K6(tm) 3D+ Processor
stepping        : 1
cpu MHz         : 451.035
cache size      : 256 KB
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
bogomips        : 897.84


[7.3.] Module information (from /proc/modules):

Module                  Size  Used by
es1370                 24400   0  (autoclean) (unused)
soundcore               3728   4  (autoclean) [es1370]
nfsd                   65872   8  (autoclean)
lockd                  50096   1  (autoclean) [nfsd]
sunrpc                 57696   1  (autoclean) [nfsd lockd]
autofs4                 9472   2  (autoclean)
af_packet              11136   1  (autoclean)
3c59x                  23776   1  (autoclean)
ntfs                   35984   1  (autoclean)
nls_iso8859-15          3392   3  (autoclean)
nls_cp865               4352   2  (autoclean)
vfat                    8656   2  (autoclean)
fat                    30048   0  (autoclean) [vfat]


[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

/proc/ioports:
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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
d000-d00f : VIA Technologies, Inc. Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
d800-d87f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  d800-d87f : eth0
dc00-dcff : Advanced System Products, Inc ABP940-U / ABP960-U
e000-e03f : Ensoniq ES1370 [AudioPCI]
  e000-e03f : es1370

/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cafff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-001c916e : Kernel code
  001c916f-002086d3 : Kernel data
e0000000-e3ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
e4000000-e5ffffff : PCI Bus #01
  e4000000-e4ffffff : NVidia / SGS Thomson (Joint Venture) Riva128
e6000000-e6ffffff : PCI Bus #01
  e6000000-e6ffffff : NVidia / SGS Thomson (Joint Venture) Riva128
e9000000-e90000ff : Advanced System Products, Inc ABP940-U / ABP960-U
e9001000-e900107f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev
04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: e6000000-e6ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO]
(rev 06)
        Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at d000 [size=16]

00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:08.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d800 [size=128]
        Region 1: Memory at e9001000 (32-bit, non-prefetchable)
[size=128]
        Expansion ROM at e7000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 SCSI storage controller: Advanced System Products, Inc ABP940-U
/ ABP960-U (rev 03)
        Subsystem: Advanced System Products, Inc ASC1300 SCSI Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [size=256]
        Region 1: Memory at e9000000 (32-bit, non-prefetchable)
[size=256]
        Expansion ROM at e8000000 [disabled] [size=64K]

00:0a.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
        Subsystem: Unknown device 4942:4c4c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at e000 [size=64]

01:00.0 VGA compatible controller: NVidia / SGS Thomson (Joint Venture)
Riva128 (rev 10) (prog-if 00 [VGA])
        Subsystem: Diamond Multimedia Systems Viper V330
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e4000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at e6000000 (32-bit, prefetchable) [size=16M]
        Expansion ROM at <unassigned> [disabled] [size=4M]
        Capabilities: [44] AGP version 1.0
                Status: RQ=4 SBA- 64bit- FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


[7.6.] SCSI information (from /proc/scsi/scsi)

none loaded. I have an advansys ABP940-U / ABP960-U (rev 03), with cd
and cd-r - but no drivers loaded during the oops.

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

/proc/interrupts:
           CPU0
  0:    1694968          XT-PIC  timer
  1:      76716          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       8811          XT-PIC  es1370
 11:     321453          XT-PIC  eth0
 12:     239542          XT-PIC  PS/2 Mouse
 14:     377596          XT-PIC  ide0
 15:      43092          XT-PIC  ide1
NMI:          0
ERR:          0

dmesg output:
Linux version 2.4.3-ac7 (root@grignard) (gcc version 2.95.3 20010315
(release)) #2 man apr 16 15:03:36 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux rw root=304
BOOT_FILE=/boot/vmlinuz
Initializing CPU#0
Detected 451.035 MHz processor.
Console: colour VGA+ 132x50
Calibrating delay loop... 897.84 BogoMIPS
Memory: 127032k/131072k available (804k kernel code, 3652k reserved,
253k data, 168k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb4d0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Disabled enhanced CPU to PCI posting #2
PCI: Using IRQ router VIA [1106/0596] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 84360kB/28120kB, 256 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c596a (rev 06) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD205AA, ATA DISK drive
hdd: QUANTUM FIREBALL_TM3200A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40079088 sectors (20520 MB) w/2048KiB Cache, CHS=2494/255/63,
UDMA(33)
hdd: 6281856 sectors (3216 MB) w/76KiB Cache, CHS=6232/16/63, DMA
Partition check:
 hda: hda1 hda2 < hda5 hda6 > hda3 hda4
 hdd: [PTBL] [779/128/63] hdd1 hdd2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 03:04) ...
reiserfs: replayed 58 transactions in 3 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem).
Freeing unused kernel memory: 168k freed
Adding Swap: 216836k swap-space (priority -1)
reiserfs: checking transaction log (device 16:42) ...
reiserfs: replayed 28 transactions in 9 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
MSDOS FS: Using codepage 865
MSDOS FS: IO charset iso8859-15
MSDOS FS: Using codepage 865
MSDOS FS: IO charset iso8859-15
NTFS version 010116
PCI: Found IRQ 11 for device 00:08.0
3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others.
http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd800,  00:10:5a:41:f0:16,
IRQ 11
  product code 5150 rev 00.12 date 09-14-98
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
eth0: scatter/gather enabled. h/w checksums enabled
eth0: using NWAY device table, not 8
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 16
0x378: readIntrThreshold is 16
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x4b
0x378: ECP settings irq=7 dma=3
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
es1370: version v0.37 time 14:58:33 Apr 16 2001
PCI: Found IRQ 5 for device 00:0a.0
es1370: found adapter at io 0xe000 irq 5
es1370: features: joystick off, line in, mic impedance 0
Trying to open MFT
Trying to open MFT
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 16
0x378: readIntrThreshold is 16
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x4b
0x378: ECP settings irq=7 dma=3
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
nfsd: terminating on signal 9
nfsd: terminating on signal 9
nfsd: terminating on signal 9
nfsd: terminating on signal 9
nfsd: terminating on signal 9
nfsd: terminating on signal 9
nfsd: terminating on signal 9
nfsd: terminating on signal 9
Undo loss 212.54.64.155/110 c2 l0 ss2/2 p0

Output from procinfo:
Linux 2.4.3-ac7 (root@grignard) (gcc 2.95.3 20010315 ) #2 man apr 16
15:03:36 CEST 2001 1CPU [grignard.amagerkollegiet.dk]

Memory:      Total        Used        Free      Shared     Buffers
Cached
Mem:        127200      124896        2304           0        4788
76552
Swap:       216836       36692      180144

Bootup: Tue Apr 17 20:07:29 2001    Load average: 1.52 1.65 1.45 3/110
14936

user  :       2:30:47.57  49.2%  page in :  2338056  disk 1:   164330r
248610w
nice  :       0:00:00.00   0.0%  page out:  4375288  disk 2:    10147r
34865w
system:       0:32:07.59  10.5%  swap in :    22373
idle  :       2:03:27.99  40.3%  swap out:    18848
uptime:       5:06:23.13         context :  8655961

irq  0:   1838315 timer                 irq 11:    336262 eth0
irq  1:     83323 keyboard              irq 12:    259790 PS/2 Mouse
irq  2:         0 cascade [4]           irq 14:    403889 ide0
irq  5:      8811 es1370                irq 15:     44963 ide1
irq  7:         4


[X.] Other notes, patches, fixes, workarounds:

not much more. I must admit, that I have a worn out CPU. I have a few
times had hard lockups (power-off + power-on), which did not happen with
another CPU (a K6-2). The lockups also occurs under other OS's, so I'm
pretty sure, it's a hw problem. No overclocking, apparently not a heat
problem (from teemp. meters) - just a worn out CPU. I have not had
oopses before (except for a few on kernel bugs).

I know my last statement could lead to the thought that it's not a
kernel problem. Perhaps it ain't - if so I apologize for bugging you
guys out there - but even though it might be a real kernel problem.

If you need more info, I'll readily give it away.

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] --------------------------------------
Is there anything else I can contribute?
The latitude and longtitude of the bios writers current position, and
a ballistic missile.
                                                          -- Alan Cox
--------------------------------- [ moffe at amagerkollegiet dot dk ] -0



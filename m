Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285745AbSAFWPL>; Sun, 6 Jan 2002 17:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285593AbSAFWOD>; Sun, 6 Jan 2002 17:14:03 -0500
Received: from avalon.student.liu.se ([130.236.230.76]:1223 "EHLO
	student.liu.se") by vger.kernel.org with ESMTP id <S282967AbSAFWNn>;
	Sun, 6 Jan 2002 17:13:43 -0500
Date: Sun, 06 Jan 2002 23:12:54 +0100
From: robho956@student.liu.se
Subject: System errors under heavy load and with kernels > 2.4.0-test3-pre5
To: linux-kernel@vger.kernel.org
Message-id: <2c42926890.268902c429@student.liu.se>
MIME-version: 1.0
X-Mailer: iPlanet Webmail
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7bit
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I've put together this bug report as well as I could. It got quite big
but I hope it at least includes enough information and isn't a duplicate
of something old.

Please CC any replies to me.

Any help would be appreciated.

/Robert

[1.] One line summary of the problem:

System errors under heavy load and with kernels > 2.4.0-test3-pre5


[2.] Full description of the problem/report:

I've found that when I put some load on my system I get segmentation
faults or kernel oops with the 2.4 kernels. The latest 2.2 kernels, most
of the 2.3 kernels and the 2.4 kernels up to and including
2.4.0-test3-pre5 are working nicely. All kernels above, including
2.4.16, seem bad. (I haven't tried every kernel. Only taken samples here
and there. > 20 kernels have been tested from the 2.2->2.4 series.)

The problems look alot like the ones described in the Sig11 FAQ. I've
tried to modify the BIOS settings, remove unnecessary hardware and
replace what I can of the remaining parts but the problems still occur.
What I haven't replaced is RAM, CPU and motherboard.

Since it appears suddenly in 2.4.0-test3-pre6 I now believe there is
something in the kernel that doesn't work well with my system. But I
know it could still be a hardware error.

Can I find the individual patches that were put into pre6 somewhere?


[3.] Keywords

kernel crash oops 2.4 heavy load


[4.] Kernel version

Linux version 2.4.0-test3 (root@a70) (gcc version 2.95.3 20010315
(release)) #2 Sat Jan 5 22:01:56 CET 2002

Actually 2.4.0-test3-pre6


[5.] Output of Oops..

ksymoops 2.4.3 on i586 2.4.0-test3.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux/System.map (default)

Unable to handle kernel paging request at virtual address 254f4034
c0124df0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0124df0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010083
eax: 97f3bfff   ebx: c1247cdc   ecx: c0e84080   edx: c5804020
esi: 00000246   edi: 00000003   ebp: 00000400   esp: c12bdca8
ds: 0018   es: 0018   ss: 0018
Process dd (pid: 108, stackpage=c12bd000)
Stack: c70040e0 00000000 c70040e0 c012b9cd c1247cdc 00000003 c70040e0
00000000
       c70040e0 c012badc 00000000 00000400 c119edd0 00001640 001cb61c
00000282
       00000000 c01e48ec c01265a3 00000400 00000400 c012d326 c119edd0
00000400
Call Trace: [<c012b9cd>] [<c012badc>] [<c01265a3>] [<c012d326>]
[<c012b449>] [<c012b63e>] [<c0130cbd>]
       [<c01800bd>] [<c0180210>] [<c016fdc7>] [<c01857a3>] [<c0181ce2>]
[<c018b01d>] [<c018b314>] [<c0195fac>]
       [<c017fc85>] [<c019d488>] [<c011b077>] [<c011b2c6>] [<c011ad42>]
[<c0118483>] [<c011b077>] [<c011b2c6>]
       [<c011ad42>] [<c0118483>] [<c01183d7>] [<c01182d2>] [<c0129b59>]
[<c0109514>]
Code: 8b 44 82 18 89 42 14 83 f8 ff 75 05 8b 02 89 43 08 56 9d 89

>>EIP; c0124df0 <kmem_cache_alloc+24/54>   <=====
Trace; c012b9cc <get_unused_buffer_head+38/c8>
Trace; c012badc <create_buffers+20/380>
Trace; c01265a2 <__alloc_pages+52/194>
Trace; c012d326 <grow_buffers+6e/124>
Trace; c012b448 <refill_freelist+8/2c>
Trace; c012b63e <getblk+86/90>
Trace; c0130cbc <block_read+298/4cc>
Trace; c01800bc <kfree_skbmem+24/6c>
Trace; c0180210 <__kfree_skb+10c/114>
Trace; c016fdc6 <el3_start_xmit+be/134>
Trace; c01857a2 <qdisc_restart+12/c8>
Trace; c0181ce2 <dev_queue_xmit+32/124>
Trace; c018b01c <ip_output+a4/d8>
Trace; c018b314 <ip_queue_xmit+2c4/3ac>
Trace; c0195fac <tcp_transmit_skb+40c/4c0>
Trace; c017fc84 <sock_def_readable+64/88>
Trace; c019d488 <udp_queue_rcv_skb+58/a0>
Trace; c011b076 <update_wall_time+a/3c>
Trace; c011b2c6 <timer_bh+92/258>
Trace; c011ad42 <tqueue_bh+42/4c>
Trace; c0118482 <bh_action+1a/5c>
Trace; c011b076 <update_wall_time+a/3c>
Trace; c011b2c6 <timer_bh+92/258>
Trace; c011ad42 <tqueue_bh+42/4c>
Trace; c0118482 <bh_action+1a/5c>
Trace; c01183d6 <tasklet_hi_action+36/60>
Trace; c01182d2 <do_softirq+52/78>   
Trace; c0129b58 <sys_read+c4/e4>
Trace; c0109514 <system_call+34/40>
Code;  c0124df0 <kmem_cache_alloc+24/54>
0000000000000000 <_EIP>:
Code;  c0124df0 <kmem_cache_alloc+24/54>   <=====
   0:   8b 44 82 18               mov    0x18(%edx,%eax,4),%eax   <=====
Code;  c0124df4 <kmem_cache_alloc+28/54>
   4:   89 42 14                  mov    %eax,0x14(%edx)
Code;  c0124df6 <kmem_cache_alloc+2a/54>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c0124dfa <kmem_cache_alloc+2e/54>  
   a:   75 05                     jne    11 <_EIP+0x11> c0124e00
<kmem_cache_alloc+34/54>
Code;  c0124dfc <kmem_cache_alloc+30/54> 
   c:   8b 02                     mov    (%edx),%eax
Code;  c0124dfe <kmem_cache_alloc+32/54>
   e:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  c0124e00 <kmem_cache_alloc+34/54>
  11:   56                        push   %esi
Code;  c0124e02 <kmem_cache_alloc+36/54>
  12:   9d                        popf
Code;  c0124e02 <kmem_cache_alloc+36/54>
  13:   89 00                     mov    %eax,(%eax)


[6.] A small shell script or example program which triggers the problem

while true; do dd if=/dev/hdc of=/dev/null; done

This would after a few minutes (sometimes an hour or more) cause the
second IDE controller to stop responding and the computer crashes
completely very easy.


[7.] Environment

Slackware 8.0


[7.1.] Software

Linux a70 2.4.0-test3 #2 Sat Jan 5 22:01:56 CET 2002 i586 unknown
Kernel modules 2.4.6
Gnu C 2.95.3
Binutils 2.11.90.0.19
Linux C Library 2.2.3
Dynamic linker ldd (GNU libc) 2.2.3
Procps 2.0.7
Mount 2.11b
Net-tools 1.60
Kbd 1.06
Sh-utils 2.0
Modules Loaded


[7.2.] Processor information (from /proc/cpuinfo):

processor : 0
vendor_id : AuthenticAMD
cpu family : 5
model : 8
model name : AMD-K6(tm) 3D processor
stepping : 12
cpu MHz : 501.148308
cache size : 64 KB
fdiv_bug : no
hlt_bug : no
sep_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 1
wp : yes
flags : fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow
bogomips : 999.42

Not overclocked. I even tried to lower the speed to 375 MHz, running 75
MHz bus speed.


[7.3.] Module information

None loaded.


[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

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
0300-030f : 3c509
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
6000-60ff : VIA Technologies, Inc. VT82C586B ACPI
e000-e00f : VIA Technologies, Inc. VT82C586 IDE [Apollo]
e000-e007 : ide0
e008-e00f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
00100000-001dff07 : Kernel code
001dff08-001f0e6b : Kernel data
07ff0000-07ff07ff : ACPI Non-volatile Storage
07ff0800-07ffffff : ACPI Tables
e0000000-e3ffffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
e4000000-e5ffffff : PCI Bus #01
e4000000-e4ffffff : nVidia Corporation Riva TnT2 Ultra [NV5]
e6000000-e7ffffff : PCI Bus #01
e6000000-e7ffffff : nVidia Corporation Riva TnT2 Ultra [NV5]
e8000000-e9ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
eb000000-eb000fff : Brooktree Corporation Bt878
eb001000-eb001fff : Brooktree Corporation Bt878
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

Is "!!! Invalid class 0604 for header type 00" for device 00:07.3 a bad
thing?

00:00.0 Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev
04)
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
Latency: 16
Region 0: Memory at e8000000 (32-bit, prefetchable) [size=32M]
Capabilities: [a0] AGP version 1.0
Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
(prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: e4000000-e5ffffff
Prefetchable memory behind bridge: e6000000-e7ffffff
BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
[Apollo VP] (rev 47)
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
Region 4: I/O ports at e000 [size=16]

00:07.3 PCI bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
(prog-if 00 [Normal decode])
!!! Invalid class 0604 for header type 00
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:08.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]
(rev 54) (prog-if 00 [VGA]) 
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Interrupt: pin A routed to IRQ 9
Region 0: Memory at e0000000 (32-bit, non-prefetchable)
[disabled] [size=64M]
Expansion ROM at ea000000 [disabled] [size=64K]

00:09.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
02)
Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
Latency: 64 (4000ns min, 10000ns max)
Interrupt: pin A routed to IRQ 9
Region 0: Memory at eb000000 (32-bit, prefetchable) [size=4K]

00:09.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
Latency: 64 (1000ns min, 63750ns max)
Interrupt: pin A routed to IRQ 9
Region 0: Memory at eb001000 (32-bit, prefetchable) [size=4K]

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT2 Ultra
[NV5] (rev 11) (prog-if 00 [VGA])
Subsystem: Asustek Computer, Inc. AGP-V3800 Deluxe
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 64 (1250ns min, 250ns max)
Interrupt: pin A routed to IRQ 9
Region 0: Memory at e4000000 (32-bit, non-prefetchable)
[size=16M]
Region 1: Memory at e6000000 (32-bit, prefetchable) [size=32M]
Expansion ROM at e5000000 [disabled] [size=64K]
Capabilities: [60] Power Management version 1 
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [44] AGP version 2.0
Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


[7.7.] Other information that might be relevant to the problem

The motherboard is a FIC VA-503+ with the MVP3 chipset.

The problems disappear if I disable the secondary cache, but I guess
that is because the stress on the system decreases and not because it's
faulty.

dmesg
~~~~~
Linux version 2.4.0-test3 (root@a70) (gcc version 2.95.3 20010315
(release)) #2 Sat Jan 5 22:01:56 CET 2002
BIOS-provided physical RAM map:
 e820: 000000000009fc00 @ 0000000000000000 (usable)
 e820: 0000000000000400 @ 000000000009fc00 (reserved)
 e820: 0000000000010000 @ 00000000000f0000 (reserved)
 e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 e820: 0000000007ef0000 @ 0000000000100000 (usable)
 e820: 000000000000f800 @ 0000000007ff0800 (ACPI data)
 e820: 0000000000000800 @ 0000000007ff0000 (ACPI NVS)
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=24026 ro root=341
Initializing CPU#0
Detected 501148308 Hz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 127012k/131008k available (895k kernel code, 3608k reserved, 67k
data, 164k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: L1 I Cache: 32K L1 D Cache: 32K (32 bytes/line)
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: 00:07.3: class 604 doesn't match header type 00. Ignoring class.
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.3 
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Starting kswapd v1.6
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VT 82C597 Apollo VP3
 Chipset Core ATA-33
Split FIFO Configuration:  8 Primary buffers, threshold = 1/2
                           8 Second. buffers, threshold = 1/2
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
ide0: VIA Bus-Master (U)DMA Timing Config Success
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
ide1: VIA Bus-Master (U)DMA Timing Config Success
hda: QUANTUM FIREBALL SE4.3A, ATA DISK drive
hdb: QUANTUM FIREBALL ST6.4A, ATA DISK drive
hdc: IBM-DJNA-352030, ATA DISK drive
hdd: ST360021A, ATA DISK drive  
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 8418816 sectors (4310 MB) w/80KiB Cache, CHS=524/255/63, UDMA(33)
hdb: 12594960 sectors (6449 MB) w/81KiB Cache, CHS=784/255/63, UDMA(33)
hdc: 39876480 sectors (20417 MB) w/1966KiB Cache, CHS=39560/16/63,
UDMA(33)
hdd: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63,
UDMA(33)
Partition check:
 hda: hda1
 hdb: hdb1 hdb2
 hdc: [PTBL] [2482/255/63] hdc1
 hdd: hdd1 hdd2
FDC 0 is a post-1991 82077
eth0: 3c509 at 0x300, 10baseT port, address  00 a0 24 42 e3 1c, IRQ 10.
3c509.c:1.16 (2.2) 2/3/98 becker@cesdis.gsfc.nasa.gov.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 164k freed
Adding Swap: 205088k swap-space (priority -1)   
eth0: Setting Rx mode to 1 addresses.

.config
~~~~~~~
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y

CONFIG_MK6=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_BYTES=32
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y 
CONFIG_NOHIGHMEM=y

CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y

CONFIG_BLK_DEV_FD=y

CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SKB_LARGE=y 

CONFIG_IDE=y

CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

CONFIG_NETDEVICES=y

CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL3=y

CONFIG_VT=y
CONFIG_VT_CONSOLE=y

CONFIG_MOUSE=y
CONFIG_PSMOUSE=y 

CONFIG_PROC_FS=y
CONFIG_EXT2_FS=y

CONFIG_MSDOS_PARTITION=y

CONFIG_VGA_CONSOLE=y


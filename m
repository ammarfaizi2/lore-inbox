Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132598AbRDEKJ4>; Thu, 5 Apr 2001 06:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132601AbRDEKJr>; Thu, 5 Apr 2001 06:09:47 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:33554 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S132598AbRDEKJc>; Thu, 5 Apr 2001 06:09:32 -0400
Date: Thu, 5 Apr 2001 12:08:45 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Divide error 2.4.3
Message-ID: <Pine.LNX.4.33.0104051145160.1343-100000@7812-grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This morning I tried to restart networking on our server. However,
networking did not come up again. It showed out, that ifconfig had
triggered an oops. The box is running vanilla 2.4.3 with reiserfs 3.6.x
fs format.

The box is running iptables and squid - and not more than this. It has
got a via rhine based NIC (D-link DFE-530TX), eth0, and a Wisecom
(RTL8139too) card, eth1. eth1 has proxy arp enabled.

I have included what I think is necessary - don't hope, I have forgotten
anything.

Rasmus

moffe@wiibroe:~# ksymoops -m /boot/System.map < /tmp/oops.txt
ksymoops 2.3.4 on i586 2.4.3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3/ (default)
     -m /boot/System.map (specified)

CPU:    0
EIP:    0010:[kfree+69/188]
EFLAGS: 00010046
eax: 0b7ce4e0   ebx: c116a840   ecx: c020f360   edx: 00000000
esi: 0b7ce4e0   edi: 00000286   ebp: 00000000   esp: cf389e08
ds: 0018   es: 0018   ss: 0018
Process ifconfig (pid: 25860, stackpage=cf389000)
Stack: cc2275c0 00000000 cc22761c 00000000 00000282 000c9e80 c019a14b
cc9e8000
       00000000 c019a2ca cc2275c0 cc2275c0 cc2275c0 c01d4974 cc2275c0
cc2275c0
       c0215de0 00000001 00000049 c01a0500 c15f5040 cc2275c0 00000000
00000001
Call Trace: [kfree_skbmem+35/108] [__kfree_skb+310/316]
[netlink_broadcast+504/512] [rtmsg_ifinfo+108/116]
Code: f7 73 0c 89 c5 8b 41 14 89 44 a9 18 89 69 14 8b 53 14 8b 41
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f7 73 0c                  div    0xc(%ebx),%eax
Code;  00000003 Before first symbol
   3:   89 c5                     mov    %eax,%ebp
Code;  00000005 Before first symbol
   5:   8b 41 14                  mov    0x14(%ecx),%eax
Code;  00000008 Before first symbol
   8:   89 44 a9 18               mov    %eax,0x18(%ecx,%ebp,4)
Code;  0000000c Before first symbol
   c:   89 69 14                  mov    %ebp,0x14(%ecx)
Code;  0000000f Before first symbol
   f:   8b 53 14                  mov    0x14(%ebx),%edx
Code;  00000012 Before first symbol
  12:   8b 41 00                  mov    0x0(%ecx),%eax

moffe@wiibroe:~# cat /var/log/dmesg
Linux version 2.4.3 (root@wiibroe) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #2 fre mar 30 10:20:16 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux rw root=306
BOOT_FILE=/boot/vmlinuz
Initializing CPU#0
Detected 299.752 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 598.01 BogoMIPS
Memory: 255876k/262144k available (866k kernel code, 5880k reserved,
262k data, 172k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
Enabling new style K6 write allocation for 256 Mb
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb120, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Disabled enhanced CPU to PCI posting #2
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 170026kB/56675kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG VG34323A (4.32GB), ATA DISK drive
hdc: IBM-DTLA-307030, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 8446032 sectors (4324 MB) w/496KiB Cache, CHS=525/255/63, UDMA(33)
hdc: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63,
UDMA(33)
Partition check:
 hda: hda1 hda2 < hda5 hda6 >
 hdc: hdc1
NET4: Frame Diverter 0.46
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
ip_conntrack (2048 buckets, 16384 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 03:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem).
Freeing unused kernel memory: 172k freed
Adding Swap: 530104k swap-space (priority -1)
reiserfs: checking transaction log (device 16:01) ...
attempt to access beyond end of device
16:01: rw=0, want=0, limit=30018208
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat
data of [1 2 0x0 SD]
Using r5 hash to sort names
ReiserFS version 3.6.25

root@wiibroe:/home/moffe# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev
04)
        Flags: bus master, medium devsel, latency 64
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: e6000000-e6ffffff

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
[Apollo VP] (rev 41)
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at e000 [size=16]

00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
        Flags: medium devsel

00:09.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine
10/100] (rev 06)
        Subsystem: D-Link System Inc DFE-530TX
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at e800 [size=128]
        Memory at e8000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at e7000000 [disabled] [size=64K]

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 64, IRQ 12
        I/O ports at ec00 [size=256]
        Memory at e8001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP
(rev 3a) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0084
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 11
        Memory at e6000000 (32-bit, prefetchable) [size=16M]
        I/O ports at d000 [size=256]
        Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1

root@wiibroe:/home/moffe# cat /proc/ioports
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
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
d000-dfff : PCI Bus #01
  d000-d0ff : ATI Technologies Inc 3D Rage IIC AGP
e000-e00f : VIA Technologies, Inc. Bus Master IDE
  e000-e007 : ide0
  e008-e00f : ide1
e800-e87f : VIA Technologies, Inc. VT86C100A [Rhine 10/100]
  e800-e87f : via-rhine
ec00-ecff : Realtek Semiconductor Co., Ltd. RTL-8139
  ec00-ecff : 8139too

root@wiibroe:/home/moffe# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-001d8a09 : Kernel code
  001d8a0a-0021a3cf : Kernel data
e0000000-e3ffffff : VIA Technologies, Inc. VT82C598 [Apollo MVP3]
e4000000-e5ffffff : PCI Bus #01
  e5000000-e5000fff : ATI Technologies Inc 3D Rage IIC AGP
e6000000-e6ffffff : PCI Bus #01
  e6000000-e6ffffff : ATI Technologies Inc 3D Rage IIC AGP
e8000000-e800007f : VIA Technologies, Inc. VT86C100A [Rhine 10/100]
  e8000000-e800007f : via-rhine
e8001000-e80010ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e8001000-e80010ff : 8139too
ffff0000-ffffffff : reserved

root@wiibroe:/tmp# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 299.752
cache size      : 64 KB
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
bogomips        : 598.01

root@wiibroe:/tmp# cat /proc/interrupts
           CPU0
  0:     243740          XT-PIC  timer
  1:        450          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
 10:     672340          XT-PIC  eth0
 12:     166836          XT-PIC  eth1
 14:      11231          XT-PIC  ide0
 15:    1690447          XT-PIC  ide1
NMI:          0
ERR:          0

root@wiibroe:/tmp# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:50:BA:C2:04:A3
          inet addr:194.182.238.2  Bcast:194.182.238.31
Mask:255.255.255.224
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:344900 errors:0 dropped:0 overruns:0 frame:0
          TX packets:393118 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:10 Base address:0xe800

eth0:0    Link encap:Ethernet  HWaddr 00:50:BA:C2:04:A3
          inet addr:172.16.0.2  Bcast:172.31.255.255  Mask:255.240.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:10 Base address:0xe800

eth1      Link encap:Ethernet  HWaddr 00:40:95:30:0D:9C
          inet addr:194.182.238.2  Bcast:194.182.238.31
Mask:255.255.255.224
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:96428 errors:0 dropped:0 overruns:0 frame:0
          TX packets:86360 errors:0 dropped:0 overruns:0 carrier:0
          collisions:29 txqueuelen:100
          Interrupt:12 Base address:0x7000

eth1:0    Link encap:Ethernet  HWaddr 00:40:95:30:0D:9C
          inet addr:172.16.0.2  Bcast:172.31.255.255  Mask:255.240.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:12 Base address:0x7000

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16144  Metric:1
          RX packets:92 errors:0 dropped:0 overruns:0 frame:0
          TX packets:92 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

root@wiibroe:/tmp# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use
Iface
172.16.0.1      0.0.0.0         255.255.255.255 UH    0      0        0
eth1
194.182.238.1   0.0.0.0         255.255.255.255 UH    0      0        0
eth1
194.182.238.0   0.0.0.0         255.255.255.224 U     0      0        0
eth0
194.182.238.0   0.0.0.0         255.255.255.224 U     0      0        0
eth1
172.16.0.0      0.0.0.0         255.240.0.0     U     0      0        0
eth0
172.16.0.0      0.0.0.0         255.240.0.0     U     0      0        0
eth1
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0
lo
0.0.0.0         194.182.238.1   0.0.0.0         UG    0      0        0
eth1

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] --------------------------------------
To alcohol!
The cause of - and solution to - all of life's problems!
                                        -- Homer Simpson
--------------------------------- [ moffe at amagerkollegiet dot dk ] -



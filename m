Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267040AbRGIL4h>; Mon, 9 Jul 2001 07:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267041AbRGIL4S>; Mon, 9 Jul 2001 07:56:18 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:44039 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S267040AbRGIL4P>; Mon, 9 Jul 2001 07:56:15 -0400
To: linux-kernel@vger.kernel.org
Subject: [OOPS] network related crash with Linux 2.4
From: Moritz Schulte <moritz@chaosdorf.de>
Date: 09 Jul 2001 13:51:17 +0200
Message-ID: <87d77ae2x6.fsf@gryffindor.sc>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I often see my Gateway (Cx486DX4 CPU, 14364K RAM, 124956K Swap)
running Linux 2.4.[56] crashing (should I test previous
versions?). These crashes seem related to networking, because they
happen when trying to access some hosts. Now, the system crashes
(reproducible) when attempting a TCP connection to wwwkeys.eu.pgp.net
from a masqueraded System (running Linux 2.2.19) - it doesn't crash
when trying to connect from the Gateway itself. After such a crash,
the system seems really dead; I've to fetch the Oops via a serial
line.

Here's the decoded Oops from clean Linux 2.4.6:

--------------------------------
Unable to handle kernel paging request at virtual address 0100e018
c01268a2
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01268a2>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 0100e000   ebx: 00000000   ecx: 0100e000   edx: 00000000
esi: c068c470   edi: c0ce7a70   ebp: 00000050   esp: c021dde0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c021d000)
Stack: c0191ebd 00000100 c068c470 c01924a3 c068c470 c068c470 c008c800 c06550b0
       c008c800 fffffffa c0194f3d c068c470 00000020 c0df9770 c068c470 c06550b0
       c01983dd c068c470 c068c470 00000000 00000004 c01a2d60 c01a2ded c068c470
Call Trace: [<c0191ebd>] [<c01924a3>] [<c0194f3d>] [<c01983dd>] [<c01a2d60>] [<c01a2ded>] [<c019a6c7>]
       [<c01a0400>] [<c01a2d32>] [<c01a2d60>] [<c01a044a>] [<c019a6c7>] [<c01905dc>] [<c01a03a4>] [<c01a0400>]
       [<c019f630>] [<c019f7b9>] [<c019f630>] [<c019a6c7>] [<c019f476>] [<c019f630>] [<c019553d>] [<c011416f>]
       [<c010807d>] [<c0105140>] [<c0106c40>] [<c0105140>] [<c0105163>] [<c01051c8>] [<c0105000>]
Code: 8b 41 18 85 c0 7c 11 ff 49 14 0f 94 c0 84 c0 74 07 89 c8 e8

>>EIP; c01268a2 <__free_pages+2/20>   <=====
Trace; c0191ebd <skb_release_data+3d/70>
Trace; c01924a3 <skb_linearize+d3/140>
Trace; c0194f3d <dev_queue_xmit+6d/240>
Trace; c01983dd <neigh_resolve_output+13d/1b0>
Trace; c01a2d60 <ip_finish_output2+0/d0>
Trace; c01a2ded <ip_finish_output2+8d/d0>
Trace; c019a6c7 <nf_hook_slow+e7/140>
Trace; c01a0400 <ip_forward_finish+0/50>
Trace; c01a2d32 <ip_finish_output+f2/100>
Trace; c01a2d60 <ip_finish_output2+0/d0>
Trace; c01a044a <ip_forward_finish+4a/50>
Trace; c019a6c7 <nf_hook_slow+e7/140>
Trace; c01905dc <sys_socketcall+1c/210>
Trace; c01a03a4 <ip_forward+1a4/200>
Trace; c01a0400 <ip_forward_finish+0/50>
Trace; c019f630 <ip_rcv_finish+0/1c0>
Trace; c019f7b9 <ip_rcv_finish+189/1c0>
Trace; c019f630 <ip_rcv_finish+0/1c0>
Trace; c019a6c7 <nf_hook_slow+e7/140>
Trace; c019f476 <ip_rcv+336/370>
Trace; c019f630 <ip_rcv_finish+0/1c0>
Trace; c019553d <net_rx_action+13d/220>
Trace; c011416f <do_softirq+3f/70>
Trace; c010807d <do_IRQ+9d/b0>
Trace; c0105140 <default_idle+0/30>
Trace; c0106c40 <ret_from_intr+0/7>
Trace; c0105140 <default_idle+0/30>
Trace; c0105163 <default_idle+23/30>
Trace; c01051c8 <cpu_idle+38/50>
Trace; c0105000 <_stext+0/0>
Code;  c01268a2 <__free_pages+2/20>
00000000 <_EIP>:
Code;  c01268a2 <__free_pages+2/20>   <=====
   0:   8b 41 18                  mov    0x18(%ecx),%eax   <=====
Code;  c01268a5 <__free_pages+5/20>
   3:   85 c0                     test   %eax,%eax
Code;  c01268a7 <__free_pages+7/20>
   5:   7c 11                     jl     18 <_EIP+0x18> c01268ba <__free_pages+1a/20>
Code;  c01268a9 <__free_pages+9/20>
   7:   ff 49 14                  decl   0x14(%ecx)
Code;  c01268ac <__free_pages+c/20>
   a:   0f 94 c0                  sete   %al
Code;  c01268af <__free_pages+f/20>
   d:   84 c0                     test   %al,%al
Code;  c01268b1 <__free_pages+11/20>
   f:   74 07                     je     18 <_EIP+0x18> c01268ba <__free_pages+1a/20>
Code;  c01268b3 <__free_pages+13/20>
  11:   89 c8                     mov    %ecx,%eax
Code;  c01268b5 <__free_pages+15/20>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c01268ba <__free_pages+1a/20>
n
Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.
--------------------------------

Boot messages:

--------------------------------
Linux version 2.4.6 (root@gryffindor) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 Mon Jul 9 00:58:38 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000001000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=302 BOOT_FILE=/boot/vmlinuz-2.4.6 console=ttyS1,9600
Initializing CPU#0
Console: colour VGA+ 80x25
Calibrating delay loop... 39.62 BogoMIPS
Memory: 14180k/16384k available (857k kernel code, 1820k reserved, 274k data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
CPU: Before vendor init, caps: 00000000 00000000 00000000, vendor = 1
CPU: After vendor init, caps: 00000000 00000000 00000000 00000000
CPU:     After generic, caps: 00000000 00000000 00000000 00000000
CPU:             Common caps: 00000000 00000000 00000000 00000000
CPU: Cyrix Cx486DX4 stepping 06
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfc0b0, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Disabling direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
devfs: v0.106 (20010617) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
pty: 256 Unix98 ptys configured
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 9304kB/3101kB, 64 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: ST3630A, ATA DISK drive
ide0: unexpected interrupt, status=0x51, count=1
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 1232784 sectors (631 MB) w/120KiB Cache, CHS=611/32/63
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
ip_conntrack (128 buckets, 1024 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 184k freed
Adding Swap: 124956k swap-space (priority -1)
eth0: 3c5x9 at 0x300, 10baseT port, address  00 a0 24 47 bc 56, IRQ 10.
3c509.c:1.18 12Mar2001 becker@scyld.com
http://www.scyld.com/network/3c509.html
ISDN subsystem Rev: 1.114.6.12/1.94.6.2/1.140.6.6/1.85.6.5/none/1.5.6.3 loaded
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (module)
HiSax: Layer1 Revision 2.41.6.3
HiSax: Layer2 Revision 2.25.6.3
HiSax: TeiMgr Revision 2.17.6.2
HiSax: Layer3 Revision 2.17.6.4
HiSax: LinkLayer Revision 2.51.6.4
HiSax: Approval certification valid
HiSax: Approved with ELSA Microlink PCI cards
HiSax: Approved with Eicon Technology Diva 2.01 PCI cards
HiSax: Approved with Sedlbauer Speedfax + cards
HiSax: Total 1 card defined
HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
HiSax: AVM driver Rev. 2.13.6.1
AVM A1: Byte at 1b40 is 2
AVM A1: Byte at 1b43 is 3
AVM A1: Byte at 1b42 is 2
AVM A1: Byte at 1b40 is 6
HiSax: AVM A1 config irq:4 cfg:0x1B40
HiSax: isac:0x1740/0x1340
HiSax: hscx A:0x740/0x340  hscx B:0xF40/0xB40
AVM A1: ISAC version (0): 2086/2186 V1.1
AVM A1: HSCX version A: V2.1  B: V2.1
AVM A1: IRQ 4 count 0
AVM A1: IRQ 4 count 0
AVM A1: IRQ(4) getting no interrupts during init 1
AVM A1: IRQ 4 count 3
HiSax: DSS1 Rev. 2.30.6.1
HiSax: 2 channels added
HiSax: MAX_WAITING_CALLS added
eth0: Setting Rx mode to 1 addresses.
--------------------------------

lspci -vv:
--------------------------------
00:05.0 Host bridge: Silicon Integrated Systems [SiS] 85C496 (rev 31)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0 set

00:0f.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
--------------------------------

Something I should test?

	moritz
-- 
Moritz Schulte <moritz@chaosdorf.de> http://www.chaosdorf.de/moritz/
Debian/GNU supporter - http://www.debian.org/ http://www.gnu.org/
GPG fingerprint = 3A14 3923 15BE FD57 FC06  B501 0841 2D7B 6F98 4199

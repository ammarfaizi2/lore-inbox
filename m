Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271249AbRHOQAR>; Wed, 15 Aug 2001 12:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271247AbRHOQAJ>; Wed, 15 Aug 2001 12:00:09 -0400
Received: from dynamic-131.remotepoint.com ([204.221.114.131]:32010 "EHLO
	aerospace.fries.net") by vger.kernel.org with ESMTP
	id <S271249AbRHOP7w>; Wed, 15 Aug 2001 11:59:52 -0400
Date: Wed, 15 Aug 2001 10:56:20 -0500
From: David Fries <dfries@mail.win.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4 irq problem on SMP 2.4.8
Message-ID: <20010815105620.A7943@d-131-151-189-65.dynamic.umr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.6, 2.4.7, and 2.4.8 all fail on this SMP Alpha system.  I haven't
tried earlier 2.4 kernels yet though.  I also find it interesting that
under SMP 2.2.19 CPU0 only gets timer interrupts, CPU0 gets all
external interrups.

Linux version 2.4.7 (root@oemlab38) (gcc version 2.95.4 20010629
(Debian prerele
ase)) #6 SMP Wed Jul 25 16:34:37 CDT 2001
Booting GENERIC on Sable using machine vector Sable from SRM
Command line: ro root=/dev/sda3 console=ttyS0
memcluster 0, usage 1, start        0, end      256
memcluster 1, usage 0, start      256, end    12287
memcluster 2, usage 1, start    12287, end    12288
freeing pages 256:384
freeing pages 953:12287
reserving pages 953:954
t2_init: HBASE was 0x2000
SMP: 2 CPUs probed -- cpu_present_mask = 3
On node 0 totalpages: 12287
zone(0): 12287 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/sda3 console=ttyS0
Using epoch = 1900
Setting RTC_FREQ to 1024 Hz (25)
Turning on RTC interrupts.
Console: colour VGA+ 80x25
Calibrating delay loop... 916.72 BogoMIPS
Memory: 90048k/98296k available (2203k kernel code, 6200k reserved,
1612k data,
368k init)
Dentry-cache hash table entries: 16384 (order: 5, 262144 bytes)
Inode-cache hash table entries: 8192 (order: 4, 131072 bytes)
Mount-cache hash table entries: 2048 (order: 2, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 8192 bytes)
Page-cache hash table entries: 16384 (order: 4, 131072 bytes)
POSIX conformance testing by UNIFIX
Unable to handle kernel paging request at virtual address 0000000000000000
CPU 0 swapper(0): Oops 0
pc = [<fffffc0000544550>]  ra = [<fffffc0000544c34>]  ps = 0000
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = fffffc00005c0000  t0 = 0000000000000001  t1 = 0000000000000000
t2 = 00000000000001c0  t3 = 00000000000005a8  t4 = fffffc00007323e8
t5 = 0000000000003ff0  t6 = fffffc00006c9780  t7 = fffffc000059c000
s0 = fffffc0000604480  s1 = fffffc0000732498  s2 = fffffc00005c0000
s3 = fffffc0000685500  s4 = 0000000120001f40  s5 = 0000000000000000
s6 = 0000000000000000
a0 = fffffc00005c0000  a1 = 0000000000000000  a2 = 0000000000000000
a3 = 0000000000000008  a4 = 0000000000000000  a5 = 0000000000000000
t8 = 0000000000000004  t9 = fffffc0000732660  t10= fffffc0000733290
t11= fffffc000073d370  pv = fffffc0000530ba0  at = fffffc0000732638
gp = fffffc0000715488  sp = fffffc000059ff70
Trace:fffffc000031001c
Code: b57e0018  20d13ff0  b75e0000  47f0040b  b55e0010  209105a8 <a6e20000>

>>PC;  fffffc0000544550 <init_i8259a_irqs+70/a0>   <=====
Trace; fffffc000031001c <_stext+1c/20>
Code;  fffffc0000544538 <init_i8259a_irqs+58/a0>
0000000000000000 <_PC>:
Code;  fffffc0000544538 <init_i8259a_irqs+58/a0>
   0:   18 00 7e b5       stq  s2,24(sp)
Code;  fffffc000054453c <init_i8259a_irqs+5c/a0>
   4:   f0 3f d1 20       lda  t5,16368(a1)
Code;  fffffc0000544540 <init_i8259a_irqs+60/a0>
   8:   00 00 5e b7       stq  ra,0(sp)
Code;  fffffc0000544544 <init_i8259a_irqs+64/a0>
   c:   0b 04 f0 47       mov  a0,s2
Code;  fffffc0000544548 <init_i8259a_irqs+68/a0>
  10:   10 00 5e b5       stq  s1,16(sp)
Code;  fffffc000054454c <init_i8259a_irqs+6c/a0>
  14:   a8 05 91 20       lda  t3,1448(a1)
Code;  fffffc0000544550 <init_i8259a_irqs+70/a0>
  18:   00 00 e2 a6       ldq  t9,0(t1)


emlab38:~/oops# cat /proc/cpuinfo
cpu                     : Alpha
cpu model               : EV45
cpu variation           : 7
cpu revision            : 0
cpu serial number       : 
system type             : Sable
system variation        : 0
system revision         : 0
system serial number    : 
cycle frequency [Hz]    : 233335400 est.
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 34
max. addr. space #      : 63
BogoMIPS                : 8.38
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : AlphaServer 2000 4/233
cpus detected           : 2
CPUs probed 2 active 2 map 0x3 IPIs 39788


-- 
		+---------------------------------+
		|      David Fries                |
		|      dfries@mail.win.org        |
		+---------------------------------+

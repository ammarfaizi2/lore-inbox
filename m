Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTDHOow (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 10:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTDHOow (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 10:44:52 -0400
Received: from cibs9.sns.it ([192.167.206.29]:47368 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S261819AbTDHOos (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 10:44:48 -0400
Date: Tue, 8 Apr 2003 16:56:24 +0200 (CEST)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: three oops starting XF86 4.3.0 on i810 video card (kernel 2.5.67)
Message-ID: <Pine.LNX.4.43.0304081645210.10297-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,
When I start XF86 4.3.0, and then I stop X11, and then, after e few seconds I
restart it again X11 crashes and I get those three oops:

invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c013f4b7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c14f5920   ecx: d5830600   edx: d64a29c0
esi: d12cc030   edi: c1000000   ebp: d46e7220   esp: d60e9e88
ds: 007b   es: 007b   ss: 0068
Stack: 00000002 d12cc030 c013b1a0 000000d0 4000c000 00000000 40150000 4014d000
       d4938960 00000000 00000286 db0961c0 d4938960 d5830600 c14f5920 d5f90400
       db0961c0 d5f90400 4000c547 db0961c0 d46e7220 c013b5f9 db0961c0 d46e7220
Call Trace: [<c013b1a0>]  [<c013b5f9>]  [<c01159bc>]  [<c010f155>]  [<c0147a8d>]
[<c0115880>]  [<c0109ab9>]
Code: 0f 0b d4 00 9a 2c 26 c0 eb d6 eb 0d 90 90 90 90 90 90 90 90


>>EIP; c013f4b7 <page_add_rmap+b7/d0>   <=====

Trace; c013b1a0 <do_no_page+180/3d0>
Trace; c013b5f9 <handle_mm_fault+f9/170>
Trace; c01159bc <do_page_fault+13c/45e>
Trace; c010f155 <old_mmap+e5/150>
Trace; c0147a8d <filp_close+4d/80>
Trace; c0115880 <do_page_fault+0/45e>
Trace; c0109ab9 <error_code+2d/38>

Code;  c013f4b7 <page_add_rmap+b7/d0>
00000000 <_EIP>:
Code;  c013f4b7 <page_add_rmap+b7/d0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013f4b9 <page_add_rmap+b9/d0>
   2:   d4 00                     aam    $0x0
Code;  c013f4bb <page_add_rmap+bb/d0>
   4:   9a 2c 26 c0 eb d6 eb      lcall  $0xebd6,$0xebc0262c
Code;  c013f4c2 <page_add_rmap+c2/d0>
   b:   0d 90 90 90 90            or     $0x90909090,%eax
Code;  c013f4c7 <page_add_rmap+c7/d0>
  10:   90                        nop
Code;  c013f4c8 <page_add_rmap+c8/d0>
  11:   90                        nop
Code;  c013f4c9 <page_add_rmap+c9/d0>
  12:   90                        nop
Code;  c013f4ca <page_add_rmap+ca/d0>
  13:   90                        nop

kernel BUG at mm/rmap.c:212!
invalid operand: 0000 [#2]
CPU:    0
EIP:    0060:[<c013f4b7>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c14f5920   ecx: d58301e0   edx: d64a29c0
esi: d12dd030   edi: c1000000   ebp: d4938620   esp: d12cbe88
ds: 007b   es: 007b   ss: 0068
Stack: 00000002 d12dd030 c013b1a0 000000d0 4000c000 00000000 4021a000 40219000
       d4938460 00000000 00000286 d60eb000 c13724b8 d58301e0 c14f5920 d5f90400
       db0961c0 d5f90400 4000c547 db0961c0 d4938620 c013b5f9 db0961c0 d4938620
Call Trace: [<c013b1a0>]  [<c013b5f9>]  [<c01159bc>]  [<c010f17c>]  [<c0147a8d>]
[<c0115880>]  [<c0109ab9>]
Code: 0f 0b d4 00 9a 2c 26 c0 eb d6 eb 0d 90 90 90 90 90 90 90 90


>>EIP; c013f4b7 <page_add_rmap+b7/d0>   <=====

Trace; c013b1a0 <do_no_page+180/3d0>
Trace; c013b5f9 <handle_mm_fault+f9/170>
Trace; c01159bc <do_page_fault+13c/45e>
Trace; c010f17c <old_mmap+10c/150>
Trace; c0147a8d <filp_close+4d/80>
Trace; c0115880 <do_page_fault+0/45e>
Trace; c0109ab9 <error_code+2d/38>

Code;  c013f4b7 <page_add_rmap+b7/d0>
00000000 <_EIP>:
Code;  c013f4b7 <page_add_rmap+b7/d0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013f4b9 <page_add_rmap+b9/d0>
   2:   d4 00                     aam    $0x0
Code;  c013f4bb <page_add_rmap+bb/d0>
   4:   9a 2c 26 c0 eb d6 eb      lcall  $0xebd6,$0xebc0262c
Code;  c013f4c2 <page_add_rmap+c2/d0>
   b:   0d 90 90 90 90            or     $0x90909090,%eax
Code;  c013f4c7 <page_add_rmap+c7/d0>
  10:   90                        nop
Code;  c013f4c8 <page_add_rmap+c8/d0>
  11:   90                        nop
Code;  c013f4c9 <page_add_rmap+c9/d0>
  12:   90                        nop
Code;  c013f4ca <page_add_rmap+ca/d0>
  13:   90                        nop

kernel BUG at mm/rmap.c:212!
invalid operand: 0000 [#3]
CPU:    0
EIP:    0060:[<c013f4b7>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c14f5920   ecx: d5830fa0   edx: d64a29c0
esi: d12dd030   edi: 4000c000   ebp: d12dd030   esp: d12ede8c
ds: 007b   es: 007b   ss: 0068
Stack: 1fbd4005 d12f4030 c01395a5 00000020 00000000 00000000 00000000 d5f90400
       c1649400 c14f5920 d5830fa0 00000001 40016000 d49387a0 db0961c0 d49387a0
       d519c6e0 d49387c8 c1698a00 c011925b db0961c0 c1698a00 d49387a0 d12ec000
Call Trace: [<c01395a5>]  [<c011925b>]  [<c0119ada>]  [<c011a0a0>]  [<c012434b>]
[<c012449f>]  [<c0147e80>]  [<c0107957>]  [<c01090af>]
Code: 0f 0b d4 00 9a 2c 26 c0 eb d6 eb 0d 90 90 90 90 90 90 90 90


>>EIP; c013f4b7 <page_add_rmap+b7/d0>   <=====

Trace; c01395a5 <copy_page_range+235/350>
Trace; c011925b <copy_mm+2db/370>
Trace; c0119ada <copy_process+42a/9a0>
Trace; c011a0a0 <do_fork+50/160>
Trace; c012434b <sigprocmask+4b/c0>
Trace; c012449f <sys_rt_sigprocmask+df/130>
Trace; c0147e80 <default_llseek+0/80>
Trace; c0107957 <sys_fork+37/50>
Trace; c01090af <syscall_call+7/b>

Code;  c013f4b7 <page_add_rmap+b7/d0>
00000000 <_EIP>:
Code;  c013f4b7 <page_add_rmap+b7/d0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013f4b9 <page_add_rmap+b9/d0>
   2:   d4 00                     aam    $0x0
Code;  c013f4bb <page_add_rmap+bb/d0>
   4:   9a 2c 26 c0 eb d6 eb      lcall  $0xebd6,$0xebc0262c
Code;  c013f4c2 <page_add_rmap+c2/d0>
   b:   0d 90 90 90 90            or     $0x90909090,%eax
Code;  c013f4c7 <page_add_rmap+c7/d0>
  10:   90                        nop
Code;  c013f4c8 <page_add_rmap+c8/d0>
  11:   90                        nop
Code;  c013f4c9 <page_add_rmap+c9/d0>
  12:   90                        nop
Code;  c013f4ca <page_add_rmap+ca/d0>
  13:   90                        nop

The problem is connected with this error message about MTRR I get
immediatelly before X11 crash:

mtrr: MTRR 3 not used
mtrr: base(0x44000000) is not aligned on a size(0x4b0000) boundary


System is a PentiumIII 933 Mhz 256 KB L2 cache with 512MB RAM 133 Mhz.
Chipset is an intel i810, the video card is on the Mother Board, using system
memory.
kernerl is 2.5.67, compiled with gcc 3.2.2, binutils 2.13.90.0.18.
System is running with glibc 2.3.2.

full kernel preemption is not enabled.

agpgart support is statically linked in my kernel,
while i810 DRM support is a module, as you can see:

Linux agpgart interface v0.100 (c) Dave Jones
agpgart: agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0x44000000

[...]

[drm] AGP 0.100 aperture @ 0x44000000 64MB
[drm] Initialized i810 1.2.1 20020211 on minor 0


DRM and DRI are enabled in my XF86 configuration.

lspci -v:

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory
Controller Hub (rev 02)
        Flags: bus master, fast devsel, latency 0
        Capabilities: [88] #09 [f104]

00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics
Controller] (rev 02) (prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation: Unknown device 0034
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 16
        Memory at 44000000 (32-bit, prefetchable) [size=64M]
        Memory at 40300000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [dc] Power Management version 2

00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal
decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 40000000-402fffff

00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if 80 [Master])
        Subsystem: Intel Corp. 82801AA IDE
        Flags: bus master, medium devsel, latency 0
        I/O ports at 2460 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp. 82801AA USB
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at 2440 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device b1bf
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at 2000 [size=256]
        I/O ports at 2400 [size=64]

02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management
NIC
        Flags: bus master, medium devsel, latency 64, IRQ 16
        I/O ports at 1000 [size=128]
        Memory at 40000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262698AbSI1EXO>; Sat, 28 Sep 2002 00:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262699AbSI1EXN>; Sat, 28 Sep 2002 00:23:13 -0400
Received: from mail4.mx.voyager.net ([216.93.66.203]:30475 "EHLO
	mail4.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S262698AbSI1EXL>; Sat, 28 Sep 2002 00:23:11 -0400
Message-ID: <3D9530A3.2FF67FE4@megsinet.net>
Date: Fri, 27 Sep 2002 23:31:31 -0500
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.39 - bad: scheduling while atomic!  && also ISAPNP kills 2.5.39
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just tried SMP 2.5.39, and get scheduling errors, the system continues but later dies completely
during ISAPnP.

Martin

Hand copied:

Oops: 002
CPU: 0
EIP: 0060:[<c01f41aa7>]
EFLAGS: 00010282
EIP is at attach:0x5a/0xa0
...stuff deleted...
Call trace:
device_attach + 0x50/0x60
device_register + 0x1d0/0x220
sprintf + 0x1f/0x30
isapnp_init_device_tree + 0xcd/0x162
init + 0x79/0x200
init + 0x0/0x200
kernel_thread_helper + 0x5/0x10


I recompiled w/ ISAPnP as a module and modprobed isapnp.o and got

isapnp: Scanning for PnP cards...
isapnp: Card 'SMC EZ Card (1660)'
isapnp: 1 Plug & Play card detected total
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01f9892
*pde = 00000000
Oops: 0002
isa-pnp
CPU:    1
EIP:    0060:[<c01f9892>]    Not tainted
EFLAGS: 00010286
EIP is at attach+0x62/0xc0
eax: d3fb849c   ebx: d24ce000   ecx: 00000000   edx: d4827f01
esi: d3fb8484   edi: d24ce000   ebp: 00000000   esp: d24cfe70
ds: 0068   es: 0068   ss: 0068
Process modprobe (pid: 717, threadinfo=d24ce000 task=d117c0c0)
Stack: c01fc320 d3fb8484 d3fb8528 00000000 00000000 d3fb848c c01f9a10 d3fb8484
       d3fb8484 d3fb8484 d3fb8484 c01f9e95 d3fb8484 d3fb8508 2c047af8 d4825a31
       d24cfed4 d3fb6800 d4827e40 d3e0bb64 d3e0bb78 d482221d d3fb8484 d4825a29
Call Trace:
 [<c01fc320>]device_create_file+0x40/0x50
 [<c01f9a10>]device_attach+0x50/0x60
 [<c01f9e95>]device_register+0x205/0x260
 [<d4825a31>].rodata.str1.1+0x66/0x45f [isa-pnp]
 [<d4827e40>]isapnp_cards+0x0/0x8 [isa-pnp]
 [<d482221d>]isapnp_init_device_tree+0xcd/0x170 [isa-pnp]
 [<d4825a29>].rodata.str1.1+0x5e/0x45f [isa-pnp]
 [<d4827e40>]isapnp_cards+0x0/0x8 [isa-pnp]
 [<d4821e52>]isapnp_init+0x162/0x290 [isa-pnp]
 [<d4825520>].rodata.str1.32+0x280/0x72b [isa-pnp]
 [<d48259ed>].rodata.str1.1+0x22/0x45f [isa-pnp]
 [<d48259df>].rodata.str1.1+0x14/0x45f [isa-pnp]
 [<c0120f3e>]sys_init_module+0x4ee/0x640
 [<d481e060>]isapnp_read_byte+0x0/0x30 [isa-pnp]
 [<d481e060>]isapnp_read_byte+0x0/0x30 [isa-pnp]
 [<c0107e3b>]syscall_call+0x7/0xb

Code: 89 01 81 3d d4 a2 31 c0 ad 4e ad de 74 08 0f 0b 5f 00 40 39
 <6>note: modprobe[717] exited with preempt_count 2
Sleeping function called from illegal context at slab.c:1374
d24cfbcc c01420c2 c02db682 0000055e c132e2c0 d2dd8000 d2dd8ee8 d2ebee64
       d0b23480 ffffffdb 00000001 c0168f9d d3f8f630 000001d0 c0169fda 00000000
       c0144c61 00002d0c 00000000 c0312c84 d2dd8eec c132e2c0 c014236c c0312a00
Call Trace:
 [<c01420c2>]__kmem_cache_alloc+0x1e2/0x1f0
 [<c0168f9d>]locks_alloc_lock+0x3d/0x60
 [<c0169fda>]posix_lock_file+0x3a/0x630
 [<c0144c61>]__free_pages_ok+0x2f1/0x3c0
 [<c014236c>]__kmem_cache_free+0xac/0xee
 [<c014557b>]__pagevec_free+0x1b/0x30
 [<c016b9d6>]locks_remove_posix+0x96/0xc0
 [<c0151c4d>]filp_close+0xad/0xe0
 [<c012358c>]put_files_struct+0x6c/0xe0
 [<c0123d15>]do_exit+0x165/0x310
 [<c0108eba>]die+0xea/0x100
 [<c01177c7>]do_page_fault+0x157/0x49f
 [<c016ec45>]alloc_inode+0x185/0x1b0
 [<c016f528>]new_inode+0xd8/0xe0
 [<c016d5ce>]d_instantiate+0xbe/0xc0
 [<c01878a5>]driverfs_get_inode+0x15/0xf0
 [<c0117670>]do_page_fault+0x0/0x49f
 [<c010887d>]error_code+0x2d/0x38
 [<d4827f01>]isapnp_reserve_mem+0x1/0x40 [isa-pnp]
 [<c01f9892>]attach+0x62/0xc0
 [<c01fc320>]device_create_file+0x40/0x50
 [<c01f9a10>]device_attach+0x50/0x60
 [<c01f9e95>]device_register+0x205/0x260
 [<d4825a31>].rodata.str1.1+0x66/0x45f [isa-pnp]
 [<d4827e40>]isapnp_cards+0x0/0x8 [isa-pnp]
 [<d482221d>]isapnp_init_device_tree+0xcd/0x170 [isa-pnp]
 [<d4825a29>].rodata.str1.1+0x5e/0x45f [isa-pnp]
 [<d4827e40>]isapnp_cards+0x0/0x8 [isa-pnp]
 [<d4821e52>]isapnp_init+0x162/0x290 [isa-pnp]
 [<d4825520>].rodata.str1.32+0x280/0x72b [isa-pnp]
 [<d48259ed>].rodata.str1.1+0x22/0x45f [isa-pnp]
 [<d48259df>].rodata.str1.1+0x14/0x45f [isa-pnp]
 [<c0120f3e>]sys_init_module+0x4ee/0x640
 [<d481e060>]isapnp_read_byte+0x0/0x30 [isa-pnp]
 [<d481e060>]isapnp_read_byte+0x0/0x30 [isa-pnp]
 [<c0107e3b>]syscall_call+0x7/0xb


---------------------------------------------------------------

calibrating APIC timer ...
..... CPU clock speed is 476.0020 MHz.
..... host bus clock speed is 68.0002 MHz.
cpu: 0, clocks: 68002, slice: 2060
CPU0<T0:68000,T1:65936,D:4,S:2060,C:68002>
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
cpu: 1, clocks: 68002, slice: 2060
CPU1<T0:68000,T1:63872,D:8,S:2060,C:68002>
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
bad: scheduling while atomic!
d3fd5ecc c01197b3 c02d9540 00000000 00000000 00000000 00000000 00000000
       00000000 d3fd4000 d3fd5f84 d3fd5f88 d3fd5f64 c0119c3a 00000000 00000000
       00000282 00000000 d3fd3060 c0119810 00000000 00000000 c03784c8 c03784c8
Call Trace:
 [<c01197b3>]schedule+0x403/0x410
 [<c0119c3a>]wait_for_completion+0xfa/0x1b0
 [<c0119810>]default_wake_function+0x0/0x40
 [<c0119810>]default_wake_function+0x0/0x40
 [<c011b3ce>]set_cpus_allowed+0x13e/0x150
 [<c011b435>]migration_thread+0x55/0x370
 [<c0107d99>]ret_from_fork+0x5/0x14
 [<c011b3e0>]migration_thread+0x0/0x370
 [<c011b3e0>]migration_thread+0x0/0x370
 [<c0105705>]kernel_thread_helper+0x5/0x10

bad: scheduling while atomic!
d3fd1ef0 c01197b3 c02d9540 00000000 00000000 00000000 00000000 00000000
       00000000 d3fd0000 d3fd1fa8 d3fd1fac d3fd1f88 c0119c3a 00000000 00000000
       00000292 00000000 d3fd3780 c0119810 00000000 00000000 c0378940 c0378940
Call Trace:
 [<c01197b3>]schedule+0x403/0x410
 [<c0119c3a>]wait_for_completion+0xfa/0x1b0
 [<c0119810>]default_wake_function+0x0/0x40
 [<c0119810>]default_wake_function+0x0/0x40
 [<c011b3ce>]set_cpus_allowed+0x13e/0x150
 [<c0126530>]ksoftirqd+0x60/0x130
 [<c01264d0>]ksoftirqd+0x0/0x130
 [<c0105705>]kernel_thread_helper+0x5/0x10

CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb5c0, last bus=1
PCI: Using configuration type 1
adding '' to cpu class interfaces
adding '' to cpu class interfaces

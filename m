Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUJWIdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUJWIdh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 04:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUJWIdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 04:33:37 -0400
Received: from p54808873.dip.t-dialin.net ([84.128.136.115]:33028 "EHLO
	pro01.local.promotion-ie.de") by vger.kernel.org with ESMTP
	id S266741AbUJWIdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 04:33:10 -0400
From: alex@local.promotion-ie.de
Subject: Re: linux 2.6.9 on alpha noritake
To: rth@twiddle.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1098476483.11296.37.camel@pro30.local.promotion-ie.de>
References: <1098476483.11296.37.camel@pro30.local.promotion-ie.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098520279.14984.12.camel@pro30.local.promotion-ie.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 23 Oct 2004 10:31:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) 2.6.8.1 after fb-console is up no further messages will appear on
> serial console
> 
> 2) >2.6.9 (maybe >2.6.8.1-bk? not tested) __ioremap is missing in
> include/alpha/io.h
> following got deleted between 2.6.8.1 and 2.6.9 
# define __ioremap(a,s) alpha_mv.mv_ioremap((unsigned long)(a),(s))
> 
> the only source that uses __ioremap on my system is the framebuffer
> (radeonfb), so that's not a so big problem for the moment ;-)

  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0xdbac): In function `fb_mmap':
include/asm/io.h:73: undefined reference to `__ioremap'
drivers/built-in.o(.text+0xdbbc):include/asm/io.h:73: undefined
reference to `__ioremap'
make: *** [.tmp_vmlinux1] Error 1

> 3) >2.6.9 (maybe >2.6.8.1-bk? not tested) 
> srm console during aboot goes from white on blue to red on blue coloring
> and freezes ( couldn't find info on that effect)
> more than 10-20 oopses scroll by on serial console

if System.map needed please email me!!!

after a while SRM console turns blue on white again
with:
--------------------------------------------
halted CPU 0

halt code = 7
maachine check while in PAL mode
PC = 1c778
boot failure
>>>
--------------------------------------------

serial console capture:

Console: switching to colour dummy device 80x25
Linux version 2.6.9-bk7 (root@Gentoo) (gcc version 3.3.3 20040217
(Gentoo Linux 3.3.3, propolice-3.3-7)) #1 Fri Oct 22 20:26:22 CEST 2004
Booting on Noritake using machine vector Noritake-Primo from SRM
Major Options: EV56 LEGACY_START VERBOSE_MCHECK MAGIC_SYSRQ 
Command line: root=/dev/sda4 console=ttyS1,115200n8 console=tty0
memcluster 0, usage 1, start        0, end      235
memcluster 1, usage 0, start      235, end   131046
memcluster 2, usage 1, start   131046, end   131072
freeing pages 235:384
freeing pages 873:131046
reserving pages 873:875
2048K Bcache detected; load hit latency 38 cycles, load miss latency 168
cycles
pci: cia revision 2
Built 1 zonelists
Kernel command line: root=/dev/sda4 console=ttyS1,115200n8 console=tty0
PID hash table entries: 4096 (order: 12, 131072 bytes)
Using epoch = 2000
CIA machine check NOT expected!!!
CIA machine check: vector=0x670 pc=0xfffffc000031ce4c code=0x98
machine check type: processor detected hard error
pc = [<fffffc000031ce4c>]  ra = [<fffffc00005f646c>]  ps = 0007    Not
tainted
pc is at __raw_readw+0x4c/0x60
ra is at vgacon_startup+0x4ec/0x750
v0 = 0000000000000000  t0 = fffffc8581700008  t1 = fffffc8580000008
t2 = 0000000000000000  t3 = 0000000001700000  t4 = 00000000000c0000
t5 = 00000000000b2944  t6 = ffffffffbe85edbe  t7 = fffffc000060c000
a0 = 0000000000000001  a1 = 00000000000003c9  a2 = 0000000000000000
a3 = fffffc00006bc4a0  a4 = 000000000000000b  a5 = fffffc000031b9c0
t8 = 000000000000001f  t9 = fffffc00005ecefc  t10= 0400000000000000
t11= 000000001dcd6500  pv = fffffc000031ce00  at = 0000000000000000
gp = fffffc00006a1500  sp = fffffc000060fe38
   +       0 0000000000000200 000001a000000118
   +      10 0000000000000098 0000000000000000
   +      20 0000000000000000 0000000000000000
   +      30 0000000000000000 0000000000000000
   +      40 0000000000000000 0000000000000000
   +      50 0000000000000000 0000000000000000
   +      60 fffffc8581700008 fffffc0000312c20
   +      70 0000000000005200 0000000001700000
   +      80 00000000000c0000 00000000000b2944
   +      90 fffffc0000312ba0 1f1e161514020100
   +      a0 fffffc0000312e80 fffffc000031ce4c
   +      b0 fffffc00003129e0 fffffc0000312a60
   +      c0 0000000000000a0d 00000000000000f4
   +      d0 00000000000001ec 0000009806700001
   +      e0 0000000000000000 0000000000000000
   +      f0 000000002005be18 0000000000300000
   +     100 fffffc0000312ae0 fffffc00006a1500
   +     110 000000000060c000 fffffc000031ce4c
   +     120 0000000000000000 0000000000000000
   +     130 0000000000018000 0000000000000000
   +     140 0000004164020000 0000000000000000
   +     150 0000000000000000 00000000101303e8
   +     160 00000000000148d0 ffffff00006bd5af
   +     170 0000000000000000 ffffff8000cf6fff
   +     180 ffffffffffffffff 000000000000d8f2
   +     190 fffffff005ffffff ffffff00006146df
   +     1a0 0000000000c1d910 0000000000200b00
   +     1b0 0000000000000000 000000000000001a
   +     1c0 0000000000000c12 00000000000000f3
   +     1d0 ffffffffffe00000 0000000010100000
   +     1e0 0000000002010006 0000000040008840
   +     1f0 0000000000000000 00000000000b8000
CIA machine check NOT expected!!!
CIA machine check: vector=0x670 pc=0xfffffc000031ce4c code=0x98
machine check type: processor detected hard error
pc = [<fffffc000031ce4c>]  ra = [<fffffc00005f6454>]  ps = 0007    Not
tainted
pc is at __raw_readw+0x4c/0x60
ra is at vgacon_startup+0x4d4/0x750
v0 = 0000000000000000  t0 = fffffc8581700048  t1 = fffffc8580000008
t2 = 0000000000000002  t3 = 0000000001700040  t4 = 00000000000c0000
t5 = 00000000000b2944  t6 = ffffffffbe85edbe  t7 = fffffc000060c000
a0 = 0000000000000001  a1 = 00000000000003c9  a2 = 0000000000000000
a3 = fffffc00006bc4a0  a4 = 000000000000000b  a5 = fffffc000031b9c0
t8 = 000000000000001f  t9 = fffffc00005ecefc  t10= 0400000000000000
t11= 000000001dcd6500  pv = fffffc000031ce00  at = 0000000000000000
gp = fffffc00006a1500  sp = fffffc000060fe38
   +       0 0000000000000200 000001a000000118
   +      10 0000000000000098 0000000000000000
   +      20 0000000000000000 0000000000000000
   +      30 0000000000000000 0000000000000000
   +      40 0000000000000000 0000000000000000
   +      50 0000000000000000 0000000000000000
   +      60 fffffc8581700048 fffffc0000312c20
   +      70 0000000000005200 0000000001700040
   +      80 00000000000c0000 00000000000b2944
   +      90 fffffc0000312ba0 1f1e161514020100
   +      a0 fffffc0000312e80 fffffc000031ce4c
   +      b0 fffffc00003129e0 fffffc0000312a60
   +      c0 0000000000000a0d 00000000000000f4
   +      d0 00000000000001ec 0000009806700001
   +      e0 0000000000000000 0000000000000000
   +      f0 fffffc000060fe38 0000000000300000
   +     100 fffffc0000312ae0 fffffc00006a1500
   +     110 000000000060c000 fffffc000031ce4c
   +     120 0000000000000000 0000000000000000
   +     130 0000000000018000 0000000000400000
   +     140 0000004164020000 0000000000000000
   +     150 0000000000000000 00000000101303e8
   +     160 00000000000148d0 ffffff000001d5cf
   +     170 0000000000000000 ffffff80000f1fff
   +     180 ffffffffffffffff 000000000000d8f2
   +     190 fffffff005ffffff ffffff00006146df
   +     1a0 ffffffffffe00000 00000000000000ff
   +     1b0 0000000000000000 000000000000001a
   +     1c0 0000000000000c12 00000000000000f3
   +     1d0 ffffffffffe00000 0000000010100000
   +     1e0 0000000002010006 0000000040008840
   +     1f0 0000000000000000 00000000000b8002
CIA machine check NOT expected!!!
CIA machine check: vector=0x670 pc=0xfffffc000031ce4c code=0x98
machine check type: processor detected hard error
pc = [<fffffc000031ce4c>]  ra = [<fffffc00005f640c>]  ps = 0007    Not
tainted
pc is at __raw_readw+0x4c/0x60
ra is at vgacon_startup+0x48c/0x750
v0 = 0000000000000000  t0 = fffffc8581700008  t1 = fffffc8580000008
t2 = 0000000000000000  t3 = 0000000001700000  t4 = 00000000000c0000
t5 = 00000000000b2944  t6 = ffffffffbe85edbe  t7 = fffffc000060c000
a0 = 0000000000000001  a1 = 0000000000000001  a2 = 0000000000000000
a3 = fffffc00006bc4a0  a4 = 000000000000000b  a5 = fffffc000031b9c0
t8 = 000000000000001f  t9 = fffffc00005ecefc  t10= 0400000000000000
t11= 000000001dcd6500  pv = fffffc000031ce00  at = 0000000000000000
gp = fffffc00006a1500  sp = fffffc000060fe38
   +       0 0000000000000200 000001a000000118
   +      10 0000000000000098 0000000000000000
   +      20 0000000000000000 0000000000000000
   +      30 0000000000000000 0000000000000000
   +      40 0000000000000000 0000000000000000
   +      50 0000000000000000 0000000000000000
   +      60 fffffc8581700008 fffffc0000312c20
   +      70 0000000000005200 0000000001700000
   +      80 00000000000c0000 00000000000b2944
   +      90 fffffc0000312ba0 1f1e161514020100
   +      a0 fffffc0000312e80 fffffc000031ce4c
   +      b0 fffffc00003129e0 fffffc0000312a60
   +      c0 0000000000000a0d 00000000000000f4
   +      d0 00000000000001ec 0000009806700001
   +      e0 0000000000000000 0000000000000000
   +      f0 fffffc000060fe38 0000000000300000
   +     100 fffffc0000312ae0 fffffc00006a1500
   +     110 000000000060c000 fffffc000031ce4c
   +     120 0000000000000000 0000000000000000
   +     130 0000000000018000 0000000000400000
   +     140 0000004164020000 0000000000000000
   +     150 0000000000000000 00000000101303e8
   +     160 00000000000148d0 ffffff000001d5ef
   +     170 0000000000000000 ffffff80000f1fff
   +     180 ffffffffffffffff 000000000000d8f2
   +     190 fffffff005ffffff ffffff00006146df
   +     1a0 00000000001fd8c0 00000000000000ff
   +     1b0 0000000000000000 000000000000001a
   +     1c0 0000000000000c12 00000000000000f3
   +     1d0 ffffffffffe00000 0000000010100000
   +     1e0 0000000002010006 0000000040008840
   +     1f0 0000000000000000 00000000000b8000
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
Memory: 1031808k/1048368k available (2455k kernel code, 14344k reserved,
581k data, 144k init)
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
NET: Registered protocol family 16
EISA bus registered
pci: passed tb register update test
pci: passed sg loopback i/o read test
pci: passed tbia test
pci: passed pte write cache snoop test
CIA machine check expected.
pci: failed valid tag invalid pte reload test (mcheck; workaround
available)
CIA machine check expected.
pci: passed pci machine check test
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
CIA machine check expected.
pci: enabling save/restore of SRM state
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
srm_env: version 0.0.5 loaded successfully
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
SGI XFS with ACLs, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
rtc: SRM (post-2000) epoch (2000) detected
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
CIA machine check NOT expected!!!
CIA machine check: vector=0x670 pc=0xfffffc000031cde8 code=0x98
machine check type: processor detected hard error
pc = [<fffffc000031cde8>]  ra = [<fffffc000031cf58>]  ps = 0000    Not
tainted
pc is at __raw_readb+0x48/0x60
ra is at readb+0x18/0x30
v0 = 0000000000000000  t0 = fffffc85c4e400e0  t1 = fffffffffffffff9
t2 = 0000000000000003  t3 = 0000000044e400e0  t4 = 0000000000000000
t5 = 0000000002272000  t6 = 0000000000000000  t7 = fffffc00010f8000
a0 = 0000000000000001  a1 = 0000000000000100  a2 = fffffc00010fbbec
a3 = 0000000000000170  a4 = fffffc00010fbad8  a5 = 0000000000000000
t8 = 0000000000000000  t9 = fffffc0000481e78  t10= 0000000000000010
t11= 0000000000000008  pv = fffffc000031cf40  at = 0000000000000000
gp = fffffc00006a1500  sp = fffffc00010fba98
   +       0 0000000000000200 000001a000000118
   +      10 0000000000000098 0000000000000000
   +      20 0000000000000000 0000000000000000
   +      30 0000000000000000 0000000000000000
   +      40 0000000000000000 0000000000000000
   +      50 0000000000000000 0000000000000000
   +      60 fffffc85c4e400e0 fffffc0000312c20
   +      70 0000000000005200 0000000044e400e0
   +      80 0000000000000000 0000000002272000
   +      90 fffffc0000312ba0 1f1e161514020100
   +      a0 fffffc0000312e80 fffffc000031cde8
   +      b0 fffffc00003129e0 fffffc0000312a60
   +      c0 0000000000000a0d 00000000000000f4
   +      d0 00000000000001ec 0000009806700001
   +      e0 0000000000000000 0000000000000000
   +      f0 fffffc00010efaa8 0000000000300000
   +     100 fffffc0000312ae0 fffffc00006a1500
   +     110 00000000010f8000 fffffc000031cde8
   +     120 0000000000000000 0000000000000000
   +     130 0000000000018000 0000000000000000
   +     140 0000004164020000 0000000000000000
   +     150 0000000000000000 0000000000000000
   +     160 00000000000147d0 ffffff000001d58f
   +     170 0000000000000000 ffffff80000f1fff
   +     180 ffffffffffffffff 000000000000d8f2
   +     190 fffffff005ffffff ffffff00010d70df
   +     1a0 000000003ffae120 0000000000200b00
   +     1b0 0000000000000000 000000000000001a
   +     1c0 0000000000000c12 00000000000000f3
   +     1d0 ffffffffffe00000 0000000010100000
   +     1e0 0000000002010006 0000000040008840
   +     1f0 0000000000000000 0000000000272007
CIA machine check NOT expected!!!
CIA machine check: vector=0x670 pc=0xfffffc000031cde8 code=0x98
machine check type: processor detected hard error
pc = [<fffffc000031cde8>]  ra = [<fffffc000031cf58>]  ps = 0000    Not
tainted
pc is at __raw_readb+0x48/0x60
ra is at readb+0x18/0x30
v0 = 0000000000000000  t0 = fffffc85c4e408e0  t1 = fffffffffffffff9
t2 = 0000000000000003  t3 = 0000000044e408e0  t4 = 0000000000000000
t5 = 0000000002272000  t6 = 0000000000000000  t7 = fffffc00010f8000
a0 = 0000000000000001  a1 = 0000000000000100  a2 = fffffc00010fbbec
a3 = 0000000000000170  a4 = fffffc00010fbad8  a5 = 0000000000000000
t8 = 0000000000000000  t9 = fffffc0000481e78  t10= 0000000000000010
t11= 0000000000000008  pv = fffffc000031cf40  at = 0000000000000000
gp = fffffc00006a1500  sp = fffffc00010fba98
   +       0 0000000000000200 000001a000000118
   +      10 0000000000000098 0000000000000000
   +      20 0000000000000000 0000000000000000
   +      30 0000000000000000 0000000000000000
   +      40 0000000000000000 0000000000000000
   +      50 0000000000000000 0000000000000000
   +      60 fffffc85c4e408e0 fffffc0000312c20
   +      70 0000000000005200 0000000044e408e0
   +      80 0000000000000000 0000000002272000
   +      90 fffffc0000312ba0 1f1e161514020100
   +      a0 fffffc0000312e80 fffffc000031cde8
   +      b0 fffffc00003129e0 fffffc0000312a60
   +      c0 0000000000000a0d 00000000000000f4
   +      d0 00000000000001ec 0000009806700001
   +      e0 0000000000000000 0000000000000000
   +      f0 fffffc00010fba98 0000000000300000
   +     100 fffffc0000312ae0 fffffc00006a1500
   +     110 00000000010f8000 fffffc000031cde8
   +     120 0000000000000000 0000000000000000
   +     130 0000000000018000 0000000000000000
   +     140 0000004164020000 0000000000000000
   +     150 0000000000000000 0000000000000000
   +     160 00000000000147d0 ffffff000001d58f
   +     170 0000000000000000 ffffff80000f1fff
   +     180 ffffffffffffffff 000000000000d8f2
   +     190 fffffff005ffffff ffffff00006a257f
   +     1a0 ffffffffffe00000 0000000000200000
   +     1b0 0000000000000000 000000000000001a
   +     1c0 0000000000000c12 00000000000000f3
   +     1d0 ffffffffffe00000 0000000000100000
   +     1e0 0000000002010006 0000000040008840
   +     1f0 0000000000000000 0000000000272047
CIA machine check NOT expected!!!
CIA machine check: vector=0x670 pc=0xfffffc000031cde8 code=0x98
machine check type: processor detected hard error
pc = [<fffffc000031cde8>]  ra = [<fffffc000031cf58>]  ps = 0000    Not
tainted
pc is at __raw_readb+0x48/0x60
ra is at readb+0x18/0x30
v0 = 0000000000000000  t0 = fffffc85c4e400e0  t1 = fffffffffffffff9
t2 = 0000000000000003  t3 = 0000000044e400e0  t4 = 0000000000000000
t5 = 0000000002272000  t6 = 0000000000000000  t7 = fffffc00010f8000
a0 = 0000000000000001  a1 = 0000000000000001  a2 = fffffc00010fbae9
a3 = 0000000000000002  a4 = fffffc00010fbae8  a5 = 0000000000000000
t8 = 0000000000000000  t9 = fffffc0000481e78  t10= 0000000000000010
t11= 0000000000000008  pv = fffffc000031cf40  at = 0000000000000000
gp = fffffc00006a1500  sp = fffffc00010fba48
   +       0 0000000000000200 000001a000000118
   +      10 0000000000000098 0000000000000000
   +      20 0000000000000000 0000000000000000
   +      30 0000000000000000 0000000000000000
   +      40 0000000000000000 0000000000000000
   +      50 0000000000000000 0000000000000000
   +      60 fffffc85c4e400e0 fffffc0000312c20
   +      70 0000000000005200 0000000044e400e0
   +      80 0000000000000000 0000000002272000
   +      90 fffffc0000312ba0 1f1e161514020100
   +      a0 fffffc0000312e80 fffffc000031cde8
   +      b0 fffffc00003129e0 fffffc0000312a60
   +      c0 0000000000000a0d 00000000000000f4
   +      d0 00000000000001ec 0000009806700001
   +      e0 0000000000000000 0000000000000000
   +      f0 fffffc00010fba98 0000000000300000
   +     100 fffffc0000312ae0 fffffc00006a1500
   +     110 00000000010f8000 fffffc000031cde8
   +     120 0000000000000000 0000000000000000
   +     130 0000000000018000 0000000000000000
   +     140 0000004164020000 0000000000000000
   +     150 0000000000000000 0000000000000000
   +     160 00000000000147d0 ffffff000001d5cf
   +     170 0000000000000000 ffffff80000f1fff
   +     180 ffffffffffffffff 000000000000d8f2
   +     190 fffffff005ffffff ffffff00006bd5cf
   +     1a0 ffffffffffe00000 00000000000000ff
   +     1b0 0000000000000000 000000000000001a
   +     1c0 0000000000000c12 00000000000000f3
   +     1d0 ffffffffffe00000 0000000010100000
   +     1e0 0000000002010006 0000000040008840
   +     1f0 0000000000000000 0000000000272007
CIA machine check NOT expected!!!
CIA machine check: vector=0x670 pc=0xfffffc000031cde8 code=0x98
machine check type: processor detected hard error
pc = [<fffffc000031cde8>]  ra = [<fffffc000031cf58>]  ps = 0000    Not
tainted
pc is at __raw_readb+0x48/0x60
ra is at readb+0x18/0x30
v0 = 0000000000000000  t0 = fffffc85c4e400e0  t1 = fffffffffffffff9
t2 = 0000000000000003  t3 = 0000000044e400e0  t4 = 0000000000000000
t5 = 0000000002272000  t6 = 0000000000000000  t7 = fffffc00010f8000
a0 = 0000000000000001  a1 = 0000000000000001  a2 = fffffc00010fbae9
a3 = 0000000000000002  a4 = fffffc00010fbae8  a5 = 0000000000000000
t8 = 0000000000000000  t9 = fffffc0000481e78  t10= 0000000000000010
t11= 0000000000000008  pv = fffffc000031cf40  at = 0000000000000000
gp = fffffc00006a1500  sp = fffffc00010fba48
   +       0 0000000000000200 000001a000000118
   +      10 0000000000000098 0000000000000000
   +      20 0000000000000000 0000000000000000
   +      30 0000000000000000 0000000000000000
   +      40 0000000000000000 0000000000000000
   +      50 0000000000000000 0000000000000000
   +      60 fffffc85c4e400e0 fffffc0000312c20
   +      70 0000000000005200 0000000044e400e0
   +      80 0000000000000000 0000000002272000
   +      90 fffffc0000312ba0 1f1e161514020100
   +      a0 fffffc0000312e80 fffffc000031cde8
   +      b0 fffffc00003129e0 fffffc0000312a60
   +      c0 0000000000000a0d 00000000000000f4
   +      d0 00000000000001ec 0000009806700001
   +      e0 0000000000000000 0000000000000000
   +      f0 fffffc00010fba48 0000000000300000
   +     100 fffffc0000312ae0 fffffc00006a1500
   +     110 00000000010f8000 fffffc000031cde8
   +     120 0000000000000000 0000000000000000
   +     130 0000000000018000 0000000000000000
   +     140 0000004164020000 0000000000000000
   +     150 0000000000000000 0000000000000000
   +     160 00000000000147d0 ffffff00006bd5ef
   +     170 0000000000000000 ffffff80000f1fff
   +     180 ffffffffffffffff 000000000000d8f2
   +     190 fffffff005ffffff ffffff00006bd5cf
   +     1a0 ffffffffffe00000 00000000000000ff
   +     1b0 0000000000000000 000000000000001a
   +     1c0 0000000000000c12 00000000000000f3
   +     1d0 ffffffffffe00000 0000000010100000
   +     1e0 0000000002010006 0000000040008840
   +     1f0 0000000000000000 0000000000272007
CIA machine check NOT expected!!!
CIA machine check: vector=0x670 pc=0xfffffc000031cde8 code=0x98
machine check type: processor detected hard error
pc = [<fffffc000031cde8>]  ra = [<fffffc000031cf58>]  ps = 0000    Not
tainted
pc is at __raw_readb+0x48/0x60
ra is at readb+0x18/0x30
v0 = 0000000000000000  t0 = fffffc85c4e400e0  t1 = fffffffffffffff9
t2 = 0000000000000003  t3 = 0000000044e400e0  t4 = 0000000000000000
t5 = 0000000002272000  t6 = 0000000000000000  t7 = fffffc00010f8000
a0 = 0000000000000001  a1 = 0000000000000001  a2 = fffffc00010fbae9
a3 = 0000000000000002  a4 = fffffc00010fbae8  a5 = 0000000000000000
t8 = 0000000000000000  t9 = fffffc0000481e78  t10= 0000000000000010
t11= 0000000000000008  pv = fffffc000031cf40  at = 0000000000000000
gp = fffffc00006a1500  sp = fffffc00010fba48
   +       0 0000000000000200 000001a000000118
   +      10 0000000000000098 0000000000000000
   +      20 0000000000000000 0000000000000000
   +      30 0000000000000000 0000000000000000
   +      40 0000000000000000 0000000000000000
   +      50 0000000000000000 0000000000000000
   +      60 fffffc85c4e400e0 fffffc0000312c20
   +      70 0000000000005200 0000000044e400e0
   +      80 0000000000000000 0000000002272000
   +      90 fffffc0000312ba0 1f1e161514020100
   +      a0 fffffc0000312e80 fffffc000031cde8
   +      b0 fffffc00003129e0 fffffc0000312a60
   +      c0 0000000000000a0d 00000000000000f4
   +      d0 00000000000001ec 0000009806700001
   +      e0 0000000000000000 0000000000000000
   +      f0 fffffc00010fba48 0000000000300000
   +     100 fffffc0000312ae0 fffffc00006a1500
   +     110 00000000010f8000 fffffc000031cde8
   +     120 0000000000000000 0000000000000000
   +     130 0000000000018000 0000000000000000
   +     140 0000004164020000 0000000000000000
   +     150 0000000000000000 0000000000000000
   +     160 00000000000147d0 ffffff000001d5cf
   +     170 0000000000000000 ffffff80000f1fff
   +     180 ffffffffffffffff 000000000000d8f2
   +     190 fffffff005ffffff ffffff00006bd5cf
   +     1a0 ffffffffffe00000 00000000000000ff
   +     1b0 0000000000000000 000000000000001a
   +     1c0 0000000000000c12 00000000000000f3
   +     1d0 ffffffffffe00000 0000000010100000
   +     1e0 0000000002010006 0000000040008840
   +     1f0 0000000000000000 0000000000272007
CIA machine check NOT expected!!!
CIA machine check: vector=0x670 pc=0xfffffc000031cde8 code=0x98
machine check type: processor detected hard error
pc = [<fffffc000031cde8>]  ra = [<fffffc000031cf58>]  ps = 0000    Not
tainted
pc is at __raw_readb+0x48/0x60
ra is at readb+0x18/0x30
v0 = 0000000000000000  t0 = fffffc85c4e400e0  t1 = fffffffffffffff9
t2 = 0000000000000003  t3 = 0000000044e400e0  t4 = 0000000000000000
t5 = 0000000002272000  t6 = 0000000000000000  t7 = fffffc00010f8000
a0 = 0000000000000001  a1 = 0000000000000001  a2 = fffffc00010fbae9
a3 = 0000000000000002  a4 = fffffc00010fbae8  a5 = 0000000000000000
t8 = 0000000000000000  t9 = fffffc0000481e78  t10= 0000000000000010
t11= 0000000000000008  pv = fffffc000031cf40  at = 0000000000000000
gp = fffffc00006a1500  sp = fffffc00010fba28
   +       0 0000000000000200 000001a000000118
   +      10 0000000000000098 0000000000000000
   +      20 0000000000000000 0000000000000000
   +      30 0000000000000000 0000000000000000
   +      40 0000000000000000 0000000000000000
   +      50 0000000000000000 0000000000000000
   +      60 fffffc85c4e400e0 fffffc0000312c20
   +      70 0000000000005200 0000000044e400e0
   +      80 0000000000000000 0000000002272000
   +      90 fffffc0000312ba0 1f1e161514020100
   +      a0 fffffc0000312e80 fffffc000031cde8
   +      b0 fffffc00003129e0 fffffc0000312a60
   +      c0 0000000000000a0d 00000000000000f4
   +      d0 00000000000001ec 0000009806700001
   +      e0 0000000000000000 0000000000000000
   +      f0 fffffc00010fba48 0000000000300000
   +     100 fffffc0000312ae0 fffffc00006a1500
   +     110 00000000010f8000 fffffc000031cde8
   +     120 0000000000000000 0000000000000000
   +     130 0000000000018000 0000000000000000
   +     140 0000004164020000 0000000000000000
   +     150 0000000000000000 0000000000000000
   +     160 00000000000147d0 ffffff000001d5cf
   +     170 0000000000000000 ffffff80000f1fff
   +     180 ffffffffffffffff 000000000000d8f2
   +     190 fffffff005ffffff ffffff00006bd5cf
   +     1a0 ffffffffffe00000 00000000000000ff
   +     1b0 0000000000000000 000000000000001a
   +     1c0 0000000000000c12 00000000000000f3
   +     1d0 ffffffffffe00000 0000000010100000
   +     1e0 0000000002010006 0000000040008840
   +     1f0 0000000000000000 0000000000272007


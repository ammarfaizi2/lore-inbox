Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbRBRUyQ>; Sun, 18 Feb 2001 15:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129635AbRBRUyH>; Sun, 18 Feb 2001 15:54:07 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:56079
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129477AbRBRUyB>; Sun, 18 Feb 2001 15:54:01 -0500
Date: Sun, 18 Feb 2001 16:00:55 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: AIC7xxx oops with justin gibbs patch on 2.4.1 alpha noritake
Message-ID: <20010218160055.B16715@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is one bug that might affect the Alpha in there.  Once you have
> patched your kernel, you should change the typedef of bus_addr_t in
> drivers/scsi/aic7xxx/aic7xxx_osm.h from uint32_t to dma_addr_t:
> 
> typedef uint32_t bus_addr_t
> 
> becomes
> 
> typedef dma_addr_t bus_addr_t
> 
> I just noticed this today while testing an IA64 system (Compaq still
> hasn't shipped us our Alpha) and it will be fixed in 6.1.2.  6.1.2
> will probably release on Friday.
> 
> Please let me know how this works for you.

Justin, subject says it all.  here's the oops I get (only does it with the
adaptec card, nothing else)  See details at very bottom

Decoded Oops:
ksymoops 2.3.4 on alpha 2.4.1.  Options used
     -v /241-aic7xxx (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.1-aic7xxx (specified)
     -m /boot/System.map-2.4.1-aic7xxx (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address 003ffc0000156000
pc = [<fffffc000031b880>]  ra = [<fffffc000031c3a8>]  ps = 0007
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000001  t0 = 003ffc0000156000  t1 = 003ffc0000156000
t2 = 0000000040000000  t3 = 0000000000c5efff  t4 = 0000000000c5afff
t5 = fffffc0000156000  t6 = 0000000000000007  t7 = fffffc000837c000
s0 = 0000000000000001  s1 = 0000000000002000  s2 = fffffc000827d0c0
s3 = fffffc0000156080  s4 = 0000000000c5efff  s5 = 0000000000c49000
s6 = fffffc000827d280
a0 = fffffc0000156080  a1 = 0007fffffffffc00  a2 = 0000000000000002
a3 = 0000000000000000  a4 = 0000000000000000  a5 = 00000000000000ff
t8 = 0000000000000000  t9 = fffffc00004b69a8  t10= fffffc00004b6480
t11= 0000000000003fff  pv = fffffc000031c280  at = fffffc00004b77f0
gp = fffffc00004b5508  sp = fffffc000837faa8
Code: 42220642 e4200008 47e20401 2fe00000 47ff041f 2fe00000 <b7e10000> 42403532

>>PC;  fffffc000031b880 <iommu_arena_free+20/40>   <=====
Code;  fffffc000031b868 <iommu_arena_free+8/40>
0000000000000000 <_PC>:
Code;  fffffc000031b868 <iommu_arena_free+8/40>
   0:   42 06 22 42       s8addq       a1,t1,t1
Code;  fffffc000031b86c <iommu_arena_free+c/40>
   4:   08 00 20 e4       beq  t0,28 <_PC+0x28> fffffc000031b890 <iommu_arena_free+30/40>
Code;  fffffc000031b870 <iommu_arena_free+10/40>
   8:   01 04 e2 47       mov  t1,t0
Code;  fffffc000031b874 <iommu_arena_free+14/40>
   c:   00 00 e0 2f       unop 
Code;  fffffc000031b878 <iommu_arena_free+18/40>
  10:   1f 04 ff 47       nop  
Code;  fffffc000031b87c <iommu_arena_free+1c/40>
  14:   00 00 e0 2f       unop 
Code;  fffffc000031b880 <iommu_arena_free+20/40>   <=====
  18:   00 00 e1 b7       stq  zero,0(t0)   <=====
Code;  fffffc000031b884 <iommu_arena_free+24/40>
  1c:   32 35 40 42       subq a2,0x1,a2


Here's the dmesg when it happened (I took this via serial console which I was
logged in to)
[root@kakarot:/lvm/misc] cp /dev/zero .
(scsi1:A:2:0): data overrun detected in Data-out phase.  Tag == 0x33.
(scsi1:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x35.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:1:0): data overrun detected in Data-out phase.  Tag == 0x34.
(scsi1:A:1:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:1:0): data overrun detected in Data-out phase.  Tag == 0x30.
(scsi1:A:1:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:2:0): data overrun detected in Data-out phase.  Tag == 0x32.
(scsi1:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x31.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:2:0): data overrun detected in Data-out phase.  Tag == 0x3e.
(scsi1:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:1:0): data overrun detected in Data-out phase.  Tag == 0x3f.
(scsi1:A:1:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:2:0): data overrun detected in Data-out phase.  Tag == 0x3a.
(scsi1:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:1:0): data overrun detected in Data-out phase.  Tag == 0x3b.
(scsi1:A:1:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x3d.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:2:0): data overrun detected in Data-out phase.  Tag == 0x39.
(scsi1:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:1:0): data overrun detected in Data-out phase.  Tag == 0x47.
(scsi1:A:1:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:2:0): data overrun detected in Data-out phase.  Tag == 0x45.
(scsi1:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x3c.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:1:0): data overrun detected in Data-out phase.  Tag == 0x46.
(scsi1:A:1:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x38.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:2:0): data overrun detected in Data-out phase.  Tag == 0x41.
(scsi1:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:1:0): data overrun detected in Data-out phase.  Tag == 0x42.
(scsi1:A:1:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:2:0): data overrun detected in Data-out phase.  Tag == 0x40.
(scsi1:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x44.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:1:0): data overrun detected in Data-out phase.  Tag == 0x4e.
(scsi1:A:1:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:2:0): data overrun detected in Data-out phase.  Tag == 0x4c.
(scsi1:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x43.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:1:0): data overrun detected in Data-out phase.  Tag == 0x4d.
(scsi1:A:1:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x4f.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:2:0): data overrun detected in Data-out phase.  Tag == 0x48.
(scsi1:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:1:0): data overrun detected in Data-out phase.  Tag == 0x49.
(scsi1:A:1:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x4b.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:1:0): data overrun detected in Data-out phase.  Tag == 0x56.
(scsi1:A:1:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x4a.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x5.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:2:0): data overrun detected in Data-out phase.  Tag == 0x3.
(scsi1:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
NORITAKE APECS machine check: vector=0x660 pc=0xfffffc0000328b2c code=0x100000208
machine check type: MCHK_K_DCSR (retryable)
pc = [<fffffc0000328b2c>]  ra = [<fffffc0000310c64>]  ps = 0000
v0 = 0000000000000007  t0 = 0000000000000000  t1 = fffffffffffffffe
t2 = 0000000000000001  t3 = 0000000100000000  t4 = fffffc00004d4a18
t5 = fffffc0000156000  t6 = 0000000000000000  t7 = fffffc0008648000
a0 = 0000000000000000  a1 = 0000000010060000  a2 = 0000000000016000
a3 = 0000000000000000  a4 = fffffc000864bce0  a5 = 0000000000000000
t8 = 0000000000000004  t9 = 0000000000000070  t10= 0000000000000384
t11= fffffc0005fd5c00  pv = fffffc0000328aa0  at = 0000000000000000
gp = fffffc00004b5508  sp = fffffc000864b570
scsi1: PCI error Interrupt at seqaddr = 0x7c
scsi1: Received a Target Abort
apecs.c:conf_write: got stat0=802e4018
scsi1:0:0:0: Attempting to queue an ABORT message
scsi1: PCI error Interrupt at seqaddr = 0x7c
scsi1: Received a Target Abort
Unable to handle kernel paging request at virtual address 003ffc0000156000
scsi_eh_1(221): Oops 1
pc = [<fffffc000031b880>]  ra = [<fffffc000031c3a8>]  ps = 0007
v0 = 0000000000000001  t0 = 003ffc0000156000  t1 = 003ffc0000156000
t2 = 0000000040000000  t3 = 0000000000c5efff  t4 = 0000000000c5afff
t5 = fffffc0000156000  t6 = 0000000000000007  t7 = fffffc000837c000
s0 = 0000000000000001  s1 = 0000000000002000  s2 = fffffc000827d0c0
s3 = fffffc0000156080  s4 = 0000000000c5efff  s5 = 0000000000c49000
s6 = fffffc000827d280
a0 = fffffc0000156080  a1 = 0007fffffffffc00  a2 = 0000000000000002
a3 = 0000000000000000  a4 = 0000000000000000  a5 = 00000000000000ff
t8 = 0000000000000000  t9 = fffffc00004b69a8  t10= fffffc00004b6480
t11= 0000000000003fff  pv = fffffc000031c280  at = fffffc00004b77f0
gp = fffffc00004b5508  sp = fffffc000837faa8
Code: 42220642  s8addq a1,t1,t1
 e4200008  blt t0,.+36
 47e20401  or zero,t1,t0
 2fe00000  ldq_u zero,0(v0)
 47ff041f  or zero,zero,zero
 2fe00000  ldq_u zero,0(v0)
*b7e10000  stq zero,0(t0)
 42403532  subq a2,1,a2

Trace:31a4ac 3be73c 3bf10c 3bfa78 310610 3bf900 

Debian GNU/Linux 2.2 kakarot ttyS0
s3 = fffffc0000156080  s4 = 0000000000c5efff  s5 = 0000000000c49000
s6 = fffffc000827d280
a0 = fffffc0000156080  a1 = 0007fffffffffc00  a2 = 0000000000000002
a3 = 0000000000000000  a4 = 0000000000000000  a5 = 00000000000000ff
t8 = 0000000000000000  t9 = fffffc00004b69a8  t10= fffffc00004b6480
t11= 0000000000003fff  pv = fffffc000031c280  at = fffffc00004b77f0
gp = fffffc00004b5508  sp = fffffc000837faa8
Code: 42220642  s8addq a1,t1,t1
 e4200008  blt t0,.+36
 47e20401  or zero,t1,t0
 2fe00000  ldq_u zero,0(v0)
 47ff041f  or zero,zero,zero
 2fe00000  ldq_u zero,0(v0)
*b7e10000  stq zero,0(t0)
 42403532  subq a2,1,a2

Trace:31a4ac 3be73c 3bf10c 3bfa78 310610 3bf900 

Debian GNU/Linux 2.2 kakarot ttyS0

kakarot login:  == 0x4f.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:2:0): data overrun detected in Data-out phase.  Tag == 0x48.
(scsi1:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:1:0): data overrun detected in Data-out phase.  Tag == 0x49.
(scsi1:A:1:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x4b.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:1:0): data overrun detected in Data-out phase.  Tag == 0x56.
(scsi1:A:1:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x4a.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x5.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:2:0): data overrun detected in Data-out phase.  Tag == 0x3.
(scsi1:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
NORITAKE APECS machine check: vector=0x660 pc=0xfffffc0000328b2c code=0x10000020
8
machine check type: MCHK_K_DCSR (retryable)
pc = [<fffffc0000328b2c>]  ra = [<fffffc0000310c64>]  ps = 0000
v0 = 0000000000000007  t0 = 0000000000000000  t1 = fffffffffffffffe
t2 = 0000000000000001  t3 = 0000000100000000  t4 = fffffc00004d4a18
t5 = fffffc0000156000  t6 = 0000000000000000  t7 = fffffc0008648000
a0 = 0000000000000000  a1 = 0000000010060000  a2 = 0000000000016000
a3 = 0000000000000000  a4 = fffffc000864bce0  a5 = 0000000000000000
t8 = 0000000000000004  t9 = 0000000000000070  t10= 0000000000000384
t11= fffffc0005fd5c00  pv = fffffc0000328aa0  at = 0000000000000000
gp = fffffc00004b5508  sp = fffffc000864b570
scsi1: PCI error Interrupt at seqaddr = 0x7c
scsi1: Received a Target Abort
apecs.c:conf_write: got stat0=802e4018
scsi1:0:0:0: Attempting to queue an ABORT message
scsi1: PCI error Interrupt at seqaddr = 0x7c
scsi1: Received a Target Abort
Unable to handle kernel paging request at virtual address 003ffc0000156000
scsi_eh_1(221): Oops 1
pc = [<fffffc000031b880>]  ra = [<fffffc000031c3a8>]  ps = 0007
v0 = 0000000000000001  t0 = 003ffc0000156000  t1 = 003ffc0000156000
t2 = 0000000040000000  t3 = 0000000000c5efff  t4 = 0000000000c5afff
t5 = fffffc0000156000  t6 = 0000000000000007  t7 = fffffc000837c000
s0 = 0000000000000001  s1 = 0000000000002000  s2 = fffffc000827d0c0
s3 = fffffc0000156080  s4 = 0000000000c5efff  s5 = 0000000000c49000
s6 = fffffc000827d280
a0 = fffffc0000156080  a1 = 0007fffffffffc00  a2 = 0000000000000002
a3 = 0000000000000000  a4 = 0000000000000000  a5 = 00000000000000ff
t8 = 0000000000000000  t9 = fffffc00004b69a8  t10= fffffc00004b6480
t11= 0000000000003fff  pv = fffffc000031c280  at = fffffc00004b77f0
gp = fffffc00004b5508  sp = fffffc000837faa8
Code: 42220642  s8addq a1,t1,t1
 e4200008  blt t0,.+36
 47e20401  or zero,t1,t0
 2fe00000  ldq_u zero,0(v0)
 47ff041f  or zero,zero,zero
 2fe00000  ldq_u zero,0(v0)
*b7e10000  stq zero,0(t0)
 42403532  subq a2,1,a2

Trace:31a4ac 3be73c 3bf10c 3bfa78 310610 3bf900 

Debian GNU/Linux 2.2 kakarot ttyS0

kakarot login: 


>From the looks of it, it logged me out.  the 2nd oops I caused with the
sysrq-s.  As you can see, I copied /dev/zero to a disk.  That disk is
reiserfs ontop of LVM striping across 3 disks. 2.4.1 using the builtin
qlogic controller appears to be solid (had a 10 day uptime or so when I
shut it down.  before with the reiserfs patch it would crash every 3-4 days
w/o usage).  what's strange is the fact that once the disk is full it then
crashes.  Last time I tried this, after the system came back up I noticed
that there were 0 bytes left on the drive (well 1995kb, but I couldn't write
anything, I think that's a reiserfs bug, not sure)

Anything else, email me back

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals

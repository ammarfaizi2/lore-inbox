Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131255AbRCHCIe>; Wed, 7 Mar 2001 21:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131257AbRCHCIZ>; Wed, 7 Mar 2001 21:08:25 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:3855
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S131255AbRCHCIJ>; Wed, 7 Mar 2001 21:08:09 -0500
Date: Wed, 7 Mar 2001 21:09:43 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: 2.4.3-pre2 aic7xxx crash on alpha
Message-ID: <20010307210943.A1330@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can trigger this every time.
I'm using 2 2gb DEC drives (seagate) wide-scsi.  I have an adaptec
aha-2940uw card installed on the primary pci bus.
I'm using reiserfs and LVM (striped), but I can reproduce this w/o these.
All I have to do is:
for dev in /dev/sd[bcd];do cp /dev/zero $dev & ; done
and before it finishes, it crashes.  I think it crashes upon completion.

LVM basically does the same thing as far as writing to all 3 drives.
The way I caused the one below was coping /dev/zero to a reiserfs LVM drive
(1.6gb striped across all 3 disks).  This time, it didn't actually finish,
but it did write 1.49gb to the disk before it died (141mb left).

Dmesg output (including oops):
Linux version 2.4.3-pre2 (wakko@kakarot) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #7 Tue Mar 6 20:12:04 EST 2001
Booting on Noritake using machine vector Noritake from SRM
Command line: root=0801 ro console=ttyS0
memcluster 0, usage 1, start        0, end      171
memcluster 1, usage 0, start      171, end    20403
memcluster 2, usage 1, start    20403, end    20480
freeing pages 171:384
freeing pages 635:20403
On node 0 totalpages: 20480
zone(0): 20480 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=0801 ro console=ttyS0
Using epoch = 1900
Console: colour VGA+ 80x25
Calibrating delay loop... 525.28 BogoMIPS
Memory: 157088k/163224k available (1156k kernel code, 4768k reserved, 249k data, 232k init)
Dentry-cache hash table entries: 32768 (order: 6, 524288 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 65536 bytes)
Page-cache hash table entries: 32768 (order: 5, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 262144 bytes)
POSIX conformance testing by UNIFIX
  got res[9000:90ff] for resource 0 of Adaptec AIC-7881U
  got res[9400:943f] for resource 0 of Ensoniq ES1371 [AudioPCI-97]
  got res[2800000:2ffffff] for resource 1 of 3DLabs Permedia II 2D+3D
  got res[3000000:37fffff] for resource 2 of 3DLabs Permedia II 2D+3D
  got res[2200000:221ffff] for resource 0 of 3DLabs Permedia II 2D+3D
  got res[2220000:222ffff] for resource 6 of Adaptec AIC-7881U
  got res[2230000:223ffff] for resource 6 of 3DLabs Permedia II 2D+3D
  got res[2240000:2240fff] for resource 1 of Adaptec AIC-7881U
  got res[a000:a0ff] for resource 0 of Q Logic ISP1020
  got res[a400:a47f] for resource 0 of Digital Equipment Corporation DECchip 21142/43
  got res[a480:a4bf] for resource 0 of 3Com Corporation 3c905 100BaseTX [Boomerang]
  got res[3800000:383ffff] for resource 6 of Digital Equipment Corporation DECchip 21142/43
  got res[3840000:384ffff] for resource 6 of Q Logic ISP1020
  got res[3850000:385ffff] for resource 6 of 3Com Corporation 3c905 100BaseTX [Boomerang]
  got res[3860000:3860fff] for resource 1 of Q Logic ISP1020
  got res[3861000:386107f] for resource 1 of Digital Equipment Corporation DECchip 21142/43
PCI: Bus 1, bridge: Digital Equipment Corporation DECchip 21050
  IO window: a000-afff
  MEM window: 03800000-038fffff
PCI enable device: (Intel Corporation 82375EB)
  cmd reg 0x7
PCI enable device: (Digital Equipment Corporation DECchip 21050)
  cmd reg 0x107
PCI enable device: (Adaptec AIC-7881U)
  cmd reg 0x47
PCI enable device: (3DLabs Permedia II 2D+3D)
  cmd reg 0x7
PCI enable device: (Ensoniq ES1371 [AudioPCI-97])
  cmd reg 0x5
PCI enable device: (Q Logic ISP1020)
  cmd reg 0x47
PCI enable device: (Digital Equipment Corporation DECchip 21142/43)
  cmd reg 0x47
PCI enable device: (3Com Corporation 3c905 100BaseTX [Boomerang])
  cmd reg 0x47
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 103824kB/34608kB, 320 slots per queue
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS03 at 0x02e8 (irq = 3) is a 16550A
SCSI subsystem driver Revision: 1.00
qlogicisp : new isp1020 revision ID (2)
scsi0 : QLogic ISP1020 SCSI on PCI bus 01 device 00 irq 17 I/O base 0xa000
  Vendor: WDIGTL    Model: ENTERPRISE        Rev: 1.80
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ARCHIVE   Model: Python 25501-XXX  Rev: 2.54
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 4254819 512-byte hdwr sectors (2178 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 sda5
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack (637 buckets, 5096 max)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 232k freed
eth0: Digital DS21143 Tulip rev 48 at 0xa400, 00:00:F8:06:85:5D, IRQ 28.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block.
eth0:  Index #1 - Media 10baseT-FD (#4) described by a 21142 Serial PHY (2) block.
eth0:  Index #2 - Media 100baseTx (#3) described by a 21143 SYM PHY (4) block.
eth0:  Index #3 - Media 100baseTx-FD (#5) described by a 21143 SYM PHY (4) block.
nfs warning: mount version older than kernel
         <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: DEC       Model: RZ28D    (C) DEC  Rev: 0010
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi1, channel 0, id 0, lun 0
(scsi1:A:0): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: DEC       Model: RZ28D    (C) DEC  Rev: 0008
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdc at scsi1, channel 0, id 1, lun 0
(scsi1:A:1): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: DEC       Model: RZ28D    (C) DEC  Rev: 0008
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdd at scsi1, channel 0, id 2, lun 0
(scsi1:A:2): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
scsi1:0:0:0: Tagged Queuing enabled.  Depth 253
scsi1:0:1:0: Tagged Queuing enabled.  Depth 253
scsi1:0:2:0: Tagged Queuing enabled.  Depth 253
SCSI device sdb: 4110480 512-byte hdwr sectors (2105 MB)
sdc: Spinning up disk.................ready
SCSI device sdc: 4110480 512-byte hdwr sectors (2105 MB)
sdd: Spinning up disk..................ready
SCSI device sdd: 4110480 512-byte hdwr sectors (2105 MB)
lvm -- Module successfully initialized
reiserfs: checking transaction log (device 3a:00) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:02) ...
reiserfs: replayed 3 transactions in 5 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 3a:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x36.
(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:1:0): data overrun detected in Data-out phase.  Tag == 0x34.
(scsi1:A:1:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
(scsi1:A:2:0): data overrun detected in Data-out phase.  Tag == 0x33.
(scsi1:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
Unable to handle kernel paging request at virtual address 003ffc0000156000
cp(244): Oops 1
pc = [<fffffc000031b880>]  ra = [<fffffc000031c3a8>]  ps = 0007
v0 = 0000000000000000  t0 = 003ffc0000156000  t1 = 003ffc0000156000
t2 = 0000000040000000  t3 = 000000000ca50602  t4 = fffffc0008380000
t5 = fffffc0000156000  t6 = fffffc00004b61f0  t7 = fffffc0005da8000
s0 = 0000000000000001  s1 = 0000000000002000  s2 = fffffc0008278000
s3 = fffffc0000156080  s4 = 0000000000000000  s5 = ffffffffffffffff
s6 = fffffc00082782c0
a0 = fffffc0000156080  a1 = 0007fffffffffc00  a2 = 0000000000000002
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000000  t9 = fffffc00004b61e8  t10= 0000000000000060
t11= 10000000003ba001  pv = fffffc000031c280  at = fffffc00060fa020
gp = fffffc00004b5530  sp = fffffc0005dab798
Code: 42220642  s8addq a1,t1,t1
 e4200008  blt t0,.+36
 47e20401  or zero,t1,t0
 2fe00000  ldq_u zero,0(v0)
 47ff041f  or zero,zero,zero
 2fe00000  ldq_u zero,0(v0)
*b7e10000  stq zero,0(t0)
 42403532  subq a2,1,a2

Trace:315c5c 316660 31d574 316c44 310ab8 3c17d0 38df60 3c1818 3c1bf8 3b8be8 3c9bb8
3b8ca8 3b890c 328f74 328ddc 328b94 310c64 350640 36aaac 33d784 34d25c 310aa0
3109f8 
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Oops decoded:
ksymoops 2.3.4 on alpha 2.4.3-pre2.  Options used
     -v /243p2 (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.3-pre2/ (default)
     -m /boot/System.map-2.4.3-pre2 (default)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address 003ffc0000156000
cp(244): Oops 1
pc = [<fffffc000031b880>]  ra = [<fffffc000031c3a8>]  ps = 0007
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000000  t0 = 003ffc0000156000  t1 = 003ffc0000156000
t2 = 0000000040000000  t3 = 000000000ca50602  t4 = fffffc0008380000
t5 = fffffc0000156000  t6 = fffffc00004b61f0  t7 = fffffc0005da8000
s0 = 0000000000000001  s1 = 0000000000002000  s2 = fffffc0008278000
s3 = fffffc0000156080  s4 = 0000000000000000  s5 = ffffffffffffffff
s6 = fffffc00082782c0
a0 = fffffc0000156080  a1 = 0007fffffffffc00  a2 = 0000000000000002
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000000  t9 = fffffc00004b61e8  t10= 0000000000000060
t11= 10000000003ba001  pv = fffffc000031c280  at = fffffc00060fa020
gp = fffffc00004b5530  sp = fffffc0005dab798
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

Kernel panic: Aiee, killing interrupt handler!

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals

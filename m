Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUEFRh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUEFRh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUEFRh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:37:28 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:15280 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S261680AbUEFRgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:36:50 -0400
Message-ID: <313680C9A886D511A06000204840E1CF09429D61@whq-msgusr-02.pit.comms.marconi.com>
From: "Strange, John" <John.Strange@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Bug Report: 2.6.5 + LVM + EXT3 = boom
Date: Thu, 6 May 2004 13:36:47 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here it is..

Here's all the information I have, I'm not subscribed for the list so if you
need more information or have relevenant information please cc me.  I was
running some scripts to beat up the filesystem when it crashed..

Loops of Bonnie -s 1000 
Loops of tar cvf of a automount mount to the mountpoint /data which is the
LVM/EXT3 volume. 

[root@mikazuki-restore root]# uname -a 
Linux mikazuki-restore 2.6.5 #2 Wed May 5 10:24:15 EDT 2004 i686 i686 i386
GNU/Linux 

[root@mikazuki-restore root]# mount 
/dev/hda2 on / type ext3 (rw) 
none on /proc type proc (rw) 
usbdevfs on /proc/bus/usb type usbdevfs (rw) 
/dev/hda1 on /boot type ext3 (rw) 
/dev/vol0/data on /data type ext3 (rw) 
none on /dev/pts type devpts (rw,gid=5,mode=620) 
none on /dev/shm type tmpfs (rw) 
automount(pid17457) on /n.sun4-4.1 type autofs
(rw,fd=5,pgrp=17457,minproto=2,maxproto=3) 
automount(pid17478) on /deleted type autofs
(rw,fd=5,pgrp=17478,minproto=2,maxproto=3) 
automount(pid17459) on /nobackups type autofs
(rw,fd=5,pgrp=17459,minproto=2,maxproto=3) 
automount(pid17502) on /bfscad type autofs
(rw,fd=5,pgrp=17502,minproto=2,maxproto=3) 
automount(pid17528) on /homes type autofs
(rw,fd=5,pgrp=17528,minproto=2,maxproto=3) 
automount(pid17565) on /home type autofs
(rw,fd=5,pgrp=17565,minproto=2,maxproto=3) 
automount(pid17591) on /cad type autofs
(rw,fd=5,pgrp=17591,minproto=2,maxproto=3) 
automount(pid17619) on /us type autofs
(rw,fd=5,pgrp=17619,minproto=2,maxproto=3) 
automount(pid17646) on /- type autofs
(rw,fd=5,pgrp=17646,minproto=2,maxproto=3) 
nfsd on /proc/fs/nfsd type nfsd (rw) 
mixer:/vol/vol0/dis/jstrange on /us/jstrange type nfs (rw,addr=10.90.2.15) 

[root@mikazuki-restore root]# df 
Filesystem           1K-blocks      Used Available Use% Mounted on 
/dev/hda2             12452448   6437916   5381976  55% / 
/dev/hda1               101089     12696     83174  14% /boot 
/dev/vol0/data       965049448   8877892 907149812   1% /data 
none                    127812         0    127812   0% /dev/shm 
mixer:/vol/vol0/dis/jstrange 
                      56384920  37220236  19164684  67% /us/jstrange 

Assertion failure in __journal_unfile_buffer() at fs/jbd/transaction.c:1512:
"jh->b_jlist < 8" 
------------[ cut here ]------------ 
kernel BUG at fs/jbd/transaction.c:1512! 
invalid operand: 0000 [#1] 
PREEMPT 
CPU:    0 
EIP:    0060:[<c019ec24>]    Not tainted 
EFLAGS: 00010286   (2.6.5) 
EIP is at __journal_unfile_buffer+0x174/0x1c0 
eax: 00000062   ebx: ce9907f0   ecx: c1a79480   edx: c02d9e98 
esi: c9f33c00   edi: 00000000   ebp: c24d0ca0   esp: c8239cf8 
ds: 007b   es: 007b   ss: 0068 
Process pdflush (pid: 18304, threadinfo=c8238000 task=c1a79480) 
Stack: c02ad360 c029a343 c02ab3c6 000005e8 c02ab516 c8238000 cde521e0
ce9907f0 
       c63823a8 c019e258 ce9907f0 c24d0ca0 c0152c50 00000001 ce3c1360
00000000 
       00001000 c63823a8 c24d0ca0 00001000 c018f673 c63823a8 c24d0ca0
00000000 
Call Trace: 
 [<c019e258>] journal_dirty_data+0x128/0x200 
 [<c0152c50>] __block_write_full_page+0x270/0x480 
 [<c018f673>] ext3_journal_dirty_data+0x23/0x70 
 [<c018f497>] walk_page_buffers+0x77/0x80 
 [<c018fc92>] ext3_ordered_writepage+0x182/0x1f0 
 [<c018faf0>] journal_dirty_data_fn+0x0/0x20 
 [<c0172a2b>] mpage_writepages+0x22b/0x310 
 [<c018fb10>] ext3_ordered_writepage+0x0/0x1f0 
 [<c0138bc6>] do_writepages+0x36/0x40 
 [<c0170d9e>] __sync_single_inode+0xde/0x240 
 [<c017117c>] sync_sb_inodes+0x1ac/0x260 
 [<c0171287>] writeback_inodes+0x57/0xb0 
 [<c0138895>] background_writeout+0xb5/0x100 
 [<c0138fbc>] __pdflush+0xcc/0x1c0 
 [<c01390b0>] pdflush+0x0/0x30 
 [<c01390d8>] pdflush+0x28/0x30 
 [<c01387e0>] background_writeout+0x0/0x100 
 [<c01390b0>] pdflush+0x0/0x30 
 [<c012d67a>] kthread+0xaa/0xb0 
 [<c012d5d0>] kthread+0x0/0xb0 
 [<c01050c5>] kernel_thread_helper+0x5/0x10 

Code: 0f 0b e8 05 c6 b3 2a c0 8b 43 08 e9 ac fe ff ff c7 44 24 10 
 <6>note: pdflush[18304] exited with preempt_count 2 



System Information: 

00:00.0 Host bridge: Intel Corp. 82810E DC-133 GMCH [Graphics Memory
Controller Hub] (rev 03) 
        Flags: bus master, fast devsel, latency 0 

00:01.0 VGA compatible controller: Intel Corp. 82810E DC-133 CGC [Chipset
Graphics Controller] (rev 03) (prog-if 00 [VGA])

        Subsystem: Intel Corp.: Unknown device 4332 
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 11 
        Memory at f8000000 (32-bit, prefetchable) [size=64M] 
        Memory at ffa80000 (32-bit, non-prefetchable) [size=512K] 
        Capabilities: [dc] Power Management version 1 

00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02) (prog-if 00
[Normal decode]) 
        Flags: bus master, fast devsel, latency 0 
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=64 
        I/O behind bridge: 0000c000-0000dfff 
        Memory behind bridge: ff100000-ff8fffff 
        Prefetchable memory behind bridge: f6900000-f6afffff 

00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02) 
        Flags: bus master, medium devsel, latency 0 

00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if 80
[Master]) 
        Subsystem: Intel Corp. 82801AA IDE 
        Flags: bus master, medium devsel, latency 0 
        I/O ports at ffa0 [size=16] 

00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02) (prog-if 00 [UHCI])

        Subsystem: Intel Corp. 82801AA USB 
        Flags: bus master, medium devsel, latency 0, IRQ 10 
        I/O ports at ef80 [size=32] 

00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02) 
        Subsystem: Intel Corp. 82801AA SMBus 
        Flags: medium devsel, IRQ 9 
        I/O ports at efa0 [size=16] 

01:01.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
08) 
        Subsystem: Intel Corp. 82559 Fast Ethernet LAN on Motherboard 
        Flags: bus master, medium devsel, latency 64, IRQ 10 
        Memory at ff8fe000 (32-bit, non-prefetchable) [size=4K] 
        I/O ports at dd80 [size=64] 
        Memory at ff700000 (32-bit, non-prefetchable) [size=1M] 
        Expansion ROM at <unassigned> [disabled] [size=1M] 
        Capabilities: [dc] Power Management version 2 

01:07.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06) 
        Subsystem: Intel Corp.: Unknown device 4332 
        Flags: bus master, slow devsel, latency 64, IRQ 11 
        I/O ports at de80 [size=64] 
        Capabilities: [dc] Power Management version 1 

01:08.0 RAID bus controller: Promise Technology, Inc.: Unknown device 3319
(rev 02) 
        Subsystem: Promise Technology, Inc.: Unknown device 3319 
        Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 11 
        I/O ports at df00 [size=64] 
        I/O ports at dfa0 [size=16] 
        I/O ports at dc00 [size=128] 
        Memory at ff8ff000 (32-bit, non-prefetchable) [size=4K] 
        Memory at ff8c0000 (32-bit, non-prefetchable) [size=128K] 
        Expansion ROM at ff8e0000 [disabled] [size=64K] 
        Capabilities: [60] Power Management version 2 

01:0b.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
(prog-if 00 [Normal decode]) 
        Flags: bus master, medium devsel, latency 64 
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=64 
        I/O behind bridge: 0000c000-0000cfff 
        Memory behind bridge: ff100000-ff3fffff 
        Prefetchable memory behind bridge: 00000000f6900000-00000000f6900000

        Capabilities: [dc] Power Management version 1 

02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(rev 41) 
        Subsystem: Znyx Advanced Systems: Unknown device 0013 
        Flags: bus master, medium devsel, latency 64, IRQ 10 
        I/O ports at c480 [size=128] 
        Memory at ff3ff000 (32-bit, non-prefetchable) [size=1K] 
        Expansion ROM at ff2c0000 [disabled] [size=256K] 

02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(rev 41) 
        Subsystem: Znyx Advanced Systems: Unknown device 0013 
        Flags: bus master, medium devsel, latency 64, IRQ 11 
        I/O ports at c800 [size=128] 
        Memory at ff3ff400 (32-bit, non-prefetchable) [size=1K] 
        Expansion ROM at ff300000 [disabled] [size=256K] 

02:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(rev 41) 
        Subsystem: Znyx Advanced Systems: Unknown device 0013 
        Flags: bus master, medium devsel, latency 64, IRQ 9 
        I/O ports at c880 [size=128] 
        Memory at ff3ff800 (32-bit, non-prefetchable) [size=1K] 
        Expansion ROM at ff340000 [disabled] [size=256K] 

02:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(rev 41) 
        Subsystem: Znyx Advanced Systems: Unknown device 0013 
        Flags: bus master, medium devsel, latency 64, IRQ 11 
        I/O ports at cc00 [size=128] 
        Memory at ff3ffc00 (32-bit, non-prefetchable) [size=1K] 
        Expansion ROM at ff380000 [disabled] [size=256K] 

LVM Information: 

  --- Volume group --- 
  VG Name               vol0 
  System ID             
  Format                lvm2 
  Metadata Areas        4 
  Metadata Sequence No  2 
  VG Access             read/write 
  VG Status             resizable 
  MAX LV                255 
  Cur LV                1 
  Open LV               1 
  Max PV                255 
  Cur PV                4 
  Act PV                4 
  VG Size               935.02 GB 
  PE Size               4.00 MB 
  Total PE              239364 
  Alloc PE / Size       239364 / 935.02 GB 
  Free  PE / Size       0 / 0   
  VG UUID               gWAmLd-pKeB-pfpI-gk6h-CMxb-0iSG-IBkpNz 
   
  --- Physical volume --- 
  PV Name               /dev/sda1 
  VG Name               vol0 
  PV Size               233.75 GB / not usable 0   
  Allocatable           yes (but full) 
  PE Size (KByte)       4096 
  Total PE              59841 
  Free PE               0 
  Allocated PE          59841 
  PV UUID               6DxfrW-EOFe-xI96-vsB6-6tX8-D0sr-3Ro8Wg 
   
  --- Physical volume --- 
  PV Name               /dev/sdb1 
  VG Name               vol0 
  PV Size               233.75 GB / not usable 0   
  Allocatable           yes (but full) 
  PE Size (KByte)       4096 
  Total PE              59841 
  Free PE               0 
  Allocated PE          59841 
  PV UUID               XKasG3-N65c-zWzw-4QBG-HaIE-Yc8q-098WPk 
   
  --- Physical volume --- 
  PV Name               /dev/sdc1 
  VG Name               vol0 
  PV Size               233.75 GB / not usable 0   
  Allocatable           yes (but full) 
  PE Size (KByte)       4096 
  Total PE              59841 
  Free PE               0 
  Allocated PE          59841 
  PV UUID               uH6QUF-af6y-QodV-xhqn-ABo5-3jeO-0tw2kf 
   
  --- Physical volume --- 
  PV Name               /dev/sdd1 
  VG Name               vol0 
  PV Size               233.75 GB / not usable 0   
  Allocatable           yes (but full) 
  PE Size (KByte)       4096 
  Total PE              59841 
  Free PE               0 
  Allocated PE          59841 
  PV UUID               YW3tHM-n2Rx-AbmI-H2Vo-weGW-stWr-Y6cjNC 

John Strange
Network Analyst II
Marconi Communications
john.strange@marconi.com


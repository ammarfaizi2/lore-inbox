Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280618AbRKFWG2>; Tue, 6 Nov 2001 17:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280617AbRKFWGV>; Tue, 6 Nov 2001 17:06:21 -0500
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:40205 "EHLO
	mail.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S280619AbRKFWGG>; Tue, 6 Nov 2001 17:06:06 -0500
Date: Tue, 06 Nov 2001 15:05:49 -0700 (MST)
From: James Bourne <jbourne@MtRoyal.AB.CA>
Subject: 2.4.14 SMP Buffers/Cache reporting problem
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.33.0111061443050.19781-100000@jbourne2.mtroyal.ab.ca>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
X-Comment: This communication is intended for the use of the recipient to which
 it is
X-Comment: addressed, and may contain confidential, personal, and or privileged
X-Comment: information.  Please contact the sender immediately if you are not
 the
X-Comment: intended recipient of this communication, and do not copy,
 distribute, or
X-Comment: take action relying on it.  Any communication received in error, or
X-Comment: subsequent reply, should be deleted or destroyed.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Versions 2.4.13, 2.4.14 both SMP
ext3 patch versions ext3-2.4-0.9.15-2414, ext3-2.4-0.9.13-2413p6
Red Hat e1000 patch (not used on this machine)

2.4.14 has the loop patch to remove the 2 deactivate_page() calls.

System is a Dell 4300, dual 450, 1G RAM.  2xeepro100.  Megaraid with 3-9G
drives on raid5.

Ok, the problem is that after heavy workload with ext3, buffers and cache go
completely and utterly insane...

Output relates to 2.4.14 with ext3-2.4-0.9.15-2414, loop-patch, and e1000
patch from 2.4.7 (redhat).

We are in need to get a production system off 2.4.13.  Is this one a show
stopper?

Regards
James Bourne

---------------------------

# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  1054720000 210366464 844353536        0 169832448 18446744073561239552
Swap: 2147467264        0 2147467264
MemTotal:      1030000 kB
MemFree:        824564 kB
MemShared:           0 kB
Buffers:        165852 kB
Cached:       4294822460 kB
SwapCached:          0 kB
Active:         166492 kB
Inactive:        18604 kB
HighTotal:      131064 kB
HighFree:         2968 kB
LowTotal:       898936 kB
LowFree:        821596 kB
SwapTotal:     2097136 kB
SwapFree:      2097136 kB

******** Alt-Sysrq output ********
Nov  6 14:54:39 test-10-2 kernel: SysRq : Show Memory
Nov  6 14:54:39 test-10-2 kernel: Mem-info:
Nov  6 14:54:39 test-10-2 kernel: Free pages:      823460kB (  2068kB HighMem)
Nov  6 14:54:39 test-10-2 kernel: Zone:DMA freepages: 14148kB min:   512kB low:  1024kB high:  1536kB
Nov  6 14:54:39 test-10-2 kernel: Zone:Normal freepages:807244kB min:  1020kB low:  2040kB high:  3060kB
Nov  6 14:54:39 test-10-2 kernel: Zone:HighMem freepages:  2068kB min:  1020kB low:  2040kB high:  3060kB
Nov  6 14:54:39 test-10-2 kernel: ( Active: 41679, inactive: 4892, free: 205865 )
Nov  6 14:54:39 test-10-2 kernel: 1*4kB 2*8kB 3*16kB 2*32kB 1*64kB 3*128kB 1*256kB 0*512kB 1*1024kB 6*2048kB = 14148kB)
Nov  6 14:54:39 test-10-2 kernel: 1*4kB 19*8kB 101*16kB 95*32kB 170*64kB 132*128kB 0*256kB 1*512kB 0*1024kB 378*2048kB = 807244kB)
Nov  6 14:54:39 test-10-2 kernel: 5*4kB 2*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB = 2068kB)
Nov  6 14:54:39 test-10-2 kernel: Swap cache: add 0, delete 0, find 0/0, race 0+0
Nov  6 14:54:39 test-10-2 kernel: Free swap:       2097136kB
Nov  6 14:54:39 test-10-2 kernel: 262142 pages of RAM
Nov  6 14:54:39 test-10-2 kernel: 32766 pages of HIGHMEM
Nov  6 14:54:39 test-10-2 kernel: 4642 reserved pages
Nov  6 14:54:39 test-10-2 kernel: 10659 pages shared
Nov  6 14:54:39 test-10-2 kernel: 0 pages swap cached
Nov  6 14:54:39 test-10-2 kernel: 32 pages in page table cache
Nov  6 14:54:39 test-10-2 kernel: Buffer memory:   166088kB
Nov  6 14:54:39 test-10-2 kernel:     CLEAN: 40843 buffers, 162478 kbyte, 43 used (last=40737), 0 locked, 0 dirty
Nov  6 14:54:39 test-10-2 kernel:    LOCKED: 2 buffers, 8 kbyte, 1 used (last=1), 0 locked, 1 dirty
Nov  6 14:54:39 test-10-2 kernel:     DIRTY: 13 buffers, 40 kbyte, 13 used (last=13), 0 locked, 13 dirty
Nov  6 14:54:44 test-10-2 kernel: SysRq : Show Regs
Nov  6 14:54:44 test-10-2 kernel:
Nov  6 14:54:44 test-10-2 kernel: Pid: 0, comm:              swapper
Nov  6 14:54:44 test-10-2 kernel: EIP: 0010:[default_idle+44/64] CPU: 0 EFLAGS: 00000246    Not tainted
Nov  6 14:54:44 test-10-2 kernel: EIP: 0010:[<c010520c>] CPU: 0 EFLAGS: 00000246    Not tainted
Nov  6 14:54:44 test-10-2 kernel: EAX: 00000000 EBX: c01051e0 ECX: 00000032 EDX: c0258000
Nov  6 14:54:44 test-10-2 kernel: ESI: c0258000 EDI: c0258000 EBP: c01051e0 DS: 0018 ES: 0018
Nov  6 14:54:44 test-10-2 kernel: CR0: 8005003b CR2: 080c9f9c CR3: 37867000 CR4: 000006d0
Nov  6 14:54:44 test-10-2 kernel: Call Trace: [cpu_idle+82/112] [_stext+0/64]
Nov  6 14:54:44 test-10-2 kernel: Call Trace: [<c0105292>] [<c0105000>]

******** Test Output ********

Script started on Tue Nov  6 14:35:22 2001
[root@thissystem]# cd bar
[root@thissystem]# free
             total       used       free     shared    buffers     cached
Mem:       1030000      37564     992436          0       5032      13712
-/+ buffers/cache:      18820    1011180
Swap:      2097136          0    2097136

[root@thissystem]# ls
[root@thissystem]# let j=0 ; while [ $j -lt 10 ] ; do let j=$j+1 ; for i in 1 
 2 3 4 5 6 7 8 9 0 ; do dd if=/dev/zero of=$i.file bs=1024k count=10 ; done ; for
r i in 1 2 3 4 5 6 7 8 9 0 ; do cat $i.file > /dev/null ; done ; for i in 1 2 3 4
4 5 6 7 8 9 0 ; do rm -f $i.file ; done ; sync ; done
10+0 records in
10+0 records out
10+0 records in
10+0 records out
10+0 records in
10+0 records out
...
10+0 records in
10+0 records out
10+0 records in
10+0 records in
10+0 records out
10+0 records in
10+0 records out
10+0 records in
10+0 records out

[root@test-10-2]# free
             total       used       free     shared    buffers     cached
Mem:       1030000     226036     803964          0     165192 4294842208
-/+ buffers/cache: -4294781364 4295811364
Swap:      2097136          0    2097136
[root@test-10-2]# procinfo
Linux 2.4.14-1 (root@odin) (gcc 2.96 20000731 ) #1 2CPU [test-10-2.(none)]

Memory:      Total        Used        Free      Shared     Buffers      Cached
Mem:       1030000      226100      803900           0      165232     -125088
Swap:      2097136           0     2097136

Bootup: Tue Nov  6 14:33:35 2001    Load average: 1.54 0.72 0.27 1/47 1168

user  :       0:00:05.74   1.3%  page in :    14970  disk 1:     1717r    3892w
nice  :       0:00:00.00   0.0%  page out:   225213
system:       0:00:21.22   5.0%  swap in :        1
idle  :       0:06:37.36  93.6%  swap out:        0
uptime:       0:03:32.15         context :    20888

irq  0:     21216 timer                 irq 12:         6
irq  1:         3 keyboard              irq 16:        35 aic7xxx, aic7xxx
irq  2:         0 cascade [4]           irq 18:      5620 megaraid
irq  6:         7                       irq 21:      3305 eth0
irq  8:         1 rtc

[root@test-10-2]# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  1054720000 231538688 823181312        0 169218048 18446744073581461504
Swap: 2147467264        0 2147467264
MemTotal:      1030000 kB
MemFree:        803888 kB
MemShared:           0 kB
Buffers:        165252 kB
Cached:       4294842208 kB
SwapCached:          0 kB
Active:         186480 kB
Inactive:        19308 kB
HighTotal:      131064 kB
HighFree:         2156 kB
LowTotal:       898936 kB
LowFree:        801732 kB
SwapTotal:     2097136 kB
SwapFree:      2097136 kB
[root@test-10-2]# exit
exit

Script done on Tue Nov  6 14:37:27 2001



-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263727AbTJCM0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 08:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263730AbTJCM0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 08:26:15 -0400
Received: from rainstorm.omikk.bme.hu ([152.66.114.242]:3076 "EHLO
	rainstorm.org") by vger.kernel.org with ESMTP id S263727AbTJCMZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 08:25:23 -0400
Date: Fri, 3 Oct 2003 14:25:21 +0200 (CEST)
From: PALFFY Daniel <dpalffy@rainstorm.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6 deadlock, maybe ext2 related
Message-ID: <Pine.LNX.4.58.0310031401310.753@rainstorm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

This problem has been around since at least about test1, but this was the
first time i could capture a trace. On this low-traffic machine it occurs
about once a week (sometimes right after booting, this time it took two
weeks). Any help would be appreciated. Please CC.

The kernel version was:
Linux version 2.6.0-test4-bk10 (root@rainstorm) (gcc version 3.3.1
20030626 (Debian prerelease)) #1 Mon Sep 8 19:20:55 CEST 2003
It was compiled with ext[23] acl support, but acls were only active on the
(seemingly sane) ext3 partition that I could umount.

Alt-sysrq backtrace of the dead processes (with built-in ksymoops, serial
console capture):

SysRq : Kill All Tasks


Debian GNU/Linux woody rainstorm tts/0

rainstorm login: root
Password:
login(pam_unix)[10544]: session opened for user root by LOGIN(uid=0)
Last login: Fri Oct  3 13:29:19 2003 on tts/0
Linux rainstorm 2.6.0-test4-bk10 #1 Mon Sep 8 19:20:55 CEST 2003 i686 GNU/Linux
login[10544]: ROOT LOGIN  on `tts/0'
root@rainstorm:~# ps ax
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:08 init [2]
    2 ?        SWN    0:00 [ksoftirqd/0]
    3 ?        SW<    0:00 [events/0]
    4 ?        SW<    0:00 [kblockd/0]
    7 ?        SW     1:15 [kswapd0]
    8 ?        SW<    0:00 [aio/0]
    9 ?        SW     0:00 [scsi_eh_0]
  260 ?        SW     0:00 [kjournald]
  262 ?        SW     0:00 [kjournald]
  496 ?        D      0:02 /usr/sbin/apache
  548 ?        SW     0:04 [pdflush]
12359 ?        DW     0:02 [pdflush]
 7832 ?        D      0:00 /usr/sbin/apache
 7838 ?        D      0:00 /usr/sbin/apache
 9233 ?        D      0:00 /usr/sbin/apache
 9714 ?        D      0:00 /usr/sbin/apache
10174 ?        D      0:00 pine
10175 ?        D      0:00 postgres: checkpoint subprocess
10184 ?        D      0:00 pine
10188 ?        D      0:00 find /tmp -name *.att -cmin +15 -maxdepth 1 -exec rm
10197 ?        D      0:00 pine
10217 ?        D      0:00 find /tmp -name *.att -cmin +15 -maxdepth 1 -exec rm
10237 ?        D      0:00 pine
10246 ?        D      0:00 pine
10468 ?        D      0:00 find /tmp -name *.att -cmin +15 -maxdepth 1 -exec rm
10538 tty1     S      0:00 /sbin/getty 38400 vc/1
10539 vc/2     S      0:00 /sbin/getty 38400 vc/2
10540 vc/3     S      0:00 /sbin/getty 38400 vc/3
10541 vc/4     S      0:00 /sbin/getty 38400 vc/4
10542 vc/5     S      0:00 /sbin/getty 38400 vc/5
10543 vc/6     S      0:00 /sbin/getty 38400 vc/6
10544 tts/0    S      0:00 -bash
10550 tts/0    R      0:00 ps ax
root@rainstorm:~# ps axux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.3  1460  472 ?        S    Sep18   0:08 init [2]
root         2  0.0  0.0     0    0 ?        SWN  Sep18   0:00 [ksoftirqd/0]
root         3  0.0  0.0     0    0 ?        SW<  Sep18   0:00 [events/0]
root         4  0.0  0.0     0    0 ?        SW<  Sep18   0:00 [kblockd/0]
root         7  0.0  0.0     0    0 ?        SW   Sep18   1:15 [kswapd0]
root         8  0.0  0.0     0    0 ?        SW<  Sep18   0:00 [aio/0]
root         9  0.0  0.0     0    0 ?        SW   Sep18   0:00 [scsi_eh_0]
root       260  0.0  0.0     0    0 ?        SW   Sep18   0:00 [kjournald]
root       262  0.0  0.0     0    0 ?        SW   Sep18   0:00 [kjournald]
root       496  0.0  3.3 19312 4256 ?        D    Sep18   0:02 /usr/sbin/apache
root       548  0.0  0.0     0    0 ?        SW   Sep18   0:04 [pdflush]
root     12359  0.0  0.0     0    0 ?        DW   Sep30   0:02 [pdflush]
www-data  7832  0.0  5.0 29776 6404 ?        D    02:32   0:00 /usr/sbin/apache
www-data  7838  0.0  4.9 29712 6256 ?        D    02:35   0:00 /usr/sbin/apache
www-data  9233  0.0  4.9 29708 6224 ?        D    08:02   0:00 /usr/sbin/apache
www-data  9714  0.0  5.0 29784 6360 ?        D    10:15   0:00 /usr/sbin/apache
user1    10174  0.0  1.7  7452 2164 ?        D    12:58   0:00 pine
postgres 10175  0.0  1.7 16068 2160 ?        D    13:00   0:00 postgres: checkpo
user1    10184  0.0  1.7  7452 2164 ?        D    13:01   0:00 pine
www-data 10188  0.0  0.3  1484  416 ?        D    13:02   0:00 find /tmp -name *
user1    10197  0.0  1.7  7452 2164 ?        D    13:07   0:00 pine
www-data 10217  0.0  0.3  1484  416 ?        D    13:12   0:00 find /tmp -name *
dpalffy  10237  0.0  1.7  7452 2192 ?        D    13:14   0:00 pine
user1    10246  0.0  1.7  7452 2164 ?        D    13:14   0:00 pine
www-data 10468  0.0  0.3  1484  416 ?        D    13:22   0:00 find /tmp -name *
root     10538  0.0  0.3  1460  484 tty1     S    13:34   0:00 /sbin/getty 38400
root     10539  0.0  0.3  1460  484 vc/2     S    13:34   0:00 /sbin/getty 38400
root     10540  0.0  0.3  1460  484 vc/3     S    13:34   0:00 /sbin/getty 38400
root     10541  0.0  0.3  1460  484 vc/4     S    13:34   0:00 /sbin/getty 38400
root     10542  0.0  0.3  1460  484 vc/5     S    13:34   0:00 /sbin/getty 38400
root     10543  0.0  0.3  1460  484 vc/6     S    13:34   0:00 /sbin/getty 38400
root     10544  0.0  1.1  2604 1500 tts/0    S    13:34   0:00 -bash
root     10551  0.0  0.6  2832  840 tts/0    R    13:34   0:00 ps aux
root@rainstorm:~# SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 14, high 42, batch 7
cpu 0 cold: low 0, high 14, batch 7
HighMem per-cpu: empty

Free pages:       21656kB (0kB HighMem)
Active:12117 inactive:10205 dirty:2074 writeback:0 unstable:0 free:5414
DMA free:2076kB min:128kB low:256kB high:384kB active:10280kB inactive:552kB
Normal free:19580kB min:896kB low:1792kB high:2688kB active:38188kB inactive:40268kB
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB
DMA: 19*4kB 34*8kB 18*16kB 9*32kB 2*64kB 2*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 2076kB
Normal: 2395*4kB 854*8kB 78*16kB 24*32kB 8*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 19580kB
HighMem: empty
Swap cache: add 70653, delete 70037, find 58135/62996, race 0+0
Free swap:       129144kB
32768 pages of RAM
0 pages of HIGHMEM
1166 reserved pages
13626 pages shared
616 pages swap cached
SysRq : Show Regs

Pid: 0, comm:              swapper
EIP: 0060:[<c0106f93>] CPU: 0
EIP is at default_idle+0x23/0x40
 EFLAGS: 00000246    Not tainted
EAX: 00000000 EBX: c03b6000 ECX: c114ec60 EDX: 4d6cb428
ESI: 000a0200 EDI: c0105000 EBP: 0008e000 DS: 007b ES: 007b
CR0: 8005003b CR2: 080f9008 CR3: 02c74000 CR4: 000002d0
Call Trace:
 [<c0107024>] cpu_idle+0x34/0x40
 [<c03b870f>] start_kernel+0x13f/0x150
 [<c03b8480>] unknown_bootoption+0x0/0x120

SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S 00000000 115906744     1      0     2               (NOTLB)
c7fd9eb4 00000082 c7e89200 00000000 c0368294 c7fd9ec8 00000246 00000246
       c040a480 4d6cce24 c7fd9ec8 0000000b 0000000b c011da63 c7fd9ec8 4d6cce24
       c01576dc c040acf8 c040acf8 4d6cce24 4b87ad6e c011d9f0 c114f880 c040a480
Call Trace:
 [<c011da63>] schedule_timeout+0x63/0xc0
 [<c01576dc>] __pollwait+0x8c/0xd0
 [<c011d9f0>] process_timeout+0x0/0x10
 [<c015799f>] do_select+0x17f/0x2c0
 [<c0157650>] __pollwait+0x0/0xd0
 [<c0157deb>] sys_select+0x2db/0x4e0
 [<c010906f>] syscall_call+0x7/0xb

ksoftirqd/0   S 00000001 49680     2      1             3       (L-TLB)
c115bfd8 00000046 c115bfac 00000001 c040a208 fffffffd 00000246 00000246
       c114ec60 c115a000 c115a000 00000000 00000000 c0119c9c c114f270 00000013
       c0119be0 00000000 c0107195 00000000 00000000 00000000
Call Trace:
 [<c0119c9c>] ksoftirqd+0xbc/0xd0
 [<c0119be0>] ksoftirqd+0x0/0xd0
 [<c0107195>] kernel_thread_helper+0x5/0x10

events/0      S C215A0C4 181904     3      1             4     2 (L-TLB)
c117bf78 00000046 00000082 c215a0c4 00000282 c117bf78 00000082 c7ffdc38
       00000003 c117a000 c7ffdc28 00000282 c7ffdc20 c0123fdd c215a000 c117bfa0
       00000000 c7ffdc38 c7ffdc30 c0201ba0 c7ffdc28 c117a000 00000001 00000000
Call Trace:
 [<c0123fdd>] worker_thread+0x23d/0x270
 [<c0201ba0>] flush_to_ldisc+0x0/0xd0
 [<c0113400>] default_wake_function+0x0/0x30
 [<c0108f82>] ret_from_fork+0x6/0x14
 [<c0113400>] default_wake_function+0x0/0x30
 [<c0123da0>] worker_thread+0x0/0x270
 [<c0107195>] kernel_thread_helper+0x5/0x10

kblockd/0     S C7EDAEF4 115149880     4      1             7     3 (L-TLB)
c7f1ff78 00000046 00000082 c7edaef4 00000296 c7f1ff78 00000082 c7ffdd78
       00000003 c7f1e000 c7ffdd68 00000296 c7ffdd60 c0123fdd c7edae00 c7f1ffa0
       00000000 c7ffdd78 c7ffdd70 c0220bd0 c7ffdd68 c7f1e000 00000001 00000000
Call Trace:
 [<c0123fdd>] worker_thread+0x23d/0x270
 [<c0220bd0>] blk_unplug_work+0x0/0x20
 [<c0113400>] default_wake_function+0x0/0x30
 [<c0113400>] default_wake_function+0x0/0x30
 [<c0123da0>] worker_thread+0x0/0x270
 [<c0107195>] kernel_thread_helper+0x5/0x10

kswapd0       S C11A7F20 4294950112     7      1             8     4 (L-TLB)
c11a7f08 00000046 c11a7ef8 c11a7f20 0000000b 00000001 c11a7f1c 0000000a
       00000000 c11a6000 c0368510 c11a7f20 c11a7fc0 c01370eb c0368180 0000011d
       c11a7f20 00000000 00000014 00000000 00000000 00000143 00002fb7 00000eb3
Call Trace:
 [<c01370eb>] kswapd+0xeb/0x130
 [<c01146e0>] autoremove_wake_function+0x0/0x50
 [<c01146e0>] autoremove_wake_function+0x0/0x50
 [<c0137000>] kswapd+0x0/0x130
 [<c0107195>] kernel_thread_helper+0x5/0x10

aio/0         S C01211D2 4294945832     8      1             9     7 (L-TLB)
c11a5f78 00000046 c11a4000 c01211d2 00010000 c11ab244 c7fe1184 00010000
       00000010 c11a4000 00000000 c11a5fb4 c7f0b660 c0123fdd 00000011 c11a5fa0
       00000000 00000000 c7f0b670 00000000 c7f0b668 c11a4000 00000001 00000000
Call Trace:
 [<c01211d2>] do_sigaction+0x162/0x1f0
 [<c0123fdd>] worker_thread+0x23d/0x270
 [<c0113400>] default_wake_function+0x0/0x30
 [<c0113400>] default_wake_function+0x0/0x30
 [<c0123da0>] worker_thread+0x0/0x270
 [<c0107195>] kernel_thread_helper+0x5/0x10

scsi_eh_0     S 00000086 114481304     9      1           260     8 (L-TLB)
c7ed7f80 00000046 00000000 00000086 0000000a 00000086 00000001 c7fd9cb8
       00000001 c7ed6000 c7ed7fd8 00000286 c11aa060 c0107fd9 c7ed7fe0 00000000
       00000001 c11aa060 c0113400 c7ed7fe0 c7ed7fe0 c7ed7fd8 00000000 c7ed7fc8
Call Trace:
 [<c0107fd9>] __down_interruptible+0x99/0x110
 [<c0113400>] default_wake_function+0x0/0x30
 [<c0108097>] __down_failed_interruptible+0x7/0xc
 [<c02456a8>] .text.lock.scsi_error+0x41/0x49
 [<c0245370>] scsi_error_handler+0x0/0xd0
 [<c0107195>] kernel_thread_helper+0x5/0x10

kjournald     S C7EBE2C0 4293268368   260      1           262     9 (L-TLB)
c7bb7f68 00000046 00000282 c7ebe2c0 00000001 c7bb7f68 00000282 c7ebe304
       00000003 00000000 c7ebe2c0 00000001 c7ebe314 c01925a8 c7ebe2c0 00000005
       c7ebe304 00000000 00000000 c7d54690 c01146e0 c7bb7fac c7bb7fac 00000000
Call Trace:
 [<c01925a8>] kjournald+0x1d8/0x1e0
 [<c01146e0>] autoremove_wake_function+0x0/0x50
 [<c01146e0>] autoremove_wake_function+0x0/0x50
 [<c0108f82>] ret_from_fork+0x6/0x14
 [<c01923b0>] commit_timeout+0x0/0x10
 [<c01923d0>] kjournald+0x0/0x1e0
 [<c0107195>] kernel_thread_helper+0x5/0x10

kjournald     S C7EBE3C0 4183969152   262      1           496   260 (L-TLB)
c137bf68 00000046 00000282 c7ebe3c0 00000001 c137bf68 00000282 c7ebe404
       00000003 00000000 c7ebe3c0 00000001 c7ebe414 c01925a8 c7ebe3c0 00000005
       c7ebe404 00000000 00000000 c7d54ca0 c01146e0 c137bfac c137bfac 00000000
Call Trace:
 [<c01925a8>] kjournald+0x1d8/0x1e0
 [<c01146e0>] autoremove_wake_function+0x0/0x50
 [<c01146e0>] autoremove_wake_function+0x0/0x50
 [<c0108f82>] ret_from_fork+0x6/0x14
 [<c01923b0>] commit_timeout+0x0/0x10
 [<c01923d0>] kjournald+0x0/0x1e0
 [<c0107195>] kernel_thread_helper+0x5/0x10

apache        D C5C4BF80 65170072   496      1  7832     548   262 (NOTLB)
c5c4bf28 00000086 c64d5001 c5c4bf80 c7ff4760 00000001 c64d5005 c21628c0
       c019db10 c2162928 c1e24770 00000246 c2162930 c0107eeb 00000001 c1e24770
       c0113400 c2162930 c6025f3c c5c4bf80 c7ff4120 c138bc00 c64d5000 ffffffeb
Call Trace:
 [<c019db10>] ext2_permission+0x0/0x1c0
 [<c0107eeb>] __down+0x7b/0xd0
 [<c0113400>] default_wake_function+0x0/0x30
 [<c010808c>] __down_failed+0x8/0xc
 [<c0155ffc>] .text.lock.namei+0x109/0x16d
 [<c013bcf0>] do_munmap+0x120/0x160
 [<c013bd74>] sys_munmap+0x44/0x70
 [<c010906f>] syscall_call+0x7/0xb

pdflush       S 00000000 4260389184   548      1         12359   496 (L-TLB)
c40adfb0 00000046 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 c40adfdc c40adfd0 c40ac000 00000000 c0132659 00000000 c0132760
       00000000 00000000 c013276f c40adfd0 c61a58e0 00000000 00000000 c03685d4
Call Trace:
 [<c0132659>] __pdflush+0x89/0x190
 [<c0132760>] pdflush+0x0/0x20
 [<c013276f>] pdflush+0xf/0x20
 [<c0107190>] kernel_thread_helper+0x0/0x10
 [<c0107195>] kernel_thread_helper+0x5/0x10

pdflush       D 00000000 50574288 12359      1         10174   548 (L-TLB)
c70cdb98 00000046 80000000 00000000 c0368294 00000000 c03684bc 00000000
       00000220 c35d6abc c4090650 c70cdba4 c3cd7c20 c01f0cad c35d6ac0 c35d6ac0
       c770df48 c4090650 00000001 00000400 00000400 00000000 c3cd7c20 c017069f
Call Trace:
 [<c01f0cad>] rwsem_down_read_failed+0x8d/0x130
 [<c017069f>] .text.lock.dquot+0xcd/0x2fe
 [<c0194abd>] ext2_new_block+0xad/0x5e0
 [<c019767f>] ext2_alloc_block+0x6f/0xb0
 [<c01979b4>] ext2_alloc_branch+0x34/0x230
 [<c0197d05>] ext2_get_block+0x155/0x390
 [<c0226d1f>] as_insert_request+0x8f/0x110
 [<c014936f>] __block_write_full_page+0x27f/0x3c0
 [<c014a9fc>] block_write_full_page+0xcc/0xd0
 [<c0197bb0>] ext2_get_block+0x0/0x390
 [<c0197f5f>] ext2_writepage+0x1f/0x30
 [<c0197bb0>] ext2_get_block+0x0/0x390
 [<c01649a6>] mpage_writepage+0x2d6/0x580
 [<c01492c6>] __block_write_full_page+0x1d6/0x3c0
 [<c014a9fc>] block_write_full_page+0xcc/0xd0
 [<c014d160>] blkdev_get_block+0x0/0x60
 [<c0164eb2>] mpage_writepages+0x262/0x2a0
 [<c0197bb0>] ext2_get_block+0x0/0x390
 [<c019813f>] ext2_writepages+0x1f/0x30
 [<c0197bb0>] ext2_get_block+0x0/0x390
 [<c013231e>] do_writepages+0x1e/0x40
 [<c0163709>] __sync_single_inode+0xa9/0x200
 [<c0163aa3>] sync_sb_inodes+0x193/0x230
 [<c0163b7c>] writeback_inodes+0x3c/0x60
 [<c0132188>] wb_kupdate+0xa8/0x120
 [<c0132684>] __pdflush+0xb4/0x190
 [<c0132760>] pdflush+0x0/0x20
 [<c013276f>] pdflush+0xf/0x20
 [<c01320e0>] wb_kupdate+0x0/0x120
 [<c0107190>] kernel_thread_helper+0x0/0x10
 [<c0107195>] kernel_thread_helper+0x5/0x10

apache        D C53F5F70 11552596  7832    496          7838       (NOTLB)
c53f5ee0 00000082 00000000 c53f5f70 c7ff4760 00000001 c66a0005 c21628c0
       c019db10 c2162928 c48ef2d0 00000246 c2162930 c0107eeb 00000001 c48ef2d0
       c0113400 c1d8def4 c2162930 c53f5f70 c7ff4120 c138bc00 ffffffeb 000000c3
Call Trace:
 [<c019db10>] ext2_permission+0x0/0x1c0
 [<c0107eeb>] __down+0x7b/0xd0
 [<c0113400>] default_wake_function+0x0/0x30
 [<c010808c>] __down_failed+0x8/0xc
 [<c0155f70>] .text.lock.namei+0x7d/0x16d
 [<c014570e>] filp_open+0x3e/0x70
 [<c0145b0b>] sys_open+0x5b/0x90
 [<c010906f>] syscall_call+0x7/0xb

apache        D C1D8DF70 4278280576  7838    496          9233  7832 (NOTLB)
c1d8dee0 00000086 00000000 c1d8df70 c7ff4760 00000001 c1930005 c21628c0
       c019db10 c2162928 c2d758a0 00000246 c2162930 c0107eeb 00000001 c2d758a0
       c0113400 c3b11e58 c53f5ef4 c1d8df70 c7ff4120 c138bc00 ffffffeb 000000c3
Call Trace:
 [<c019db10>] ext2_permission+0x0/0x1c0
 [<c0107eeb>] __down+0x7b/0xd0
 [<c0113400>] default_wake_function+0x0/0x30
 [<c010808c>] __down_failed+0x8/0xc
 [<c0155f70>] .text.lock.namei+0x7d/0x16d
 [<c014570e>] filp_open+0x3e/0x70
 [<c0145b0b>] sys_open+0x5b/0x90
 [<c010906f>] syscall_call+0x7/0xb

apache        D 00000000 45345604  9233    496          9714  7838 (NOTLB)
c6bd1eb4 00000086 00000000 00000000 c01958b9 c21628c0 00000000 c7fce880
       04004760 c35d6abc c4091270 c6bd1ec0 ffffffff c01f0dcd c35d6ac0 c770df48
       c6befac4 c4091270 00000002 00000000 c21628c0 00000000 ffffffff c017065e
Call Trace:
 [<c01958b9>] ext2_find_entry+0xc9/0x200
 [<c01f0dcd>] rwsem_down_write_failed+0x7d/0x120
 [<c017065e>] .text.lock.dquot+0x8c/0x2fe
 [<c01525e6>] permission+0x46/0x50
 [<c015390e>] vfs_create+0xde/0x120
 [<c0153f46>] open_namei+0x3a6/0x400
 [<c014570e>] filp_open+0x3e/0x70
 [<c0145b0b>] sys_open+0x5b/0x90
 [<c010906f>] syscall_call+0x7/0xb

apache        D C278A120 77489808  9714    496                9233 (NOTLB)
c6befab8 00000086 c278a2a0 c278a120 c0292604 c278a120 c1e1e460 c882a040
       c041f460 c35d6abc c2207390 c6befac4 c7e400c0 c01f0cad c35d6ac0 c6bd1ec0
       c35d6ac0 c2207390 00000001 00000400 00000400 00000000 c7e400c0 c017069f
Call Trace:
 [<c0292604>] tcp_v4_rcv+0x654/0x880
 [<c01f0cad>] rwsem_down_read_failed+0x8d/0x130
 [<c017069f>] .text.lock.dquot+0xcd/0x2fe
 [<c02773d5>] ip_local_deliver_finish+0xc5/0x1c0
 [<c0277310>] ip_local_deliver_finish+0x0/0x1c0
 [<c0194abd>] ext2_new_block+0xad/0x5e0
 [<c019767f>] ext2_alloc_block+0x6f/0xb0
 [<c01979b4>] ext2_alloc_branch+0x34/0x230
 [<c0197d05>] ext2_get_block+0x155/0x390
 [<c026626b>] netif_receive_skb+0x17b/0x200
 [<c0149693>] __block_prepare_write+0x1e3/0x420
 [<c015e0dd>] inode_update_time+0xcd/0xe0
 [<c014a0b4>] block_prepare_write+0x34/0x50
 [<c0197bb0>] ext2_get_block+0x0/0x390
 [<c012ef4e>] generic_file_aio_write_nolock+0x36e/0xa90
 [<c0197bb0>] ext2_get_block+0x0/0x390
 [<c027c1c0>] ip_finish_output2+0x0/0x190
 [<c027c190>] dst_output+0x0/0x30
 [<c027a57c>] ip_queue_xmit+0x40c/0x520
 [<c027c190>] dst_output+0x0/0x30
 [<c012f6ee>] generic_file_write_nolock+0x7e/0xa0
 [<c0148c92>] __find_get_block+0x52/0xc0
 [<c0148d2b>] __getblk+0x2b/0x60
 [<c0148ddf>] __bread+0x1f/0x40
 [<c016f7d3>] dquot_free_space+0x63/0x110
 [<c01945f7>] ext2_free_blocks+0xe7/0x2f0
 [<c012f7fb>] generic_file_write+0x5b/0x80
 [<c0170ac6>] v1_commit_dqblk+0xa6/0x100
 [<c016e5de>] commit_dqblk+0x3e/0x60
 [<c016e955>] dqput+0x35/0xc0
 [<c0148a22>] mark_buffer_dirty+0x32/0x50
 [<c016f4ad>] dquot_drop_nolock+0x3d/0x50
 [<c016f4ef>] dquot_drop+0x2f/0x60
 [<c019687f>] ext2_free_inode+0x14f/0x170
 [<c0197530>] ext2_delete_inode+0x0/0x90
 [<c0197530>] ext2_delete_inode+0x0/0x90
 [<c015dc45>] generic_delete_inode+0x85/0x120
 [<c015de75>] iput+0x55/0x80
 [<c015b5d4>] dput+0xd4/0x170
 [<c01473c9>] __fput+0x99/0xf0
 [<c0145bc9>] filp_close+0x59/0x90
 [<c0145c50>] sys_close+0x50/0x60
 [<c010906f>] syscall_call+0x7/0xb

pine          D 00000202 4231677776 10174      1         10184 12359 (NOTLB)
c3b11e44 00000086 00000060 00000202 c3b11e94 c4ab04e0 3f7d55b7 3691c225
       c4ab051c c2162928 c776b2d0 00000246 c2162930 c0107eeb 00000001 c776b2d0
       c0113400 c575be58 c1d8def4 c1080d68 00000000 c012ddf9 00000000 c2162928
Call Trace:
 [<c0107eeb>] __down+0x7b/0xd0
 [<c0113400>] default_wake_function+0x0/0x30
 [<c012ddf9>] __generic_file_aio_read+0x1c9/0x200
 [<c010808c>] __down_failed+0x8/0xc
 [<c0155ef8>] .text.lock.namei+0x5/0x16d
 [<c0152a66>] do_lookup+0x96/0xb0
 [<c0152e8c>] link_path_walk+0x40c/0x7f0
 [<c0153709>] __user_walk+0x49/0x60
 [<c014eeec>] vfs_lstat+0x1c/0x60
 [<c014f5ab>] sys_lstat64+0x1b/0x40
 [<c010906f>] syscall_call+0x7/0xb

postmaster    D 00000020 89151680 10175      1         10538 10468 (NOTLB)
c770df3c 00000086 c770df2c 00000020 c770df24 c0000000 00000580 00000000
       00000000 c35d6abc c2206160 c770df48 c35d6a98 c01f0cad c35d6ac0 c70cdba4
       c6bd1ec0 c2206160 00000001 c35d6a00 ffffffff c35d6a00 c35d6a98 c0170629
Call Trace:
 [<c01f0cad>] rwsem_down_read_failed+0x8d/0x130
 [<c0170629>] .text.lock.dquot+0x57/0x2fe
 [<c016e6c0>] vfs_quota_sync+0x0/0x1a0
 [<c017256c>] sync_dquots+0x6c/0x70
 [<c0147b47>] do_sync+0x37/0x80
 [<c0147b9f>] sys_sync+0xf/0x20
 [<c010906f>] syscall_call+0x7/0xb

pine          D 00000000 59983504 10184      1         10197 10174 (NOTLB)
c575be44 00000086 00000009 00000000 00000083 c010ac5c 00000009 c03b4b20
       00000001 c2162928 c1e25390 00000246 c2162930 c0107eeb 00000001 c1e25390
       c0113400 c3c8ff3c c3b11e58 c10acc10 00000000 0000007b 00000000 c2162928
Call Trace:
 [<c010ac5c>] do_IRQ+0x8c/0xf0
 [<c0107eeb>] __down+0x7b/0xd0
 [<c0113400>] default_wake_function+0x0/0x30
 [<c010808c>] __down_failed+0x8/0xc
 [<c0155ef8>] .text.lock.namei+0x5/0x16d
 [<c0152a66>] do_lookup+0x96/0xb0
 [<c0152e8c>] link_path_walk+0x40c/0x7f0
 [<c0153709>] __user_walk+0x49/0x60
 [<c014eeec>] vfs_lstat+0x1c/0x60
 [<c014f5ab>] sys_lstat64+0x1b/0x40
 [<c010906f>] syscall_call+0x7/0xb

find          D C658C2A0 23576800 10188      1         10237 10246 (NOTLB)
c3c8ff28 00000082 c4f03d40 c658c2a0 c2611940 c0111c3c c4f03d20 c658c2a0
       400c13a0 c2162928 c2611940 00000246 c2162930 c0107eeb 00000001 c2611940
       c0113400 c5ca5e58 c575be58 10e03069 3f7d5541 1c496f65 c2162928 c21628c0
Call Trace:
 [<c0111c3c>] do_page_fault+0x12c/0x469
 [<c0107eeb>] __down+0x7b/0xd0
 [<c0113400>] default_wake_function+0x0/0x30
 [<c010808c>] __down_failed+0x8/0xc
 [<c0195520>] ext2_readdir+0x0/0x2d0
 [<c01575c6>] .text.lock.readdir+0x5/0x1f
 [<c0157571>] sys_getdents64+0x81/0xd1
 [<c01573e0>] filldir64+0x0/0x110
 [<c010906f>] syscall_call+0x7/0xb

pine          D C012D875 78993888 10197      1         10246 10184 (NOTLB)
c5ca5e44 00000086 00000000 c012d875 c5ca5e94 c4ab04e0 3f7d57d8 161c2b68
       c4ab051c c2162928 c114e040 00000246 c2162930 c0107eeb 00000001 c114e040
       c0113400 c4053f3c c3c8ff3c c10cbae8 00000000 c012ddf9 00000000 c2162928
Call Trace:
 [<c012d875>] do_generic_mapping_read+0x105/0x3c0
 [<c0107eeb>] __down+0x7b/0xd0
 [<c0113400>] default_wake_function+0x0/0x30
 [<c012ddf9>] __generic_file_aio_read+0x1c9/0x200
 [<c010808c>] __down_failed+0x8/0xc
 [<c0155ef8>] .text.lock.namei+0x5/0x16d
 [<c0152a66>] do_lookup+0x96/0xb0
 [<c0152e8c>] link_path_walk+0x40c/0x7f0
 [<c0153709>] __user_walk+0x49/0x60
 [<c014eeec>] vfs_lstat+0x1c/0x60
 [<c014f5ab>] sys_lstat64+0x1b/0x40
 [<c010906f>] syscall_call+0x7/0xb

find          D C3129A20 4239504144 10217      1         10468 10237 (NOTLB)
c4053f28 00000082 c4f03240 c3129a20 c7536710 c0111c3c c4f03220 c3129a20
       400c13a0 c2162928 c7536710 00000246 c2162930 c0107eeb 00000001 c7536710
       c0113400 c75a1e58 c5ca5e58 10e03069 3f7d5541 1c496f65 c2162928 c21628c0
Call Trace:
 [<c0111c3c>] do_page_fault+0x12c/0x469
 [<c0107eeb>] __down+0x7b/0xd0
 [<c0113400>] default_wake_function+0x0/0x30
 [<c010808c>] __down_failed+0x8/0xc
 [<c0195520>] ext2_readdir+0x0/0x2d0
 [<c01575c6>] .text.lock.readdir+0x5/0x1f
 [<c0157571>] sys_getdents64+0x81/0xd1
 [<c01573e0>] filldir64+0x0/0x110
 [<c010906f>] syscall_call+0x7/0xb

pine          D C012D875 427912 10237      1         10217 10188 (NOTLB)
c75a1e44 00000082 00000000 c012d875 c75a1e94 c1427700 3f7d5969 1de226d5
       c142773c c2162928 c7537330 00000246 c2162930 c0107eeb 00000001 c7537330
       c0113400 c248be58 c4053f3c c10b6d50 00000000 c012ddf9 00000000 c2162928
Call Trace:
 [<c012d875>] do_generic_mapping_read+0x105/0x3c0
 [<c0107eeb>] __down+0x7b/0xd0
 [<c0113400>] default_wake_function+0x0/0x30
 [<c012ddf9>] __generic_file_aio_read+0x1c9/0x200
 [<c010808c>] __down_failed+0x8/0xc
 [<c0155ef8>] .text.lock.namei+0x5/0x16d
 [<c0152a66>] do_lookup+0x96/0xb0
 [<c0152e8c>] link_path_walk+0x40c/0x7f0
 [<c0153709>] __user_walk+0x49/0x60
 [<c014eeec>] vfs_lstat+0x1c/0x60
 [<c014f5ab>] sys_lstat64+0x1b/0x40
 [<c010906f>] syscall_call+0x7/0xb

pine          D C012D875 4233941680 10246      1         10188 10197 (NOTLB)
c248be44 00000086 00000000 c012d875 c248be94 00003a89 c03682d0 00000006
       c0368370 c2162928 c5ebc770 00000246 c2162930 c0107eeb 00000001 c5ebc770
       c0113400 c6025f3c c75a1e58 c10a0118 00000000 00000007 00000000 c2162928
Call Trace:
 [<c012d875>] do_generic_mapping_read+0x105/0x3c0
 [<c0107eeb>] __down+0x7b/0xd0
 [<c0113400>] default_wake_function+0x0/0x30
 [<c010808c>] __down_failed+0x8/0xc
 [<c0155ef8>] .text.lock.namei+0x5/0x16d
 [<c0152a66>] do_lookup+0x96/0xb0
 [<c0152e8c>] link_path_walk+0x40c/0x7f0
 [<c0153709>] __user_walk+0x49/0x60
 [<c014eeec>] vfs_lstat+0x1c/0x60
 [<c014f5ab>] sys_lstat64+0x1b/0x40
 [<c010906f>] syscall_call+0x7/0xb

find          D C4272560 68975008 10468      1         10175 10217 (NOTLB)
c6025f28 00000082 c341ae60 c4272560 c1e5c080 c0111c3c c341ae40 c4272560
       400c13a0 c2162928 c1e5c080 00000246 c2162930 c0107eeb 00000001 c1e5c080
       c0113400 c5c4bf3c c248be58 10e03069 3f7d5541 1c496f65 c2162928 c21628c0
Call Trace:
 [<c0111c3c>] do_page_fault+0x12c/0x469
 [<c0107eeb>] __down+0x7b/0xd0
 [<c0113400>] default_wake_function+0x0/0x30
 [<c010808c>] __down_failed+0x8/0xc
 [<c0195520>] ext2_readdir+0x0/0x2d0
 [<c01575c6>] .text.lock.readdir+0x5/0x1f
 [<c0157571>] sys_getdents64+0x81/0xd1
 [<c01573e0>] filldir64+0x0/0x110
 [<c010906f>] syscall_call+0x7/0xb

getty         S 00000000 3112428 10538      1         10539 10175 (NOTLB)
c2155e7c 00000082 c012d44a 00000000 00000009 c0212235 c114b000 c00b81f2
       00000008 c35fa000 7fffffff c2154000 00000001 c011dab5 000000ff 00000000
       c00b8202 c00b81f2 00000000 ffffffff 00000286 c35fa000 c0212eca 00000008
Call Trace:
 [<c012d44a>] find_get_page+0x1a/0x30
 [<c0212235>] do_con_write+0x295/0x760
 [<c011dab5>] schedule_timeout+0xb5/0xc0
 [<c0212eca>] con_flush_chars+0x4a/0x50
 [<c0204974>] read_chan+0x654/0x7f0
 [<c0204c7c>] write_chan+0x16c/0x230
 [<c0113400>] default_wake_function+0x0/0x30
 [<c0113400>] default_wake_function+0x0/0x30
 [<c01ff9ec>] tty_write+0x18c/0x1f0
 [<c01ff83a>] tty_read+0xca/0xf0
 [<c01ff860>] tty_write+0x0/0x1f0
 [<c0146348>] vfs_read+0xb8/0x130
 [<c01465f2>] sys_read+0x42/0x70
 [<c010906f>] syscall_call+0x7/0xb

getty         S 00000000 4261675192 10539      1         10540 10538 (NOTLB)
c5577e7c 00000082 c012d44a 00000000 c6348000 c0212235 c123f600 00000020
       00000008 c6348000 7fffffff c5576000 00000001 c011dab5 000000ff 00000000
       c460d202 00000000 00000001 ffffffff 00000286 c6348000 c0212eca 00000008
Call Trace:
 [<c012d44a>] find_get_page+0x1a/0x30
 [<c0212235>] do_con_write+0x295/0x760
 [<c011dab5>] schedule_timeout+0xb5/0xc0
 [<c0212eca>] con_flush_chars+0x4a/0x50
 [<c0204974>] read_chan+0x654/0x7f0
 [<c0204c7c>] write_chan+0x16c/0x230
 [<c0113400>] default_wake_function+0x0/0x30
 [<c0113400>] default_wake_function+0x0/0x30
 [<c01ff9ec>] tty_write+0x18c/0x1f0
 [<c01ff83a>] tty_read+0xca/0xf0
 [<c01ff860>] tty_write+0x0/0x1f0
 [<c0146348>] vfs_read+0xb8/0x130
 [<c01465f2>] sys_read+0x42/0x70
 [<c010906f>] syscall_call+0x7/0xb

getty         S 00000000 61765920 10540      1         10541 10539 (NOTLB)
c60f9e7c 00000086 c012d44a 00000000 c5af6000 c0212235 c3564600 00000020
       00000008 c5af6000 7fffffff c60f8000 00000001 c011dab5 000000ff 00000000
       c75d4202 00000000 00000002 ffffffff 00000286 c5af6000 c0212eca 00000008
Call Trace:
 [<c012d44a>] find_get_page+0x1a/0x30
 [<c0212235>] do_con_write+0x295/0x760
 [<c011dab5>] schedule_timeout+0xb5/0xc0
 [<c0212eca>] con_flush_chars+0x4a/0x50
 [<c0204974>] read_chan+0x654/0x7f0
 [<c0204c7c>] write_chan+0x16c/0x230
 [<c0113400>] default_wake_function+0x0/0x30
 [<c0113400>] default_wake_function+0x0/0x30
 [<c01ff9ec>] tty_write+0x18c/0x1f0
 [<c01ff83a>] tty_read+0xca/0xf0
 [<c01ff860>] tty_write+0x0/0x1f0
 [<c0146348>] vfs_read+0xb8/0x130
 [<c01465f2>] sys_read+0x42/0x70
 [<c010906f>] syscall_call+0x7/0xb

getty         S 00000000 94419424 10541      1         10542 10540 (NOTLB)
c7831e7c 00000086 c012d44a 00000000 c3419000 c0212235 c3564800 00000020
       00000008 c3419000 7fffffff c7830000 00000001 c011dab5 000000ff 00000000
       c75dd202 00000000 00000003 ffffffff 00000286 c3419000 c0212eca 00000008
Call Trace:
 [<c012d44a>] find_get_page+0x1a/0x30
 [<c0212235>] do_con_write+0x295/0x760
 [<c011dab5>] schedule_timeout+0xb5/0xc0
 [<c0212eca>] con_flush_chars+0x4a/0x50
 [<c0204974>] read_chan+0x654/0x7f0
 [<c0204c7c>] write_chan+0x16c/0x230
 [<c0113400>] default_wake_function+0x0/0x30
 [<c0113400>] default_wake_function+0x0/0x30
 [<c01ff9ec>] tty_write+0x18c/0x1f0
 [<c01ff83a>] tty_read+0xca/0xf0
 [<c01ff860>] tty_write+0x0/0x1f0
 [<c0146348>] vfs_read+0xb8/0x130
 [<c01465f2>] sys_read+0x42/0x70
 [<c010906f>] syscall_call+0x7/0xb

getty         S 00000000 15434660 10542      1         10543 10541 (NOTLB)
c7823e7c 00000086 c012d44a 00000000 c5af5000 c0212235 c123fc00 00000020
       00000008 c5af5000 7fffffff c7822000 00000001 c011dab5 000000ff 00000000
       c1fa5202 00000000 00000004 ffffffff 00000286 c5af5000 c0212eca 00000008
Call Trace:
 [<c012d44a>] find_get_page+0x1a/0x30
 [<c0212235>] do_con_write+0x295/0x760
 [<c011dab5>] schedule_timeout+0xb5/0xc0
 [<c0212eca>] con_flush_chars+0x4a/0x50
 [<c0204974>] read_chan+0x654/0x7f0
 [<c0204c7c>] write_chan+0x16c/0x230
 [<c0113400>] default_wake_function+0x0/0x30
 [<c0113400>] default_wake_function+0x0/0x30
 [<c01ff9ec>] tty_write+0x18c/0x1f0
 [<c01ff83a>] tty_read+0xca/0xf0
 [<c01ff860>] tty_write+0x0/0x1f0
 [<c0146348>] vfs_read+0xb8/0x130
 [<c01465f2>] sys_read+0x42/0x70
 [<c010906f>] syscall_call+0x7/0xb

getty         S 00000000 73269600 10543      1         10544 10542 (NOTLB)
c643fe7c 00000082 c012d44a 00000000 c584f000 c0212235 c3564c00 00000020
       00000008 c584f000 7fffffff c643e000 00000001 c011dab5 000000ff 00000000
       c1fb4202 00000000 00000005 ffffffff 00000286 c584f000 c0212eca 00000008
Call Trace:
 [<c012d44a>] find_get_page+0x1a/0x30
 [<c0212235>] do_con_write+0x295/0x760
 [<c011dab5>] schedule_timeout+0xb5/0xc0
 [<c0212eca>] con_flush_chars+0x4a/0x50
 [<c0204974>] read_chan+0x654/0x7f0
 [<c0204c7c>] write_chan+0x16c/0x230
 [<c0113400>] default_wake_function+0x0/0x30
 [<c0113400>] default_wake_function+0x0/0x30
 [<c01ff9ec>] tty_write+0x18c/0x1f0
 [<c01ff83a>] tty_read+0xca/0xf0
 [<c01ff860>] tty_write+0x0/0x1f0
 [<c0146348>] vfs_read+0xb8/0x130
 [<c01465f2>] sys_read+0x42/0x70
 [<c010906f>] syscall_call+0x7/0xb

bash          S C0202BC0 11029632 10544      1               10543 (NOTLB)
c73f1e7c 00000082 00000032 c0202bc0 c215a000 00000000 c73f1e6c 00000032
       30305b1b c215a000 7fffffff c73f0000 00000001 c011dab5 6f74736e 7e3a6d72
       35305b1b 3b31333b 236d3130 30305b1b 0000206d 7fffffff c012d295 c1119d10
Call Trace:
 [<c0202bc0>] opost_block+0x120/0x1f0
 [<c011dab5>] schedule_timeout+0xb5/0xc0
 [<c012d295>] unlock_page+0x15/0x60
 [<c0204974>] read_chan+0x654/0x7f0
 [<c0204c7c>] write_chan+0x16c/0x230
 [<c0139e33>] handle_mm_fault+0x133/0x150
 [<c0113400>] default_wake_function+0x0/0x30
 [<c0113400>] default_wake_function+0x0/0x30
 [<c01ff9ec>] tty_write+0x18c/0x1f0
 [<c01ff83a>] tty_read+0xca/0xf0
 [<c01ff860>] tty_write+0x0/0x1f0
 [<c0146348>] vfs_read+0xb8/0x130
 [<c012079b>] sys_rt_sigprocmask+0xeb/0x150
 [<c01465f2>] sys_read+0x42/0x70
 [<c010906f>] syscall_call+0x7/0xb

SysRq : Emergency Sync
SysRq : Emergency Remount R/O

root@rainstorm:~# cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext2 rw 0 0
none /dev devfs rw 0 0
proc /proc proc rw 0 0
none /dev/pts devpts rw 0 0
none /dev/shm tmpfs rw 0 0
none /sys sysfs rw 0 0
/dev/ide/host0/bus0/target0/lun0/part1 /boot ext2 rw 0 0
/dev/scsi/host0/bus0/target0/lun0/part6 /usr ext2 rw 0 0
/dev/scsi/host0/bus0/target0/lun0/part7 /usr/local ext2 rw 0 0
/dev/scsi/host0/bus0/target0/lun0/part8 /var ext2 rw,nosuid,nodev 0 0
/dev/scsi/host0/bus0/target0/lun0/part9 /tmp ext2 rw,nosuid,nodev 0 0
/dev/scsi/host0/bus0/target0/lun0/part10 /var/mail ext2 rw,nosuid,nodev,noexec 0 0
/dev/scsi/host0/bus0/target0/lun0/part12 /home ext2 rw,nosuid,nodev 0 0
/dev/scsi/host0/bus0/target0/lun0/part7 /net ext2 rw 0 0
/dev/ide/host0/bus0/target0/lun0/part5 /data ext3 rw,nosuid,nodev 0 0
/dev/ide/host0/bus0/target0/lun0/part6 /stuffz ext3 rw,nosuid,nodev 0 0
root@rainstorm:~# umount /stuffz
root@rainstorm:~# umount /data
root@rainstorm:~# umount /home
umount: /home: device is busy
root@rainstorm:~# mount -n -o reo mount,ro /home
root@rainstorm:~# umount /net
root@rainstorm:~# umount /usr/local
root@rainstorm:~# umount /var/mail
root@rainstorm:~# umount /tmp

[umount dead, all other umount attempts, reading /tmp or /proc/mounts
dead]


--
Dani
			...and Linux for all.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbULaM6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbULaM6q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 07:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbULaM6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 07:58:46 -0500
Received: from [212.234.37.131] ([212.234.37.131]:45190 "EHLO temp.intrnic.com")
	by vger.kernel.org with ESMTP id S262020AbULaM6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 07:58:25 -0500
Message-ID: <41D54E6A.3020801@free.fr>
Date: Fri, 31 Dec 2004 14:04:42 +0100
From: Guillaume <g4ndalf@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr, en, ja
MIME-Version: 1.0
To: reiserfs-list-subscribe@namesys.com, linux-kernel@vger.kernel.org
Subject: error in /usr/src/linux/fs/reiserfs/prints.c line 362
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The server has started to refuse all connections after several days of 
functioning correctly. After a reboot it worked well during 5 hours 
until it crashed in exactly the same manner and after analyzing the logs 
I came accross the following message.

(This machine is a biprocessor AMD MP 2800+, motherboard tyan S2469 but 
it has ECC RAM Registered (3Go) and SCSI hard drives)

At the moment the crash occured there was a heavy load on the postfix 
mail queue

Dec 30 14:00:38 lanai -- MARK --
Dec 30 14:20:38 lanai -- MARK --
Dec 30 14:24:31 lanai kernel:  <1>Unable to handle kernel paging request 
at virtual address 00008804
Dec 30 14:24:31 lanai kernel: c01aa27b
Dec 30 14:24:31 lanai kernel: PREEMPT SMP
Dec 30 14:24:31 lanai kernel: Modules linked in: capability commoncap 
8250 serial_core unix
Dec 30 14:24:31 lanai kernel: CPU:    1
Dec 30 14:24:31 lanai kernel: EIP: 
0060:[reiserfs_allocate_blocks_for_region+2987/5792]    Not tainted VLI
Dec 30 14:24:31 lanai kernel: EFLAGS: 00010246   (2.6.9)
Dec 30 14:24:31 lanai kernel: EIP is at 
reiserfs_allocate_blocks_for_region+0xbab/0x16a0
Dec 30 14:24:31 lanai kernel: eax: 00008804   ebx: ea0ea910   ecx: 
00000fff   edx: 868b042f
Dec 30 14:24:31 lanai kernel: esi: f7e57d74   edi: ea0ea910   ebp: 
00000000   esp: cb62fccc
Dec 30 14:24:31 lanai kernel: ds: 007b   es: 007b   ss: 0068
Dec 30 14:24:31 lanai kernel: Process procmail (pid: 12316, 
threadinfo=cb62e000 task=d35334d0)
Dec 30 14:24:31 lanai kernel: Stack: 00000246 cb62febc f3ba3414 cb62fe1c 
cb62fd4c f3ba3414 c37a7e34 00000004
Dec 30 14:24:31 lanai kernel:        00000000 00008804 f7e57d74 00000050 
0000000c 00010000 00010050 00001000
Dec 30 14:24:31 lanai kernel:        cb62e000 00000000 00000000 00000000 
00000000 c37a7e34 f3ba33c0 00000000
Dec 30 14:24:31 lanai kernel: Call Trace:
Dec 30 14:24:31 lanai kernel: 
[reiserfs_prepare_file_region_for_write+1493/2720] 
reiserfs_prepare_file_region_for_write+0x5d5/0xaa0
Dec 30 14:24:31 lanai kernel:  [reiserfs_file_write+1353/1952] 
reiserfs_file_write+0x549/0x7a0
Dec 30 14:24:31 lanai kernel:  [link_path_walk+2628/3424] 
link_path_walk+0xa44/0xd60
Dec 30 14:24:31 lanai kernel:  [cache_free_debugcheck+297/608] 
cache_free_debugcheck+0x129/0x260
Dec 30 14:24:31 lanai kernel:  [cp_new_stat64+253/288] 
cp_new_stat64+0xfd/0x120
Dec 30 14:24:31 lanai kernel:  [reiserfs_file_write+0/1952] 
reiserfs_file_write+0x0/0x7a0
Dec 30 14:24:31 lanai kernel:  [vfs_write+216/320] vfs_write+0xd8/0x140
Dec 30 14:24:31 lanai kernel:  [sys_write+81/128] sys_write+0x51/0x80
Dec 30 14:24:31 lanai kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec 30 14:24:31 lanai kernel: Code: 24 90 01 00 00 48 39 c5 74 3c 8b 07 
a8 10 0f 85 6c ff ff ff 8b 44 24 6c 8b 54 24 50 8b 04 82 89 44 24 20 f0 
0f ba 2f 04 8b 86 9c <00> 00 00 89 47 1c 8b 54 24 20 89 57 14 ff 44 24 
6c f0 0f ba 2f
Dec 30 14:24:31 lanai kernel:  <1>Unable to handle kernel paging request 
at virtual address 00178801
Dec 30 14:24:31 lanai kernel: c01aa27b
Dec 30 14:24:31 lanai kernel: PREEMPT SMP
Dec 30 14:24:31 lanai kernel: Modules linked in: capability commoncap 
8250 serial_core unix
Dec 30 14:24:31 lanai kernel: CPU:    1
Dec 30 14:24:31 lanai kernel: EIP: 
0060:[reiserfs_allocate_blocks_for_region+2987/5792]    Not tainted VLI
Dec 30 14:24:31 lanai kernel: EFLAGS: 00010246   (2.6.9)
Dec 30 14:24:31 lanai kernel: EIP is at 
reiserfs_allocate_blocks_for_region+0xbab/0x16a0
Dec 30 14:24:31 lanai kernel: eax: 00178801   ebx: e766d58c   ecx: 
00000fff   edx: 868b042f
Dec 30 14:24:31 lanai kernel: esi: f7e57d74   edi: e766d58c   ebp: 
00000000   esp: d6941ccc
Dec 30 14:24:31 lanai kernel: ds: 007b   es: 007b   ss: 0068
Dec 30 14:24:31 lanai kernel: Process bounce (pid: 12063, 
threadinfo=d6940000 task=c5f7d9d0)
Dec 30 14:24:31 lanai kernel: Stack: 00000246 d6941ebc f4ecf414 d6941e1c 
d6941d4c f4ecf414 c37a7e60 00000004
Dec 30 14:24:31 lanai kernel:        00000000 00178801 f7e57d74 00000050 
0000000c 00010000 00010050 00001000
Dec 30 14:24:31 lanai kernel:        d6940000 00000000 00000000 00000000 
00000000 c37a7e60 f4ecf3c0 00000000
Dec 30 14:24:31 lanai kernel: Call Trace:
Dec 30 14:24:31 lanai kernel: 
[reiserfs_prepare_file_region_for_write+1493/2720] 
reiserfs_prepare_file_region_for_write+0x5d5/0xaa0
Dec 30 14:24:31 lanai kernel:  [reiserfs_file_write+1353/1952] 
reiserfs_file_write+0x549/0x7a0
Dec 30 14:24:31 lanai kernel:  [journal_end+160/192] journal_end+0xa0/0xc0
Dec 30 14:24:31 lanai kernel:  [check_poison_obj+47/480] 
check_poison_obj+0x2f/0x1e0
Dec 30 14:24:31 lanai kernel:  [cache_alloc_debugcheck_after+114/368] 
cache_alloc_debugcheck_after+0x72/0x170
Dec 30 14:24:31 lanai kernel:  [may_open+89/608] may_open+0x59/0x260
Dec 30 14:24:31 lanai kernel:  [kmem_cache_alloc+106/160] 
kmem_cache_alloc+0x6a/0xa0
Dec 30 14:24:31 lanai kernel:  [flock_lock_file+310/464] 
flock_lock_file+0x136/0x1d0
Dec 30 14:24:31 lanai kernel:  [flock_lock_file_wait+38/256] 
flock_lock_file_wait+0x26/0x100
Dec 30 14:24:31 lanai kernel:  [cache_alloc_debugcheck_after+114/368] 
cache_alloc_debugcheck_after+0x72/0x170
Dec 30 14:24:31 lanai kernel:  [reiserfs_file_write+0/1952] 
reiserfs_file_write+0x0/0x7a0
Dec 30 14:24:31 lanai kernel:  [vfs_write+216/320] vfs_write+0xd8/0x140
Dec 30 14:24:31 lanai kernel:  [sys_write+81/128] sys_write+0x51/0x80
Dec 30 14:24:31 lanai kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec 30 14:24:31 lanai kernel: Code: 24 90 01 00 00 48 39 c5 74 3c 8b 07 
a8 10 0f 85 6c ff ff ff 8b 44 24 6c 8b 54 24 50 8b 04 82 89 44 24 20 f0 
0f ba 2f 04 8b 86 9c <00> 00 00 89 47 1c 8b 54 24 20 89 57 14 ff 44 24 
6c f0 0f ba 2f
Dec 30 14:40:38 lanai -- MARK --
Dec 30 14:53:13 lanai syslogd 1.4.1#15: restart.
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4872 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4871 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4870 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4818 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4817 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4780 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4779 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4778 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4777 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4529 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4528 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4527 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4526 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4525 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4524 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4443 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4441 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4440 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4439 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4344 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4227 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4226 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 4225 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 3831 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 3600 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 3599 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 3598 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 3025 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 3024 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 2682 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 2681 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 2147 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 2146 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 2145 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: Removing [2 1997 0x0 
SD]..done
Dec 30 14:53:13 lanai kernel: ReiserFS: sda10: There were 162 
uncompleted unlinks/truncates. Completed
Dec 30 14:53:13 lanai kernel: ReiserFS: sda11: found reiserfs format 
"3.6" with standard journal
Dec 30 14:53:13 lanai kernel: ReiserFS: sda11: warning: 
CONFIG_REISERFS_CHECK is set ON
Dec 30 14:53:13 lanai kernel: ReiserFS: sda11: warning: - it is slow 
mode for debugging.
Dec 30 14:53:13 lanai kernel: ReiserFS: sda11: using ordered data mode
Dec 30 14:53:13 lanai kernel: ReiserFS: sda11: journal params: device 
sda11, size 8192, journal first block 18, max trans len 1024, max batch 
900, max commit age 30, max trans age 30
Dec 30 14:53:13 lanai kernel: ReiserFS: sda11: checking transaction log 
(sda11)
Dec 30 14:53:13 lanai kernel: ReiserFS: sda11: Using r5 hash to sort names
Dec 30 14:53:13 lanai kernel: e1000: eth0: e1000_watchdog: NIC Link is 
Up 100 Mbps Full Duplex
Dec 30 14:53:13 lanai kernel: Serial: 8250/16550 driver $Revision: 1.90 
$ 8 ports, IRQ sharing disabled
Dec 30 14:53:13 lanai kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Dec 30 14:53:13 lanai kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Dec 30 14:53:13 lanai kernel: Capability LSM initialized
Dec 30 15:13:13 lanai -- MARK --
Dec 30 15:33:13 lanai -- MARK --
Dec 30 15:53:13 lanai -- MARK --
Dec 30 16:13:13 lanai -- MARK --
Dec 30 16:33:13 lanai -- MARK --
Dec 30 16:53:14 lanai -- MARK --
Dec 30 17:13:14 lanai -- MARK --
Dec 30 17:33:14 lanai -- MARK --
Dec 30 17:43:56 lanai kernel: ReiserFS: sda6: warning: vs-8301: 
reiserfs_kmalloc: allocated memory 200096
Dec 30 18:13:14 lanai -- MARK --
Dec 30 18:33:14 lanai -- MARK --
Dec 30 18:53:14 lanai -- MARK --
Dec 30 19:13:14 lanai -- MARK --


lanai:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) MP 2800+
stepping        : 0
cpu MHz         : 2134.402
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 4194.30

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) Processor
stepping        : 0
cpu MHz         : 2134.402
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 4259.84


lanai:~# uname -a
Linux lanai 2.6.9 #1 SMP Fri Dec 24 12:45:27 CET 2004 i686 GNU/Linux

lanai:~# procinfo
Linux 2.6.9 (root@lanai) (gcc ) #à[ÿ·  2CPU [lanai.(none)]

Memory:      Total        Used        Free      Shared     Buffers
Mem:       3113688     2369512      744176           0      181812
Swap:       578300           0      578300

Bootup: Fri Dec 31 13:14:13 2004    Load average: 1.33 0.44 0.58 9/205 4189

user  :       0:09:11.28  12.4%  page in :        0
nice  :       0:00:00.00   0.0%  page out:        0
system:       0:02:33.20   3.4%  swap in :        0
idle  :       0:51:00.30  68.8%  swap out:        0
uptime:       0:37:03.98         context :  1830416

irq  0:   2222582 timer                 irq  7:         2
irq  1:         8 i8042                 irq  8:         1 rtc
irq  2:         0 cascade [4]           irq 16:    315388 aic79xx
irq  3:         2                       irq 17:        30 aic79xx
irq  4:      1650 serial                irq 19:     79448 eth0
irq  6:         2

lanai:~# lsmod
Module                  Size  Used by
capability              4104  0
commoncap               6144  1 capability
8250                   21824  2
serial_core            20608  1 8250
unix                   24212  920

I use : debian sarge

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317551AbSFSHf7>; Wed, 19 Jun 2002 03:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317620AbSFSHf6>; Wed, 19 Jun 2002 03:35:58 -0400
Received: from smtp1.wanadoo.nl ([194.134.35.136]:63945 "EHLO smtp1.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S317551AbSFSHf5>;
	Wed, 19 Jun 2002 03:35:57 -0400
Subject: [2.2.19] SuSE kernel panic
From: Steven Bosscher <s.bosscher@student.tudelft.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Jun 2002 09:34:37 +0200
Message-Id: <1024472078.765.19.camel@steven>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I had a number of "oops"-es and finally kernel panic on one of my old
but trusted 486 boxes. Since I couldn't find the changelogs for the 2.2 
kernel series, I couldn't check if this is a known and/or fixed problem,
so I guess I'll just post it here... 

I've appended a description of what I did, what exactly happened and
some info about this box.

I hope this helps, please let me know if you need to know more, 

Greetz 
Steven 


------
I rloged in from an xterm and tried to view the firewall logs:
huis@router:~ >  cat /var/log/firewall

`cron' jobs were running, plus the usual system processes and four user processes
(adsl-connect, pppd, pppoed, httpd). Nothing seemed to happen even after a couple
of minutes, which is unusually long even for this machine. So I decided to try
and see what was going on. So I tried to rlogin from another xterm and almost
instantly I got this message on the first xterm:

Message from syslogd@router at Wed Jun 19 00:19:48 2002 ...
router kernel: Kernel panic: VFS: LRU block list corrupted

It looks like there already was an oops before I did my first rlogin. This never
happened before, the machine had an uptime of several months. In fact, I've
never had to reboot it since I installed this kernel. It serves as a bridge
between a small LAN and out ADSL provider.

Here's the relevant part of `messages'.

Jun 19 00:06:59 router kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000014
Jun 19 00:06:59 router kernel: current->tss.cr3 = 00101000, %cr3 = 00101000
Jun 19 00:06:59 router kernel: *pde = 00000000
Jun 19 00:06:59 router kernel: Oops: 0000
Jun 19 00:06:59 router kernel: CPU:    0
Jun 19 00:06:59 router kernel: EIP:    0010:[sync_page_buffers+32/148]
Jun 19 00:06:59 router kernel: EFLAGS: 00010203
Jun 19 00:06:59 router kernel: eax: 00000000   ebx: 00000000   ecx: c02c1080   edx: c001fa20
Jun 19 00:06:59 router kernel: esi: c0d6f6c0   edi: 00000007   ebp: c0300230   esp: c0085f0c
Jun 19 00:06:59 router kernel: ds: 0018   es: 0018   ss: 0018
Jun 19 00:07:00 router kernel: Process kswapd (pid: 4, process nr: 4, stackpage=c0085000)
Jun 19 00:07:00 router kernel: Stack: c0d6f6c0 c0300230 c0af34a0 c0af34a0 c0af34a0 00000000 c0af34a0 c0339410 
Jun 19 00:07:00 router kernel:        c010b964 c012d305 c0300230 00000003 c02ffe20 c012d2ed c0300230 00000319 
Jun 19 00:07:00 router kernel:        c0084000 00000030 00000030 00000002 c0b20018 c012103e c0300230 00000030 
Jun 19 00:07:00 router kernel: Call Trace: [do_IRQ+64/68] [try_to_free_buffers+149/192] [try_to_free_buffers+125/192] [shrink_mmap+262/356] [try_to_free_pages+61/168] [tvecs+7566/14560] [kswapd+105/168] 
Jun 19 00:07:00 router kernel:        [kswapd+82/168] [kernel_thread+31/56] [kernel_thread+40/56] 
Jun 19 00:07:00 router kernel: Code: 8b 5b 14 8b 54 24 1c 8b 42 18 a8 02 75 07 8b 42 18 a8 04 74 
Jun 19 00:07:07 router kernel: Unable to handle kernel paging request at virtual address 03030303
Jun 19 00:07:07 router kernel: current->tss.cr3 = 00bf9000, %cr3 = 00bf9000
Jun 19 00:07:07 router kernel: *pde = 00000000
Jun 19 00:07:07 router kernel: Oops: 0000
Jun 19 00:07:07 router kernel: CPU:    0
Jun 19 00:07:07 router kernel: EIP:    0010:[<03030303>]
Jun 19 00:07:07 router kernel: EFLAGS: 00010287
Jun 19 00:07:07 router kernel: eax: 03030303   ebx: c0d6f660   ecx: c0d6f660   edx: 00000000
Jun 19 00:07:07 router kernel: esi: c0d6f660   edi: c0d6f660   ebp: c03070f8   esp: c0b29c28
Jun 19 00:07:07 router kernel: ds: 0018   es: 0018   ss: 0018
Jun 19 00:07:07 router kernel: Process find (pid: 1669, process nr: 46, stackpage=c0b29000)
Jun 19 00:07:07 router kernel: Stack: ffffffff c031b620 c0fd7fe0 c0d6f660 c0d6f660 00000282 00000202 c0d6f660 
Jun 19 00:07:07 router kernel:        c0d6f660 c0dfdaf0 c012d2b4 c0d6f660 00000000 00000021 c012d2ab c0d6f660 
Jun 19 00:07:07 router kernel:        00000003 c0306d60 c012d2ed c03070f8 0000031c c0b28000 00000005 c031b620 
Jun 19 00:07:08 router kernel: Call Trace: [try_to_free_buffers+68/192] [try_to_free_buffers+59/192] [try_to_free_buffers+125/192] [shrink_mmap+262/356] [ip_forward+826/1416] [try_to_free_pages+61/168] [ip_forward+1067/1416] 
Jun 19 00:07:08 router kernel:        [__get_free_pages+157/684] [update_wall_time+16/68] [grow_buffers+63/268] [refill_freelist+15/64] [getblk+33/348] [getblk+301/348] [bread+25/128] [ext2_read_inode+244/1004] 
Jun 19 00:07:08 router kernel:        [get_new_inode+171/328] [get_new_inode+151/328] [schedule+322/644] [iget4+125/136] [__brelse+28/68] [iget+20/28] [ext2_lookup+88/136] [real_lookup+91/216] 
Jun 19 00:07:08 router kernel:        [permission+32/56] [lookup_dentry+336/540] [getname+93/152] [__namei+47/100] [sys_newlstat+19/112] [do_IRQ+64/68] [system_call+52/64] [startup_32+43/290] 
Jun 19 00:07:08 router kernel: Code: <1>Unable to handle kernel paging request at virtual address 03030303
Jun 19 00:07:08 router kernel: current->tss.cr3 = 00bf9000, %cr3 = 00bf9000
Jun 19 00:07:08 router kernel: *pde = 00000000
Jun 19 00:07:08 router kernel: Oops: 0000
Jun 19 00:07:08 router kernel: CPU:    0
Jun 19 00:07:08 router kernel: EIP:    0010:[show_registers+556/604]
Jun 19 00:07:08 router kernel: EFLAGS: 00010083
Jun 19 00:07:08 router kernel: eax: 03030303   ebx: 00000000   ecx: c08f6000   edx: c0b29bec
Jun 19 00:07:09 router kernel: esi: 0000002b   edi: c0b2a000   ebp: c1800000   esp: c0b29b34
Jun 19 00:07:09 router kernel: ds: 0018   es: 0018   ss: 0018
Jun 19 00:07:09 router kernel: Process find (pid: 1669, process nr: 46, stackpage=c0b29000)
Jun 19 00:07:09 router kernel: Stack: c0b29bec 08048000 03030303 c0b28000 c0b29bec 08048000 03030303 c2000000 
Jun 19 00:07:09 router kernel:        00000092 00000001 c02bc44e c010a8a2 c0b29bec 00000001 c02bc456 c010a899 
Jun 19 00:07:09 router kernel:        c02363d6 c0237fee 00000000 c0b28000 00000000 00000001 c02bc456 00000013 
Jun 19 00:07:09 router kernel: Call Trace: [<c2000000>] [die+54/68] [die+45/68] [error_table+2646/10208] [error_table+9838/10208] [error_table+9760/10208] [do_page_fault+767/1032] 
Jun 19 00:07:09 router kernel:        [error_table+9838/10208] [do_page_fault+0/1032] [error_code+53/64] [put_unused_buffer_head+22/100] [try_to_free_buffers+68/192] [try_to_free_buffers+59/192] [try_to_free_buffers+125/192] [shrink_mmap+262/356] 
Jun 19 00:07:09 router kernel:        [ip_forward+826/1416] [try_to_free_pages+61/168] [ip_forward+1067/1416] [__get_free_pages+157/684] [update_wall_time+16/68] [grow_buffers+63/268] [refill_freelist+15/64] [getblk+33/348] 
Jun 19 00:07:09 router kernel:        [getblk+301/348] [bread+25/128] [ext2_read_inode+244/1004] [get_new_inode+171/328] [get_new_inode+151/328] [schedule+322/644] [iget4+125/136] [__brelse+28/68] 
Jun 19 00:07:09 router kernel:        [iget+20/28] [ext2_lookup+88/136] [real_lookup+91/216] [permission+32/56] [lookup_dentry+336/540] [getname+93/152] [__namei+47/100] [sys_newlstat+19/112] 
Jun 19 00:07:09 router kernel:        [do_IRQ+64/68] [system_call+52/64] [startup_32+43/290] 
Jun 19 00:07:09 router kernel: Code: 0f b6 04 03 50 68 ce 63 23 c0 e8 89 c3 00 00 83 c4 10 43 83 
Jun 19 00:07:14 router kernel: Packet log: input DENY ppp0 PROTO=6 172.141.21.241:2094 62.234.23.152:6346 L=48 S=0x00 I=55316 F=0x4000 T=112 SYN (#3)
Jun 19 00:07:16 router kernel: Packet log: input DENY ppp0 PROTO=6 172.141.21.241:2094 62.234.23.152:6346 L=48 S=0x00 I=55340 F=0x4000 T=112 SYN (#3)
Jun 19 00:07:29 router kernel: Unable to handle kernel paging request at virtual address 03030303
Jun 19 00:07:29 router kernel: current->tss.cr3 = 006d3000, %cr3 = 006d3000
Jun 19 00:07:29 router kernel: *pde = 00000000
Jun 19 00:07:29 router kernel: Oops: 0000
Jun 19 00:07:29 router kernel: CPU:    0
Jun 19 00:07:29 router kernel: EIP:    0010:[<03030303>]
Jun 19 00:07:29 router kernel: EFLAGS: 00010283
Jun 19 00:07:29 router kernel: eax: 03030303   ebx: c0d6f2a0   ecx: 00000001   edx: c0d6f2a0
Jun 19 00:07:29 router kernel: esi: c08e9540   edi: 00058507   ebp: c0d16150   esp: c0b33da8
Jun 19 00:07:29 router kernel: ds: 0018   es: 0018   ss: 0018
Jun 19 00:07:29 router kernel: Process sort (pid: 1667, process nr: 41, stackpage=c0b33000)
Jun 19 00:07:29 router kernel: Stack: c08e9540 c05f46e0 c012c063 c0d6f2a0 c08e9540 000584a6 c012c078 c0d6f4e0 
Jun 19 00:07:29 router kernel:        c08e9540 00058507 c012c110 c0d6f2a0 c08e9540 c0038a30 00003050 c0037400 
Jun 19 00:07:29 router kernel:        00000000 c0d6f720 c01502fc c0d6f2a0 00058507 00001000 c01500cb 00000000 
Jun 19 00:07:29 router kernel: Call Trace: [refile_buffer+95/160] [refile_buffer+116/160] [__bforget+40/48] [trunc_indirect+544/760] [trunc_direct+355/372] [ext2_truncate+130/536] [cprt+8960/45558] 
Jun 19 00:07:29 router kernel:        [ext2_delete_inode+154/176] [ext2_put_inode+15/24] [iput+139/536] [balance_dirty+17/40] [refile_buffer+95/160] [d_delete+83/116] [ext2_unlink+407/440] [vfs_unlink+243/256] 
Jun 19 00:07:29 router kernel:        [sys_unlink+124/188] [common_interrupt+24/32] [error_code+53/64] [system_call+52/64] [startup_32+43/290] 
Jun 19 00:07:29 router kernel: Code: <1>Unable to handle kernel paging request at virtual address 03030303
Jun 19 00:07:29 router kernel: current->tss.cr3 = 006d3000, %cr3 = 006d3000
Jun 19 00:07:29 router kernel: *pde = 00000000
Jun 19 00:07:30 router kernel: Oops: 0000
Jun 19 00:07:30 router kernel: CPU:    0
Jun 19 00:07:30 router kernel: EIP:    0010:[show_registers+556/604]
Jun 19 00:07:30 router kernel: EFLAGS: 00010087
Jun 19 00:07:30 router kernel: eax: 03030303   ebx: 00000000   ecx: c08f6000   edx: c0b33d6c
Jun 19 00:07:30 router kernel: esi: 0000002b   edi: c0b34000   ebp: c1800000   esp: c0b33cb4
Jun 19 00:07:30 router kernel: ds: 0018   es: 0018   ss: 0018
Jun 19 00:07:31 router kernel: Process sort (pid: 1667, process nr: 41, stackpage=c0b33000)
Jun 19 00:07:31 router kernel: Stack: c0b33d6c 08048000 03030303 c0b32000 c0b33d6c 08048000 03030303 c2000000 
Jun 19 00:07:31 router kernel:        00000096 00000001 c02bc44e c010a8a2 c0b33d6c 00000001 c02bc456 c010a899 
Jun 19 00:07:31 router kernel:        c02363d6 c0237fee 00000000 c0b32000 00000000 00000001 c02bc456 00000013 
Jun 19 00:07:31 router kernel: Call Trace: [<c2000000>] [die+54/68] [die+45/68] [error_table+2646/10208] [error_table+9838/10208] [error_table+9760/10208] [do_page_fault+767/1032] 
Jun 19 00:07:31 router kernel:        [error_table+9838/10208] [do_page_fault+0/1032] [do_IRQ+64/68] [error_code+53/64] [put_last_free+30/152] [refile_buffer+95/160] [refile_buffer+116/160] [__bforget+40/48] 
Jun 19 00:07:31 router kernel:        [trunc_indirect+544/760] [trunc_direct+355/372] [ext2_truncate+130/536] [cprt+8960/45558] [ext2_delete_inode+154/176] [ext2_put_inode+15/24] [iput+139/536] [balance_dirty+17/40] 
Jun 19 00:07:32 router kernel:        [refile_buffer+95/160] [d_delete+83/116] [ext2_unlink+407/440] [vfs_unlink+243/256] [sys_unlink+124/188] [common_interrupt+24/32] [error_code+53/64] [system_call+52/64] 
Jun 19 00:07:32 router kernel:        [startup_32+43/290] 
Jun 19 00:07:32 router kernel: Code: 0f b6 04 03 50 68 ce 63 23 c0 e8 89 c3 00 00 83 c4 10 43 83 
Jun 19 00:19:46 router in.rlogind[1700]: connect from 192.168.1.101
Jun 19 00:19:47 router pam_rhosts_auth[1700]: denied to steven@192.168.1.101 as huis: access not allowed

After this, the machine would not respond and I had to reset it (it booted
fine and is up and running right now).

MACHINE INFO:
My machine runs SuSE 6.3 with their 2.2.19 kernel RPM for this version.

Output of `uname -a'
Linux router 2.2.19 #1 Thu Oct 25 16:50:43 GMT 2001 i486 unknown

My machine is a Cyrix 486. `cat /proc/cpuinfo':
processor	: 0
vendor_id	: CyrixInstead
cpu family	: 4
model		: 1
model name	: UnknownDLC
stepping	: unknown
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: no
cpuid level	: -1
wp		: yes
flags		:
bogomips	: 13.10

`cat /proc/meminfo':
        total:    used:    free:  shared: buffers:  cached:
Mem:  16359424 14368768  1990656        0  1781760  3502080
Swap: 33026048        0 33026048
MemTotal:     15976 kB
MemFree:       1944 kB
MemShared:        0 kB
Buffers:       1740 kB
Cached:        3420 kB
BigTotal:         0 kB
BigFree:          0 kB
SwapTotal:    32252 kB
SwapFree:     32252 kB

User processes that are always running are Apache, pppd and pppoed. Otherwise
the machine does nothing but running cron jobs now and then.



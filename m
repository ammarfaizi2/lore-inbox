Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279832AbRKILx7>; Fri, 9 Nov 2001 06:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279840AbRKILxu>; Fri, 9 Nov 2001 06:53:50 -0500
Received: from shami.gointernet.co.uk ([212.111.50.98]:39619 "EHLO
	shami.gointernet.co.uk") by vger.kernel.org with ESMTP
	id <S279832AbRKILxd>; Fri, 9 Nov 2001 06:53:33 -0500
Message-ID: <3BEBC3E7.48C4A659@gointernet.co.uk>
Date: Fri, 09 Nov 2001 11:54:15 +0000
From: Eugenio Mastroviti <eugeniom@gointernet.co.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-64GB-SMP i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hack Central <linux-kernel@vger.kernel.org>
Subject: kernel: Unable to handle kernel paging request at virtual address xxxx - 
 2.4.14
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I upgraded a Dell 2400 to kernel 2.4.14 (from 2.2.16). In the
past, it had run 2.4.4 without any problems, although it had been
recently downgraded to 2.2.xx due to "standardization" (don't ask).

The upgrade was completed at 18:00, it was running without any problem.
As it's used only for development and network backup, the load at that
time was minimal. A cron job fires up the amanda backup system at 3 AM.
This is /var/log/messages:

Looks like kswapd barfed, although I'm not sure why.

The system as I said is a Dell 2400, single PIII 733 (APIC was not
enabled), 1GB RAM, 1 GB swap, Ami MegaRaid with 3 disks in RAID 5

-------------------------------------------------------

Nov  9 03:00:00 puri CROND[7770]: (informix) CMD
(/software/informix/scripts/onstatseg)
Nov  9 03:00:00 puri kernel: st1: Block limits 2 - 16777214 bytes.
Nov  9 03:01:00 puri CROND[7808]: (root) CMD (run-parts
/etc/cron.hourly)
Nov  9 03:03:40 puri kernel: Unable to handle kernel paging request at
virtual address 00017600
Nov  9 03:03:40 puri kernel:  printing eip:
Nov  9 03:03:40 puri kernel: 00017600
Nov  9 03:03:40 puri kernel: *pde = 00000000
Nov  9 03:03:40 puri kernel: Oops: 0000
Nov  9 03:03:40 puri kernel: CPU:    0
Nov  9 03:03:40 puri kernel: EIP:   
0010:[agp_frontend_cleanup+95744/-1072693248]    Not tainted
Nov  9 03:03:40 puri kernel: EFLAGS: 00010202
Nov  9 03:03:40 puri kernel: eax: 00000013   ebx: c024cee0   ecx:
00000176   edx: f8808000
Nov  9 03:03:40 puri kernel: esi: 00000176   edi: 00000012   ebp:
0001956c   esp: f7efbf28
Nov  9 03:03:40 puri kernel: ds: 0018   es: 0018   ss: 0018
Nov  9 03:03:40 puri kernel: Process kswapd (pid: 4, stackpage=f7efb000)
Nov  9 03:03:40 puri kernel: Stack: c1f09a00 c0127d83 c024cee0 00000000
f7efa000 000003d0 000001d0 c0203f90
Nov  9 03:03:40 puri kernel:        c200f2f0 e991e024 c200f0c0 00000001
00000012 000001d0 00000002 00066a78
Nov  9 03:03:40 puri kernel:        c0127f08 00000002 00000001 c0203f90
00000002 000001d0 c0203f90 00000000
Nov  9 03:03:40 puri kernel: Call Trace: [shrink_cache+659/720]
[shrink_caches+88/128] [try_to_free_pages+44/80]
[kswapd_balance_pgdat+81/160] [kswapd_balance+38/64]
Nov  9 03:03:40 puri kernel:    [kswapd+161/192] [kswapd+0/192]
[kernel_thread+43/64]
Nov  9 03:03:40 puri kernel:
Nov  9 03:03:40 puri kernel: Code:  Bad EIP value.
Nov  9 03:03:40 puri kernel:  <1>Unable to handle kernel paging request
at virtual address 0001e300
Nov  9 03:03:40 puri kernel:  printing eip:
Nov  9 03:03:40 puri kernel: 0001e300
Nov  9 03:03:40 puri kernel: *pde = 00000000
Nov  9 03:03:40 puri kernel: Oops: 0000
Nov  9 03:03:40 puri kernel: CPU:    0
Nov  9 03:03:40 puri kernel: EIP:   
0010:[agp_frontend_cleanup+123648/-1072693248]    Not tainted
Nov  9 03:03:40 puri kernel: EFLAGS: 00010202
Nov  9 03:03:40 puri kernel: eax: 00000001   ebx: c024cee0   ecx:
000001e3   edx: f8808000
Nov  9 03:03:40 puri kernel: esi: 000001e3   edi: 00000020   ebp:
00008973   esp: f4f3de10
Nov  9 03:03:40 puri kernel: ds: 0018   es: 0018   ss: 0018
Nov  9 03:03:40 puri kernel: Process gtar (pid: 7811,
stackpage=f4f3d000)
Nov  9 03:03:40 puri kernel: Stack: c1f08d00 c0127d83 c024cee0 e64b3994
f4f3c000 000000f5 000001d2 c0203f90
Nov  9 03:03:40 puri kernel:        d68931a0 f0f0e47c c200bb20 00000000
00000020 000001d2 00000006 000671f6
Nov  9 03:03:40 puri kernel:        c0127f08 00000006 00000001 c0203f90
00000006 000001d2 c0203f90 00000000
Nov  9 03:03:40 puri kernel: Call Trace: [shrink_cache+659/720]
[shrink_caches+88/128] [try_to_free_pages+44/80]
[balance_classzone+83/416] [__alloc_pages+331/464]
Nov  9 03:03:40 puri kernel:    [page_cache_read+97/176]
[generic_file_readahead+245/304] [do_generic_file_read+433/1024]
[update_process_times+32/128] [generic_file_read+107/144]
[file_read_actor+0/192]
Nov  9 03:03:40 puri kernel:    [sys_read+150/208] [system_call+51/56]
Nov  9 03:03:40 puri kernel:
Nov  9 03:03:40 puri kernel: Code:  Bad EIP value.
Nov  9 03:05:50 puri kernel:  <1>Unable to handle kernel paging request
at virtual address 00020d00
Nov  9 03:05:50 puri kernel:  printing eip:
Nov  9 03:05:50 puri kernel: 00020d00
Nov  9 03:05:50 puri kernel: *pde = 00000000
Nov  9 03:05:50 puri kernel: Oops: 0000
Nov  9 03:05:50 puri kernel: CPU:    0
Nov  9 03:05:50 puri kernel: EIP:   
0010:[agp_frontend_cleanup+134400/-1072693248]    Not tainted
Nov  9 03:05:50 puri kernel: EFLAGS: 00010202
Nov  9 03:05:50 puri kernel: eax: 00000001   ebx: c024cee0   ecx:
0000020d   edx: f8808000
Nov  9 03:05:50 puri kernel: esi: 0000020d   edi: 00000020   ebp:
000083d6   esp: e6ffbdd0
Nov  9 03:05:50 puri kernel: ds: 0018   es: 0018   ss: 0018
Nov  9 03:05:50 puri kernel: Process gtar (pid: 7867,
stackpage=e6ffb000)
Nov  9 03:05:50 puri kernel: Stack: c1d48500 c0127d83 c024cee0 c0203ee8
e6ffa000 000000ed 000001f0 c0203ee8
Nov  9 03:05:50 puri kernel:        0000be4c 00000809 c0203d00 00000000
00000020 000001f0 00000006 00062efe
Nov  9 03:05:50 puri kernel:        c0127f08 00000006 00000002 c0203ee8
00000006 000001f0 c0203ee8 00000000
Nov  9 03:05:50 puri kernel: Call Trace: [shrink_cache+659/720]
[shrink_caches+88/128] [try_to_free_pages+44/80]
[balance_classzone+83/416] [__alloc_pages+331/464]
Nov  9 03:05:50 puri kernel:    [__get_free_pages+16/32]
[kmem_cache_grow+156/528] [iget4+194/208] [kmem_cache_alloc+156/176]
[d_alloc+25/336] [real_lookup+60/192]
Nov  9 03:05:50 puri kernel:    [link_path_walk+1267/1824]
[getname+94/160] [__user_walk+51/80] [sys_lstat64+20/112]
[system_call+51/56]
Nov  9 03:05:50 puri kernel:
Nov  9 03:05:50 puri kernel: Code:  Bad EIP value.
Nov  9 03:06:00 puri kernel:  <1>Unable to handle kernel paging request
at virtual address 00044700
Nov  9 03:06:00 puri kernel:  printing eip:
Nov  9 03:06:00 puri kernel: 00044700
Nov  9 03:06:00 puri kernel: *pde = 00000000
Nov  9 03:06:00 puri kernel: Oops: 0000
Nov  9 03:06:00 puri kernel: CPU:    0
Nov  9 03:06:00 puri kernel: EIP:   
0010:[agp_frontend_cleanup+280320/-1072693248]    Not tainted
Nov  9 03:06:00 puri kernel: EFLAGS: 00010202
Nov  9 03:06:00 puri kernel: eax: 00000001   ebx: c024cee0   ecx:
00000447   edx: f8808000
Nov  9 03:06:00 puri kernel: esi: 00000447   edi: f6f243e4   ebp:
f758a8c0   esp: f6ef5e98
Nov  9 03:06:00 puri kernel: ds: 0018   es: 0018   ss: 0018
Nov  9 03:06:00 puri kernel: Process SilverServer_ (pid: 1016,
stackpage=f6ef5000)
Nov  9 03:06:00 puri kernel: Stack: c1da34c0 c011fe6d c024cee0 00000001
084f94c0 00000000 f758a8c0 f74b29c0
Nov  9 03:06:00 puri kernel:        c01201db f758a8c0 f74b29c0 084f94c0
f6f243e4 00044700 00000000 f6ed5780
Nov  9 03:06:00 puri kernel:        f6ef5f54 00000800 00000000 f6ef5f08
00000000 c18a6a80 0009f700 f6ef4000
Nov  9 03:06:00 puri kernel: Call Trace: [do_swap_page+125/224]
[handle_mm_fault+107/192] [do_page_fault+394/1232] [sock_read+134/144]
[sys_send+29/48]
Nov  9 03:06:00 puri kernel:    [sys_read+195/208]
[do_page_fault+0/1232] [error_code+52/60]
Nov  9 03:06:00 puri kernel:
Nov  9 03:06:00 puri kernel: Code:  Bad EIP value.
Nov  9 03:09:41 puri kernel:  <1>Unable to handle kernel paging request
at virtual address 00041c00

-------------------------------------------------------

Thanks to anyone who will help

Eugenio

-- 
When the going gets tough, the tough get an UZI

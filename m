Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280999AbRLEP3V>; Wed, 5 Dec 2001 10:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281777AbRLEP3J>; Wed, 5 Dec 2001 10:29:09 -0500
Received: from smtp.awc.net ([216.205.112.6]:33808 "EHLO mx-a.awc.net")
	by vger.kernel.org with ESMTP id <S280999AbRLEP1g>;
	Wed, 5 Dec 2001 10:27:36 -0500
For: <linux-kernel@vger.kernel.org>
Message-Id: <200112051527.KAA21483@mx-a.awc.net>
Content-Type: text/plain; charset=US-ASCII
From: Caleb Tennis <caleb@aei-tech.com>
Organization: Analytical Engineering, Inc.
To: linux-kernel@vger.kernel.org
Subject: 2.4.16 oops:
Date: Wed, 5 Dec 2001 10:26:59 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry if this is something that has already been addressed or if it's just a 
problem on my end - this is the first kernel oops I've ever experienced first 
hand.

Yesterday I installed 2.4.16 onto a Pentium-166 machine w/ 64 megs of ram.  
When I came in this morning, I had a backlog of a few errors from overnight.  
This is a snippet of ksymoops on my messages log:

Warning (compare_maps): mismatch on symbol journal_enable_debug  , jbd says 
c481e900, /lib/modules/2.4.16/kernel/fs/jbd/jbd.o says c481e8ec.  Ignoring 
/lib/modules/2.4.16/kernel/fs/jbd/jbd.o entry
Dec  4 13:43:21 inet kernel: Intel Pentium with F0 0F bug - workaround 
enabled.
Dec  4 16:47:24 inet kernel: ds: no socket drivers loaded!
Dec  5 04:03:14 inet kernel: Unable to handle kernel paging request at 
virtual address 00001000
Dec  5 04:03:14 inet kernel: 00001000
Dec  5 04:03:14 inet kernel: *pde = 00000000
Dec  5 04:03:14 inet kernel: Oops: 0000
Dec  5 04:03:14 inet kernel: CPU:    0
Dec  5 04:03:14 inet kernel: EIP:    0010:[<00001000>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec  5 04:03:14 inet kernel: EFLAGS: 00010202
Dec  5 04:03:14 inet kernel: eax: 00000001   ebx: c02c9e40   ecx: c4802000   
edx: 00000010
Dec  5 04:03:14 inet kernel: esi: 00000010   edi: 0000000a   ebp: 00000030   
esp: c116ff28
Dec  5 04:03:14 inet kernel: ds: 0018   es: 0018   ss: 0018
Dec  5 04:03:14 inet kernel: Process kswapd (pid: 4, stackpage=c116f000)
Dec  5 04:03:14 inet kernel: Stack: c10cac80 c0127513 c02c9e40 00018598 
c116e000 0000003b 000001d0 c0273fe8
Dec  5 04:03:14 inet kernel:        c02e4d40 c115cde0 c1103420 00000000 
00000020 000001d0 00000006 00000dee
Dec  5 04:03:14 inet kernel:        c0127686 00000006 00000030 c0273fe8 
00000006 000001d0 c0273fe8 00000000 
Dec  5 04:03:14 inet kernel: Call Trace: [<c0127513>] [<c0127686>] 
[<c01276cd>] [<c0127764>] [<c01277c6>]
Dec  5 04:03:14 inet kernel:    [<c01278e1>] [<c0127840>] [<c010552b>]
Dec  5 04:03:14 inet kernel: Code:  Bad EIP value.

>>EIP; 00001000 Before first symbol   <=====
Trace; c0127513 <shrink_cache+293/2d0>
Trace; c0127686 <shrink_caches+56/80>
Trace; c01276cd <try_to_free_pages+1d/40>
Trace; c0127764 <kswapd_balance_pgdat+44/90>
Trace; c01277c6 <kswapd_balance+16/30>
Trace; c01278e1 <kswapd+a1/c0>
Trace; c0127840 <kswapd+0/c0>
Trace; c010552b <kernel_thread+2b/40>

Dec  5 04:03:15 inet kernel:  <1>Unable to handle kernel paging request at 
virtual address 00005a00
Dec  5 04:03:15 inet kernel: 00005a00
Dec  5 04:03:15 inet kernel: *pde = 00000000
Dec  5 04:03:15 inet kernel: Oops: 0000
Dec  5 04:03:15 inet kernel: CPU:    0
Dec  5 04:03:15 inet kernel: EIP:    0010:[<00005a00>]    Not tainted
Dec  5 04:03:15 inet kernel: EFLAGS: 00010202
Dec  5 04:03:15 inet kernel: eax: 00000001   ebx: c02c9e40   ecx: c4802000   
edx: 0000005a
Dec  5 04:03:15 inet kernel: esi: 0000005a   edi: c29de204   ebp: c11d7da0   
esp: c25f9e98
Dec  5 04:03:15 inet kernel: ds: 0018   es: 0018   ss: 0018
Dec  5 04:03:15 inet kernel: Process awk (pid: 2248, stackpage=c25f9000)
Dec  5 04:03:15 inet kernel: Stack: c109c8c0 c011f43d c02c9e40 00000001 
08081138 00000001 c11d7da0 c2bef8a0
Dec  5 04:03:15 inet kernel:        c011f6bb c11d7da0 c2bef8a0 08081138 
c29de204 00005a00 00000001 c2ac3380
Dec  5 04:03:15 inet kernel:        c2bef0e4 c012002b c2ac39e0 c257a000 
c11d7ee0 c257a000 c257bfbc c25f8000
Dec  5 04:03:15 inet kernel: Call Trace: [<c011f43d>] [<c011f6bb>] 
[<c012002b>] [<c010f32a>] [<c0227f70>]
Dec  5 04:03:15 inet kernel:    [<c0134f01>] [<c012d6b3>] [<c011f975>] 
[<c012d5df>] [<c010f190>] [<c0106e44>] 
Dec  5 04:03:15 inet kernel: Code:  Bad EIP value.

>>EIP; 00005a00 Before first symbol   <=====
Trace; c011f43d <do_swap_page+7d/e0>
Trace; c011f6bb <handle_mm_fault+6b/c0>
Trace; c012002b <do_mmap_pgoff+44b/510>
Trace; c010f32a <do_page_fault+19a/4f0>
Trace; c0227f70 <__generic_copy_to_user+30/40>
Trace; c0134f01 <pipe_read+201/230>
Trace; c012d6b3 <sys_read+c3/d0>
Trace; c011f975 <sys_brk+c5/100>
Trace; c012d5df <sys_llseek+bf/d0>
Trace; c010f190 <do_page_fault+0/4f0>
Trace; c0106e44 <error_code+34/40>

This behavior happened again today when I was rebuilding the kernel.  It 
seems to take an hour or so of uptime before any noticable effects occur.

This is stock 2.4.16 with the ethernet bridging patch added (and loaded as a 
module).  The only other modules running are ext3 and jdb.  The machine is 
quite a few years old so the amount of extra addons to the kernel is quite 
small.

Please cc me for any replies as I only read the archived lkml.  Thanks!

Caleb Tennis
Analytical Engineering, Inc.

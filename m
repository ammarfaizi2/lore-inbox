Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263620AbUECJQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUECJQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 05:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbUECJQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 05:16:13 -0400
Received: from [194.243.27.136] ([194.243.27.136]:47626 "HELO
	venere.pandoraonline.it") by vger.kernel.org with SMTP
	id S263620AbUECJQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 05:16:04 -0400
Date: Mon, 3 May 2004 11:18:36 +0200
From: Devel <devel@integra-sc.it>
To: linux-kernel@vger.kernel.org
Subject: Oops with GigaByte  MainBoard
Message-Id: <20040503111836.6cff4016.devel@integra-sc.it>
Organization: Integra Solutions
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This is a report of a test i made on my two machine.
I have two identical Machine with Red Hat 7.3 and kernel 2.4.22:

CPU: AMD athlon-xp 3000
RAM: 512MB
HD: Maxtor 120GB
Modem: Conexant
VIDEO: ATI Radeon 7000
VIDEO GRABBER.

The difference are on The main Board:
1) GigaByte GA-7VT600(-L) chipset(via kt600)					(VT8235 South Bridge)
2) GigaByte GA-7VT600 1364 chipset(via kt600 with SATA disabled from BIOS)	(VT8237 South Bridge)

When i run my heavy load application (heavy CPU and I/O load) on the 1) all work fine. But when i run the same application on the same HW on the 2) i have a lot of OOPS (see bottom). The main difference between the two MB is the South Bridge. How i can diagnose these problem There are know proble with 2)? some suggest?
Thanks a lot !



OOPS

Apr 23 20:46:15 webeye kernel: Unable to handle kernel paging request at virtual address 23232327
Apr 23 20:46:15 webeye kernel:  printing eip:
Apr 23 20:46:15 webeye kernel: c012d96e
Apr 23 20:46:15 webeye kernel: *pde = 00000000
Apr 23 20:46:15 webeye kernel: Oops: 0002
Apr 23 20:46:15 webeye kernel: CPU:    0
Apr 23 20:46:15 webeye kernel: EIP:    0010:[<c012d96e>]    Tainted: P
Apr 23 20:46:15 webeye kernel: EFLAGS: 00010046
Apr 23 20:46:15 webeye kernel: eax: 23232323   ebx: dffd5dd4   ecx: de528000   edx: df79e000
Apr 23 20:46:15 webeye kernel: esi: 00000282   edi: 0000000d   ebp: c1534ca4   esp: c15efee0
Apr 23 20:46:15 webeye kernel: ds: 0018   es: 0018   ss: 0018
Apr 23 20:46:15 webeye kernel: Process kswapd (pid: 4, stackpage=c15ef000)
Apr 23 20:46:15 webeye kernel: Stack: df0e55c0 de528740 de528740 de528740 c01371bb dffd5dd4 de528740 c01391f1
Apr 23 20:46:15 webeye kernel:        de528740 de528740 dffe9c80 c1534ca4 000001d0 c013748f 00000000 c1534ca4
Apr 23 20:46:15 webeye kernel:        00000010 00002d11 c012e7f4 c1534ca4 000001d0 00000000 c15ee000 00000200
Apr 23 20:46:15 webeye kernel: Call Trace:    [<c01371bb>] [<c01391f1>] [<c013748f>] [<c012e7f4>] [<c012ea40>]
Apr 23 20:46:15 webeye kernel:   [<c012eaac>] [<c012ebbf>] [<c012ec36>] [<c012ed71>] [<c012ecd0>] [<c0105000>]
Apr 23 20:46:15 webeye kernel:   [<c0107116>] [<c012ecd0>]
Apr 23 20:46:15 webeye kernel:
Apr 23 20:46:15 webeye kernel: Code: 89 50 04 89 02 c7 01 00 00 00 00 c7 41 04 00 00 00 00 8b 43

Ksymoops:
>>EIP; c012d96e <kmem_cache_free+7e/b0>   <=====
Trace; c01371bb <__put_unused_buffer_head+2b/60>
Trace; c01391f1 <try_to_free_buffers+71/f0>
Trace; c013748f <try_to_release_page+2f/50>
Trace; c012e7f4 <shrink_cache+214/310>
Trace; c012ea40 <shrink_caches+50/80>
Trace; c012eaac <try_to_free_pages_zone+3c/60>
Trace; c012ebbf <kswapd_balance_pgdat+4f/a0>
Trace; c012ec36 <kswapd_balance+26/40>
Trace; c012ed71 <kswapd+a1/c0>
Trace; c012ecd0 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0107116 <arch_kernel_thread+26/30>
Trace; c012ecd0 <kswapd+0/c0>
Code;  c012d96e <kmem_cache_free+7e/b0>
00000000 <_EIP>:
Code;  c012d96e <kmem_cache_free+7e/b0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c012d971 <kmem_cache_free+81/b0>
   3:   89 02                     mov    %eax,(%edx)
Code;  c012d973 <kmem_cache_free+83/b0>
   5:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c012d979 <kmem_cache_free+89/b0>
   b:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  c012d980 <kmem_cache_free+90/b0>
  12:   8b 43 00                  mov    0x0(%ebx),%eax
 




Apr 26 11:50:24 webeye kernel: Unable to handle kernel paging request at virtual address 23232327
Apr 26 11:50:24 webeye kernel:  printing eip:
Apr 26 11:50:24 webeye kernel: c012d93f
Apr 26 11:50:24 webeye kernel: *pde = 00000000
Apr 26 11:50:24 webeye kernel: Oops: 0002
Apr 26 11:50:24 webeye kernel: CPU:    0
Apr 26 11:50:24 webeye kernel: EIP:    0010:[<c012d93f>]    Tainted: P
Apr 26 11:50:24 webeye kernel: EFLAGS: 00010046
Apr 26 11:50:24 webeye kernel: eax: 23232323   ebx: dffd5dd4   ecx: da7f4000   edx: da7eb000
Apr 26 11:50:24 webeye kernel: esi: 00000282   edi: 0000000b   ebp: c13bf95c   esp: c15efee0
Apr 26 11:50:24 webeye kernel: ds: 0018   es: 0018   ss: 0018
Apr 26 11:50:24 webeye kernel: Process kswapd (pid: 4, stackpage=c15ef000)
Apr 26 11:50:24 webeye kernel: Stack: c010c0f8 da7f4640 da7f4640 da7f4640 c01371bb dffd5dd4 da7f4640 c01391f1
Apr 26 11:50:24 webeye kernel:        da7f4640 da7f4640 c131bcf4 c032bf50 c102c01c c032bf64 00000000 c13bf95c
Apr 26 11:50:24 webeye kernel:        0000001d 00002b68 c012e7f4 c13bf95c 000001d0 00000000 c15ee000 00000200
Apr 26 11:50:24 webeye kernel: Call Trace:    [<c010c0f8>] [<c01371bb>] [<c01391f1>] [<c012e7f4>] [<c012ea40>]
Apr 26 11:50:24 webeye kernel:   [<c012eaac>] [<c012ebbf>] [<c012ec36>] [<c012ed71>] [<c012ecd0>] [<c0105000>]
Apr 26 11:50:24 webeye kernel:   [<c0107116>] [<c012ecd0>]
Apr 26 11:50:24 webeye kernel:
Apr 26 11:50:24 webeye kernel: Code: 89 50 04 89 02 c7 01 00 00 00 00 c7 41 04 00 00 00 00 8b 43
Apr 26 11:59:00 webeye kernel:  memory.c:100: bad pmd 23232323.


Ksymoops:

>>EIP; c012d93f <kmem_cache_free+4f/b0>   <=====
Trace; c010c0f8 <call_do_IRQ+5/d>
Trace; c01371bb <__put_unused_buffer_head+2b/60>
Trace; c01391f1 <try_to_free_buffers+71/f0>
Trace; c012e7f4 <shrink_cache+214/310>
Trace; c012ea40 <shrink_caches+50/80>
Trace; c012eaac <try_to_free_pages_zone+3c/60>
Trace; c012ebbf <kswapd_balance_pgdat+4f/a0>
Trace; c012ec36 <kswapd_balance+26/40>
Trace; c012ed71 <kswapd+a1/c0>
Trace; c012ecd0 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0107116 <arch_kernel_thread+26/30>
Trace; c012ecd0 <kswapd+0/c0>
Code;  c012d93f <kmem_cache_free+4f/b0>
00000000 <_EIP>:
Code;  c012d93f <kmem_cache_free+4f/b0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c012d942 <kmem_cache_free+52/b0>
   3:   89 02                     mov    %eax,(%edx)
Code;  c012d944 <kmem_cache_free+54/b0>
   5:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c012d94a <kmem_cache_free+5a/b0>
   b:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  c012d951 <kmem_cache_free+61/b0>
  12:   8b 43 00                  mov    0x0(%ebx),%eax
 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUAMMks (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 07:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbUAMMkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 07:40:47 -0500
Received: from [194.243.27.136] ([194.243.27.136]:12561 "HELO
	venere.pandoraonline.it") by vger.kernel.org with SMTP
	id S263868AbUAMMkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 07:40:40 -0500
Subject: Regular oops with my RH7.3-2.4.22
From: Carlo <devel@integra-sc.it>
To: linux-kernel@vger.kernel.org
Cc: info@integra-sc.it
Content-Type: text/plain
Message-Id: <1073997527.25130.51.camel@atena>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 13 Jan 2004 13:40:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
i have regulars oops with my linux-box Red-Hat 7.3 with kernel 2.4.22
patched for ACPI. My HW is:
CPU: celeron 2.0GHz
MB : COMMEL LV-670M (Intel 845GV and ICH4 chipset)
HD : IDE drive (120GB) MAXTOR 7200RPM
RAM: 256MB kingstone

This HW is an all-in-one product so is very important for us. Someone
has some suggests for debug this kind of errors and maybe (with my
little little little capacity :-) ) help the comunity.

This are dmesg output passed through ksymoops i hope can help.


ksymoops 2.4.4 on i686 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /boot/System.map-2.4.22-WE (specified)

Jan 12 23:07:11 box kernel: Unable to handle kernel paging request at
virtual address 382f3643
Jan 12 23:07:11 box kernel: c012de70
Jan 12 23:07:11 box kernel: *pde = 00000000
Jan 12 23:07:11 box kernel: Oops: 0002
Jan 12 23:07:11 box kernel: CPU:    0
Jan 12 23:07:11 box kernel: EIP:    0010:[<c012de70>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 12 23:07:11 box kernel: EFLAGS: 00010046
Jan 12 23:07:11 box kernel: eax: 382f363f   ebx: c9f61000   ecx:
00000012   edx: cd39d000
Jan 12 23:07:11 box kernel: esi: c12aff18   edi: 00000246   ebp:
000023a9   esp: cf773f18
Jan 12 23:07:11 box kernel: ds: 0018   es: 0018   ss: 0018
Jan 12 23:07:11 box kernel: Process kswapd (pid: 5, stackpage=cf773000)
Jan 12 23:07:11 box kernel: Stack: c9a644c0 c9f619a0 c6d65860 c01469ea
c12aff18 c9f619a0 00000006 00000006
Jan 12 23:07:11 box kernel:        c010c2b8 0000001f 00000000 cce166c0
000001d0 00000006 0000001f 000001d0
Jan 12 23:07:11 box kernel:        00000006 00000006 c0146cf0 00002511
c012ef07 00000006 000001d0 c032c110
Jan 12 23:07:11 box kernel: Call Trace:    [<c01469ea>] [<c010c2b8>]
[<c0146cf0>] [<c012ef07>] [<c012ef5c>]
Jan 12 23:07:11 box kernel:   [<c012f06f>] [<c012f0e6>] [<c012f221>]
[<c012f180>] [<c0105000>] [<c0107156>]
Jan 12 23:07:11 box kernel:   [<c012f180>]
Jan 12 23:07:11 box kernel: Code: 89 50 04 89 02 8d 56 08 c7 03 00 00 00
00 c7 43 04 00 00 00

>>EIP; c012de70 <kmem_cache_free+80/b0>   <=====
Trace; c01469ea <prune_dcache+11a/150>
Trace; c010c2b8 <call_do_IRQ+5/d>
Trace; c0146cf0 <shrink_dcache_memory+20/30>
Trace; c012ef07 <shrink_caches+67/80>
Trace; c012ef5c <try_to_free_pages_zone+3c/60>
Trace; c012f06f <kswapd_balance_pgdat+4f/a0>
Trace; c012f0e6 <kswapd_balance+26/40>
Trace; c012f221 <kswapd+a1/c0>
Trace; c012f180 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0107156 <arch_kernel_thread+26/30>
Trace; c0107156 <arch_kernel_thread+26/30>
Trace; c012f180 <kswapd+0/c0>
Code;  c012de70 <kmem_cache_free+80/b0>
00000000 <_EIP>:
Code;  c012de70 <kmem_cache_free+80/b0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c012de73 <kmem_cache_free+83/b0>
   3:   89 02                     mov    %eax,(%edx)
Code;  c012de75 <kmem_cache_free+85/b0>
   5:   8d 56 08                  lea    0x8(%esi),%edx
Code;  c012de78 <kmem_cache_free+88/b0>
   8:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012de7e <kmem_cache_free+8e/b0>
   e:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)



-------------------------------------------------------

Unable to handle kernel paging request at virtual address fdfdfe01
 printing eip:
c012de70
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012de70>]    Not tainted
EFLAGS: 00010046
eax: fdfdfdfd   ebx: c9e6d000   ecx: 00000019   edx: ceb91020
esi: c12afdd4   edi: 00000202   ebp: c1098a74   esp: cf773ee4
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=cf773000)
Stack: c9e6da20 c9e6da20 c9e6da20 c013777c c12afdd4 c9e6da20 c01397f1
c9e6da20 
       c9e6da20 c032c110 c102c01c c032c124 00000206 000001d0 c1098a74
00000009 
       00001280 c012eca5 c1098a74 000001d0 00000000 cf772000 000001c0
000001d0 
Call Trace:    [<c013777c>] [<c01397f1>] [<c012eca5>] [<c012eef2>]
[<c012ef5c>]
  [<c012f06f>] [<c012f0e6>] [<c012f221>] [<c012f180>] [<c0105000>]
[<c0107156>]
  [<c012f180>]

Code: 89 50 04 89 02 8d 56 08 c7 03 00 00 00 00 c7 43 04 00 00 00
 
>>EIP; c012de70 <kmem_cache_free+80/b0>   <=====
Trace; c013777c <__put_unused_buffer_head+2c/60>
Trace; c01397f1 <try_to_free_buffers+71/f0>
Trace; c012eca5 <shrink_cache+215/310>
Trace; c012eef2 <shrink_caches+52/80>
Trace; c012ef5c <try_to_free_pages_zone+3c/60>
Trace; c012f06f <kswapd_balance_pgdat+4f/a0>
Trace; c012f0e6 <kswapd_balance+26/40>
Trace; c012f221 <kswapd+a1/c0>
Trace; c012f180 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0107156 <arch_kernel_thread+26/30>
Trace; c012f180 <kswapd+0/c0>
Code;  c012de70 <kmem_cache_free+80/b0>
00000000 <_EIP>:
Code;  c012de70 <kmem_cache_free+80/b0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c012de73 <kmem_cache_free+83/b0>
   3:   89 02                     mov    %eax,(%edx)
Code;  c012de75 <kmem_cache_free+85/b0>
   5:   8d 56 08                  lea    0x8(%esi),%edx
Code;  c012de78 <kmem_cache_free+88/b0>
   8:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012de7e <kmem_cache_free+8e/b0>
   e:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)


------------------------------------------------------------------
 <1>Unable to handle kernel paging request at virtual address 72747275
 printing eip:
c012de70
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012de70>]    Not tainted
EFLAGS: 00010046
eax: 72747271   ebx: c5761000   ecx: 00000005   edx: cf358000
esi: c12aff84   edi: 00000246   ebp: 00000000   esp: c95d9da8
ds: 0018   es: 0018   ss: 0018
Process vcr_jpeg (pid: 26096, stackpage=c95d9000)
Stack: c57619a0 c95d9de4 c884ee08 c01477ed c12aff84 c57619a0 c57619a0
c01483d3 
       c57619a0 c57619a0 c884ea48 c884ea40 c0148643 c95d9de4 00001bf5
c57615e8 
       c92c70c8 00000011 000001d2 00000006 00000006 c0148680 00001bf5
c012ef0e 
Call Trace:    [<c01477ed>] [<c01483d3>] [<c0148643>] [<c0148680>]
[<c012ef0e>]
  [<c012ef5c>] [<c012f987>] [<c012fc3b>] [<c0125e79>] [<c0125f54>]
[<c0126108>]
  [<c0114f50>] [<c010c2b8>] [<c01150ca>] [<c010d46d>] [<c0115c20>]
[<c0114f50>]
  [<c0108a04>]

Code: 89 50 04 89 02 8d 56 08 c7 03 00 00 00 00 c7 43 04 00 00 00 

>>EIP; c012de70 <kmem_cache_free+80/b0>   <=====
Trace; c01477ed <destroy_inode+3d/50>
Trace; c01483d3 <dispose_list+53/70>
Trace; c0148643 <prune_icache+d3/f0>
Trace; c0148680 <shrink_icache_memory+20/30>
Trace; c012ef0e <shrink_caches+6e/80>
Trace; c012ef5c <try_to_free_pages_zone+3c/60>
Trace; c012f987 <balance_classzone+57/1f0>
Trace; c012fc3b <__alloc_pages+11b/170>
Trace; c0125e79 <do_anonymous_page+39/e0>
Trace; c0125f54 <do_no_page+34/190>
Trace; c0126108 <handle_mm_fault+58/c0>
Trace; c0114f50 <do_page_fault+0/4ab>
Trace; c010c2b8 <call_do_IRQ+5/d>
Trace; c01150ca <do_page_fault+17a/4ab>
Trace; c010d46d <old_mmap+ed/130>
Trace; c0115c20 <process_timeout+0/50>
Trace; c0114f50 <do_page_fault+0/4ab>
Trace; c0108a04 <error_code+34/3c>
Code;  c012de70 <kmem_cache_free+80/b0>
00000000 <_EIP>:
Code;  c012de70 <kmem_cache_free+80/b0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c012de73 <kmem_cache_free+83/b0>
   3:   89 02                     mov    %eax,(%edx)
Code;  c012de75 <kmem_cache_free+85/b0>
   5:   8d 56 08                  lea    0x8(%esi),%edx
Code;  c012de78 <kmem_cache_free+88/b0>
   8:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012de7e <kmem_cache_free+8e/b0>
   e:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)

------------------------------------------------------------------
Jan 13 04:43:02 box kernel:  <1>Unable to handle kernel paging request
at virtual address 423b3a3f
Jan 13 04:43:02 box kernel: c012dc83
Jan 13 04:43:02 box kernel: *pde = 00000000
Jan 13 04:43:02 box kernel: Oops: 0002
Jan 13 04:43:02 box kernel: CPU:    0
Jan 13 04:43:02 box kernel: EIP:    0010:[<c012dc83>]    Not tainted
Jan 13 04:43:02 box kernel: EFLAGS: 00010057
Jan 13 04:43:02 box kernel: eax: c12aff8c   ebx: c12aff84   ecx:
ce105000   edx: 423b3a3b
Jan 13 04:43:02 box kernel: esi: 00000246   edi: ce104e60   ebp:
ce105040   esp: c89e3eec
Jan 13 04:43:02 box kernel: ds: 0018   es: 0018   ss: 0018
Jan 13 04:43:02 box kernel: Process mgetty (pid: 28103,
stackpage=c89e3000)
Jan 13 04:43:02 box kernel: Stack: 000000f0 c89e3f10 c080b2a0 cce16140
00000001 00000000 ffffff9f cf77c400
Jan 13 04:43:02 box kernel:        c01476d1 c12aff84 000001f0 00000001
00000004 ffffff9f c03cb3a0 c01486ea
Jan 13 04:43:02 box kernel:        cf77c400 c028276f cf77c400 00000001
c0283085 c939bde0 c01470ec c080b2a0
Jan 13 04:43:02 box kernel: Call Trace:    [<c01476d1>] [<c01486ea>]
[<c028276f>] [<c0283085>] [<c01470ec>]
Jan 13 04:43:02 box kernel:   [<c02830fb>] [<c0283da2>] [<c0114f50>]
[<c0108a04>] [<c0108913>]
Jan 13 04:43:02 box kernel: Code: 89 42 04 89 10 c7 01 00 00 00 00 c7 41
04 00 00 00 00 8b 03

>>EIP; c012dc83 <kmem_cache_alloc+93/e0>   <=====
Trace; c01476d1 <alloc_inode+31/110>
Trace; c01486ea <new_inode+a/50>
Trace; c028276f <sock_alloc+f/a0>
Trace; c0283085 <sock_create+a5/100>
Trace; c01470ec <d_delete+4c/80>
Trace; c02830fb <sys_socket+1b/50>
Trace; c0283da2 <sys_socketcall+62/200>
Trace; c0114f50 <do_page_fault+0/4ab>
Trace; c0108a04 <error_code+34/3c>
Trace; c0108913 <system_call+33/38>
Code;  c012dc83 <kmem_cache_alloc+93/e0>
00000000 <_EIP>:
Code;  c012dc83 <kmem_cache_alloc+93/e0>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c012dc86 <kmem_cache_alloc+96/e0>
   3:   89 10                     mov    %edx,(%eax)
Code;  c012dc88 <kmem_cache_alloc+98/e0>
   5:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c012dc8e <kmem_cache_alloc+9e/e0>
  12:   8b 03                     mov    (%ebx),%eax





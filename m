Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUDWWda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUDWWda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 18:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUDWWd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 18:33:27 -0400
Received: from dsl092-109-241.nyc2.dsl.speakeasy.net ([66.92.109.241]:17612
	"EHLO gandalf.taltos.org") by vger.kernel.org with ESMTP
	id S261635AbUDWWdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 18:33:15 -0400
Date: Fri, 23 Apr 2004 18:33:13 -0400
From: Carson Gaspar <carson@taltos.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Message-ID: <382320000.1082759593@taltos.ny.ficc.gs.com>
X-Mailer: Mulberry/3.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, we see the exact same panic with the tg3 driver using 2.4.25 and 
distcc with sendfile(). The bcm5700 driver also panics, but I haven't 
captured a panic message to be certain it's the same bug.

kernel BUG at page_alloc.c:98!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c0139492>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000001   ebx: c294dcb0   ecx: 00000001   edx: 00000020
esi: edb6e2e0   edi: 00000000   ebp: 00000004   esp: c55af9b4
ds: 0018   es: 0018   ss: 0018
Process cc1plus (pid: 21186, stackpage=c55af000)
Stack: c022e9ee f6fb1000 c022aa9c 00000287 00000206 00000286 db5a9600 
00000001
       edb6e2e0 edb6e2e0 00000004 c022aa4e edb6e2e0 f3716100 c022aa9c 
edb6e2e0
       f371623c f3716100 c022ac25 edb6e2e0 00000000 c025423a edb6e2e0 
c55ae000
Call Trace:    [<c022e9ee>] [<c022aa9c>] [<c022aa4e>] [<c022aa9c>] 
[<c022ac25>]
  [<c025423a>] [<c0247d28>] [<c024be53>] [<c025675b>] [<c02547c8>] 
[<c0256bdf>]
  [<c0138175>] [<c022aa9c>] [<c0254307>] [<c0258a67>] [<c022aa9c>] 
[<c0254307>]
  [<c025ef5b>] [<c025f4ad>] [<c022ac25>] [<c0256bec>] [<c01550dc>] 
[<c014ba00>]
  [<c02449a3>] [<c02449a3>] [<c0244da6>] [<c025ef5b>] [<c0139c05>] 
[<c025f4ad>]
  [<c022a8af>] [<c022f189>] [<c022a8af>] [<f8990d48>] [<c02449a3>] 
[<f8990ef9>]
  [<c022f3a3>]o[<c0122c5b>] [<c010a74e>] [<c0131a04>] [<c012e232>] 
[<c0131487>]
  [<c0119e06>] [<c0131b08>] [<c0131990>] [<c01410d6>] [<c012e72a>] 
[<c0108b5f>]
Code: 0f 0b 62 00 bd 35 2a c0 89 d8 e8 5f ed ff ff 8b 6b 28 85 ed

>>EIP; c0139492 <__free_pages_ok+32/2b0>   <=====
Trace; c022e9ee <dev_queue_xmit+14e/320>
Trace; c022aa9c <kfree_skbmem+c/70>
Trace; c022aa4e <skb_release_data+4e/90>
Trace; c022aa9c <kfree_skbmem+c/70>
Trace; c022ac25 <__kfree_skb+125/130>
Trace; c025423a <tcp_clean_rtx_queue+15a/310>
Trace; c0247d28 <ip_queue_xmit+3d8/550>
Trace; c024be53 <tcp_write_space+53/80>
Trace; c025675b <tcp_new_space+7b/80>
Trace; c02547c8 <tcp_ack+138/360>
Trace; c0256bdf <tcp_rcv_established+ef/8b0>
Trace; c0138175 <lru_cache_add+75/80>
Trace; c022aa9c <kfree_skbmem+c/70>
Trace; c0254307 <tcp_clean_rtx_queue+227/310>
Trace; c0258a67 <tcp_transmit_skb+567/620>
Trace; c022aa9c <kfree_skbmem+c/70>
Trace; c0254307 <tcp_clean_rtx_queue+227/310>
Trace; c025ef5b <tcp_v4_do_rcv+3b/120>
Trace; c025f4ad <tcp_v4_rcv+46d/6f0>
Trace; c022ac25 <__kfree_skb+125/130>
Trace; c0256bec <tcp_rcv_established+fc/8b0>
Trace; c01550dc <dput+1c/160>
Trace; c014ba00 <cached_lookup+10/50>
Trace; c02449a3 <ip_local_deliver+f3/190>
Trace; c02449a3 <ip_local_deliver+f3/190>
Trace; c0244da6 <ip_rcv+366/400>
Trace; c025ef5b <tcp_v4_do_rcv+3b/120>
Trace; c0139c05 <__alloc_pages+75/2f0>
Trace; c025f4ad <tcp_v4_rcv+46d/6f0>
Trace; c022a8af <alloc_skb+ef/1c0>
Trace; c022f189 <netif_receive_skb+189/1c0>
Trace; c022a8af <alloc_skb+ef/1c0>
Trace; f8990d48 <[usbcore]__kstrtab_usb_hcd_giveback_urb+52f8/6a50>
Trace; c02449a3 <ip_local_deliver+f3/190>
Trace; f8990ef9 <[usbcore]__kstrtab_usb_hcd_giveback_urb+54a9/6a50>
Trace; c022f3a3 <net_rx_action+b3/170>
Trace; c0119e06 <do_page_fault+1a6/4eb>
Trace; c0131b08 <generic_file_read+88/170>
Trace; c0131990 <file_read_actor+0/f0>
Trace; c01410d6 <sys_read+96/110>
Trace; c012e72a <sys_brk+ba/f0>
Trace; c0108b5f <system_call+33/38>
Code;  c0139492 <__free_pages_ok+32/2b0>
00000000 <_EIP>:
Code;  c0139492 <__free_pages_ok+32/2b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0139494 <__free_pages_ok+34/2b0>
   2:   62 00                     bound  %eax,(%eax)
Code;  c0139496 <__free_pages_ok+36/2b0>
   4:   bd 35 2a c0 89            mov    $0x89c02a35,%ebp
Code;  c013949b <__free_pages_ok+3b/2b0>
   9:   d8 e8                     fsubr  %st(0),%st
Code;  c013949d <__free_pages_ok+3d/2b0>
   b:   5f                        pop    %edi
Code;  c013949e <__free_pages_ok+3e/2b0>
   c:   ed                        in     (%dx),%eax
Code;  c013949f <__free_pages_ok+3f/2b0>
   d:   ff                        (bad)
Code;  c01394a0 <__free_pages_ok+40/2b0>
   e:   ff 8b 6b 28 85 ed         decl   0xed85286b(%ebx)

 <0>Kernel panic: Aiee, killing interrupt handler!


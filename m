Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310803AbSCMQue>; Wed, 13 Mar 2002 11:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310796AbSCMQuZ>; Wed, 13 Mar 2002 11:50:25 -0500
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:9089 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S310806AbSCMQuF>;
	Wed, 13 Mar 2002 11:50:05 -0500
Date: Wed, 13 Mar 2002 08:50:18 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@redhat.com>
Subject: 2.4.18pre8 Oops: tcp_v4_get_port
Message-ID: <20020313165018.GA17171@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We've seen this Oops a few times now.  I'm not sure if I was imagining
things, but was this a TCP hash race that was fixed easily in newer
kernels, or is this something else?

Unable to handle kernel paging request at virtual address 1c603920
 printing eip:
c022a471
*pde = 00000000
Oops: 0000
CPU:    1 
EIP:    0010:[<c022a471>]    Not tainted
EFLAGS: 00010296
eax: 001cf9cf   ebx: f72ad2c0   ecx: ce4c3220   edx: 1c603914
esi: 0000b143   edi: 00000000   ebp: f7dd8a18   esp: e020beb4
ds: 0018   es: 0018   ss: 0018
Process wu.ftpd (pid: 13844, stackpage=e020b000)
Stack: 00000000 f72ad2c0 c0332e68 0000b143 00000000 00000000 00000001 c023803c
       f72ad2c0 0000b143 f7d19e80 e020bf14 00000010 400ca008 ffffffea 00000002
       c0200890 f7d19e80 e020bf14 00000010 00000001 00000003 ffffffff 00000000  
Call Trace: [<c023803c>] [<c0200890>] [<c0112b58>] [<c010b9ee>] [<c0201380>]    
   [<c0106f9c>] [<c0106eab>] 

Code: 8b 42 0c 39 43 0c 75 e7 83 7c 24 10 00 74 0d 80 7a 26 00 74

>>EIP; c022a470 <tcp_v4_get_port+154/294>   <=====
Trace; c023803c <inet_bind+180/294>
Trace; c0200890 <sys_bind+54/74>
Trace; c0112b58 <do_page_fault+0/4ac>
Trace; c010b9ee <old_mmap+f2/12c>
Trace; c0201380 <sys_socketcall+78/200>
Trace; c0106f9c <error_code+34/3c>
Trace; c0106eaa <system_call+32/38>
Code;  c022a470 <tcp_v4_get_port+154/294>
00000000 <_EIP-0x1>:
Code;  c022a470 <tcp_v4_get_port+154/294>
   0:   8b 42 0c          movl   0xc(%edx),%eax
Code;  c022a470 <tcp_v4_get_port+154/294>
00000001 <_EIP>:
Code;  c022a470 <tcp_v4_get_port+154/294>   <=====
   1:   42                incl   %edx   <=====
Code;  c022a472 <tcp_v4_get_port+156/294>
   2:   0c 39             orb    $0x39,%al
Code;  c022a474 <tcp_v4_get_port+158/294>
   4:   43                incl   %ebx
Code;  c022a474 <tcp_v4_get_port+158/294>
   5:   0c 75             orb    $0x75,%al
Code;  c022a476 <tcp_v4_get_port+15a/294>
   7:   e7 83             outl   %eax,$0x83
Code;  c022a478 <tcp_v4_get_port+15c/294>
   9:   7c 24             jl     2f <_EIP+0x2e> c022a49e <tcp_v4_get_port+182/294>
Code;  c022a47a <tcp_v4_get_port+15e/294>
   b:   10 00             adcb   %al,(%eax)
Code;  c022a47c <tcp_v4_get_port+160/294>
   d:   74 0d             je     1c <_EIP+0x1b> c022a48a <tcp_v4_get_port+16e/294>
Code;  c022a47e <tcp_v4_get_port+162/294>
   f:   80 7a 26 00       cmpb   $0x0,0x26(%edx)
Code;  c022a482 <tcp_v4_get_port+166/294>
  13:   74 00             je     15 <_EIP+0x14> c022a484 <tcp_v4_get_port+168/294>

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]

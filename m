Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317959AbSGWGFM>; Tue, 23 Jul 2002 02:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317960AbSGWGFM>; Tue, 23 Jul 2002 02:05:12 -0400
Received: from [196.26.86.1] ([196.26.86.1]:50623 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317959AbSGWGFH>; Tue, 23 Jul 2002 02:05:07 -0400
Date: Tue, 23 Jul 2002 08:26:06 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: odd memory corruption in 2.5.27?
In-Reply-To: <Pine.LNX.4.44.0207230824010.32636-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0207230824590.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond, Arnaldo, Al
	I tried reproducing using a local filesystem and couldn't 
(machine survived 3 make -j10 kernel compiles). Here is another oops for 
the collection. Al i'll remove you from further CCs now.

client: 2.5.27-serial, 3c905B
server: 2.4.19-pre5-ac3, 3c905B
connection: 100Mb/FD

I got this message before it oopsed;
RPC: garbage, exit EIO

Unable to handle kernel paging request at virtual address 5f707275
c013f822
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f822>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 5f707261   ebx: 00000001   ecx: 5f707261   edx: 00000000
esi: c826d2e4   edi: c826d2e4   ebp: c038c000   esp: c038deb0
ds: 0018   es: 0018   ss: 0018
Stack: c028d4fe c826d2e4 cea012cc c028d53c c826d2e4 cde2ca04 cea012cc c028d67d
       c826d2e4 c02a2b00 c02a28d3 c826d2e4 c8e0ae2c c02a2b00 c038c000 c02a2c21
       cea012cc c8e0ae2c c02a2c8b cea012cc 00000001 00000000 cc00fc0c 00000000
Call Trace: [<c028d4fe>] [<c028d53c>] [<c028d67d>] [<c02a2b00>] [<c02a28d3>]
   [<c02a2b00>] [<c02a2c21>] [<c02a2c8b>] [<c0126614>] [<c0122950>] [<c01227e0>]   [<c01224eb>] [<c0109d82>] [<c01053a0>] [<c0107f2a>] [<c01053a0>] [<c01053a0>]   [<c01053ca>] [<c0105472>] [<c0105000>]
Code: 8b 41 14 a9 00 08 00 00 75 14 f0 ff 49 10 0f 94 c0 84 c0 74

>>EIP; c013f822 <__free_pages+2/30>   <=====
Trace; c028d4fe <skb_release_data+1e/80>
Trace; c028d53c <skb_release_data+5c/80>
Trace; c028d67d <__kfree_skb+ad/e0>
Trace; c02a2b00 <ip_evictor+1d0/200>
Trace; c02a28d3 <ip_frag_destroy+43/a0>
Trace; c02a2b00 <ip_evictor+1d0/200>
Trace; c02a2c21 <ip_expire+f1/1a0>
Trace; c02a2c8b <ip_expire+15b/1a0>
Trace; c0126614 <timer_bh+324/400>
Trace; c0122950 <bh_action+70/140>
Trace; c01227e0 <tasklet_hi_action+70/c0>
Trace; c01224eb <do_softirq+7b/f0>
Trace; c0109d82 <do_IRQ+1d2/1e0>
Trace; c01053a0 <default_idle+0/40>
Trace; c0107f2a <common_interrupt+22/28>
Trace; c01053a0 <default_idle+0/40>
Trace; c01053a0 <default_idle+0/40>
Trace; c01053ca <default_idle+2a/40>
Trace; c0105472 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>
Code;  c013f822 <__free_pages+2/30>
00000000 <_EIP>:
Code;  c013f822 <__free_pages+2/30>   <=====
   0:   8b 41 14                  mov    0x14(%ecx),%eax   <=====
Code;  c013f825 <__free_pages+5/30>
   3:   a9 00 08 00 00            test   $0x800,%eax
Code;  c013f82a <__free_pages+a/30>
   8:   75 14                     jne    1e <_EIP+0x1e> c013f840 <__free_pages+20/30>
Code;  c013f82c <__free_pages+c/30>
   a:   f0 ff 49 10               lock decl 0x10(%ecx)
Code;  c013f830 <__free_pages+10/30>
   e:   0f 94 c0                  sete   %al
Code;  c013f833 <__free_pages+13/30>
  11:   84 c0                     test   %al,%al
Code;  c013f835 <__free_pages+15/30>
  13:   74 00                     je     15 <_EIP+0x15> c013f837 <__free_pages+17/30>

 <0>Kernel panic: Aiee, killing interrupt handler!


-- 
function.linuxpower.ca


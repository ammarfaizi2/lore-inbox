Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSGAUIX>; Mon, 1 Jul 2002 16:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSGAUIW>; Mon, 1 Jul 2002 16:08:22 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:3016 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S316544AbSGAUIV>; Mon, 1 Jul 2002 16:08:21 -0400
Date: Mon, 1 Jul 2002 22:10:43 +0200
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre10 oops
Message-ID: <20020701221043.A429@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using 2.4.19-pre10, and got an oops.  I sometimes also get a lockup, and have no idea why.

This oops happened when reading my lkml mailbox.  Ksymoops output:

Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c013f35e
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c013f35e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c09abb94   ebx: c09abb7c   ecx: 00000000   edx: c25927f0
esi: c09abb64   edi: c9c606a0   ebp: 00000f53   esp: c1237f60
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c1237000)
Stack: 0000000c 000001d0 00000020 00000006 c013f64b 000048ba c0129a51 00000006
       000001d0 00000006 000001d0 c028cfd4 00000000 c028cfd4 c0129a9c 00000020
       c028cfd4 00000001 c1236000 c0129b33 c028cf20 00000000 c1236249 0008e000
Call Trace: [<c013f64b>] [<c0129a51>] [<c0129a9c>] [<c0129b33>] [<c0129b8e>]
   [<c0129c9d>] [<c0106efc>]
Code: 89 11 89 46 30 89 40 04 8b 46 4c 85 c0 74 13 8b 40 14 85 c0

>>EIP; c013f35e <prune_dcache+9e/138>   <=====

>>eax; c09abb94 <_end+69cfb0/c52641c>
>>ebx; c09abb7c <_end+69cf98/c52641c>
>>edx; c25927f0 <_end+2283c0c/c52641c>
>>esi; c09abb64 <_end+69cf80/c52641c>
>>edi; c9c606a0 <_end+9951abc/c52641c>
>>ebp; 00000f53 Before first symbol
>>esp; c1237f60 <_end+f2937c/c52641c>

Trace; c013f64b <shrink_dcache_memory+1b/34>
Trace; c0129a51 <shrink_caches+69/80>
Trace; c0129a9c <try_to_free_pages+34/54>
Trace; c0129b33 <kswapd_balance_pgdat+43/8c>
Trace; c0129b8e <kswapd_balance+12/28>
Trace; c0129c9d <kswapd+99/bc>
Trace; c0106efc <kernel_thread+28/38>

Code;  c013f35e <prune_dcache+9e/138>
00000000 <_EIP>:
Code;  c013f35e <prune_dcache+9e/138>   <=====
   0:   89 11                     mov    %edx,(%ecx)   <=====
Code;  c013f360 <prune_dcache+a0/138>
   2:   89 46 30                  mov    %eax,0x30(%esi)
Code;  c013f363 <prune_dcache+a3/138>
   5:   89 40 04                  mov    %eax,0x4(%eax)
Code;  c013f366 <prune_dcache+a6/138>
   8:   8b 46 4c                  mov    0x4c(%esi),%eax
Code;  c013f369 <prune_dcache+a9/138>
   b:   85 c0                     test   %eax,%eax
Code;  c013f36b <prune_dcache+ab/138>
   d:   74 13                     je     22 <_EIP+0x22> c013f380 <prune_dcache+c0/138>
Code;  c013f36d <prune_dcache+ad/138>
   f:   8b 40 14                  mov    0x14(%eax),%eax
Code;  c013f370 <prune_dcache+b0/138>
  12:   85 c0                     test   %eax,%eax

After that I got a few times "kernel BUG at dcache.c:345"


Kurt


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264797AbTF0V2Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 17:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264802AbTF0V2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 17:28:25 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:43499 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264797AbTF0V2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 17:28:23 -0400
Date: Fri, 27 Jun 2003 23:42:36 +0200
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: prune_dcache oops with 2.4.21
Message-ID: <20030627214236.GA2715@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just had an oops today with 2.4.21.

I've ran it through ksymoops:
Unable to handle kernel NULL pointer dereference at virtual
address 00000000
c013d06f
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c013d06f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c060dc54   ebx: c060dc3c   ecx: 00000000   edx: c05f5bd0
esi: c060dc24   edi: ca1f8bc0   ebp: 00000179   esp: c123ff60
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c123f000)
Stack: 00000001 000001d0 00000001 00000005 c013d38b 0000049a c01271e7 00000005
       000001d0 00000005 000001d0 c02be394 00000000 c02be394 c0127232 00000001
       c02be394 00000001 c123e000 c0127331 c02be2e0 00000000 c123e249 0008e000
Call Trace:    [<c013d38b>] [<c01271e7>] [<c0127232>] [<c0127331>] [<c0127396>]
  [<c01274ad>] [<c010553c>]
Code: 89 11 89 46 30 89 40 04 8b 46 4c 85 c0 74 12 8b 40 14 85 c0


>>EIP; c013d06f <prune_dcache+af/148>   <=====

>>eax; c060dc54 <END_OF_CODE+2b32b0/????>
>>ebx; c060dc3c <END_OF_CODE+2b3298/????>
>>edx; c05f5bd0 <END_OF_CODE+29b22c/????>
>>esi; c060dc24 <END_OF_CODE+2b3280/????>
>>edi; ca1f8bc0 <END_OF_CODE+9e9e21c/????>
>>esp; c123ff60 <END_OF_CODE+ee55bc/????>
Trace; c013d38b <shrink_dcache_memory+1b/34>
Trace; c01271e7 <shrink_caches+67/80>
Trace; c0127232 <try_to_free_pages_zone+32/50>
Trace; c0127331 <kswapd_balance_pgdat+41/8c>
Trace; c0127396 <kswapd_balance+1a/30>
Trace; c01274ad <kswapd+99/bc>
Trace; c010553c <arch_kernel_thread+28/38>

Code;  c013d06f <prune_dcache+af/148>
00000000 <_EIP>:
Code;  c013d06f <prune_dcache+af/148>   <=====
   0:   89 11                     mov    %edx,(%ecx)   <=====
Code;  c013d071 <prune_dcache+b1/148>
   2:   89 46 30                  mov    %eax,0x30(%esi)
Code;  c013d074 <prune_dcache+b4/148>
   5:   89 40 04                  mov    %eax,0x4(%eax)
Code;  c013d077 <prune_dcache+b7/148>
   8:   8b 46 4c                  mov    0x4c(%esi),%eax
Code;  c013d07a <prune_dcache+ba/148>
   b:   85 c0                     test   %eax,%eax
Code;  c013d07c <prune_dcache+bc/148>
   d:   74 12                     je     21 <_EIP+0x21> c013d090 <prune_dcache+d0/148>
Code;  c013d07e <prune_dcache+be/148>
   f:   8b 40 14                  mov    0x14(%eax),%eax
Code;  c013d081 <prune_dcache+c1/148>
  12:   85 c0                     test   %eax,%eax


Kurt


PS: I'm not on the list, so please CC me.


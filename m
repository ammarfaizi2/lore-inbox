Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUEOGXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUEOGXF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 02:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbUEOGXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 02:23:05 -0400
Received: from science.horizon.com ([192.35.100.1]:37182 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S264530AbUEOGW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 02:22:59 -0400
Date: 15 May 2004 06:22:58 -0000
Message-ID: <20040515062258.7048.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 is crashing repeatedly
Cc: akpm@osdl.org, linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[All this time and I still havitually send e-mail to vger.rutgers.edu...]

Sorry for the delay in getting this.

I have now captured a kernel crash.  Everything after iput in the second crash
was hand-coped, and may suffer from transcription errors, but it was done
quite carefully.

System has ECC memory and has been very stable, with uptimes in excess of
1 year when kernel upgrades were infrequent (2.5 development).

Stock 2.6.6 kernel, config as posted before.

Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c012a392
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c012a392>]    Not tainted
EFLAGS: 00010012   (2.6.6) 
EIP is at free_block+0x52/0xd0
eax: 00000000   ebx: e9a3f000   ecx: e9a3f200   edx: df654000
esi: f7f8a560   edi: 00000016   ebp: f7f8a56c   esp: f7d89dec
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 8, threadinfo=f7d88000 task=f7d8eb50)
Stack: f7f8a57c 0000001b c17fd784 c17fd784 f7f8a560 dc3cdac0 0000001b c012a449 
       f7fe73dc c17fd774 c17fd774 00000296 dc3cdac0 c037a304 c012a61a dc3cdb40 
       f7d89e5c 0000003d c014f385 dc3cdb40 c014f5c3 dc19c0c8 dc19c0c0 00000080 
Call Trace:
 [<c012a449>] cache_flusharray+0x39/0xc0
 [<c012a61a>] kmem_cache_free+0x3a/0x50
 [<c014f385>] destroy_inode+0x35/0x40
 [<c014f5c3>] dispose_list+0x43/0x70
 [<c014f87e>] prune_icache+0xae/0x1b0
 [<c014f995>] shrink_icache_memory+0x15/0x20
 [<c012bfa9>] shrink_slab+0x129/0x180
 [<c012d0b3>] balance_pgdat+0x1f3/0x260
 [<c012d20e>] kswapd+0xee/0xf0
 [<c0110e30>] autoremove_wake_function+0x0/0x40
 [<c0110e30>] autoremove_wake_function+0x0/0x40
 [<c012d120>] kswapd+0x0/0xf0
 [<c0101fbd>] kernel_thread_helper+0x5/0x18

Code: 89 50 04 89 02 8b 43 0c 31 d2 c7 03 00 01 10 00 c7 43 04 00 
 <1>Unable to handle kernel paging request at virtual address 00200204
 printing eip:
c012a38d
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c012a38d>]    Not tainted
EFLAGS: 00010012   (2.6.6) 
EIP is at free_block+0x4d/0xd0
eax: 00383380   ebx: 00200200   ecx: dc19cac0   edx: c1000000
esi: f7f8a560   edi: 00000000   ebp: f7f8a56c   esp: f42f5f20
ds: 007b   es: 007b   ss: 0068
Process qmail-clean (pid: 1027, threadinfo=f42f4000 task=f433c6f0)
Stack: f7f8a57c 0000001b c17fd784 c17fd784 f7f8a560 da337200 0000001b c012a449 
       f7fe73dc c17fd774 c17fd774 00000296 da337200 f42f5f80 c012a61a da337280 
       00000000 da337280 c014f385 da337280 c01501ac f6e4f000 c0147f44 ec9fc8b8 
Call Trace:
 [<c012a449>] cache_flusharray+0x39/0xc0
 [<c012a61a>] kmem_cache_free+0x3a/0x50
 [<c014f385>] destroy_inode+0x35/0x40
 [<c01501ac>] iput+0x4c/0x60
 [<c0147f44>] sys_unlink+0xf4/0x120
 [<c013b538>] sys_read+0x38/0x60
 [<c01039ff>] syscall_call+0x7/0xb

Code: 8b 53 04 8b 03 89 50 04 89 02 86 43 0c 31 d2 c7 03 00 01 10
 <1>Unable to handle kernel paging request at virtual address 00200204

<cascading errors not copied, ending with>

Kernel panic: Fatal exception in interrupt

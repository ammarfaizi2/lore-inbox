Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267229AbSLRMhF>; Wed, 18 Dec 2002 07:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267230AbSLRMhF>; Wed, 18 Dec 2002 07:37:05 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:63689 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267229AbSLRMhE>; Wed, 18 Dec 2002 07:37:04 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: 2.5.52-mm1
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Wed, 18 Dec 2002 07:26:01 -0500
References: <3DFD908D.14D7F6E7@digeo.com>
Organization: me
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20021218122602.288D52230@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Got this oops this morning reading news:

Dec 18 07:15:29 oscar kernel:  printing eip:
Dec 18 07:15:29 oscar kernel: c0140317
Dec 18 07:15:29 oscar kernel: Oops: 0002
Dec 18 07:15:29 oscar kernel: CPU:    0
Dec 18 07:15:29 oscar kernel: EIP:    0060:[remove_inode_buffers+67/116]    Not tainted
Dec 18 07:15:29 oscar kernel: EFLAGS: 00010246
Dec 18 07:15:29 oscar kernel: EIP is at remove_inode_buffers+0x43/0x74
Dec 18 07:15:29 oscar kernel: eax: 0dc4c344   ebx: c3440dc4   ecx: c3440dc6   edx: 0000c344
Dec 18 07:15:29 oscar kernel: esi: c3440cd4   edi: 00000001   ebp: dfdb9ebc   esp: dfdb9e8c
Dec 18 07:15:29 oscar kernel: ds: 0068   es: 0068   ss: 0068
Dec 18 07:15:29 oscar kernel: Process kswapd0 (pid: 7, threadinfo=dfdb8000 task=dfdcb860)
Dec 18 07:15:29 oscar kernel: Stack: c3440cd4 c3440cdc dfdb8000 c0152ff7 c3440cd4 00000080 00000923 d
Dec 18 07:15:29 oscar kernel:        00000036 00000036 c3440b5c d76876dc 00000000 c01530db 00000080 c
Dec 18 07:15:29 oscar kernel:        00000080 000001d0 00000221 c02a5374 fffffe27 0000000c 0d024a92 0
Dec 18 07:15:29 oscar kernel: Call Trace:
Dec 18 07:15:29 oscar kernel:  [prune_icache+191/396] prune_icache+0xbf/0x18c
Dec 18 07:15:29 oscar kernel:  [shrink_icache_memory+23/32] shrink_icache_memory+0x17/0x20
Dec 18 07:15:29 oscar kernel:  [shrink_slab+245/320] shrink_slab+0xf5/0x140
Dec 18 07:15:29 oscar kernel:  [balance_pgdat+212/316] balance_pgdat+0xd4/0x13c
Dec 18 07:15:29 oscar kernel:  [kswapd+256/264] kswapd+0x100/0x108
Dec 18 07:15:29 oscar kernel:  [kswapd+0/264] kswapd+0x0/0x108
Dec 18 07:15:29 oscar kernel:  [autoremove_wake_function+0/56] autoremove_wake_function+0x0/0x38
Dec 18 07:15:29 oscar kernel:  [autoremove_wake_function+0/56] autoremove_wake_function+0x0/0x38
Dec 18 07:15:29 oscar kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Dec 18 07:15:29 oscar kernel:
Dec 18 07:15:29 oscar kernel: Code: 89 50 04 89 02 89 09 89 49 04 39 1b 75 e0 b8 00 e0 ff ff 21

followed by

Dec 18 07:15:29 oscar kernel:  <6>note: kswapd0[7] exited with preempt_count 1
Dec 18 07:15:29 oscar kernel: Call Trace:
Dec 18 07:15:29 oscar kernel:  [__might_sleep+82/88] __might_sleep+0x52/0x58
Dec 18 07:15:29 oscar kernel:  [profile_exit_task+23/72] profile_exit_task+0x17/0x48
Dec 18 07:15:29 oscar kernel:  [do_exit+149/964] do_exit+0x95/0x3c4
Dec 18 07:15:29 oscar kernel:  [die+111/112] die+0x6f/0x70
Dec 18 07:15:29 oscar kernel:  [do_page_fault+757/1076] do_page_fault+0x2f5/0x434
Dec 18 07:15:29 oscar kernel:  [do_page_fault+0/1076] do_page_fault+0x0/0x434
Dec 18 07:15:29 oscar kernel:  [x86_profile_hook+28/56] x86_profile_hook+0x1c/0x38
Dec 18 07:15:29 oscar kernel:  [timer_interrupt+42/272] timer_interrupt+0x2a/0x110
Dec 18 07:15:29 oscar kernel:  [free_hot_page+7/8] free_hot_page+0x7/0x8
Dec 18 07:15:29 oscar kernel:  [__free_pages+49/64] __free_pages+0x31/0x40
Dec 18 07:15:29 oscar kernel:  [free_pages+48/52] free_pages+0x30/0x34
Dec 18 07:15:29 oscar kernel:  [slab_destroy+154/180] slab_destroy+0x9a/0xb4
Dec 18 07:15:29 oscar kernel:  [cache_flusharray+161/292] cache_flusharray+0xa1/0x124
Dec 18 07:15:29 oscar kernel:  [error_code+45/64] error_code+0x2d/0x40
Dec 18 07:15:29 oscar kernel:  [remove_inode_buffers+67/116] remove_inode_buffers+0x43/0x74
Dec 18 07:15:29 oscar kernel:  [prune_icache+191/396] prune_icache+0xbf/0x18c
Dec 18 07:15:29 oscar kernel:  [shrink_icache_memory+23/32] shrink_icache_memory+0x17/0x20
Dec 18 07:15:29 oscar kernel:  [shrink_slab+245/320] shrink_slab+0xf5/0x140
Dec 18 07:15:29 oscar kernel:  [balance_pgdat+212/316] balance_pgdat+0xd4/0x13c
Dec 18 07:15:29 oscar kernel:  [kswapd+256/264] kswapd+0x100/0x108
Dec 18 07:15:29 oscar kernel:  [kswapd+0/264] kswapd+0x0/0x108
Dec 18 07:15:29 oscar kernel:  [autoremove_wake_function+0/56] autoremove_wake_function+0x0/0x38
Dec 18 07:15:29 oscar kernel:  [autoremove_wake_function+0/56] autoremove_wake_function+0x0/0x38
Dec 18 07:15:29 oscar kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Dec 18 07:15:29 oscar kernel:

Ideas?

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTKLNxD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 08:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTKLNxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 08:53:03 -0500
Received: from [195.67.90.253] ([195.67.90.253]:14505 "EHLO
	knant27.kna.flextronics.com") by vger.kernel.org with ESMTP
	id S262069AbTKLNw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 08:52:58 -0500
Message-ID: <3FB23B36.1020203@se.flextronics.com>
Date: Wed, 12 Nov 2003 14:52:54 +0100
From: Martin Johansson <martin.b.johansson@se.flextronics.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9 Oops
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had bittorrent segfaulting on me today and went checking the log.
According to the log I apparently had this in_atomic() + oops yesterday 
without noticing:

in_atomic():0, irqs_disabled():1
Call Trace:
  [__might_sleep+145/176] __might_sleep+0x91/0xb0
  [do_page_fault+112/1344] do_page_fault+0x70/0x540
  [ide_dma_intr+0/176] ide_dma_intr+0x0/0xb0
  [dma_timer_expiry+0/128] dma_timer_expiry+0x0/0x80
  [__ide_do_rw_disk+412/1712] __ide_do_rw_disk+0x19c/0x6b0
  [__delay+18/32] __delay+0x12/0x20
  [as_move_to_dispatch+241/496] as_move_to_dispatch+0xf1/0x1f0
  [start_request+385/656] start_request+0x181/0x290
  [schedule+726/1344] schedule+0x2d6/0x540
  [do_page_fault+0/1344] do_page_fault+0x0/0x540
  [error_code+45/56] error_code+0x2d/0x38
  [prepare_to_wait+37/64] prepare_to_wait+0x25/0x40
  [__lock_page+126/208] __lock_page+0x7e/0xd0
  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
  [do_page_cache_readahead+190/272] do_page_cache_readahead+0xbe/0x110
  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
  [filemap_nopage+648/720] filemap_nopage+0x288/0x2d0
  [filemap_nopage+0/720] filemap_nopage+0x0/0x2d0
  [do_no_page+173/800] do_no_page+0xad/0x320
  [handle_mm_fault+224/336] handle_mm_fault+0xe0/0x150
  [do_page_fault+316/1344] do_page_fault+0x13c/0x540
  [update_process_times+68/80] update_process_times+0x44/0x50
  [update_wall_time+22/64] update_wall_time+0x16/0x40
  [do_timer+224/240] do_timer+0xe0/0xf0
  [do_IRQ+197/240] do_IRQ+0xc5/0xf0
  [do_page_fault+0/1344] do_page_fault+0x0/0x540
  [error_code+45/56] error_code+0x2d/0x38


  printing eip:
c0117c15
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[prepare_to_wait+37/64]    Not tainted
EFLAGS: 00010046
EIP is at prepare_to_wait+0x25/0x40
eax: c2e71960   ebx: 00000246   ecx: c2ab7e40   edx: c2ab7e34
esi: 99fa5db8   edi: c2ab7e34   ebp: c6164ae0   esp: c2ab7e04
ds: 007b   es: 007b   ss: 0068
Process mozilla-bin (pid: 24130, threadinfo=c2ab6000 task=c2e71960)
Stack: c1000640 99fa5db8 c01311de c1000640 00000000 c2e71960 c0117cc0 
c2ab7e40
        c2ab7e40 d3a24760 00000010 c0136c3e 00000000 c2e71960 c0117cc0 
c2ab7e40
        c2ab7e40 00000000 cfdaebe8 0000000c c1000640 cfdaebe8 0000000c 
c0132318
Call Trace:
  [__lock_page+126/208] __lock_page+0x7e/0xd0
  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
  [do_page_cache_readahead+190/272] do_page_cache_readahead+0xbe/0x110
  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
  [filemap_nopage+648/720] filemap_nopage+0x288/0x2d0
  [filemap_nopage+0/720] filemap_nopage+0x0/0x2d0
  [do_no_page+173/800] do_no_page+0xad/0x320
  [handle_mm_fault+224/336] handle_mm_fault+0xe0/0x150
  [do_page_fault+316/1344] do_page_fault+0x13c/0x540
  [update_process_times+68/80] update_process_times+0x44/0x50
  [update_wall_time+22/64] update_wall_time+0x16/0x40
  [do_timer+224/240] do_timer+0xe0/0xf0
  [do_IRQ+197/240] do_IRQ+0xc5/0xf0
  [do_page_fault+0/1344] do_page_fault+0x0/0x540
  [error_code+45/56] error_code+0x2d/0x38

Code: 8b 06 89 48 04 89 42 0c 89 71 04 89 0e 53 9d 8b 1c 24 8b 74

And this today ~24 hours later, which probably eventually caused the 
bittorrent segfault. This one was followed by a bunch of kernel BUG's in 
vmscan:

printing eip:
c0130f9a
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[page_waitqueue+26/48]    Not tainted
EFLAGS: 00010a97
EIP is at page_waitqueue+0x1a/0x30
eax: e0280618   ebx: c1000618   ecx: 00000020   edx: 4b87ad6e
esi: 4d2bfc64   edi: 00000000   ebp: d3e48000   esp: d3e49dd0
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 7, threadinfo=d3e48000 task=d3e4d2c0)
Stack: c0131095 c1000618 c1000618 4d2bfc64 c0139a97 d3e49df8 c9c34f00 
00000000
	00000010 00000000 00000002 00000000 c1000618 c10005f0 d3ff8460 00000292
	c34410c0 c039c540 00000292 d3e79bc0 d3ff8460 c9c534b4 d3e49e4c c0115928
Call Trace:
  [unlock_page+21/96] unlock_page+0x15/0x60
  [invalidate_mapping_pages+231/256] invalidate_mapping_pages+0xe7/0x100
  [recalc_task_prio+168/464] recalc_task_prio+0xa8/0x1d0
  [invalidate_inode_pages+30/48] invalidate_inode_pages+0x1e/0x30
  [prune_icache+451/464] prune_icache+0x1c3/0x1d0
  [shrink_icache_memory+40/48] shrink_icache_memory+0x28/0x30
  [shrink_slab+286/368] shrink_slab+0x11e/0x170
  [balance_pgdat+507/544] balance_pgdat+0x1fb/0x220
  [kswapd+277/304] kswapd+0x115/0x130
  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
  [kswapd+0/304] kswapd+0x0/0x130
  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10

Code: 2b 8a c8 00 00 00 8b 92 c0 00 00 00 d3 e8 8d 04 c2 c3 8d 74

Tell me if you want more info. The machine is still up although not very 
stable. Processes are segfaulting left and right.

/Martin



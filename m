Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSKYBMs>; Sun, 24 Nov 2002 20:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSKYBMr>; Sun, 24 Nov 2002 20:12:47 -0500
Received: from services.cam.org ([198.73.180.252]:43046 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S262215AbSKYBMq>;
	Sun, 24 Nov 2002 20:12:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: opps in kswapd
Date: Sun, 24 Nov 2002 13:27:10 -0500
User-Agent: KMail/1.4.3
Cc: akpm@digeo.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <25282B06EFB8D31198BF00508B66D4FA03EA5B14@fmsmsx114.fm.intel.com> <200211241021.54957.tomlins@cam.org> <20021124153017.GC18063@holomorphy.com>
In-Reply-To: <20021124153017.GC18063@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211241327.10443.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another 2.5.49-mm1 oops.  This time starting openoffice on
a reiserfs fs - the only other fs that might be being accessed at this
time would be tmpfs.  Note shpte is enabled.

Think I will revert to 2.5.49 and fsck my fs(es)

Hope this helps,
Ed Tomlinson

Nov 24 13:16:10 oscar kernel:  printing eip:
Nov 24 13:16:10 oscar kernel: c012dc25
Nov 24 13:16:10 oscar kernel: Oops: 0002
Nov 24 13:16:10 oscar kernel: CPU:    0
Nov 24 13:16:10 oscar kernel: EIP:    0060:[find_get_page+37/64]    Not tainted
Nov 24 13:16:10 oscar kernel: EFLAGS: 00010206
Nov 24 13:16:10 oscar kernel: EIP is at find_get_page+0x25/0x40
Nov 24 13:16:10 oscar kernel: eax: dfa8a984   ebx: 00000017   ecx: fffffffa   edx: 000004d2
Nov 24 13:16:10 oscar kernel: esi: c2d80000   edi: 000004d2   ebp: dfa8a980   esp: c2d81e84
Nov 24 13:16:10 oscar kernel: ds: 0068   es: 0068   ss: 0068
Nov 24 13:16:10 oscar kernel: Process soffice.bin (pid: 2597, threadinfo=c2d80000 task=c2e3e660)
Nov 24 13:16:10 oscar kernel: Stack: 00000540 00000001 c012eafe dfa8a980 000004d2 00000540 dfa8a8f4 df6c1c28
Nov 24 13:16:10 oscar kernel:        df6c1be0 dee92718 c2f21440 441c6600 d9aeada0 c012b3a2 d9aeada0 441c6000
Nov 24 13:16:10 oscar kernel:        00000000 c2f21440 00000000 dee92718 c2f21440 441c6600 c2a78cc0 c012b71b
Nov 24 13:16:10 oscar kernel: Call Trace:
Nov 24 13:16:10 oscar kernel:  [filemap_nopage+190/704] filemap_nopage+0xbe/0x2c0
Nov 24 13:16:10 oscar kernel:  [do_no_page+98/736] do_no_page+0x62/0x2e0
Nov 24 13:16:10 oscar kernel:  [handle_mm_fault+251/512] handle_mm_fault+0xfb/0x200
Nov 24 13:16:10 oscar kernel:  [do_page_fault+531/1059] do_page_fault+0x213/0x423
Nov 24 13:16:10 oscar kernel:  [__wake_up+32/128] __wake_up+0x20/0x80
Nov 24 13:16:10 oscar kernel:  [queue_work+135/160] queue_work+0x87/0xa0
Nov 24 13:16:10 oscar kernel:  [blk_unplug_timeout+0/32] blk_unplug_timeout+0x0/0x20
Nov 24 13:16:10 oscar kernel:  [__run_timers+117/320] __run_timers+0x75/0x140
Nov 24 13:16:10 oscar kernel:  [schedule+390/768] schedule+0x186/0x300
Nov 24 13:16:10 oscar kernel:  [do_page_fault+0/1059] do_page_fault+0x0/0x423
Nov 24 13:16:10 oscar kernel:  [error_code+45/64] error_code+0x2d/0x40
Nov 24 13:16:10 oscar kernel:
Nov 24 13:16:10 oscar kernel: Code: ff 43 04 ff 4e 10 8b 46 08 83 e0 08 75 05 89 d8 5b 5e c3 e8
Nov 24 13:16:10 oscar kernel:  <6>note: soffice.bin[2597] exited with preempt_count 1
Nov 24 13:16:10 oscar kernel: Call Trace:
Nov 24 13:16:10 oscar kernel:  [profile_exit_task+18/96] profile_exit_task+0x12/0x60
Nov 24 13:16:10 oscar kernel:  [do_exit+112/768] do_exit+0x70/0x300
Nov 24 13:16:10 oscar kernel:  [find_get_page+37/64] find_get_page+0x25/0x40
Nov 24 13:16:10 oscar kernel:  [die+105/128] die+0x69/0x80
Nov 24 13:16:10 oscar kernel:  [do_page_fault+308/1059] do_page_fault+0x134/0x423
Nov 24 13:16:10 oscar kernel:  [reiserfs_get_block+0/4192] reiserfs_get_block+0x0/0x1060
Nov 24 13:16:10 oscar kernel:  [read_pages+236/256] read_pages+0xec/0x100
Nov 24 13:16:10 oscar kernel:  [buffered_rmqueue+204/384] buffered_rmqueue+0xcc/0x180
Nov 24 13:16:10 oscar kernel:  [__alloc_pages+129/544] __alloc_pages+0x81/0x220
Nov 24 13:16:10 oscar kernel:  [do_page_cache_readahead+118/352] do_page_cache_readahead+0x76/0x160
Nov 24 13:16:10 oscar kernel:  [do_page_fault+0/1059] do_page_fault+0x0/0x423
Nov 24 13:16:10 oscar kernel:  [error_code+45/64] error_code+0x2d/0x40
Nov 24 13:16:10 oscar kernel:  [find_get_page+37/64] find_get_page+0x25/0x40
Nov 24 13:16:10 oscar kernel:  [filemap_nopage+190/704] filemap_nopage+0xbe/0x2c0
Nov 24 13:16:10 oscar kernel:  [do_no_page+98/736] do_no_page+0x62/0x2e0
Nov 24 13:16:10 oscar kernel:  [handle_mm_fault+251/512] handle_mm_fault+0xfb/0x200
Nov 24 13:16:10 oscar kernel:  [do_page_fault+531/1059] do_page_fault+0x213/0x423
Nov 24 13:16:10 oscar kernel:  [__wake_up+32/128] __wake_up+0x20/0x80ov 24 
Nov 24 13:16:10 oscar kernel:  [queue_work+135/160] queue_work+0x87/0xa0
Nov 24 13:16:10 oscar kernel:  [blk_unplug_timeout+0/32] blk_unplug_timeout+0x0/0x20
Nov 24 13:16:10 oscar kernel:  [__run_timers+117/320] __run_timers+0x75/0x140
Nov 24 13:16:10 oscar kernel:  [schedule+390/768] schedule+0x186/0x300
Nov 24 13:16:10 oscar kernel:  [do_page_fault+0/1059] do_page_fault+0x0/0x423
Nov 24 13:16:10 oscar kernel:  [error_code+45/64] error_code+0x2d/0x40
Nov 24 13:16:10 oscar kernel:




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422918AbWJOWxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422918AbWJOWxV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 18:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422921AbWJOWxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 18:53:21 -0400
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:18148 "EHLO
	mtiwmhc11.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1422918AbWJOWxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 18:53:21 -0400
Message-ID: <4532BBDF.9010800@lwfinger.net>
Date: Sun, 15 Oct 2006 17:53:19 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: BUG in 2.6.18.1?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.6.18.1, I got the following warning in my log:

Oct 15 16:24:38 larrylap kernel: BUG: warning at kernel/lockdep.c:565/print_infinite_recursion_bug()
Oct 15 16:24:38 larrylap kernel:  [<c0103b3f>] show_trace_log_lvl+0x1af/0x1d0
Oct 15 16:24:38 larrylap kernel:  [<c0104f4b>] show_trace+0x1b/0x20
Oct 15 16:24:38 larrylap kernel:  [<c0104f76>] dump_stack+0x26/0x30
Oct 15 16:24:38 larrylap kernel:  [<c0131099>] print_infinite_recursion_bug+0x49/0x50
Oct 15 16:24:38 larrylap kernel:  [<c01311d5>] find_usage_backwards+0x65/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131e27>] check_usage+0x27/0x280
Oct 15 16:24:38 larrylap kernel:  [<c01337a0>] __lock_acquire+0xac0/0xdc0
Oct 15 16:24:38 larrylap kernel:  [<c0133e18>] lock_acquire+0x68/0x90
Oct 15 16:24:38 larrylap kernel:  [<c0310788>] _spin_lock_irqsave+0x48/0x60
Oct 15 16:24:38 larrylap kernel:  [<c0112713>] change_page_attr+0x13/0x260
Oct 15 16:24:38 larrylap kernel:  [<c0112996>] kernel_map_pages+0x36/0xa0
Oct 15 16:24:38 larrylap kernel:  [<c0146c68>] free_hot_cold_page+0x98/0x130
Oct 15 16:24:38 larrylap kernel:  [<c0146d5a>] free_hot_page+0xa/0x10
Oct 15 16:24:38 larrylap kernel:  [<c0146d8a>] __free_pages+0x2a/0x40
Oct 15 16:24:38 larrylap kernel:  [<c0146dce>] free_pages+0x2e/0x40
Oct 15 16:24:38 larrylap kernel:  [<c015ac39>] kmem_freepages+0x79/0xa0
Oct 15 16:24:38 larrylap kernel:  [<c015c242>] slab_destroy+0x112/0x1a0
Oct 15 16:24:38 larrylap kernel:  [<c015c424>] free_block+0x154/0x1a0
Oct 15 16:24:38 larrylap kernel:  [<c015c5b2>] cache_flusharray+0x72/0x150
Oct 15 16:24:38 larrylap kernel:  [<c015c106>] kmem_cache_free+0xb6/0xe0
Oct 15 16:24:38 larrylap kernel:  [<c015c277>] slab_destroy+0x147/0x1a0
Oct 15 16:24:38 larrylap kernel:  [<c015c424>] free_block+0x154/0x1a0
Oct 15 16:24:38 larrylap kernel:  [<c015c5b2>] cache_flusharray+0x72/0x150
Oct 15 16:24:38 larrylap kernel:  [<c015c106>] kmem_cache_free+0xb6/0xe0
Oct 15 16:24:38 larrylap kernel:  [<c01d59df>] ext3_destroy_inode+0x1f/0x30
Oct 15 16:24:38 larrylap kernel:  [<c017a02b>] destroy_inode+0x2b/0x60
Oct 15 16:24:38 larrylap kernel:  [<c017aae1>] dispose_list+0x81/0x100
Oct 15 16:24:38 larrylap kernel:  [<c017ad50>] shrink_icache_memory+0x1f0/0x230
Oct 15 16:24:38 larrylap kernel:  [<c0149c72>] shrink_slab+0x122/0x190
Oct 15 16:24:38 larrylap kernel:  [<c014ad87>] kswapd+0x297/0x420
Oct 15 16:24:38 larrylap kernel:  [<c012c269>] kthread+0xe9/0xf0
Oct 15 16:24:38 larrylap kernel:  [<c0101005>] kernel_thread_helper+0x5/0x10
Oct 15 16:24:38 larrylap kernel: DWARF2 unwinder stuck at kernel_thread_helper+0x5/0x10
Oct 15 16:24:38 larrylap kernel: Leftover inexact backtrace:
Oct 15 16:24:38 larrylap kernel:  [<c0104f4b>] show_trace+0x1b/0x20
Oct 15 16:24:38 larrylap kernel:  [<c0104f76>] dump_stack+0x26/0x30
Oct 15 16:24:38 larrylap kernel:  [<c0131099>] print_infinite_recursion_bug+0x49/0x50
Oct 15 16:24:38 larrylap kernel:  [<c01311d5>] find_usage_backwards+0x65/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131210>] find_usage_backwards+0xa0/0xd0
Oct 15 16:24:38 larrylap kernel:  [<c0131e27>] check_usage+0x27/0x280
Oct 15 16:24:38 larrylap kernel:  [<c01337a0>] __lock_acquire+0xac0/0xdc0
Oct 15 16:24:38 larrylap kernel:  [<c0133e18>] lock_acquire+0x68/0x90
Oct 15 16:24:38 larrylap kernel:  [<c0310788>] _spin_lock_irqsave+0x48/0x60
Oct 15 16:24:38 larrylap kernel:  [<c0112713>] change_page_attr+0x13/0x260
Oct 15 16:24:38 larrylap kernel:  [<c0112996>] kernel_map_pages+0x36/0xa0
Oct 15 16:24:38 larrylap kernel:  [<c0146c68>] free_hot_cold_page+0x98/0x130
Oct 15 16:24:38 larrylap kernel:  [<c0146d5a>] free_hot_page+0xa/0x10
Oct 15 16:24:38 larrylap kernel:  [<c0146d8a>] __free_pages+0x2a/0x40
Oct 15 16:24:38 larrylap kernel:  [<c0146dce>] free_pages+0x2e/0x40
Oct 15 16:24:38 larrylap kernel:  [<c015ac39>] kmem_freepages+0x79/0xa0
Oct 15 16:24:38 larrylap kernel:  [<c015c242>] slab_destroy+0x112/0x1a0
Oct 15 16:24:38 larrylap kernel:  [<c015c424>] free_block+0x154/0x1a0
Oct 15 16:24:38 larrylap kernel:  [<c015c5b2>] cache_flusharray+0x72/0x150
Oct 15 16:24:38 larrylap kernel:  [<c015c106>] kmem_cache_free+0xb6/0xe0
Oct 15 16:24:38 larrylap kernel:  [<c015c277>] slab_destroy+0x147/0x1a0
Oct 15 16:24:38 larrylap kernel:  [<c015c424>] free_block+0x154/0x1a0
Oct 15 16:24:38 larrylap kernel:  [<c015c5b2>] cache_flusharray+0x72/0x150
Oct 15 16:24:38 larrylap kernel:  [<c015c106>] kmem_cache_free+0xb6/0xe0
Oct 15 16:24:38 larrylap kernel:  [<c01d59df>] ext3_destroy_inode+0x1f/0x30
Oct 15 16:24:38 larrylap kernel:  [<c017a02b>] destroy_inode+0x2b/0x60
Oct 15 16:24:38 larrylap kernel:  [<c017aae1>] dispose_list+0x81/0x100
Oct 15 16:24:38 larrylap kernel:  [<c017ad50>] shrink_icache_memory+0x1f0/0x230
Oct 15 16:24:38 larrylap kernel:  [<c0149c72>] shrink_slab+0x122/0x190
Oct 15 16:24:38 larrylap kernel:  [<c014ad87>] kswapd+0x297/0x420
Oct 15 16:24:38 larrylap kernel:  [<c012c269>] kthread+0xe9/0xf0
Oct 15 16:24:38 larrylap kernel:  [<c0101005>] kernel_thread_helper+0x5/0x10


Larry

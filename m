Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVLOQdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVLOQdx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVLOQdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:33:53 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:7577 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750800AbVLOQdv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:33:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JH7Vgzp1edVJ01nVIyXc9TmdDbWcr30GE9nZBDWT7dE5Vjn8oBeVG8sEFczpVDz/TmSSstBUKmLHCDhUJgGD/u45FjV6ywUbANi5aj4puGVvGgrH8/v2OcKVQn0ZIwZNjF7iHFVZgzoL6Qnql5kNWwWfBwH9oHVHSG4cVj5llcg=
Message-ID: <6bffcb0e0512150833jdd7965ck@mail.gmail.com>
Date: Thu, 15 Dec 2005 17:33:49 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc5-mm3 -- BUG: using smp_processor_id() in preemptible [00000001] code: swapper/1
Cc: Andrew Morton <akpm@osdl.org>
In-Reply-To: <1134649458.12421.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a44ae5cd0512150035j1e1a032bpe8b271069ad5d008@mail.gmail.com>
	 <1134649458.12421.35.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[1.] One line summary of the problem:
BUG: using smp_processor_id() in preemptible [00000001] code:

[2.1.] Occurrence: reproductible/common

[3.] Keywords (i.e., modules, networking, kernel):
everything ;)

[4.] Kernel version (from /proc/version):
Linux version 2.6.15-rc5-mm3 (michal@debian) (gcc version 4.0.3
20051201 (prerelease) (Debian 4.0.2-5)) #4 SMP PREEMPT Thu Dec 15
16:57:58 CET 2005

[5.] Most recent kernel version which did not have the bug:
2.6.15-rc5-mm2, 2.6.15-rc5-git-current

[6.] Output of Oops
Dec 15 17:14:39 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: dirmngr/3426
Dec 15 17:14:39 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:14:39 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:14:39 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:14:39 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:14:39 localhost kernel:  [<c104ea0a>] kmem_getpages+0x67/0x8a
Dec 15 17:14:39 localhost kernel:  [<c104fbc9>] cache_grow+0xaa/0x150
Dec 15 17:14:39 localhost kernel:  [<c1050138>] cache_alloc_refill+0x205/0x246
Dec 15 17:14:39 localhost kernel:  [<c105053b>] kmem_cache_alloc+0x65/0x81
Dec 15 17:14:39 localhost kernel:  [<c1092a23>] ext3_alloc_inode+0x12/0x44
Dec 15 17:14:39 localhost kernel:  [<c1068f6c>] alloc_inode+0x18/0x18f
Dec 15 17:14:39 localhost kernel:  [<c1069be2>] get_new_inode_fast+0x15/0x102
Dec 15 17:14:39 localhost kernel:  [<c106a02f>] iget_locked+0x51/0x56
Dec 15 17:14:39 localhost kernel:  [<c10901ce>] ext3_lookup+0x44/0x8c
Dec 15 17:14:39 localhost kernel:  [<c105fc09>] real_lookup+0x6e/0xd3
Dec 15 17:14:39 localhost kernel:  [<c106027a>] do_lookup+0x4e/0x7e
Dec 15 17:14:39 localhost kernel:  [<c1060583>] __link_path_walk+0x2d9/0x43b
Dec 15 17:14:39 localhost kernel:  [<c1060735>] link_path_walk+0x50/0xca
Dec 15 17:14:39 localhost kernel:  [<c1060abb>] path_lookup+0x14f/0x185
Dec 15 17:14:39 localhost kernel:  [<c1060b2e>]
__path_lookup_intent_open+0x3d/0x6c
Dec 15 17:14:39 localhost kernel:  [<c1060b6a>] path_lookup_open+0xd/0xf
Dec 15 17:14:39 localhost kernel:  [<c1061309>] open_namei+0x65/0x3f7
Dec 15 17:14:39 localhost kernel:  [<c1052e3d>] filp_open+0x1c/0x31
Dec 15 17:14:39 localhost kernel:  [<c10530d4>] do_sys_open+0x36/0xa7
Dec 15 17:14:39 localhost kernel:  [<c1053156>] sys_open+0x11/0x13
Dec 15 17:14:39 localhost kernel:  [<c100287b>] sysenter_past_esp+0x54/0x75
Dec 15 17:14:43 localhost kernel: eth0: no IPv6 routers present
Dec 15 17:14:44 localhost kernel: printk: 65290 messages suppressed.
Dec 15 17:14:44 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: smartd/3672
Dec 15 17:14:44 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:14:44 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:14:44 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:14:44 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:14:44 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:14:44 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:14:44 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:14:44 localhost kernel:  [<c1038f84>]
do_generic_mapping_read+0x151/0x3ba
Dec 15 17:14:44 localhost kernel:  [<c1039460>]
__generic_file_aio_read+0x190/0x1e6
Dec 15 17:14:44 localhost kernel:  [<c10394f5>] generic_file_aio_read+0x3f/0x47
Dec 15 17:14:44 localhost kernel:  [<c1053878>] do_sync_read+0xaa/0xdf
Dec 15 17:14:44 localhost kernel:  [<c1053958>] vfs_read+0xab/0x154
Dec 15 17:14:44 localhost kernel:  [<c1053c71>] sys_read+0x3b/0x60
Dec 15 17:14:44 localhost kernel:  [<c100287b>] sysenter_past_esp+0x54/0x75
Dec 15 17:14:49 localhost kernel: printk: 45242 messages suppressed.
Dec 15 17:14:49 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: Xorg/3799
Dec 15 17:14:49 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:14:49 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:14:49 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:14:49 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:14:49 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:14:49 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:14:49 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:14:55 localhost kernel: printk: 4402 messages suppressed.
Dec 15 17:14:55 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: pdflush/133
Dec 15 17:14:55 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:14:55 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:14:55 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:14:55 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:14:55 localhost kernel:  [<c103e416>]
clear_page_dirty_for_io+0x42/0x50
Dec 15 17:14:55 localhost kernel:  [<c10735e9>] mpage_writepages+0x16c/0x2ca
Dec 15 17:14:55 localhost kernel:  [<c105b35c>] generic_writepages+0xa/0xc
Dec 15 17:14:55 localhost kernel:  [<c103e12d>] do_writepages+0x23/0x36
Dec 15 17:14:55 localhost kernel:  [<c107202a>] __sync_single_inode+0x65/0x1b7
Dec 15 17:14:55 localhost kernel:  [<c10722a2>]
__writeback_single_inode+0x126/0x12e
Dec 15 17:14:55 localhost kernel:  [<c107245f>]
generic_sync_sb_inodes+0x1b5/0x286
Dec 15 17:14:55 localhost kernel:  [<c107254d>] sync_sb_inodes+0x1d/0x20
Dec 15 17:14:55 localhost kernel:  [<c10725cf>] writeback_inodes+0x7f/0xcb
Dec 15 17:14:55 localhost kernel:  [<c103df98>] wb_kupdate+0x76/0xd9
Dec 15 17:14:55 localhost kernel:  [<c103e67e>] __pdflush+0xda/0x18b
Dec 15 17:14:55 localhost kernel:  [<c103e75b>] pdflush+0x2c/0x32
Dec 15 17:14:55 localhost kernel:  [<c102b035>] kthread+0x77/0xa4
Dec 15 17:14:55 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:14:59 localhost kernel: printk: 10195 messages suppressed.
Dec 15 17:14:59 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: Xorg/3799
Dec 15 17:14:59 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:14:59 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:14:59 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:14:59 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:14:59 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:14:59 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:14:59 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:15:04 localhost kernel: printk: 15834 messages suppressed.
Dec 15 17:15:04 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: Xsession/3898
Dec 15 17:15:04 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:15:04 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:15:04 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:15:04 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:15:04 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:15:04 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:15:04 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:15:09 localhost kernel: printk: 35509 messages suppressed.
Dec 15 17:15:09 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: kbuildsycoca/3992
Dec 15 17:15:09 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:15:09 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:15:09 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:15:09 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:15:09 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:15:09 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:15:09 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:15:14 localhost kernel: printk: 30912 messages suppressed.
Dec 15 17:15:14 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: kwin/4014
Dec 15 17:15:14 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:15:14 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:15:14 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:15:14 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:15:14 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:15:14 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:15:14 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:15:19 localhost kernel: printk: 37892 messages suppressed.
Dec 15 17:15:19 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: kdesktop/4022
Dec 15 17:15:19 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:15:19 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:15:19 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:15:19 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:15:19 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:15:19 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:15:19 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:15:24 localhost kernel: printk: 20908 messages suppressed.
Dec 15 17:15:24 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: kjournald/1920
Dec 15 17:15:24 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:15:24 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:15:24 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:15:24 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:15:24 localhost kernel:  [<c10c2373>] submit_bio+0x4c/0xac
Dec 15 17:15:24 localhost kernel:  [<c10578dc>] submit_bh+0xcb/0xe8
Dec 15 17:15:24 localhost kernel:  [<c1057988>] ll_rw_block+0x8f/0xb5
Dec 15 17:15:24 localhost kernel:  [<c109c4e1>]
journal_commit_transaction+0x41c/0xf0f
Dec 15 17:15:24 localhost kernel:  [<c109ed87>] kjournald+0xb5/0x1e4
Dec 15 17:15:24 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:15:32 localhost kernel: printk: 975 messages suppressed.
Dec 15 17:15:32 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: Xorg/3799
Dec 15 17:15:32 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:15:32 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:15:32 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:15:32 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:15:32 localhost kernel:  [<c104ea0a>] kmem_getpages+0x67/0x8a
Dec 15 17:15:32 localhost kernel:  [<c104fbc9>] cache_grow+0xaa/0x150
Dec 15 17:15:32 localhost kernel:  [<c1050138>] cache_alloc_refill+0x205/0x246
Dec 15 17:15:32 localhost kernel:  [<c105063c>] __kmalloc+0x9d/0xba
Dec 15 17:15:32 localhost kernel:  [<c114bf2e>] __alloc_skb+0x46/0x11b
Dec 15 17:15:32 localhost kernel:  [<c114acce>] sock_alloc_send_pskb+0x62/0x1e4
Dec 15 17:15:32 localhost kernel:  [<c114ae5e>] sock_alloc_send_skb+0xe/0x10
Dec 15 17:15:32 localhost kernel:  [<f8875ca5>]
unix_stream_sendmsg+0x131/0x33f [unix]
Dec 15 17:15:32 localhost kernel:  [<c1148211>] sock_sendmsg+0xd9/0xf4
Dec 15 17:15:32 localhost kernel:  [<c114868d>] sock_readv_writev+0x76/0x7b
Dec 15 17:15:32 localhost kernel:  [<c11486f1>] sock_writev+0x2a/0x32
Dec 15 17:15:32 localhost kernel:  [<c1053f2e>] do_readv_writev+0x153/0x25a
Dec 15 17:15:32 localhost kernel:  [<c10540b4>] vfs_writev+0x39/0x49
Dec 15 17:15:32 localhost kernel:  [<c1054192>] sys_writev+0x3b/0x93
Dec 15 17:15:32 localhost kernel:  [<c100287b>] sysenter_past_esp+0x54/0x75
Dec 15 17:15:35 localhost kernel: printk: 1739 messages suppressed.
Dec 15 17:15:35 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: pdflush/133
Dec 15 17:15:35 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:15:35 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:15:35 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:15:35 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:15:35 localhost kernel:  [<c103e416>]
clear_page_dirty_for_io+0x42/0x50
Dec 15 17:15:35 localhost kernel:  [<c10735e9>] mpage_writepages+0x16c/0x2ca
Dec 15 17:15:35 localhost kernel:  [<c103e138>] do_writepages+0x2e/0x36
Dec 15 17:15:35 localhost kernel:  [<c107202a>] __sync_single_inode+0x65/0x1b7
Dec 15 17:15:35 localhost kernel:  [<c10722a2>]
__writeback_single_inode+0x126/0x12e
Dec 15 17:15:35 localhost kernel:  [<c107245f>]
generic_sync_sb_inodes+0x1b5/0x286
Dec 15 17:15:35 localhost kernel:  [<c107254d>] sync_sb_inodes+0x1d/0x20
Dec 15 17:15:35 localhost kernel:  [<c10725cf>] writeback_inodes+0x7f/0xcb
Dec 15 17:15:35 localhost kernel:  [<c103df98>] wb_kupdate+0x76/0xd9
Dec 15 17:15:35 localhost kernel:  [<c103e67e>] __pdflush+0xda/0x18b
Dec 15 17:15:35 localhost kernel:  [<c103e75b>] pdflush+0x2c/0x32
Dec 15 17:15:35 localhost kernel:  [<c102b035>] kthread+0x77/0xa4
Dec 15 17:15:35 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:15:40 localhost kernel: printk: 1559 messages suppressed.
Dec 15 17:15:40 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: pdflush/133
Dec 15 17:15:40 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:15:40 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:15:40 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:15:40 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:15:40 localhost kernel:  [<c103e416>]
clear_page_dirty_for_io+0x42/0x50
Dec 15 17:15:40 localhost kernel:  [<c10735e9>] mpage_writepages+0x16c/0x2ca
Dec 15 17:15:40 localhost kernel:  [<c103e138>] do_writepages+0x2e/0x36
Dec 15 17:15:40 localhost kernel:  [<c107202a>] __sync_single_inode+0x65/0x1b7
Dec 15 17:15:40 localhost kernel:  [<c10722a2>]
__writeback_single_inode+0x126/0x12e
Dec 15 17:15:40 localhost kernel:  [<c107245f>]
generic_sync_sb_inodes+0x1b5/0x286
Dec 15 17:15:40 localhost kernel:  [<c107254d>] sync_sb_inodes+0x1d/0x20
Dec 15 17:15:40 localhost kernel:  [<c10725cf>] writeback_inodes+0x7f/0xcb
Dec 15 17:15:40 localhost kernel:  [<c103df98>] wb_kupdate+0x76/0xd9
Dec 15 17:15:40 localhost kernel:  [<c103e67e>] __pdflush+0xda/0x18b
Dec 15 17:15:40 localhost kernel:  [<c103e75b>] pdflush+0x2c/0x32
Dec 15 17:15:40 localhost kernel:  [<c102b035>] kthread+0x77/0xa4
Dec 15 17:15:40 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:15:45 localhost kernel: printk: 2368 messages suppressed.
Dec 15 17:15:45 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: pdflush/133
Dec 15 17:15:45 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:15:45 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:15:45 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:15:45 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:15:45 localhost kernel:  [<c103e416>]
clear_page_dirty_for_io+0x42/0x50
Dec 15 17:15:45 localhost kernel:  [<c10735e9>] mpage_writepages+0x16c/0x2ca
Dec 15 17:15:45 localhost kernel:  [<c103e138>] do_writepages+0x2e/0x36
Dec 15 17:15:45 localhost kernel:  [<c107202a>] __sync_single_inode+0x65/0x1b7
Dec 15 17:15:45 localhost kernel:  [<c10722a2>]
__writeback_single_inode+0x126/0x12e
Dec 15 17:15:45 localhost kernel:  [<c107245f>]
generic_sync_sb_inodes+0x1b5/0x286
Dec 15 17:15:45 localhost kernel:  [<c107254d>] sync_sb_inodes+0x1d/0x20
Dec 15 17:15:45 localhost kernel:  [<c10725cf>] writeback_inodes+0x7f/0xcb
Dec 15 17:15:45 localhost kernel:  [<c103df98>] wb_kupdate+0x76/0xd9
Dec 15 17:15:45 localhost kernel:  [<c103e67e>] __pdflush+0xda/0x18b
Dec 15 17:15:45 localhost kernel:  [<c103e75b>] pdflush+0x2c/0x32
Dec 15 17:15:45 localhost kernel:  [<c102b035>] kthread+0x77/0xa4
Dec 15 17:15:45 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:15:49 localhost kernel: printk: 1544 messages suppressed.
Dec 15 17:15:49 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: gconfd-2/4034
Dec 15 17:15:49 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:15:49 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:15:49 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:15:49 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:15:49 localhost kernel:  [<c104ea0a>] kmem_getpages+0x67/0x8a
Dec 15 17:15:49 localhost kernel:  [<c104fbc9>] cache_grow+0xaa/0x150
Dec 15 17:15:49 localhost kernel:  [<c1050138>] cache_alloc_refill+0x205/0x246
Dec 15 17:15:49 localhost kernel:  [<c105053b>] kmem_cache_alloc+0x65/0x81
Dec 15 17:15:49 localhost kernel:  [<c1147d74>] sock_alloc_inode+0x18/0x82
Dec 15 17:15:49 localhost kernel:  [<c1068f6c>] alloc_inode+0x18/0x18f
Dec 15 17:15:49 localhost kernel:  [<c1069a21>] new_inode+0x17/0x8e
Dec 15 17:15:49 localhost kernel:  [<c1147ff6>] sock_alloc+0x13/0x7b
Dec 15 17:15:49 localhost kernel:  [<c1148cbb>] __sock_create+0xd5/0x2c8
Dec 15 17:15:49 localhost kernel:  [<c1148ebb>] sock_create+0xd/0xf
Dec 15 17:15:49 localhost kernel:  [<c1148ee3>] sys_socket+0x17/0x39
Dec 15 17:15:49 localhost kernel:  [<c11499db>] sys_socketcall+0x72/0x18a
Dec 15 17:15:49 localhost kernel:  [<c100287b>] sysenter_past_esp+0x54/0x75
Dec 15 17:15:55 localhost kernel: printk: 1572 messages suppressed.
Dec 15 17:15:55 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: kjournald/1920
Dec 15 17:15:55 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:15:55 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:15:55 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:15:55 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:15:55 localhost kernel:  [<c10c2373>] submit_bio+0x4c/0xac
Dec 15 17:15:55 localhost kernel:  [<c10578dc>] submit_bh+0xcb/0xe8
Dec 15 17:15:55 localhost kernel:  [<c1057a20>] sync_dirty_buffer+0x72/0xcd
Dec 15 17:15:55 localhost kernel:  [<c109c055>]
journal_write_commit_record+0x81/0xf1
Dec 15 17:15:55 localhost kernel:  [<c109cb4b>]
journal_commit_transaction+0xa86/0xf0f
Dec 15 17:15:55 localhost kernel:  [<c109ed87>] kjournald+0xb5/0x1e4
Dec 15 17:15:55 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:16:00 localhost kernel: printk: 997 messages suppressed.
Dec 15 17:16:00 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: kjournald/250
Dec 15 17:16:00 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:16:00 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:16:00 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:16:00 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:16:00 localhost kernel:  [<c10c2373>] submit_bio+0x4c/0xac
Dec 15 17:16:00 localhost kernel:  [<c10578dc>] submit_bh+0xcb/0xe8
Dec 15 17:16:00 localhost kernel:  [<c1057988>] ll_rw_block+0x8f/0xb5
Dec 15 17:16:00 localhost kernel:  [<c109c4e1>]
journal_commit_transaction+0x41c/0xf0f
Dec 15 17:16:00 localhost kernel:  [<c109ed87>] kjournald+0xb5/0x1e4
Dec 15 17:16:00 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:16:05 localhost kernel: printk: 1667 messages suppressed.
Dec 15 17:16:05 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: konsole/4042
Dec 15 17:16:05 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:16:05 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:16:05 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:16:05 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:16:05 localhost kernel:  [<c104ea0a>] kmem_getpages+0x67/0x8a
Dec 15 17:16:05 localhost kernel:  [<c104fbc9>] cache_grow+0xaa/0x150
Dec 15 17:16:05 localhost kernel:  [<c1050138>] cache_alloc_refill+0x205/0x246
Dec 15 17:16:05 localhost kernel:  [<c105063c>] __kmalloc+0x9d/0xba
Dec 15 17:16:05 localhost kernel:  [<c114bf2e>] __alloc_skb+0x46/0x11b
Dec 15 17:16:05 localhost kernel:  [<c114acce>] sock_alloc_send_pskb+0x62/0x1e4
Dec 15 17:16:05 localhost kernel:  [<c114ae5e>] sock_alloc_send_skb+0xe/0x10
Dec 15 17:16:05 localhost kernel:  [<f8875ca5>]
unix_stream_sendmsg+0x131/0x33f [unix]
Dec 15 17:16:05 localhost kernel:  [<c11485ce>] sock_aio_write+0x114/0x121
Dec 15 17:16:05 localhost kernel:  [<c1053aab>] do_sync_write+0xaa/0xdf
Dec 15 17:16:05 localhost kernel:  [<c1053b9e>] vfs_write+0xbe/0x156
Dec 15 17:16:05 localhost kernel:  [<c1053cd1>] sys_write+0x3b/0x60
Dec 15 17:16:05 localhost kernel:  [<c100287b>] sysenter_past_esp+0x54/0x75
Dec 15 17:16:10 localhost kernel: printk: 1563 messages suppressed.
Dec 15 17:16:10 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: bash/4043
Dec 15 17:16:10 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:16:10 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:16:10 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:16:10 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:16:10 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:16:10 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:16:10 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:16:14 localhost kernel: printk: 1659 messages suppressed.
Dec 15 17:16:14 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: less/4203
Dec 15 17:16:14 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:16:14 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:16:14 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:16:14 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:16:14 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:16:14 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:16:14 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:16:19 localhost kernel: printk: 1837 messages suppressed.
Dec 15 17:16:19 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: korgac/4030
Dec 15 17:16:19 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:16:19 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:16:19 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:16:19 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:16:19 localhost kernel:  [<c104ea0a>] kmem_getpages+0x67/0x8a
Dec 15 17:16:19 localhost kernel:  [<c104fbc9>] cache_grow+0xaa/0x150
Dec 15 17:16:19 localhost kernel:  [<c1050138>] cache_alloc_refill+0x205/0x246
Dec 15 17:16:19 localhost kernel:  [<c105053b>] kmem_cache_alloc+0x65/0x81
Dec 15 17:16:19 localhost kernel:  [<c105f828>] getname+0x18/0xa0
Dec 15 17:16:19 localhost kernel:  [<c1060cd2>] __user_walk+0x11/0x37
Dec 15 17:16:19 localhost kernel:  [<c105bfb4>] vfs_stat+0x1a/0x40
Dec 15 17:16:19 localhost kernel:  [<c105c4ef>] sys_stat64+0x14/0x28
Dec 15 17:16:19 localhost kernel:  [<c100287b>] sysenter_past_esp+0x54/0x75
Dec 15 17:16:25 localhost kernel: printk: 2274 messages suppressed.
Dec 15 17:16:25 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: kjournald/1920
Dec 15 17:16:25 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:16:25 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:16:25 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:16:25 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:16:25 localhost kernel:  [<c10c2373>] submit_bio+0x4c/0xac
Dec 15 17:16:25 localhost kernel:  [<c10578dc>] submit_bh+0xcb/0xe8
Dec 15 17:16:25 localhost kernel:  [<c1057988>] ll_rw_block+0x8f/0xb5
Dec 15 17:16:25 localhost kernel:  [<c109c4e1>]
journal_commit_transaction+0x41c/0xf0f
Dec 15 17:16:25 localhost kernel:  [<c109ed87>] kjournald+0xb5/0x1e4
Dec 15 17:16:25 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:16:29 localhost kernel: printk: 920 messages suppressed.
Dec 15 17:16:29 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: bash/4043
Dec 15 17:16:29 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:16:29 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:16:29 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:16:29 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:16:29 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:16:29 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:16:29 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:16:34 localhost kernel: printk: 1692 messages suppressed.
Dec 15 17:16:34 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: kjournald/250
Dec 15 17:16:34 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:16:34 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:16:34 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:16:34 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:16:34 localhost kernel:  [<c10c2373>] submit_bio+0x4c/0xac
Dec 15 17:16:34 localhost kernel:  [<c10578dc>] submit_bh+0xcb/0xe8
Dec 15 17:16:34 localhost kernel:  [<c109c953>]
journal_commit_transaction+0x88e/0xf0f
Dec 15 17:16:34 localhost kernel:  [<c109ed87>] kjournald+0xb5/0x1e4
Dec 15 17:16:34 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:16:39 localhost kernel: printk: 784 messages suppressed.
Dec 15 17:16:39 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: kjournald/250
Dec 15 17:16:39 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:16:39 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:16:39 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:16:39 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:16:39 localhost kernel:  [<c10c2373>] submit_bio+0x4c/0xac
Dec 15 17:16:39 localhost kernel:  [<c10578dc>] submit_bh+0xcb/0xe8
Dec 15 17:16:39 localhost kernel:  [<c1057988>] ll_rw_block+0x8f/0xb5
Dec 15 17:16:39 localhost kernel:  [<c109c4e1>]
journal_commit_transaction+0x41c/0xf0f
Dec 15 17:16:39 localhost kernel:  [<c109ed87>] kjournald+0xb5/0x1e4
Dec 15 17:16:39 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:16:45 localhost kernel: printk: 1948 messages suppressed.
Dec 15 17:16:45 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: less/4261
Dec 15 17:16:45 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:16:45 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:16:45 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:16:45 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:16:45 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:16:45 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:16:45 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:16:50 localhost kernel: printk: 1691 messages suppressed.
Dec 15 17:16:50 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: pdflush/133
Dec 15 17:16:50 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:16:50 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:16:50 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:16:50 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:16:50 localhost kernel:  [<c103e416>]
clear_page_dirty_for_io+0x42/0x50
Dec 15 17:16:50 localhost kernel:  [<c10735e9>] mpage_writepages+0x16c/0x2ca
Dec 15 17:16:50 localhost kernel:  [<c105b35c>] generic_writepages+0xa/0xc
Dec 15 17:16:50 localhost kernel:  [<c103e12d>] do_writepages+0x23/0x36
Dec 15 17:16:50 localhost kernel:  [<c107202a>] __sync_single_inode+0x65/0x1b7
Dec 15 17:16:50 localhost kernel:  [<c10722a2>]
__writeback_single_inode+0x126/0x12e
Dec 15 17:16:50 localhost kernel:  [<c107245f>]
generic_sync_sb_inodes+0x1b5/0x286
Dec 15 17:16:50 localhost kernel:  [<c107254d>] sync_sb_inodes+0x1d/0x20
Dec 15 17:16:50 localhost kernel:  [<c10725cf>] writeback_inodes+0x7f/0xcb
Dec 15 17:16:50 localhost kernel:  [<c103df98>] wb_kupdate+0x76/0xd9
Dec 15 17:16:50 localhost kernel:  [<c103e67e>] __pdflush+0xda/0x18b
Dec 15 17:16:50 localhost kernel:  [<c103e75b>] pdflush+0x2c/0x32
Dec 15 17:16:50 localhost kernel:  [<c102b035>] kthread+0x77/0xa4
Dec 15 17:16:50 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:16:55 localhost kernel: printk: 1778 messages suppressed.
Dec 15 17:16:55 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: kjournald/250
Dec 15 17:16:55 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:16:55 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:16:55 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:16:55 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:16:55 localhost kernel:  [<c10c2373>] submit_bio+0x4c/0xac
Dec 15 17:16:55 localhost kernel:  [<c10578dc>] submit_bh+0xcb/0xe8
Dec 15 17:16:55 localhost kernel:  [<c1057988>] ll_rw_block+0x8f/0xb5
Dec 15 17:16:55 localhost kernel:  [<c109c4e1>]
journal_commit_transaction+0x41c/0xf0f
Dec 15 17:16:55 localhost kernel:  [<c109ed87>] kjournald+0xb5/0x1e4
Dec 15 17:16:55 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:16:59 localhost kernel: printk: 4675 messages suppressed.
Dec 15 17:16:59 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: firefox-bin/4296
Dec 15 17:16:59 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:16:59 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:16:59 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:16:59 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:16:59 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:16:59 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:16:59 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:17:04 localhost kernel: printk: 14518 messages suppressed.
Dec 15 17:17:04 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: firefox-bin/4296
Dec 15 17:17:04 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:17:04 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:17:04 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:17:04 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:17:04 localhost kernel:  [<c10c2373>] submit_bio+0x4c/0xac
Dec 15 17:17:04 localhost kernel:  [<c1072ae3>] mpage_bio_submit+0x1c/0x21
Dec 15 17:17:04 localhost kernel:  [<c1072f8f>] mpage_readpages+0xf5/0xff
Dec 15 17:17:04 localhost kernel:  [<c108d3d9>] ext3_readpages+0x14/0x16
Dec 15 17:17:04 localhost kernel:  [<c103e995>] read_pages+0x25/0xe6
Dec 15 17:17:04 localhost kernel:  [<c103eb7c>]
__do_page_cache_readahead+0x126/0x142
Dec 15 17:17:04 localhost kernel:  [<c103ec44>]
do_page_cache_readahead+0x3d/0x4a
Dec 15 17:17:04 localhost kernel:  [<c10398c8>] filemap_nopage+0x13b/0x2f6
Dec 15 17:17:04 localhost kernel:  [<c104463d>] do_no_page+0x82/0x222
Dec 15 17:17:04 localhost kernel:  [<c104490f>] __handle_mm_fault+0xcd/0x180
Dec 15 17:17:04 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:17:04 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:17:11 localhost kernel: printk: 1896 messages suppressed.
Dec 15 17:17:11 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: firefox-bin/4296
Dec 15 17:17:11 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:17:11 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:17:11 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:17:11 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:17:11 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:17:11 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:17:11 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:17:15 localhost kernel: printk: 573 messages suppressed.
Dec 15 17:17:15 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: firefox-bin/4307
Dec 15 17:17:15 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:17:15 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:17:15 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:17:15 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:17:15 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:17:15 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:17:15 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:17:15 localhost kernel:  [<c100287b>] sysenter_past_esp+0x54/0x75
Dec 15 17:17:19 localhost kernel: printk: 998 messages suppressed.
Dec 15 17:17:19 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: gconfd-2/4034
Dec 15 17:17:19 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:17:19 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:17:19 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:17:19 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:17:19 localhost kernel:  [<c104ea0a>] kmem_getpages+0x67/0x8a
Dec 15 17:17:19 localhost kernel:  [<c104fbc9>] cache_grow+0xaa/0x150
Dec 15 17:17:19 localhost kernel:  [<c1050138>] cache_alloc_refill+0x205/0x246
Dec 15 17:17:19 localhost kernel:  [<c105053b>] kmem_cache_alloc+0x65/0x81
Dec 15 17:17:19 localhost kernel:  [<c1092a23>] ext3_alloc_inode+0x12/0x44
Dec 15 17:17:19 localhost kernel:  [<c1068f6c>] alloc_inode+0x18/0x18f
Dec 15 17:17:19 localhost kernel:  [<c1069a21>] new_inode+0x17/0x8e
Dec 15 17:17:19 localhost kernel:  [<c108b5ab>] ext3_new_inode+0x32/0x5b9
Dec 15 17:17:19 localhost kernel:  [<c10910c8>] ext3_create+0x84/0xea
Dec 15 17:17:19 localhost kernel:  [<c1061037>] vfs_create+0xa9/0x110
Dec 15 17:17:19 localhost kernel:  [<c10613f3>] open_namei+0x14f/0x3f7
Dec 15 17:17:19 localhost kernel:  [<c1052e3d>] filp_open+0x1c/0x31
Dec 15 17:17:19 localhost kernel:  [<c10530d4>] do_sys_open+0x36/0xa7
Dec 15 17:17:19 localhost kernel:  [<c1053156>] sys_open+0x11/0x13
Dec 15 17:17:19 localhost kernel:  [<c100287b>] sysenter_past_esp+0x54/0x75
Dec 15 17:17:25 localhost kernel: printk: 2553 messages suppressed.
Dec 15 17:17:25 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: kjournald/250
Dec 15 17:17:25 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:17:25 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:17:25 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:17:25 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:17:25 localhost kernel:  [<c10c2373>] submit_bio+0x4c/0xac
Dec 15 17:17:25 localhost kernel:  [<c10578dc>] submit_bh+0xcb/0xe8
Dec 15 17:17:25 localhost kernel:  [<c109c953>]
journal_commit_transaction+0x88e/0xf0f
Dec 15 17:17:25 localhost kernel:  [<c109ed87>] kjournald+0xb5/0x1e4
Dec 15 17:17:25 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:17:30 localhost kernel: printk: 826 messages suppressed.
Dec 15 17:17:30 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: kjournald/250
Dec 15 17:17:30 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:17:30 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:17:30 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:17:30 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:17:30 localhost kernel:  [<c10c2373>] submit_bio+0x4c/0xac
Dec 15 17:17:30 localhost kernel:  [<c10578dc>] submit_bh+0xcb/0xe8
Dec 15 17:17:30 localhost kernel:  [<c1057988>] ll_rw_block+0x8f/0xb5
Dec 15 17:17:30 localhost kernel:  [<c109c4e1>]
journal_commit_transaction+0x41c/0xf0f
Dec 15 17:17:30 localhost kernel:  [<c109ed87>] kjournald+0xb5/0x1e4
Dec 15 17:17:30 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:17:35 localhost kernel: printk: 1400 messages suppressed.
Dec 15 17:17:35 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: kjournald/250
Dec 15 17:17:35 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:17:35 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:17:35 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:17:35 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:17:35 localhost kernel:  [<c10c2373>] submit_bio+0x4c/0xac
Dec 15 17:17:35 localhost kernel:  [<c10578dc>] submit_bh+0xcb/0xe8
Dec 15 17:17:35 localhost kernel:  [<c1057988>] ll_rw_block+0x8f/0xb5
Dec 15 17:17:35 localhost kernel:  [<c109c4e1>]
journal_commit_transaction+0x41c/0xf0f
Dec 15 17:17:35 localhost kernel:  [<c109ed87>] kjournald+0xb5/0x1e4
Dec 15 17:17:35 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:17:39 localhost kernel: printk: 1452 messages suppressed.
Dec 15 17:17:39 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: firefox-bin/4296
Dec 15 17:17:39 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:17:39 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:17:39 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:17:39 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:17:39 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:17:39 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:17:39 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:17:44 localhost kernel: printk: 1046 messages suppressed.
Dec 15 17:17:44 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: firefox-bin/4296
Dec 15 17:17:44 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:17:44 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:17:44 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:17:44 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:17:44 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:17:44 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:17:44 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:17:49 localhost kernel: printk: 830 messages suppressed.
Dec 15 17:17:49 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: Xorg/3799
Dec 15 17:17:49 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:17:49 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:17:49 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:17:49 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:17:49 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:17:49 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:17:49 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:17:54 localhost kernel: printk: 4102 messages suppressed.
Dec 15 17:17:54 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: kjournald/250
Dec 15 17:17:54 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:17:54 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:17:54 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:17:54 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:17:54 localhost kernel:  [<c10c2373>] submit_bio+0x4c/0xac
Dec 15 17:17:54 localhost kernel:  [<c10578dc>] submit_bh+0xcb/0xe8
Dec 15 17:17:54 localhost kernel:  [<c1057988>] ll_rw_block+0x8f/0xb5
Dec 15 17:17:54 localhost kernel:  [<c109c4e1>]
journal_commit_transaction+0x41c/0xf0f
Dec 15 17:17:54 localhost kernel:  [<c109ed87>] kjournald+0xb5/0x1e4
Dec 15 17:17:54 localhost kernel:  [<c1000e91>] kernel_thread_helper+0x5/0xb
Dec 15 17:17:59 localhost kernel: printk: 1112 messages suppressed.
Dec 15 17:17:59 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: firefox-bin/4307
Dec 15 17:17:59 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:17:59 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:17:59 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:17:59 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:17:59 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:17:59 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:17:59 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:18:04 localhost kernel: printk: 839 messages suppressed.
Dec 15 17:18:04 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: firefox-bin/4296
Dec 15 17:18:04 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:18:04 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:18:04 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:18:04 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:18:04 localhost kernel:  [<c1044872>] __handle_mm_fault+0x30/0x180
Dec 15 17:18:04 localhost kernel:  [<c1191aa9>] do_page_fault+0x17d/0x543
Dec 15 17:18:04 localhost kernel:  [<c10033fb>] error_code+0x4f/0x54
Dec 15 17:18:09 localhost kernel: printk: 2802 messages suppressed.
Dec 15 17:18:09 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: hald/3414
Dec 15 17:18:09 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:18:09 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:18:09 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:18:09 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:18:09 localhost kernel:  [<c104ea0a>] kmem_getpages+0x67/0x8a
Dec 15 17:18:09 localhost kernel:  [<c104fbc9>] cache_grow+0xaa/0x150
Dec 15 17:18:09 localhost kernel:  [<c1050138>] cache_alloc_refill+0x205/0x246
Dec 15 17:18:09 localhost kernel:  [<c105053b>] kmem_cache_alloc+0x65/0x81
Dec 15 17:18:09 localhost kernel:  [<c105a77b>] bdev_alloc_inode+0x12/0x22
Dec 15 17:18:09 localhost kernel:  [<c1068f6c>] alloc_inode+0x18/0x18f
Dec 15 17:18:09 localhost kernel:  [<c1069abc>] get_new_inode+0x13/0x124
Dec 15 17:18:09 localhost kernel:  [<c1069fd4>] iget5_locked+0x62/0x6c
Dec 15 17:18:09 localhost kernel:  [<c105a920>] bdget+0x30/0xf1
Dec 15 17:18:09 localhost kernel:  [<c105aac1>] bd_acquire+0x3d/0xcd
Dec 15 17:18:09 localhost kernel:  [<c105b110>] blkdev_open+0x14/0x4a
Dec 15 17:18:09 localhost kernel:  [<c1052d16>] __dentry_open+0xff/0x20a
Dec 15 17:18:09 localhost kernel:  [<c1052eda>] nameidata_to_filp+0x1c/0x2e
Dec 15 17:18:09 localhost kernel:  [<c1052e4b>] filp_open+0x2a/0x31
Dec 15 17:18:09 localhost kernel:  [<c10530d4>] do_sys_open+0x36/0xa7
Dec 15 17:18:09 localhost kernel:  [<c1053156>] sys_open+0x11/0x13
Dec 15 17:18:09 localhost kernel:  [<c100287b>] sysenter_past_esp+0x54/0x75
Dec 15 17:18:14 localhost kernel: printk: 1991 messages suppressed.
Dec 15 17:18:14 localhost kernel: BUG: using smp_processor_id() in
preemptible [00000001] code: firefox-bin/4296
Dec 15 17:18:14 localhost kernel: caller is mod_page_state_offset+0x14/0x28
Dec 15 17:18:14 localhost kernel:  [<c1003722>] dump_stack+0x15/0x17
Dec 15 17:18:14 localhost kernel:  [<c10cd5d1>] debug_smp_processor_id+0x79/0x90
Dec 15 17:18:14 localhost kernel:  [<c103cd2c>] mod_page_state_offset+0x14/0x28
Dec 15 17:18:14 localhost kernel:  [<c104ea0a>] kmem_getpages+0x67/0x8a
Dec 15 17:18:14 localhost kernel:  [<c104fbc9>] cache_grow+0xaa/0x150
Dec 15 17:18:14 localhost kernel:  [<c1050138>] cache_alloc_refill+0x205/0x246
Dec 15 17:18:14 localhost kernel:  [<c105063c>] __kmalloc+0x9d/0xba
Dec 15 17:18:14 localhost kernel:  [<c114bf2e>] __alloc_skb+0x46/0x11b
Dec 15 17:18:14 localhost kernel:  [<c114acce>] sock_alloc_send_pskb+0x62/0x1e4
Dec 15 17:18:14 localhost kernel:  [<c114ae5e>] sock_alloc_send_skb+0xe/0x10
Dec 15 17:18:14 localhost kernel:  [<f8875ca5>]
unix_stream_sendmsg+0x131/0x33f [unix]
Dec 15 17:18:14 localhost kernel:  [<c11485ce>] sock_aio_write+0x114/0x121
Dec 15 17:18:14 localhost kernel:  [<c1053aab>] do_sync_write+0xaa/0xdf
Dec 15 17:18:14 localhost kernel:  [<c1053b9e>] vfs_write+0xbe/0x156
Dec 15 17:18:14 localhost kernel:  [<c1053cd1>] sys_write+0x3b/0x60
Dec 15 17:18:14 localhost kernel:  [<c100287b>] sysenter_past_esp+0x54/0x75
Dec 15 17:18:19 localhost kernel: printk: 1728 messages suppressed.


[9.] Config file
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.15-rc5-mm3
# Thu Dec 15 16:43:29 2005
#
CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_CPUSETS is not set
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_DOUBLEFAULT=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
CONFIG_SERIAL_PCI=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
# CONFIG_LBD is not set
CONFIG_BLK_DEV_IO_TRACE=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=m
CONFIG_IOSCHED_CFQ=m
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
# CONFIG_HPET_TIMER is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_SCHED_SMT=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=m
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_IRQBALANCE=y
CONFIG_REGPARM=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_SONY is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=m
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=m
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
CONFIG_X86_P4_CLOCKMOD=m
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_X86_SPEEDSTEP_LIB=m

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG_CPU is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=m
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_IPV6_TUNNEL is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_NETLINK is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_NETBIOS_NS is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_PPTP is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_DCCP is not set
CONFIG_IP_NF_MATCH_COMMENT=m
CONFIG_IP_NF_MATCH_HASHLIMIT=m
CONFIG_IP_NF_MATCH_STRING=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_ULOG is not set
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_TARGET_NFQUEUE=m
# CONFIG_IP_NF_NAT is not set
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# IPv6: Netfilter Configuration (EXPERIMENTAL)
#
# CONFIG_IP6_NF_QUEUE is not set
# CONFIG_IP6_NF_IPTABLES is not set
# CONFIG_IP6_NF_TARGET_NFQUEUE is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SAS_CLASS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_PATA_AMD is not set
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_PATA_TRIFLEX is not set
# CONFIG_SCSI_PATA_MPIIX is not set
# CONFIG_SCSI_PATA_OLDPIIX is not set
CONFIG_SCSI_ATA_PIIX=y
# CONFIG_SCSI_SATA_MV is not set
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_PATA_OPTI is not set
# CONFIG_SCSI_PDC_ADMA is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_PATA_PDC2027X is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIL24 is not set
# CONFIG_SCSI_PATA_SIL680 is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_PATA_VIA is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
CONFIG_SCSI_SATA_INTEL_COMBINED=y
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA24XX is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
CONFIG_SKGE=m
CONFIG_SKY2=m
CONFIG_SK98LIN=m
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=y
# CONFIG_KGDBOE is not set
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_RTC_X1205_I2C is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
CONFIG_SPI_ARCH_HAS_MASTER=y
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_IP is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_GOTEMP is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# EDAC - error detection and reporting (RAS)
#
# CONFIG_EDAC is not set
# CONFIG_EDAC_POLL is not set

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# File systems
#
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT2_FS_XIP=y
CONFIG_FS_XIP=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISER4_FS=m
# CONFIG_REISER4_DEBUG is not set
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
CONFIG_XFS_EXPORT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
CONFIG_OCFS2_FS=m
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_RELAYFS_FS=y
CONFIG_CONFIGFS_FS=m

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ASFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Instrumentation Support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
CONFIG_KPROBES=y

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHEDSTATS=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_VM=y
CONFIG_FRAME_POINTER=y
CONFIG_RCU_TORTURE_TEST=m
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_RODATA is not set
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_DEBUG_PROC_KEYS=y
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set
CONFIG_SECURITY_SECLVL=y
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=0
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_KTIME_SCALAR=y

[8.] Environment

[8.1.] Software
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux debian 2.6.15-rc5-mm3 #4 SMP PREEMPT Thu Dec 15 16:57:58 CET
2005 i686 GNU/Linux

Gnu C                  4.0.3
Gnu make               3.81beta4
binutils               2.16.91
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39-WIP
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           1.0.5
xfsprogs               2.7.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.93
udev                   076
Modules Loaded         binfmt_misc thermal fan processor ipv6
ipt_limit ipt_LOG ipt_REJECT ip_conntrack_ftp ipt_state ip_conntrack
iptable_filter ip_tables af_packet psmouse 8250_pnp 8250 serial_core
parport_pc parport snd_intel8x0 snd_ac97_codec snd_ac97_bus
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd sk98lin skge rtc evdev
soundcore snd_page_alloc hw_random ehci_hcd uhci_hcd usbcore intel_agp
agpgart ide_cd cdrom unix

[8.3.] Module information
binfmt_misc 8840 1 - Live 0xfd94b000
thermal 11400 0 - Live 0xfd947000
fan 3844 0 - Live 0xfd943000
processor 20044 1 thermal, Live 0xfd953000
ipv6 201632 8 - Live 0xfdf24000
ipt_limit 2432 8 - Live 0xfd945000
ipt_LOG 5632 8 - Live 0xfd931000
ipt_REJECT 4352 1 - Live 0xfd92e000
ip_conntrack_ftp 6000 0 - Live 0xfd92b000
ipt_state 2048 6 - Live 0xf989e000
ip_conntrack 38040 2 ip_conntrack_ftp,ipt_state, Live 0xfd91c000
iptable_filter 2688 1 - Live 0xf885e000
ip_tables 19036 5
ipt_limit,ipt_LOG,ipt_REJECT,ipt_state,iptable_filter, Live 0xfd916000
af_packet 13064 2 - Live 0xfd911000
psmouse 35236 0 - Live 0xfd907000
8250_pnp 8832 0 - Live 0xfd927000
8250 23716 1 8250_pnp, Live 0xfd93c000
serial_core 16640 1 8250, Live 0xf98fa000
parport_pc 20932 0 - Live 0xfd935000
parport 20672 1 parport_pc, Live 0xfd95e000
snd_intel8x0 26524 0 - Live 0xf98f2000
snd_ac97_codec 82336 1 snd_intel8x0, Live 0xfd98d000
snd_ac97_bus 2432 1 snd_ac97_codec, Live 0xf8806000
snd_pcm_oss 41600 0 - Live 0xf98e6000
snd_mixer_oss 15104 1 snd_pcm_oss, Live 0xf887b000
snd_pcm 70404 3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss, Live 0xf98d3000
snd_timer 19588 1 snd_pcm, Live 0xfd901000
snd 44164 6 snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,
Live 0xf98c7000
sk98lin 132448 0 - Live 0xf98a5000
skge 31376 0 - Live 0xf8855000
rtc 10036 0 - Live 0xf8851000
evdev 7552 0 - Live 0xf884e000
soundcore 7648 1 snd, Live 0xf884b000
snd_page_alloc 8200 2 snd_intel8x0,snd_pcm, Live 0xf883e000
hw_random 4628 0 - Live 0xf8839000
ehci_hcd 25356 0 - Live 0xf8831000
uhci_hcd 27152 0 - Live 0xf8829000
usbcore 101892 3 ehci_hcd,uhci_hcd, Live 0xf9881000
intel_agp 18460 1 - Live 0xf881e000
agpgart 26332 1 intel_agp, Live 0xf8816000
ide_cd 32644 0 - Live 0xf880d000
cdrom 30752 1 ide_cd, Live 0xf8842000
unix 22160 270 - Live 0xf8874000

[8.4.] Loaded driver and hardware information
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0290-0297 : pnp 00:0a
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-041f : 0000:00:1f.3
0480-04bf : 0000:00:1f.0
0680-06ff : pnp 00:0a
0800-087f : 0000:00:1f.0
  0800-0803 : PM1a_EVT_BLK
  0804-0805 : PM1a_CNT_BLK
  0808-080b : PM_TMR
  0828-082f : GPE0_BLK
0cf8-0cff : PCI conf1
c400-c40f : 0000:00:1f.2
  c400-c40f : libata
c480-c483 : 0000:00:1f.2
  c480-c483 : libata
c800-c807 : 0000:00:1f.2
  c800-c807 : libata
c880-c883 : 0000:00:1f.2
  c880-c883 : libata
cc00-cc07 : 0000:00:1f.2
  cc00-cc07 : libata
d000-d0ff : 0000:00:1f.5
  d000-d0ff : Intel ICH5
d400-d43f : 0000:00:1f.5
  d400-d43f : Intel ICH5
d480-d49f : 0000:00:1d.0
  d480-d49f : uhci_hcd
d800-d81f : 0000:00:1d.1
  d800-d81f : uhci_hcd
d880-d89f : 0000:00:1d.2
  d880-d89f : uhci_hcd
dc00-dc1f : 0000:00:1d.3
  dc00-dc1f : uhci_hcd
e000-efff : PCI Bus #02
  e800-e8ff : 0000:02:05.0
    e800-e8ff : skge
fc00-fc0f : 0000:00:1f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1
00000000-0009fbff : System RAM
  00000000-00000000 : Crash kernel
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf3ff : Video ROM
000f0000-000fffff : System ROM
00100000-3ff2ffff : System RAM
  01000000-01193270 : Kernel code
  01193271-0122c133 : Kernel data
3ff30000-3ff3ffff : ACPI Tables
3ff40000-3ffeffff : ACPI Non-volatile Storage
3fff0000-3fffffff : reserved
50000000-500003ff : 0000:00:1f.1
54000000-57ffffff : 0000:00:00.0
e8000000-f4ffffff : PCI Bus #01
  e8000000-efffffff : 0000:01:00.0
    e8000000-efffffff : nvidiafb
f5fff400-f5fff4ff : 0000:00:1f.5
  f5fff400-f5fff4ff : Intel ICH5
f5fff800-f5fff9ff : 0000:00:1f.5
  f5fff800-f5fff9ff : Intel ICH5
f5fffc00-f5ffffff : 0000:00:1d.7
  f5fffc00-f5ffffff : ehci_hcd
f6000000-f7efffff : PCI Bus #01
  f6000000-f6ffffff : 0000:01:00.0
    f6000000-f6ffffff : nvidiafb
  f7ee0000-f7efffff : 0000:01:00.0
f7f00000-fbffffff : PCI Bus #02
  f7ffc000-f7ffffff : 0000:02:05.0
    f7ffc000-f7ffffff : skge
ffb80000-ffffffff : reserved

[8.5.] PCI information
0000:00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM
Controller/Host-Hub Interface (rev 02)
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at 54000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] #09 [2106]
	Capabilities: [a0] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit-
FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP- GART64- 64bit- FW- Rate=<none>

0000:00:01.0 PCI bridge: Intel Corporation 82865G/PE/P PCI to AGP
Controller (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f6000000-f7efffff
	Prefetchable memory behind bridge: e8000000-f4ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at d480 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 18
	Region 4: I/O ports at d800 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
USB UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 17
	Region 4: I/O ports at d880 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
USB UHCI Controller #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at dc00 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at f5fffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: f7f00000-fbffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC
Interface Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R)
IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at fc00 [size=16]
	Region 5: Memory at 50000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA
Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at cc00 [size=8]
	Region 1: I/O ports at c880 [size=4]
	Region 2: I/O ports at c800 [size=8]
	Region 3: I/O ports at c480 [size=4]
	Region 4: I/O ports at c400 [size=16]

0000:00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus
Controller (rev 02)
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 0400 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 21
	Region 0: I/O ports at d000 [size=256]
	Region 1: I/O ports at d400 [size=64]
	Region 2: Memory at f5fff800 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at f5fff400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV34
[GeForce FX 5200] (rev a1) (prog-if 00 [VGA])
	Subsystem: PROLINK Microsystems Corp: Unknown device 1152
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at f7ee0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit-
FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

0000:02:05.0 Ethernet controller: 3Com Corporation 3c940
10/100/1000Base-T [Marvell] (rev 12)
	Subsystem: ASUSTeK Computer Inc. P4P800/K8V Deluxe motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5750ns min, 7750ns max), Cache Line Size: 0x04 (16 bytes)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at f7ffc000 (32-bit, non-prefetchable) [size=16K]
	Region 1: I/O ports at e800 [size=256]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data



OOPS Reporting Tool v.ltg1
www.wsi.edu.pl/~piotrowskim/files/ort/ltg/

Regards,
Michal Piotrowski

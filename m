Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVABMlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVABMlo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 07:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVABMlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 07:41:44 -0500
Received: from mail4.worldserver.net ([217.13.200.24]:6322 "EHLO
	mail4.worldserver.net") by vger.kernel.org with ESMTP
	id S261216AbVABMlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 07:41:08 -0500
X-Speedbone-MailScanner-Mail-From: christian@leber.de via mail4.worldserver.net
X-Speedbone-MailScanner: 1.23st (Clear:RC:1(80.140.34.108):. Processed in 1.138416 secs Process 13113)
Date: Sun, 2 Jan 2005 13:41:05 +0100
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Subject: Re: unkillable processes using samba, xfs and lvm2 snapshots (k 2.6.10)
Message-ID: <20050102124105.GA11435@core.home>
References: <41D14251.4030704@inha.fr> <200412280907.01681.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412280907.01681.gene.heskett@verizon.net>
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2004 at 09:07:01AM -0500, Gene Heskett wrote:

> I have a somewhat similar case here, samba processses are unkillable, 
> but I can do a software reboot. Something is also killing amandad, 
> and I lost the backup of this machine last night.  The amanda logs 
> are bereft of any info and I've no clue that its happened except a 
> message from amanda that the client access timed out on this machine.
> This was while running 2.6.10-rc3-mm1-V0.33-04 which ran stably for 8 
> days previously.

I have the same problem (2.6.10-rc3 running 7 days without problems) and
i had D state mc, smbd and lsof:
(there is something about nfs in the call tree, it _might_ be that i
halted a nfs server the day before without unmounting it on the system with the
problem)

Dec 31 18:55:20 core kernel: nfs warning: mount version older than kernel
Jan  1 06:25:38 core kernel: nfs: server igor3 not responding, still trying
Jan  1 17:29:15 core kernel: nfs: server igor3 not responding, still trying
Jan  1 18:05:12 core kernel:       (NOTLB)
Jan  1 18:05:12 core kernel: c843deb4 00200086 f68a6580 c04c0150 000274ab c18e57e0 587f3ab2 000274ab 
Jan  1 18:05:12 core kernel:        00003875 5880d98d 000274ab d696d560 d696d6bc 00000014 d696d560 c843c000 
Jan  1 18:05:12 core kernel:        ffffe000 c011cca2 d696d560 ecc030e0 00040005 c011d00f ffffffff d696d9d4 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c011cca2>] finish_stop+0x42/0x90
Jan  1 18:05:12 core kernel:  [<c011d00f>] get_signal_to_deliver+0x19f/0x2b0
Jan  1 18:05:12 core kernel:  [<c0102388>] do_signal+0x98/0x130
Jan  1 18:05:12 core kernel:  [<c010f740>] default_wake_function+0x0/0x20
Jan  1 18:05:12 core kernel:  [<c010f740>] default_wake_function+0x0/0x20
Jan  1 18:05:12 core kernel:  [<c01059b2>] sys_ptrace+0xb2/0x610
Jan  1 18:05:12 core kernel:  [<c0102455>] do_notify_resume+0x35/0x38
Jan  1 18:05:12 core kernel:  [<c0102596>] work_notifysig+0x13/0x15
Jan  1 18:05:12 core kernel: mc            D C04C0120     0 21514  30032 21516               (NOTLB)
Jan  1 18:05:12 core kernel: f0269da8 00000082 d1edba20 c04c0120 00000000 00000292 f7de72a4 f0269da8 
Jan  1 18:05:12 core kernel:        000f8c0f 36b16015 00026d31 d1edba20 d1edbb7c df1cbe94 df1cbda0 f0269dcc 
Jan  1 18:05:12 core kernel:        df1cbeb8 c01d4a65 c1b25560 f7de72a4 c01af638 00000000 d6aba200 00000000 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c01d4a65>] nfs_wait_on_inode+0xd5/0x1e0
Jan  1 18:05:12 core kernel:  [<c01af638>] ext3_mark_iloc_dirty+0x28/0x40
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c01545a7>] follow_mount+0x57/0xa0
Jan  1 18:05:12 core kernel:  [<c01d4f64>] __nfs_revalidate_inode+0x74/0x360
Jan  1 18:05:12 core kernel:  [<c0160120>] update_atime+0xd0/0xe0
Jan  1 18:05:12 core kernel:  [<c0154e6d>] link_path_walk+0x73d/0xb60
Jan  1 18:05:12 core kernel:  [<c01bd3c9>] journal_stop+0x149/0x200
Jan  1 18:05:12 core kernel:  [<c01d52ea>] nfs_revalidate_inode+0x4a/0x70
Jan  1 18:05:12 core kernel:  [<c01d4bd0>] nfs_getattr+0x60/0xa0
Jan  1 18:05:12 core kernel:  [<c01509f9>] vfs_getattr+0x39/0xa0
Jan  1 18:05:12 core kernel:  [<c0150aaf>] vfs_stat+0x4f/0x60
Jan  1 18:05:12 core kernel:  [<c01511ab>] sys_stat64+0x1b/0x40
Jan  1 18:05:12 core kernel:  [<c015a1ff>] fifo_open+0x13f/0x26f
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: mozilla-bin   S C04C0120     0  2810   2994          2859       (NOTLB)
Jan  1 18:05:12 core kernel: e6135f10 00200086 dde78a00 c04c0120 e6135fa0 cb94fa98 c012ff73 c1125b60 
Jan  1 18:05:12 core kernel:        00002623 41070976 00028179 dde78a00 dde78b5c 00000000 7fffffff e6135f68 
Jan  1 18:05:12 core kernel:        7fffffff c0389a35 c01536c4 e4cb7d80 cb1db8e0 e6135fa0 00000145 e491a420 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c012ff73>] __get_free_pages+0x33/0x40
Jan  1 18:05:12 core kernel:  [<c0389a35>] schedule_timeout+0xb5/0xc0
Jan  1 18:05:12 core kernel:  [<c01536c4>] pipe_poll+0x34/0x80
Jan  1 18:05:12 core kernel:  [<c0159d1f>] do_pollfd+0x4f/0x90
Jan  1 18:05:12 core kernel:  [<c0159e0a>] do_poll+0xaa/0xd0
Jan  1 18:05:12 core kernel:  [<c0159f82>] sys_poll+0x152/0x210
Jan  1 18:05:12 core kernel:  [<c0159370>] __pollwait+0x0/0xd0
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: mozilla-bin   S C04C0120     0  2859   2994          2860  2810 (NOTLB)
Jan  1 18:05:12 core kernel: db23bf10 00200086 c46cda20 c04c0120 000000d0 2d9fbab8 000000d0 f3ca81a0 
Jan  1 18:05:12 core kernel:        00000799 d2284a24 00028178 c46cda20 c46cdb7c 00000000 7fffffff db23bf68 
Jan  1 18:05:12 core kernel:        7fffffff c0389a35 c01536c4 f3ca81a0 cb1dbf20 db23bfa0 00000145 da0da768 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c0389a35>] schedule_timeout+0xb5/0xc0
Jan  1 18:05:12 core kernel:  [<c01536c4>] pipe_poll+0x34/0x80
Jan  1 18:05:12 core kernel:  [<c0159d1f>] do_pollfd+0x4f/0x90
Jan  1 18:05:12 core kernel:  [<c0159e0a>] do_poll+0xaa/0xd0
Jan  1 18:05:12 core kernel:  [<c0159f82>] sys_poll+0x152/0x210
Jan  1 18:05:12 core kernel:  [<c0159370>] __pollwait+0x0/0xd0
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: mozilla-bin   S C04C0150     0  2860   2994                2859 (NOTLB)
Jan  1 18:05:12 core kernel: c79ffe90 00200086 dde78a00 c04c0150 00028179 00000000 4105997b 00028179 
Jan  1 18:05:12 core kernel:        0000159c 4105b238 00028179 c46cd540 c46cd69c 2a0aec95 c79ffea4 fffffff5 
Jan  1 18:05:12 core kernel:        c79ffedc c03899e3 c79ffea4 2a0aec95 c79ffec8 c04c60c8 c04c60c8 2a0aec95 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c03899e3>] schedule_timeout+0x63/0xc0
Jan  1 18:05:12 core kernel:  [<c011aa90>] process_timeout+0x0/0x10
Jan  1 18:05:12 core kernel:  [<c012585f>] futex_wait+0x12f/0x170
Jan  1 18:05:12 core kernel:  [<c010f740>] default_wake_function+0x0/0x20
Jan  1 18:05:12 core kernel:  [<c010f740>] default_wake_function+0x0/0x20
Jan  1 18:05:12 core kernel:  [<c01535d0>] pipe_write+0x0/0x40
Jan  1 18:05:12 core kernel:  [<c0125b18>] do_futex+0x48/0xa0
Jan  1 18:05:12 core kernel:  [<c0125c5e>] sys_futex+0xee/0x100
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: xchat         S C04C0120     0  7965      1          7966 26544 (NOTLB)
Jan  1 18:05:12 core kernel: e4e43f10 00200082 ce06d5a0 c04c0120 e4e43fa0 e93f8af8 c012ff73 d5703400 
Jan  1 18:05:12 core kernel:        00000852 5500c143 0002817b ce06d5a0 ce06d6fc 2a0adc55 e4e43f24 e4e43f68 
Jan  1 18:05:12 core kernel:        00000034 c03899e3 e4e43f24 2a0adc55 c86fd740 c04c5a10 c04c5a10 2a0adc55 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c012ff73>] __get_free_pages+0x33/0x40
Jan  1 18:05:12 core kernel:  [<c03899e3>] schedule_timeout+0x63/0xc0
Jan  1 18:05:12 core kernel:  [<c011aa90>] process_timeout+0x0/0x10
Jan  1 18:05:12 core kernel:  [<c0159e0a>] do_poll+0xaa/0xd0
Jan  1 18:05:12 core kernel:  [<c0159f82>] sys_poll+0x152/0x210
Jan  1 18:05:12 core kernel:  [<c01163fb>] sys_gettimeofday+0x3b/0x80
Jan  1 18:05:12 core kernel:  [<c0159370>] __pollwait+0x0/0xd0
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: xchat         S C04C05C8     0  7966      1         12134  7965 (NOTLB)
Jan  1 18:05:12 core kernel: c30bfeb4 00200082 ce06d5a0 c04c05c8 0002817b 00000001 5500689d 0002817b 
Jan  1 18:05:12 core kernel:        000006de 55006e0a 0002817b dde78520 dde7867c 00000000 7fffffff 00000006 
Jan  1 18:05:12 core kernel:        00000006 c0389a35 c1346120 00000000 c01593f5 f64b54a4 00200246 f64b54a4 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c0389a35>] schedule_timeout+0xb5/0xc0
Jan  1 18:05:12 core kernel:  [<c01593f5>] __pollwait+0x85/0xd0
Jan  1 18:05:12 core kernel:  [<c01536c4>] pipe_poll+0x34/0x80
Jan  1 18:05:12 core kernel:  [<c0159693>] do_select+0x173/0x2b0
Jan  1 18:05:12 core kernel:  [<c0159370>] __pollwait+0x0/0xd0
Jan  1 18:05:12 core kernel:  [<c0159abf>] sys_select+0x2bf/0x4d0
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: smbd          D C04C0120     0  9058      1         12172 26379 (NOTLB)
Jan  1 18:05:12 core kernel: e1d95c24 00000082 ed6365a0 c04c0120 f7cbdce0 c03762de d0130400 f7cbdce0 
Jan  1 18:05:12 core kernel:        00011688 13c6a05f 000280e1 ed6365a0 ed6366fc f7cbdce0 e1d95c60 f7cbdd58 
Jan  1 18:05:12 core kernel:        e1d95c40 c037800d f7cbdce0 00000000 da6b95f8 e1d94000 00000000 00000000 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c03762de>] xprt_prepare_transmit+0x7e/0xc0
Jan  1 18:05:12 core kernel:  [<c037800d>] __rpc_execute+0x13d/0x3c0
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c03786b6>] rpc_new_task+0x36/0xb0
Jan  1 18:05:12 core kernel:  [<c0373a24>] rpc_call_sync+0x74/0xb0
Jan  1 18:05:12 core kernel:  [<c01dd6fa>] nfs3_rpc_wrapper+0x3a/0x80
Jan  1 18:05:12 core kernel:  [<c01ddc9a>] nfs3_proc_access+0xda/0x170
Jan  1 18:05:12 core kernel:  [<c01bdc75>] __journal_file_buffer+0x175/0x230
Jan  1 18:05:12 core kernel:  [<c01bd02f>] journal_dirty_metadata+0xef/0x170
Jan  1 18:05:12 core kernel:  [<c037973c>] rpcauth_lookup_credcache+0x1cc/0x210
Jan  1 18:05:12 core kernel:  [<c01d29c5>] nfs_do_access+0x65/0xb0
Jan  1 18:05:12 core kernel:  [<c01d2b00>] nfs_permission+0xf0/0x170
Jan  1 18:05:12 core kernel:  [<c0154241>] permission+0x51/0x60
Jan  1 18:05:12 core kernel:  [<c01551c2>] link_path_walk+0xa92/0xb60
Jan  1 18:05:12 core kernel:  [<c0160120>] update_atime+0xd0/0xe0
Jan  1 18:05:12 core kernel:  [<c0154e0d>] link_path_walk+0x6dd/0xb60
Jan  1 18:05:12 core kernel:  [<c01554e0>] path_lookup+0x70/0x110
Jan  1 18:05:12 core kernel:  [<c0155733>] __user_walk+0x33/0x60
Jan  1 18:05:12 core kernel:  [<c0150a7f>] vfs_stat+0x1f/0x60
Jan  1 18:05:12 core kernel:  [<c01511ab>] sys_stat64+0x1b/0x40
Jan  1 18:05:12 core kernel:  [<c0103ee8>] math_state_restore+0x28/0x50
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: lsof          D C04C0120     0 12134      1         12137  7966 (NOTLB)
Jan  1 18:05:12 core kernel: c2341da8 00000086 c46cd060 c04c0120 c0389b45 d900a5f8 c0149040 c2341dd4 
Jan  1 18:05:12 core kernel:        0000196b 064b7168 000280e4 c46cd060 c46cd1bc df1cbe94 df1cbda0 c2341dcc 
Jan  1 18:05:12 core kernel:        df1cbeb8 c01d4a65 c0124cc0 c2341dd4 c2341dd4 00000000 d6aba200 00000002 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c0389b45>] __wait_on_bit+0x45/0x60
Jan  1 18:05:12 core kernel:  [<c0149040>] sync_buffer+0x0/0x50
Jan  1 18:05:12 core kernel:  [<c01d4a65>] nfs_wait_on_inode+0xd5/0x1e0
Jan  1 18:05:12 core kernel:  [<c0124cc0>] wake_bit_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c01d4f64>] __nfs_revalidate_inode+0x74/0x360
Jan  1 18:05:12 core kernel:  [<c01545a7>] follow_mount+0x57/0xa0
Jan  1 18:05:12 core kernel:  [<c0155011>] link_path_walk+0x8e1/0xb60
Jan  1 18:05:12 core kernel:  [<c01d52ea>] nfs_revalidate_inode+0x4a/0x70
Jan  1 18:05:12 core kernel:  [<c01d4bd0>] nfs_getattr+0x60/0xa0
Jan  1 18:05:12 core kernel:  [<c01509f9>] vfs_getattr+0x39/0xa0
Jan  1 18:05:12 core kernel:  [<c0150aaf>] vfs_stat+0x4f/0x60
Jan  1 18:05:12 core kernel:  [<c01532d7>] pipe_read+0x37/0x40
Jan  1 18:05:12 core kernel:  [<c01511ab>] sys_stat64+0x1b/0x40
Jan  1 18:05:12 core kernel:  [<c0147ea1>] vfs_read+0xd1/0x130
Jan  1 18:05:12 core kernel:  [<c038944e>] schedule+0x2ce/0x4d0
Jan  1 18:05:12 core kernel:  [<c0148171>] sys_read+0x51/0x80
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: lsof          D C04C0120     0 12137      1         12141 12134 (NOTLB)
Jan  1 18:05:12 core kernel: cbed5da8 00200086 f2996a40 c04c0120 c0139fa3 dbd4d900 d9115078 d221efe4 
Jan  1 18:05:12 core kernel:        00001704 00436954 000280e6 f2996a40 f2996b9c df1cbe94 df1cbda0 cbed5dcc 
Jan  1 18:05:12 core kernel:        df1cbeb8 c01d4a65 d9115078 c013a386 dbd4d900 00000000 d6aba200 00000001 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c0139fa3>] do_no_page+0x63/0x250
Jan  1 18:05:12 core kernel:  [<c01d4a65>] nfs_wait_on_inode+0xd5/0x1e0
Jan  1 18:05:12 core kernel:  [<c013a386>] handle_mm_fault+0xf6/0x170
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c010d34c>] do_page_fault+0x18c/0x599
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c01d4f64>] __nfs_revalidate_inode+0x74/0x360
Jan  1 18:05:12 core kernel:  [<c01545a7>] follow_mount+0x57/0xa0
Jan  1 18:05:12 core kernel:  [<c0155011>] link_path_walk+0x8e1/0xb60
Jan  1 18:05:12 core kernel:  [<c01d52ea>] nfs_revalidate_inode+0x4a/0x70
Jan  1 18:05:12 core kernel:  [<c01d4bd0>] nfs_getattr+0x60/0xa0
Jan  1 18:05:12 core kernel:  [<c01509f9>] vfs_getattr+0x39/0xa0
Jan  1 18:05:12 core kernel:  [<c0150aaf>] vfs_stat+0x4f/0x60
Jan  1 18:05:12 core kernel:  [<c01532d7>] pipe_read+0x37/0x40
Jan  1 18:05:12 core kernel:  [<c01511ab>] sys_stat64+0x1b/0x40
Jan  1 18:05:12 core kernel:  [<c0147ea1>] vfs_read+0xd1/0x130
Jan  1 18:05:12 core kernel:  [<c038944e>] schedule+0x2ce/0x4d0
Jan  1 18:05:12 core kernel:  [<c0148171>] sys_read+0x51/0x80
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: lsof          D C04C0120     0 12141      1         12169 12137 (NOTLB)
Jan  1 18:05:12 core kernel: d6507da8 00200082 f2996560 c04c0120 c0139fa3 dbd4db20 e57184bc d6224fe4 
Jan  1 18:05:12 core kernel:        00001ad7 d3d93fee 000280e9 f2996560 f29966bc df1cbe94 df1cbda0 d6507dcc 
Jan  1 18:05:12 core kernel:        df1cbeb8 c01d4a65 e57184bc c013a386 dbd4db20 00000000 d6aba200 00000001 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c0139fa3>] do_no_page+0x63/0x250
Jan  1 18:05:12 core kernel:  [<c01d4a65>] nfs_wait_on_inode+0xd5/0x1e0
Jan  1 18:05:12 core kernel:  [<c013a386>] handle_mm_fault+0xf6/0x170
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c010d34c>] do_page_fault+0x18c/0x599
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c01d4f64>] __nfs_revalidate_inode+0x74/0x360
Jan  1 18:05:12 core kernel:  [<c01545a7>] follow_mount+0x57/0xa0
Jan  1 18:05:12 core kernel:  [<c0155011>] link_path_walk+0x8e1/0xb60
Jan  1 18:05:12 core kernel:  [<c01d52ea>] nfs_revalidate_inode+0x4a/0x70
Jan  1 18:05:12 core kernel:  [<c01d4bd0>] nfs_getattr+0x60/0xa0
Jan  1 18:05:12 core kernel:  [<c01509f9>] vfs_getattr+0x39/0xa0
Jan  1 18:05:12 core kernel:  [<c0150aaf>] vfs_stat+0x4f/0x60
Jan  1 18:05:12 core kernel:  [<c01532d7>] pipe_read+0x37/0x40
Jan  1 18:05:12 core kernel:  [<c01511ab>] sys_stat64+0x1b/0x40
Jan  1 18:05:12 core kernel:  [<c0147ea1>] vfs_read+0xd1/0x130
Jan  1 18:05:12 core kernel:  [<c038944e>] schedule+0x2ce/0x4d0
Jan  1 18:05:12 core kernel:  [<c0148171>] sys_read+0x51/0x80
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: lsof          D C04C0120     0 12169      1         12171 12141 (NOTLB)
Jan  1 18:05:12 core kernel: de709da8 00200082 dfe36a80 c04c0120 c0139fa3 dbd4d6e0 d9115ee8 ef49dfe4 
Jan  1 18:05:12 core kernel:        000019ce 39260da8 000280f0 dfe36a80 dfe36bdc df1cbe94 df1cbda0 de709dcc 
Jan  1 18:05:12 core kernel:        df1cbeb8 c01d4a65 d9115ee8 c013a386 dbd4d6e0 00000000 d6aba200 00000001 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c0139fa3>] do_no_page+0x63/0x250
Jan  1 18:05:12 core kernel:  [<c01d4a65>] nfs_wait_on_inode+0xd5/0x1e0
Jan  1 18:05:12 core kernel:  [<c013a386>] handle_mm_fault+0xf6/0x170
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c010d34c>] do_page_fault+0x18c/0x599
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c01d4f64>] __nfs_revalidate_inode+0x74/0x360
Jan  1 18:05:12 core kernel:  [<c01545a7>] follow_mount+0x57/0xa0
Jan  1 18:05:12 core kernel:  [<c0155011>] link_path_walk+0x8e1/0xb60
Jan  1 18:05:12 core kernel:  [<c01d52ea>] nfs_revalidate_inode+0x4a/0x70
Jan  1 18:05:12 core kernel:  [<c01d4bd0>] nfs_getattr+0x60/0xa0
Jan  1 18:05:12 core kernel:  [<c01509f9>] vfs_getattr+0x39/0xa0
Jan  1 18:05:12 core kernel:  [<c0150aaf>] vfs_stat+0x4f/0x60
Jan  1 18:05:12 core kernel:  [<c01532d7>] pipe_read+0x37/0x40
Jan  1 18:05:12 core kernel:  [<c01511ab>] sys_stat64+0x1b/0x40
Jan  1 18:05:12 core kernel:  [<c0147ea1>] vfs_read+0xd1/0x130
Jan  1 18:05:12 core kernel:  [<c038944e>] schedule+0x2ce/0x4d0
Jan  1 18:05:12 core kernel:  [<c0148171>] sys_read+0x51/0x80
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: lsof          D C04C0120     0 12171      1         26379 12169 (NOTLB)
Jan  1 18:05:12 core kernel: ed273da8 00200082 dde78040 c04c0120 c0139fa3 eb16f740 d9115e40 de75efe4 
Jan  1 18:05:12 core kernel:        000019a1 bccd2773 000280f0 dde78040 dde7819c df1cbe94 df1cbda0 ed273dcc 
Jan  1 18:05:12 core kernel:        df1cbeb8 c01d4a65 d9115e40 c013a386 eb16f740 00000000 d6aba200 00000001 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c0139fa3>] do_no_page+0x63/0x250
Jan  1 18:05:12 core kernel:  [<c01d4a65>] nfs_wait_on_inode+0xd5/0x1e0
Jan  1 18:05:12 core kernel:  [<c013a386>] handle_mm_fault+0xf6/0x170
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c010d34c>] do_page_fault+0x18c/0x599
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c01d4f64>] __nfs_revalidate_inode+0x74/0x360
Jan  1 18:05:12 core kernel:  [<c01545a7>] follow_mount+0x57/0xa0
Jan  1 18:05:12 core kernel:  [<c0155011>] link_path_walk+0x8e1/0xb60
Jan  1 18:05:12 core kernel:  [<c01d52ea>] nfs_revalidate_inode+0x4a/0x70
Jan  1 18:05:12 core kernel:  [<c01d4bd0>] nfs_getattr+0x60/0xa0
Jan  1 18:05:12 core kernel:  [<c01509f9>] vfs_getattr+0x39/0xa0
Jan  1 18:05:12 core kernel:  [<c0150aaf>] vfs_stat+0x4f/0x60
Jan  1 18:05:12 core kernel:  [<c01532d7>] pipe_read+0x37/0x40
Jan  1 18:05:12 core kernel:  [<c01511ab>] sys_stat64+0x1b/0x40
Jan  1 18:05:12 core kernel:  [<c0147ea1>] vfs_read+0xd1/0x130
Jan  1 18:05:12 core kernel:  [<c038944e>] schedule+0x2ce/0x4d0
Jan  1 18:05:12 core kernel:  [<c0148171>] sys_read+0x51/0x80
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: smbd          D C04C0120     0 12172      1         13162  9058 (NOTLB)
Jan  1 18:05:12 core kernel: e1763c24 00000082 d696da40 c04c0120 f7cbdec0 c03762de d0130400 f7cbdec0 
Jan  1 18:05:12 core kernel:        000d4246 e30867f8 000280ff d696da40 d696db9c f7cbdec0 e1763c60 f7cbdf38 
Jan  1 18:05:12 core kernel:        e1763c40 c037800d f7cbdec0 00000000 da6b95f8 e1762000 00000000 00000000 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c03762de>] xprt_prepare_transmit+0x7e/0xc0
Jan  1 18:05:12 core kernel:  [<c037800d>] __rpc_execute+0x13d/0x3c0
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c0124c60>] autoremove_wake_function+0x0/0x60
Jan  1 18:05:12 core kernel:  [<c03786b6>] rpc_new_task+0x36/0xb0
Jan  1 18:05:12 core kernel:  [<c0373a24>] rpc_call_sync+0x74/0xb0
Jan  1 18:05:12 core kernel:  [<c01dd6fa>] nfs3_rpc_wrapper+0x3a/0x80
Jan  1 18:05:12 core kernel:  [<c01ddc9a>] nfs3_proc_access+0xda/0x170
Jan  1 18:05:12 core kernel:  [<c01bdc75>] __journal_file_buffer+0x175/0x230
Jan  1 18:05:12 core kernel:  [<c01bd02f>] journal_dirty_metadata+0xef/0x170
Jan  1 18:05:12 core kernel:  [<c037973c>] rpcauth_lookup_credcache+0x1cc/0x210
Jan  1 18:05:12 core kernel:  [<c01d29c5>] nfs_do_access+0x65/0xb0
Jan  1 18:05:12 core kernel:  [<c01d2b00>] nfs_permission+0xf0/0x170
Jan  1 18:05:12 core kernel:  [<c0154241>] permission+0x51/0x60
Jan  1 18:05:12 core kernel:  [<c01551c2>] link_path_walk+0xa92/0xb60
Jan  1 18:05:12 core kernel:  [<c0160120>] update_atime+0xd0/0xe0
Jan  1 18:05:12 core kernel:  [<c0154e0d>] link_path_walk+0x6dd/0xb60
Jan  1 18:05:12 core kernel:  [<c01554e0>] path_lookup+0x70/0x110
Jan  1 18:05:12 core kernel:  [<c0155733>] __user_walk+0x33/0x60
Jan  1 18:05:12 core kernel:  [<c0150a7f>] vfs_stat+0x1f/0x60
Jan  1 18:05:12 core kernel:  [<c01511ab>] sys_stat64+0x1b/0x40
Jan  1 18:05:12 core kernel:  [<c0103ee8>] math_state_restore+0x28/0x50
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: nmbd          S C04C0120     0 13162      1         13438 12172 (NOTLB)
Jan  1 18:05:12 core kernel: f6ef1eb4 00200086 f7d585a0 c04c0120 c473dc18 c012ff73 c132a260 00000000 
Jan  1 18:05:12 core kernel:        000169ae 1415a4e0 0002817a f7d585a0 f7d586fc 2a0aee26 f6ef1ec8 0000000b 
Jan  1 18:05:12 core kernel:        0000000b c03899e3 f6ef1ec8 2a0aee26 f6ec60c0 c04079d8 d5349ec8 2a0aee26 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c012ff73>] __get_free_pages+0x33/0x40
Jan  1 18:05:12 core kernel:  [<c03899e3>] schedule_timeout+0x63/0xc0
Jan  1 18:05:12 core kernel:  [<c011aa90>] process_timeout+0x0/0x10
Jan  1 18:05:12 core kernel:  [<c0159693>] do_select+0x173/0x2b0
Jan  1 18:05:12 core kernel:  [<c0159370>] __pollwait+0x0/0xd0
Jan  1 18:05:12 core kernel:  [<c0159abf>] sys_select+0x2bf/0x4d0
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: mutt          S C04C0150     0 13427  26545                     (NOTLB)
Jan  1 18:05:12 core kernel: e751ff10 00000086 d4370ae0 c04c0150 00028179 00000001 f32707b5 00028179 
Jan  1 18:05:12 core kernel:        00000f9a f3bf6150 00028179 f2996080 f29961dc 2a13ecb8 e751ff24 e751ff68 
Jan  1 18:05:12 core kernel:        000927c1 c03899e3 e751ff24 2a13ecb8 00000145 c04c61e0 c04c61e0 2a13ecb8 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c03899e3>] schedule_timeout+0x63/0xc0
Jan  1 18:05:12 core kernel:  [<c011aa90>] process_timeout+0x0/0x10
Jan  1 18:05:12 core kernel:  [<c0159e0a>] do_poll+0xaa/0xd0
Jan  1 18:05:12 core kernel:  [<c0159f82>] sys_poll+0x152/0x210
Jan  1 18:05:12 core kernel:  [<c01163fb>] sys_gettimeofday+0x3b/0x80
Jan  1 18:05:12 core kernel:  [<c0159370>] __pollwait+0x0/0xd0
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: xterm         S C04C0120     0 13438      1 13440         13162 (NOTLB)
Jan  1 18:05:12 core kernel: ca025eb4 00000082 f6fb1140 c04c0120 00000010 00000000 00000096 ec92f240 
Jan  1 18:05:12 core kernel:        00000b61 43a9a434 0002817b f6fb1140 f6fb129c 2a0adee6 ca025ec8 00000006 
Jan  1 18:05:12 core kernel:        00000006 c03899e3 ca025ec8 2a0adee6 f6805000 f57a7ec8 f0cf1ec8 2a0adee6 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c03899e3>] schedule_timeout+0x63/0xc0
Jan  1 18:05:12 core kernel:  [<c011aa90>] process_timeout+0x0/0x10
Jan  1 18:05:12 core kernel:  [<c0159693>] do_select+0x173/0x2b0
Jan  1 18:05:12 core kernel:  [<c0159370>] __pollwait+0x0/0xd0
Jan  1 18:05:12 core kernel:  [<c0159abf>] sys_select+0x2bf/0x4d0
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: bash          S C04C0150     0 13440  13438 13443               (NOTLB)
Jan  1 18:05:12 core kernel: f4179f1c 00000086 d3a0db00 c04c0150 0002813e f30432a0 27a9401d 0002813e 
Jan  1 18:05:12 core kernel:        0002baaf 27a9401d 0002813e f6fb1620 f6fb177c fffffe00 f6fb1620 f6fb16c4 
Jan  1 18:05:12 core kernel:        f6fb16c4 c01159cd ffffffff 00000006 f1b15100 f4179f50 00000292 00030002 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c01159cd>] do_wait+0x18d/0x460
Jan  1 18:05:12 core kernel:  [<c010f740>] default_wake_function+0x0/0x20
Jan  1 18:05:12 core kernel:  [<c010f740>] default_wake_function+0x0/0x20
Jan  1 18:05:12 core kernel:  [<c022cf2e>] copy_to_user+0x3e/0x50
Jan  1 18:05:12 core kernel:  [<c0115d6f>] sys_wait4+0x3f/0x50
Jan  1 18:05:12 core kernel:  [<c0115da7>] sys_waitpid+0x27/0x2b
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb
Jan  1 18:05:12 core kernel: bash          S C04C0150     0 13443  13440                     (NOTLB)
Jan  1 18:05:12 core kernel: f169fe70 00000086 f6fb1140 c04c0150 00028143 c038944e 600f9ce1 00028143 
Jan  1 18:05:12 core kernel:        000013b7 60106e9a 00028143 f1b15100 f1b1525c e000f000 7fffffff edbe8000 
Jan  1 18:05:12 core kernel:        c081dc40 c0389a35 00000002 e7593c0f c0272c48 f6805000 e7593c11 00000000 
Jan  1 18:05:12 core kernel: Call Trace:
Jan  1 18:05:12 core kernel:  [<c038944e>] schedule+0x2ce/0x4d0
Jan  1 18:05:12 core kernel:  [<c0389a35>] schedule_timeout+0xb5/0xc0
Jan  1 18:05:12 core kernel:  [<c0272c48>] pty_write+0x68/0x70
Jan  1 18:05:12 core kernel:  [<c0271a73>] read_chan+0x5e3/0x6f0
Jan  1 18:05:12 core kernel:  [<c0271cdd>] write_chan+0x15d/0x210
Jan  1 18:05:12 core kernel:  [<c010f740>] default_wake_function+0x0/0x20
Jan  1 18:05:12 core kernel:  [<c010f740>] default_wake_function+0x0/0x20
Jan  1 18:05:12 core kernel:  [<c026c94e>] tty_write+0x20e/0x260
Jan  1 18:05:12 core kernel:  [<c026c721>] tty_read+0xe1/0x100
Jan  1 18:05:12 core kernel:  [<c0147e88>] vfs_read+0xb8/0x130
Jan  1 18:05:12 core kernel:  [<c0148171>] sys_read+0x51/0x80
Jan  1 18:05:12 core kernel:  [<c010254b>] syscall_call+0x7/0xb

I was not able to reproduce as of now, because i have to use the system.

Christian Leber

-- 
http://www.nosoftwarepatents.com


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWARMlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWARMlj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWARMlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:41:39 -0500
Received: from tornado.reub.net ([202.89.145.182]:8333 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932279AbWARMlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:41:37 -0500
Message-ID: <43CE377B.1030703@reub.net>
Date: Thu, 19 Jan 2006 01:41:31 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm1
References: <20060118005053.118f1abc.akpm@osdl.org>
In-Reply-To: <20060118005053.118f1abc.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/18/2006 09:50 PM, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm1/
> 
> - There are a lot of reiser3 features and fixes here.  Please test with
>   caution, but please test.

Indeed there are!

This was first, about 15 mins after the partition was mounted:

Jan 19 01:24:32 tornado kernel: ReiserFS: sdb8: warning: vs-4080:
reiserfs_free_block: free_block (sdb8:9217)[dev:blocknr]: bit already cleared
Jan 19 01:24:32 tornado kernel: ReiserFS: sdb8: warning: vs-4080:
reiserfs_free_block: free_block (sdb8:9122)[dev:blocknr]: bit already cleared
Jan 19 01:24:32 tornado kernel: ReiserFS: sdb8: warning: vs-4080:
reiserfs_free_block: free_block (sdb8:9121)[dev:blocknr]: bit already cleared
Jan 19 01:24:32 tornado kernel: ReiserFS: sdb8: warning: vs-4080:
reiserfs_free_block: free_block (sdb8:9120)[dev:blocknr]: bit already cleared
Jan 19 01:24:32 tornado kernel: ReiserFS: sdb8: warning: vs-4080:
reiserfs_free_block: free_block (sdb8:9119)[dev:blocknr]: bit already cleared
Jan 19 01:24:32 tornado kernel: ReiserFS: sdb8: warning: vs-4080:
reiserfs_free_block: free_block (sdb8:9118)[dev:blocknr]: bit already cleared
Jan 19 01:24:32 tornado kernel: ReiserFS: sdb8: warning: vs-4080:
reiserfs_free_block: free_block (sdb8:9117)[dev:blocknr]: bit already cleared
Jan 19 01:24:32 tornado kernel: ReiserFS: sdb8: warning: vs-4080:
reiserfs_free_block: free_block (sdb8:9116)[dev:blocknr]: bit already cleared
Jan 19 01:24:32 tornado kernel: ReiserFS: sdb8: warning: vs-4080:
reiserfs_free_block: free_block (sdb8:8235)[dev:blocknr]: bit already cleared

Then some "bad stuff" (tm) really hit the fan:

Jan 19 01:24:35 tornado kernel: ------------[ cut here ]------------
Jan 19 01:24:35 tornado kernel: kernel BUG at fs/reiserfs/journal.c:1451!
Jan 19 01:24:35 tornado kernel: invalid opcode: 0000 [#1]
Jan 19 01:24:35 tornado kernel: SMP
Jan 19 01:24:35 tornado kernel: last sysfs file:
/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002e/vrm
Jan 19 01:24:35 tornado kernel: Modules linked in: nfsd exportfs lockd sunrpc
lm85 hwmon_vid eeprom ipv6 ip_gre ipt_ECN iptable_mangle iptable_nat ip_nat
ip_conntrack nfnetlink iptable_filter ip_tables binfmt_misc serio_raw hw_random
piix i2c_i801
Jan 19 01:24:35 tornado kernel: CPU:    0
Jan 19 01:24:35 tornado kernel: EIP:    0060:[<b01af240>]    Not tainted VLI
Jan 19 01:24:35 tornado kernel: EFLAGS: 00210202   (2.6.16-rc1-mm1)
Jan 19 01:24:35 tornado kernel: EIP is at flush_journal_list+0x55e/0x71d
Jan 19 01:24:35 tornado kernel: eax: 00000001   ebx: f0d0feb0   ecx: 00000000
edx: 00000000
Jan 19 01:24:35 tornado kernel: esi: b5a30724   edi: c17694c0   ebp: efd25cf8
esp: efd25cac
Jan 19 01:24:35 tornado kernel: ds: 007b   es: 007b   ss: 0068
Jan 19 01:24:36 tornado kernel: Process pdflush (pid: 158, threadinfo=efd25000
task=efd21030)
Jan 19 01:24:36 tornado kernel: Stack: <0>000080ad 00000001 b036f1e0 b1806060
eea1dc40 00000000 00000000 ee16d800
Jan 19 01:24:36 tornado kernel:        00000001 00000000 b03e7604 f0cf1000
00000002 00200246 f0cf914c 00000000
Jan 19 01:24:36 tornado kernel:        f0cf1000 f0cf1114 c0b86f40 efd25d4c
b01aef78 00000000 000004e9 b0375600
Jan 19 01:24:36 tornado kernel: Call Trace:
Jan 19 01:24:36 tornado kernel:  [<b0103bd5>] show_stack_log_lvl+0xc5/0xea
Jan 19 01:24:36 tornado kernel:  [<b0103d61>] show_registers+0x167/0x1ec
Jan 19 01:24:36 tornado kernel:  [<b0103f0c>] die+0x126/0x231
Jan 19 01:24:36 tornado kernel:  [<b010408a>] do_trap+0x73/0x9e
Jan 19 01:24:36 tornado kernel:  [<b010496a>] do_invalid_op+0x97/0xa1
Jan 19 01:24:36 tornado kernel:  [<b0103717>] error_code+0x4f/0x54
Jan 19 01:24:36 tornado kernel:  [<b01aef78>] flush_journal_list+0x296/0x71d
Jan 19 01:24:37 tornado kernel:  [<b01af623>] flush_used_journal_lists+0x224/0x35c
Jan 19 01:24:37 tornado kernel:  [<b01b148e>] do_journal_end+0x9f6/0xc20
Jan 19 01:24:37 tornado kernel:  [<b01b171d>] journal_end_sync+0x65/0x77
Jan 19 01:24:37 tornado kernel:  [<b01a1500>] reiserfs_sync_fs+0x57/0x64
Jan 19 01:24:37 tornado kernel:  [<b01a151a>] reiserfs_write_super+0xd/0xf
Jan 19 01:24:37 tornado kernel:  [<b015e6ba>] sync_supers+0xbe/0x103
Jan 19 01:24:37 tornado kernel:  [<b01414c8>] wb_kupdate+0x38/0x13f
Jan 19 01:24:37 tornado kernel:  [<b0141ed2>] pdflush+0xd1/0x1b4
Jan 19 01:24:37 tornado kernel:  [<b012e7b7>] kthread+0xa5/0xca
Jan 19 01:24:37 tornado kernel:  [<b0100d25>] kernel_thread_helper+0x5/0xb
Jan 19 01:24:37 tornado kernel: Code: 45 d0 e8 3e e8 ff ff 89 45 f0 85 c0 0f 85
0a 01 00 00 8b 4d d0 8b 81 f8 01 00 00 e9 6a fd ff ff 89 d8 e8 67 e3 ff ff 85 c0
74 0a <0f> 0b ab 05 4f 78 33 b0 31 c0 c7 45 dc 00 00 00 00 e9 1a ff ff
Jan 19 01:24:37 tornado kernel:  Badness in do_exit at kernel/exit.c:799
Jan 19 01:24:37 tornado kernel:  [<b01040d1>] show_trace+0xd/0xf
Jan 19 01:24:37 tornado kernel:  [<b0104172>] dump_stack+0x17/0x19
Jan 19 01:24:37 tornado kernel:  [<b011f87c>] do_exit+0x83a/0x83f
Jan 19 01:24:37 tornado kernel:  [<b0104017>] do_trap+0x0/0x9e
Jan 19 01:24:37 tornado kernel:  [<b010408a>] do_trap+0x73/0x9e
Jan 19 01:24:37 tornado kernel:  [<b010496a>] do_invalid_op+0x97/0xa1
Jan 19 01:24:37 tornado kernel:  [<b0103717>] error_code+0x4f/0x54
Jan 19 01:24:37 tornado kernel:  [<b01aef78>] flush_journal_list+0x296/0x71d
Jan 19 01:24:37 tornado kernel:  [<b01af623>] flush_used_journal_lists+0x224/0x35c
Jan 19 01:24:37 tornado kernel:  [<b01b148e>] do_journal_end+0x9f6/0xc20
Jan 19 01:24:38 tornado kernel:  [<b01b171d>] journal_end_sync+0x65/0x77
Jan 19 01:24:38 tornado kernel:  [<b01a1500>] reiserfs_sync_fs+0x57/0x64
Jan 19 01:24:38 tornado kernel:  [<b01a151a>] reiserfs_write_super+0xd/0xf
Jan 19 01:24:38 tornado kernel:  [<b015e6ba>] sync_supers+0xbe/0x103
Jan 19 01:24:38 tornado kernel:  [<b01414c8>] wb_kupdate+0x38/0x13f
Jan 19 01:24:38 tornado kernel:  [<b0141ed2>] pdflush+0xd1/0x1b4
Jan 19 01:24:38 tornado kernel:  [<b012e7b7>] kthread+0xa5/0xca
Jan 19 01:24:38 tornado kernel:  [<b0100d25>] kernel_thread_helper+0x5/0xb

Think I'll go quietly retreat to -rc1 on that box now and have a fiddle with my 
x86_64 box instead ;-)

reuben


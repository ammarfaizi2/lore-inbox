Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271939AbTHNWOT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 18:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271943AbTHNWOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 18:14:18 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:48296 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S271939AbTHNWOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 18:14:15 -0400
Date: Fri, 15 Aug 2003 00:14:11 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Subject: reiserfs corruption with 2.6.0-test
Message-ID: <20030814221411.GA3916@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had some file system corruption on one partition today. When programs
tried to open certain files, they segfaulted and after that the whole
system came down hard. No idea how the corruption happened -- until
today I haven't had a kernel crash for a long time.

Both 2.6.0-test3 and -test2 produced kernel NULL pointer dereferences with
those files. fsck found the corruption fixable. Works again now.

Back traces attached for your viewing pleasure.

Roger

------------------------------------------------------------------------------
Unable to handle kernel NULL pointer dereference at virtual address 00000018
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01eed9c>]    Not tainted
EFLAGS: 00010206
EIP is at _mmx_memcpy+0x5c/0x150
eax: f778c018   ebx: 00000008   ecx: 00000000   edx: 00000000
esi: 00000018   edi: f778c018   ebp: e2cd3934   esp: e2cd3924
ds: 007b   es: 007b   ss: 0068
Process unison (pid: 3846, threadinfo=e2cd2000 task=f694b5c0)
Stack: f778c018 00000210 00000018 f778c227 e2cd3984 c01d2991 f778c018 00000018 
       00000210 f778c018 f778c000 00000284 f7788240 00000000 0000fd98 00006972 
       f778e450 00000016 00000000 f778e360 e2cd39e0 00000016 00000001 00000000 
Call Trace:
 [<c01d2991>] leaf_copy_items_entirely+0x271/0x290
 [<c01d2faa>] leaf_copy_items+0xda/0x190
 [<c01d327b>] leaf_move_items+0x5b/0xa0
 [<c01d33a8>] leaf_shift_right+0x38/0x80
 [<c01bc0e6>] balance_leaf+0x3d6/0x2aa0
 [<c0146e50>] find_get_page+0x70/0x140
 [<c0173040>] bh_lru_install+0xa0/0xd0
 [<c01cb3aa>] get_parents+0xca/0x190
 [<c01730b6>] __find_get_block+0x46/0xb0
 [<c01ccca0>] clear_all_dirty_bits+0x20/0x30
 [<c01cce82>] wait_tb_buffers_until_unlocked+0x1d2/0x380
 [<c01beb44>] do_balance+0x94/0x110
 [<c01cd1ff>] fix_nodes+0x1cf/0x420
 [<c01d943d>] reiserfs_paste_into_item+0x11d/0x130
 [<c01bf9ec>] reiserfs_add_entry+0x34c/0x500
 [<c01bfd57>] reiserfs_create+0x107/0x190
 [<c018112f>] permission+0x2f/0x50
 [<c0182e6b>] vfs_create+0x6b/0xc0
 [<c0183467>] open_namei+0x3e7/0x450
 [<c016dbc1>] filp_open+0x41/0x70
 [<c016e333>] sys_open+0x53/0x90
 [<c0109eff>] syscall_call+0x7/0xb

Code: 0f 6f 06 0f 6f 4e 08 0f 6f 56 10 0f 6f 5e 18 0f 7f 00 0f 7f 
 is_tree_node: node level 12084 does not match to the expected one 3
vs-5150: search_by_key: invalid format found in block 8213. Fsck?
zam-7001: io error in reiserfs_find_entry
is_tree_node: node level 12084 does not match to the expected one 3
vs-5150: search_by_key: invalid format found in block 8213. Fsck?
zam-7001: io error in reiserfs_find_entry
SysRq : Emergency Sync
------------------------------------------------------------------------------
<1>Unable to handle kernel NULL pointer dereference at virtual address 00000030
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<f9aec8e8>]    Not tainted
EFLAGS: 00010046
EIP is at rh_report_status+0xe8/0x370 [usbcore]
eax: 00000000   ebx: c1d5e524   ecx: f7bca944   edx: f6a03688
esi: 00000282   edi: c0313460   ebp: f6a03660   esp: f6a03634
ds: 007b   es: 007b   ss: 0068
Process unison (pid: 3577, threadinfo=f6a02000 task=f6cb4e80)
Stack: 00000001 00000000 f6a0365c c012ce86 00000000 00000001 c03144b0 f6a036f8 
       c1d5e524 f9aec800 c0313460 f6a036a0 c012d00d c1d5e524 f6a0369c c0111a6a 
       f6a036f8 f6a036c8 c01d53ed 00000000 f6a03688 f6a03688 f6a03688 c0312210 
Call Trace:
 [<c012ce86>] update_process_times+0x46/0x50
 [<f9aec800>] rh_report_status+0x0/0x370 [usbcore]
 [<c012d00d>] run_timer_softirq+0x15d/0x3e0
 [<c0111a6a>] timer_interrupt+0x8a/0x250
 [<c01d53ed>] leaf_insert_into_buf+0x18d/0x280
 [<c0127e25>] do_softirq+0xa5/0xb0
 [<c010c12d>] do_IRQ+0x20d/0x350
 [<c010a0dc>] common_interrupt+0x18/0x20
 [<c0116e64>] delay_tsc+0x14/0x20
 [<c01f0b44>] __delay+0x14/0x20
 [<c0223632>] serial8250_console_write+0xa2/0x230
 [<c0122e90>] __call_console_drivers+0x60/0x70
 [<c0122f6c>] call_console_drivers+0x5c/0x120
 [<c01235b5>] release_console_sem+0xf5/0x270
 [<c01232ff>] printk+0x25f/0x3c0
 [<c01f0d4c>] _mmx_memcpy+0x5c/0x150
 [<c011a8f3>] do_page_fault+0x213/0x4aa
 [<c0123eb1>] profile_hook+0x21/0x23
 [<c0111a6a>] timer_interrupt+0x8a/0x250
 [<c010c12d>] do_IRQ+0x20d/0x350
 [<c011a6e0>] do_page_fault+0x0/0x4aa
 [<c010a119>] error_code+0x2d/0x38
 [<c01f0d4c>] _mmx_memcpy+0x5c/0x150
 [<c01d4661>] leaf_copy_items_entirely+0x271/0x290
 [<c01d4c7a>] leaf_copy_items+0xda/0x190
 [<c01d4f4b>] leaf_move_items+0x5b/0xa0
 [<c01d5078>] leaf_shift_right+0x38/0x80
 [<c01bdd46>] balance_leaf+0x3d6/0x2aa0
 [<c0148040>] find_get_page+0x70/0x140
 [<c0174610>] bh_lru_install+0xa0/0xd0
 [<c01cd07a>] get_parents+0xca/0x190
 [<c0174686>] __find_get_block+0x46/0xb0
 [<c01ce970>] clear_all_dirty_bits+0x20/0x30
 [<c01ceb52>] wait_tb_buffers_until_unlocked+0x1d2/0x380
 [<c01c07a4>] do_balance+0x94/0x110
 [<c01ceecf>] fix_nodes+0x1cf/0x420
 [<c01db10d>] reiserfs_paste_into_item+0x11d/0x130
 [<c01c164c>] reiserfs_add_entry+0x34c/0x500
 [<c01c19b7>] reiserfs_create+0x107/0x190
 [<c018279f>] permission+0x2f/0x50
 [<c01844db>] vfs_create+0x6b/0xc0
 [<c0184ad7>] open_namei+0x3e7/0x450
 [<c016f0d1>] filp_open+0x41/0x70
 [<c016f843>] sys_open+0x53/0x90
 [<c0109f6f>] syscall_call+0x7/0xb

Code: 8b 78 30 85 ff 0f 84 78 ff ff ff 8b 97 34 01 00 00 8b 43 3c 
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing
------------------------------------------------------------------------------

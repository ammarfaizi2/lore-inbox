Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTLHXoc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 18:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTLHXob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 18:44:31 -0500
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:21165 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id S261974AbTLHXma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 18:42:30 -0500
Date: Mon, 8 Dec 2003 15:42:26 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test11] Ext3 journalling Oops on file system error
Message-ID: <20031208234226.GA15389@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like a slightly broken error handling case.  The file system was
marked as having errors before because of a failure caused by cabling
issues (grumble), and I had skipped the fsck accidentally. Anyway, it
might be worth investigating.  No other errors occurred before this
since boot.

EXT3-fs error (device md0): ext3_free_blocks: bit already cleared for block 403020800
Aborting journal on device md0.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0198ce7
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[do_get_write_access+39/1632]    Not tainted
EFLAGS: 00010246
EIP is at do_get_write_access+0x27/0x660
eax: dc842df0   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: c56a0280   edi: cac155ec   ebp: c56a0280   esp: dbfd7c58
ds: 007b   es: 007b   ss: 0068
Process mirrordir (pid: 702, threadinfo=dbfd6000 task=dbbce6b0)
Stack: 07c4c509 00000000 07c4c509 00000000 00000800 dffd23c0 00000000 00000000
       07c4c509 00000000 00000800 00000001 00000000 dc842df0 07c4c509 c0190340
       dffd23c0 00000000 c56a0280 cac155ec dbfd7d00 c0199357 dc842df0 c56a0280
Call Trace:
 [ext3_get_inode_loc+96/640] ext3_get_inode_loc+0x60/0x280
 [journal_get_write_access+55/80] journal_get_write_access+0x37/0x50
 [ext3_reserve_inode_write+85/208] ext3_reserve_inode_write+0x55/0xd0
 [ext3_mark_inode_dirty+43/96] ext3_mark_inode_dirty+0x2b/0x60
 [ext3_dirty_inode+140/144] ext3_dirty_inode+0x8c/0x90
 [__mark_inode_dirty+246/256] __mark_inode_dirty+0xf6/0x100
 [inode_update_time+206/224] inode_update_time+0xce/0xe0   
 [generic_file_aio_write_nolock+648/2896] generic_file_aio_write_nolock+0x288/0xb50
 [__copy_to_user_ll+112/128] __copy_to_user_ll+0x70/0x80
 [file_read_actor+225/256] file_read_actor+0xe1/0x100   
 [do_generic_mapping_read+317/1024] do_generic_mapping_read+0x13d/0x400
 [__generic_file_aio_read+552/608] __generic_file_aio_read+0x228/0x260 
 [file_read_actor+0/256] file_read_actor+0x0/0x100
 [generic_file_aio_write+115/160] generic_file_aio_write+0x73/0xa0
 [ext3_file_write+68/208] ext3_file_write+0x44/0xd0
 [do_sync_write+137/192] do_sync_write+0x89/0xc0   
 [ip_rcv+393/592] ip_rcv+0x189/0x250
 [ip_rcv_finish+0/614] ip_rcv_finish+0x0/0x266
 [netif_receive_skb+338/400] netif_receive_skb+0x152/0x190
 [recalc_task_prio+168/464] recalc_task_prio+0xa8/0x1d0   
 [schedule+827/1632] schedule+0x33b/0x660
 [vfs_write+184/304] vfs_write+0xb8/0x130
 [sys_write+66/112] sys_write+0x42/0x70  
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 8b 02 f6 00 02 0f 85 1d 06 00 00 89 d7 89 c6 8b 5d 00 f0 0f
 <2>EXT3-fs error (device md0): ext3_free_blocks: bit already cleared for block 403020801
ext3_abort called.
EXT3-fs abort (device md0): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only
EXT3-fs error (device md0) in start_transaction: Journal has aborted
Dec  8 14:01:45 alfie last message repeated 126 times

Simon-

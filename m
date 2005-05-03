Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVECO5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVECO5U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVECO5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:57:19 -0400
Received: from levante.wiggy.net ([195.85.225.139]:28357 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261714AbVECO4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:56:02 -0400
Date: Tue, 3 May 2005 16:55:56 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com
Subject: 2.6.11.7 ext3 oops
Message-ID: <20050503145556.GD10552@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, sct@redhat.com,
	akpm@osdl.org, adilger@clusterfs.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Might be ACL related since the most actively used ext3 filesystem uses
ACLs. Machine is a standard i386 box (VALinux 2250 to be exact) running
unpatched 2.6.11.7.

Unable to handle kernel NULL pointer dereference at virtual address 00000014
 printing eip:
c01ce44d
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: e100 eepro100 mii unix
CPU:    0
EIP:    0060:[<c01ce44d>]    Not tainted VLI
EFLAGS: 00010246   (2.6.11.7)
EIP is at journal_dirty_metadata+0x5d/0x1f0
eax: 00000000   ebx: cfe771a0   ecx: 00000000   edx: 00000000
esi: f0599dac   edi: f4c74e00   ebp: cc365a38   esp: eb963d58
ds: 007b   es: 007b   ss: 0068
Process patch (pid: 2011, threadinfo=eb962000 task=ca3d7560)
Stack: 00000000 eb963de0 c01d4fb8 c1998ba0 f2ee220c 00000000 e2282000 e346e478
       e2282080 e346e540 c01bf864 cc365a38 f0599dac c01cde01 f2ee220c f2ee220c
       00000000 00000000 00000000 00000000 f0599dac eb963de0 e346e540 cc365a38
Call Trace:
 [<c01d4fb8>] journal_free_journal_head+0x18/0x20
 [<c01bf864>] ext3_do_update_inode+0x164/0x3d0
 [<c01cde01>] journal_get_write_access+0x41/0x50
 [<c01bfdb9>] ext3_mark_iloc_dirty+0x29/0x40
 [<c01bfef0>] ext3_mark_inode_dirty+0x50/0x60
 [<c01cc40e>] ext3_set_acl+0x9e/0x1d0
 [<c015874b>] __getblk+0x2b/0x60
 [<c01cc6bd>] ext3_init_acl+0xfd/0x1a0
 [<c01bb8ae>] ext3_new_inode+0x51e/0x6f0
 [<c01c2e04>] ext3_create+0x74/0xf0
 [<c0164f07>] vfs_create+0x87/0xd0
 [<c0165751>] open_namei+0x5f1/0x650
 [<c010ccb9>] mark_offset_tsc+0x1d9/0x2d0
 [<c0154dbe>] filp_open+0x3e/0x70
 [<c0155092>] get_unused_fd+0xa2/0xd0
 [<c01551b9>] sys_open+0x49/0x90
 [<c0102783>] syscall_call+0x7/0xb
Code: 13 19 c0 85 c0 74 20 8d b4 26 00 00 00 00 0f ba 26 13 19 c0 85 c0 0f 85 93 01 00 00 f0 0f
 ba 2e 13 19 c0 85 c0 75 e7 8b 54 24 14 <39> 5a 14 0f 84 2b 01 00 00 f0 0f ba 2e 12 8b 54 24 14
 8b 42 14
 <0>Assertion failure in __journal_file_buffer() at fs/jbd/transaction.c:1915: "jh->b_transacti
on == transaction || jh->b_transaction == 0"
------------[ cut here ]------------
kernel BUG at fs/jbd/transaction.c:1915!
invalid operand: 0000 [#2]
SMP
Modules linked in: e100 eepro100 mii unix
CPU:    0
EIP:    0060:[<c01cf580>]    Not tainted VLI
EFLAGS: 00010296   (2.6.11.7)
EIP is at __journal_file_buffer+0x220/0x2d0
eax: 0000008b   ebx: ec0c9dac   ecx: c0363510   edx: 00000292
esi: 00000005   edi: cfe77c20   ebp: f11f1cec   esp: f3e79d54
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 934, threadinfo=f3e78000 task=f48b3580)
Stack: c0328d60 c0311c68 c0321fdf 0000077b c032b960 00000000 00000000 cfe77c20
       ec0c9dac 00000000 00000000 c01cf685 ec0c9dac cfe77c20 00000005 e59acefc
       c1279cc0 c01d350f ec0c9dac cfe77c20 00000005 00000003 c01d39a1 e037968c
Call Trace:
 [<c01cf685>] journal_file_buffer+0x55/0x90
 [<c01d350f>] journal_write_metadata_buffer+0x28f/0x380
 [<c01d39a1>] journal_next_log_block+0x61/0xd0
 [<c01d05ef>] journal_commit_transaction+0xc5f/0x11d0
 [<c012e070>] autoremove_wake_function+0x0/0x60
 [<c012e070>] autoremove_wake_function+0x0/0x60
 [<c01d2f65>] kjournald+0xe5/0x240
 [<c012e070>] autoremove_wake_function+0x0/0x60
 [<c012e070>] autoremove_wake_function+0x0/0x60
 [<c0102692>] ret_from_fork+0x6/0x14
 [<c01d2e60>] commit_timeout+0x0/0x10
 [<c01d2e80>] kjournald+0x0/0x240
 [<c01009e5>] kernel_thread_helper+0x5/0x10
Code: 32 c0 b8 60 b9 32 c0 89 44 24 10 b8 7b 07 00 00 89 44 24 0c b8 df 1f 32 c0 89 44 24 08 b8 68 1c 31 c0 89 44 24 04 e8 a0 a0 f4 ff <0f> 0b 7b 07 df 1f 32 c0 8b 43 14 85 c0 0f 84 2a fe ff ff 39 73

End Data


-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

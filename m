Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUFRHTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUFRHTQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 03:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUFRHTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 03:19:16 -0400
Received: from ns.sgtp.samara.ru ([195.128.153.202]:63716 "EHLO sgtp.samara.ru")
	by vger.kernel.org with ESMTP id S265031AbUFRHTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 03:19:02 -0400
Subject: reiserfs acl bug
From: Alex Murphy <murphy@sgtp.samara.ru>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: SYS.NET.RU
Message-Id: <1087543131.7539.3.camel@bene.samgtp>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 12:18:51 +0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !!
 im use 2.6.6 kernel, and creating reiserfs & aupport xattr, copy this
particion nedd file - trap and bug:

------- /var/log/messages -------
Jun 18 09:44:03 msa kernel: ReiserFS: dm-10: found reiserfs format "3.6"
with standard journal
Jun 18 09:44:03 msa kernel: ReiserFS: dm-10: using ordered data mode
Jun 18 09:44:03 msa kernel: ReiserFS: dm-10: journal params: device
dm-10, size 8192, journal first block 18, max trans len 1024, max batch
900, max commit age 30, max trans age 30
Jun 18 09:44:03 msa kernel: ReiserFS: dm-10: checking transaction log
(dm-10)
Jun 18 09:44:03 msa kernel: ReiserFS: dm-10: Using r5 hash to sort names
Jun 18 09:44:03 msa kernel: ReiserFS: dm-10: warning: Created
.reiserfs_priv on dm-10 - reserved for xattr storage.
Jun 18 09:45:55 msa kernel: ------------[ cut here ]------------
Jun 18 09:45:55 msa kernel: kernel BUG at fs/reiserfs/journal.c:524!
Jun 18 09:45:55 msa kernel: invalid operand: 0000 [#1]
Jun 18 09:45:55 msa kernel: SMP 
Jun 18 09:45:55 msa kernel: Modules linked in: lpfc
Jun 18 09:45:55 msa kernel: CPU:    0
Jun 18 09:45:55 msa kernel: EIP:   
0060:[reiserfs_in_journal+277/490]    Not tainted VLI
Jun 18 09:45:55 msa kernel: EIP:    0060:[<c01a3e2c>]    Not tainted VLI
Jun 18 09:45:55 msa kernel: EFLAGS: 00010282   (2.6.6-mm5) 
Jun 18 09:45:55 msa kernel: EIP is at reiserfs_in_journal+0x115/0x1ea
Jun 18 09:45:55 msa kernel: eax: 00000000   ebx: f8b6f11c   ecx:
00001310   edx: f8b9d440
Jun 18 09:45:55 msa kernel: esi: 00200000   edi: 00200000   ebp:
eb181638   esp: eb37dbb8
Jun 18 09:45:55 msa kernel: ds: 007b   es: 007b   ss: 0068
Jun 18 09:45:55 msa kernel: Process mc (pid: 10931, threadinfo=eb37c000
task=eb1516b0)
Jun 18 09:45:55 msa kernel: Stack: 001f8001 00000000 f7990800 e11b6000
eb37dc50 00000000 00000000 c0182c68 
Jun 18 09:45:55 msa kernel:        00000001 eb37dc08 0002425f 00000000
f8b21200 00000000 e11b6000 00000000 
Jun 18 09:45:55 msa kernel:        f7990800 00000040 eb37ded8 00000000
00000000 00000040 00000000 00000001 
Jun 18 09:45:55 msa kernel: Call Trace:
Jun 18 09:45:55 msa kernel:  [scan_bitmap_block+616/768]
scan_bitmap_block+0x268/0x300
Jun 18 09:45:55 msa kernel:  [<c0182c68>] scan_bitmap_block+0x268/0x300
Jun 18 09:45:55 msa kernel:  [scan_bitmap+298/528]
scan_bitmap+0x12a/0x210
Jun 18 09:45:55 msa kernel:  [<c0182edc>] scan_bitmap+0x12a/0x210
Jun 18 09:45:55 msa kernel:  [reiserfs_allocate_blocknrs+806/1383]
reiserfs_allocate_blocknrs+0x326/0x567
Jun 18 09:45:55 msa kernel:  [<c018414f>]
reiserfs_allocate_blocknrs+0x326/0x567
Jun 18 09:45:55 msa kernel: 
[reiserfs_allocate_blocks_for_region+524/5280]
reiserfs_allocate_blocks_for_region+0x20c/0x14a0
Jun 18 09:45:55 msa kernel:  [<c018fafe>]
reiserfs_allocate_blocks_for_region+0x20c/0x14a0
Jun 18 09:45:55 msa kernel:  [inode2sd+204/281] inode2sd+0xcc/0x119
Jun 18 09:45:55 msa kernel:  [<c018c735>] inode2sd+0xcc/0x119
Jun 18 09:45:55 msa kernel:  [autoremove_wake_function+0/67]
autoremove_wake_function+0x0/0x43
Jun 18 09:45:55 msa kernel:  [<c01187e9>]
autoremove_wake_function+0x0/0x43
Jun 18 09:45:55 msa kernel:  [search_for_position_by_key+417/997]
search_for_position_by_key+0x1a1/0x3e5
Jun 18 09:45:55 msa kernel:  [<c019f6b3>]
search_for_position_by_key+0x1a1/0x3e5
Jun 18 09:45:55 msa kernel:  [buffered_rmqueue+248/469]
buffered_rmqueue+0xf8/0x1d5
Jun 18 09:45:55 msa kernel:  [<c0133ec5>] buffered_rmqueue+0xf8/0x1d5
Jun 18 09:45:55 msa kernel:  [__alloc_pages+694/754]
__alloc_pages+0x2b6/0x2f2
Jun 18 09:45:55 msa kernel:  [<c0134258>] __alloc_pages+0x2b6/0x2f2
Jun 18 09:45:55 msa kernel:  [make_cpu_key+75/91] make_cpu_key+0x4b/0x5b
Jun 18 09:45:55 msa kernel:  [<c018a4c9>] make_cpu_key+0x4b/0x5b
Jun 18 09:45:55 msa kernel:  [pathrelse+29/43] pathrelse+0x1d/0x2b
Jun 18 09:45:55 msa kernel:  [<c019e0e9>] pathrelse+0x1d/0x2b
Jun 18 09:45:55 msa kernel: 
[reiserfs_prepare_file_region_for_write+854/2313]
reiserfs_prepare_file_region_for_write+0x356/0x909
Jun 18 09:45:55 msa kernel:  [<c019191b>]
reiserfs_prepare_file_region_for_write+0x356/0x909
Jun 18 09:45:55 msa kernel:  [reiserfs_file_write+1195/1705]
reiserfs_file_write+0x4ab/0x6a9
Jun 18 09:45:55 msa kernel:  [<c0192379>]
reiserfs_file_write+0x4ab/0x6a9
Jun 18 09:45:55 msa kernel:  [__generic_file_aio_read+461/511]
__generic_file_aio_read+0x1cd/0x1ff
Jun 18 09:45:55 msa kernel:  [<c0130fb1>]
__generic_file_aio_read+0x1cd/0x1ff
Jun 18 09:45:55 msa kernel:  [generic_file_read+112/142]
generic_file_read+0x70/0x8e
Jun 18 09:45:55 msa kernel:  [<c01310b4>] generic_file_read+0x70/0x8e
Jun 18 09:45:55 msa kernel:  [do_sigaction+376/494]
do_sigaction+0x178/0x1ee
Jun 18 09:45:55 msa kernel:  [<c0124a2a>] do_sigaction+0x178/0x1ee
Jun 18 09:45:55 msa kernel:  [sys_rt_sigaction+112/154]
sys_rt_sigaction+0x70/0x9a
Jun 18 09:45:55 msa kernel:  [<c0124d55>] sys_rt_sigaction+0x70/0x9a
Jun 18 09:45:55 msa kernel:  [vfs_write+169/245] vfs_write+0xa9/0xf5
Jun 18 09:45:55 msa kernel:  [<c014bbe3>] vfs_write+0xa9/0xf5
Jun 18 09:45:55 msa kernel:  [sys_write+56/89] sys_write+0x38/0x59
Jun 18 09:45:55 msa kernel:  [<c014bcc0>] sys_write+0x38/0x59
Jun 18 09:45:55 msa kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 18 09:45:55 msa kernel:  [<c0105643>] syscall_call+0x7/0xb
Jun 18 09:45:55 msa kernel: 
Jun 18 09:45:55 msa kernel: Code: c2 81 c3 1c 01 00 00 31 d1 81 e1 ff 1f
00 00 8b 04 8b 85 c0 74 0c 39 78 08 74 1f 8b 40 20 85 c0 75 f4 31 d2 31
c0 85 d2 2e 74 b3 <0f> 0b 0c 02 76 28 3e c0 b8 01 00 00 00 eb a4 8b 54
24 08 39 50 



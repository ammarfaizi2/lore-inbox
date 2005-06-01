Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVFALLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVFALLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 07:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVFALLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 07:11:16 -0400
Received: from mail.sbb.co.yu ([82.117.194.7]:59388 "EHLO mail.sbb.co.yu")
	by vger.kernel.org with ESMTP id S261252AbVFALKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 07:10:52 -0400
Date: Wed, 1 Jun 2005 13:10:47 +0200 (CEST)
From: Goran Gajic <ggajic@sbb.co.yu>
To: linux-kernel@vger.kernel.org
Subject: XFS and 2.6.12-rc5
Message-ID: <Pine.BSF.4.62.0506011308530.86037@mail.sbb.co.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-SBB-MailScanner-Information: Please contact the ISP for more information
X-SBB-MailScanner: Found to be clean
X-MailScanner-From: ggajic@sbb.co.yu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


xfs partition is exported via nfs to FreeBSD-5.4 machine. This is what I 
find every morning in my syslog:

  ------------[ cut here ]------------
  kernel BUG at fs/xfs/support/debug.c:106!
  invalid operand: 0000 [#1]
  SMP
  Modules linked in:
  CPU:    1
  EIP:    0060:[<c02c651d>]    Not tainted VLI
  EFLAGS: 00010246   (2.6.12-rc5)
  EIP is at cmn_err+0xad/0xd0
  eax: c0507cc4   ebx: c04b3c98   ecx: c04f8910 edx: 00000293
  esi: 00000206   edi: c0601300   ebp: 00000000 esp: dfcafbd4
  ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 168, threadinfo=dfcae000 task=dfec8020)
Stack: c04bf14d c04a1931 c0601300 00000293 dd6e5e50 00000206 00000000 dfcafd2c
        c0269758 00000000 c04b3c98 df5d4ba0 1abd9322 00000000 00000000 ffffffff
        003fffff 00000000 00000000 00000001 dfcafd0c dfcafd2c 00000000 00e2af60
Call Trace:
  [<c0269758>] xfs_bmap_search_extents+0x108/0x140
  [<c026accd>] xfs_bmapi+0x28d/0x1660
  [<c013cf5a>] find_trylock_page+0x4a/0x60
  [<c02ba25f>] xfs_probe_delalloc_page+0x1f/0xa0
  [<c014153e>] free_pages_bulk+0x1ee/0x230
  [<c0146134>] cache_flusharray+0x84/0xd0
  [<c0291bfb>] xfs_iextract+0xbb/0x1d0
  [<c02b3441>] xfs_inactive_free_eofblocks+0x101/0x300
  [<c02c5c91>] vn_wakeup+0x21/0xb0
  [<c02c6256>] vn_purge+0x156/0x170
  [<c014898e>] shrink_list+0x2de/0x450
  [<c02b3eb0>] xfs_inactive+0x120/0x5a0
  [<c0146134>] cache_flusharray+0x84/0xd0
  [<c02c637c>] vn_rele+0xac/0xf0
  [<c02c4715>] linvfs_clear_inode+0x15/0x30
  [<c01773c6>] clear_inode+0xd6/0xe0
  [<c01773ec>] dispose_list+0x1c/0xa0
  [<c01424bc>] __read_page_state+0x9c/0xd0
  [<c017781c>] prune_icache+0x18c/0x200
  [<c01778af>] shrink_icache_memory+0x1f/0x50
  [<c0148412>] shrink_slab+0x132/0x190
  [<c014989f>] balance_pgdat+0x27f/0x3e0
  [<c0149ac0>] kswapd+0xc0/0x100
  [<c0131c20>] autoremove_wake_function+0x0/0x60
  [<c0102e32>] ret_from_fork+0x6/0x14
  [<c0131c20>] autoremove_wake_function+0x0/0x60
  [<c0149a00>] kswapd+0x0/0x100
  [<c0101045>] kernel_thread_helper+0x5/0x10
Code: b8 00 13 60 c0 89 44 24 08 8b 04 ad e0 7c
50 c0 89 44 24 04 e8 75 5c e5 ff 8b 54 24 0c b8 c4 7c 50 c0 e8 c7 60 1b 00
85 ed 75 08 <0f> 0b 6a 00 49 19 4a c0 8b 5c 24 10 8b 74 24 14 8b 7c 24 18 
8b


Regards,
gg.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263016AbTCSN7y>; Wed, 19 Mar 2003 08:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263028AbTCSN7y>; Wed, 19 Mar 2003 08:59:54 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:61833 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263016AbTCSN7x>; Wed, 19 Mar 2003 08:59:53 -0500
Date: Wed, 19 Mar 2003 14:10:48 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: reiserfs oops [2.5.65]
Message-ID: <20030319141048.GA19361@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Happened during this mornings cron jobs.
find(1) had hung, taking the whole box with it.
Could switch tty's, but no keyboard input at all,
couldn't ssh into box..

12 hours previous, I had been putting it through a fairly
heavy set of stresstests with ltp/fsx/fsstress, though
nothing turned up then. I left the box idle, and went to
bed, and woke up to find this...

Mar 19 06:35:41 mesh kernel: kernel BUG at mm/slab.c:1552!
Mar 19 06:35:41 mesh kernel: invalid operand: 0000
Mar 19 06:35:41 mesh kernel: CPU:    0
Mar 19 06:35:41 mesh kernel: EIP:    0060:[<c015417b>]    Not tainted
Mar 19 06:35:41 mesh kernel: EFLAGS: 00010012
Mar 19 06:35:41 mesh kernel: EIP is at kmem_cache_free+0x24b/0x2c0
Mar 19 06:35:41 mesh kernel: eax: 002fdd94   ebx: 00010c00   ecx: 000001dc   edx: c11bd788
Mar 19 06:35:41 mesh kernel: esi: 68f30060   edi: c1f30060   ebp: c11c3df0   esp: c11c3dc8
Mar 19 06:35:41 mesh kernel: ds: 007b   es: 007b   ss: 0068
Mar 19 06:35:41 mesh kernel: Process kswapd0 (pid: 6, threadinfo=c11c2000 task=c11c1980)
Mar 19 06:35:41 mesh kernel: Stack: c11bd788 c0746458 0000006b c1f30020 c0280dfd c11d32e8 00000292 c1f30098
Mar 19 06:35:41 mesh kernel:        c11c3e74 00000031 c11c3e00 c0280dfd c11bd788 c1f30064 c11c3e14 c0194846
Mar 19 06:35:41 mesh kernel:        c1f30098 c6dcd320 c1f30098 c11c3e44 c0194bfc c1f30098 00000000 00000000
Mar 19 06:35:41 mesh kernel: Call Trace:
Mar 19 06:35:41 mesh kernel:  [<c0280dfd>] reiserfs_destroy_inode+0x1d/0x30
Mar 19 06:35:41 mesh kernel:  [<c0280dfd>] reiserfs_destroy_inode+0x1d/0x30
Mar 19 06:35:41 mesh kernel:  [<c0194846>] destroy_inode+0x36/0x60
Mar 19 06:35:41 mesh kernel:  [<c0194bfc>] dispose_list+0x4c/0x1f0
Mar 19 06:35:41 mesh kernel:  [<c01952e0>] prune_icache+0x190/0x480
Mar 19 06:35:41 mesh kernel:  [<c01955f8>] shrink_icache_memory+0x28/0x30
Mar 19 06:35:41 mesh kernel:  [<c015724f>] shrink_slab+0x11f/0x170
Mar 19 06:35:41 mesh kernel:  [<c0158d1e>] balance_pgdat+0x12e/0x180
Mar 19 06:35:41 mesh kernel:  [<c0158e5d>] kswapd+0xed/0xf0
Mar 19 06:35:41 mesh kernel:  [<c0124ad0>] autoremove_wake_function+0x0/0x50
Mar 19 06:35:41 mesh kernel:  [<c010a2e6>] ret_from_fork+0x6/0x20
Mar 19 06:35:41 mesh kernel:  [<c0124ad0>] autoremove_wake_function+0x0/0x50
Mar 19 06:35:41 mesh kernel:  [<c0158d70>] kswapd+0x0/0xf0
Mar 19 06:35:41 mesh kernel:  [<c01075fd>] kernel_thread_helper+0x5/0x18
Mar 19 06:35:41 mesh kernel:
Mar 19 06:35:41 mesh kernel: Code: 0f 0b 10 06 56 5a 54 c0 e9 d7 fe ff ff 8b 55 08 8b 5a 34 e9


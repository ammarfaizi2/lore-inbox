Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261457AbTCTNw6>; Thu, 20 Mar 2003 08:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261460AbTCTNw6>; Thu, 20 Mar 2003 08:52:58 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:59275 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261457AbTCTNwz>; Thu, 20 Mar 2003 08:52:55 -0500
Date: Thu, 20 Mar 2003 14:03:44 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Oleg Drokin <green@namesys.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs oops [2.5.65]
Message-ID: <20030320140344.GA19751@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Oleg Drokin <green@namesys.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030319141048.GA19361@suse.de> <20030320112559.A12732@namesys.com> <20030320132409.GA19042@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320132409.GA19042@suse.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 01:24:09PM +0000, Dave Jones wrote:

 >  > Hm, very interesting. Thank you.
 >  > I've seen this once too, but on kernel patched with lots of unrelated and
 >  > possibly memory corrupting stuff.
 >  > I will look at it more closely.
 >  > BTW, it oopsed not in find. Is your box SMP?
 > 
 > Same box committed seppuku overnight, this time in a different way.

Managed to get the full logs off the box..
http://www.codemonkey.org.uk/cruft/oops.txt

Including the very first oops that triggered the 'bad shit'.

Mar 20 06:41:07 mesh kernel: Unable to handle kernel paging request at virtual address 20b8c080
Mar 20 06:41:07 mesh kernel:  printing eip:
Mar 20 06:41:07 mesh kernel: c01538b4
Mar 20 06:41:07 mesh kernel: *pde = 00000000
Mar 20 06:41:07 mesh kernel: Oops: 0002
Mar 20 06:41:07 mesh kernel: CPU:    0
Mar 20 06:41:07 mesh kernel: EIP:    0060:[<c01538b4>]    Not tainted 
Mar 20 06:41:07 mesh kernel: EFLAGS: 00010012
Mar 20 06:41:07 mesh kernel: EIP is at cache_flusharray+0x104/0x450
Mar 20 06:41:07 mesh kernel: eax: c1eea020   ebx: 00000006   ecx: c49e621c   edx: 20b8c080
Mar 20 06:41:07 mesh kernel: esi: c49e6000   edi: c11bd788   ebp: c11c3dc0   esp: c11c3d88
Mar 20 06:41:07 mesh kernel: ds: 007b   es: 007b   ss: 0068
Mar 20 06:41:07 mesh kernel: Process kswapd0 (pid: 6, threadinfo=c11c2000 task=c11c1980)
Mar 20 06:41:07 mesh kernel: Stack: c11d656c c6bb2000 c11c3e18 c11c2000 c05ac7c0 00000800 c6129040 c11bd7a4 
Mar 20 06:41:07 mesh kernel:        c11bd794 c11d32f8 00000010 00000800 c1792040 c179221c c11c3df0 c0154121 
Mar 20 06:41:07 mesh kernel:        c11bd788 c11d32e8 0000006b c1792000 c0280dfd c11d32e8 00000292 c1792254 
Mar 20 06:41:07 mesh kernel: Call Trace:
Mar 20 06:41:07 mesh kernel:  [<c0154121>] kmem_cache_free+0x1f1/0x2c0
Mar 20 06:41:07 mesh kernel:  [<c0280dfd>] reiserfs_destroy_inode+0x1d/0x30
Mar 20 06:41:07 mesh kernel:  [<c0280dfd>] reiserfs_destroy_inode+0x1d/0x30
Mar 20 06:41:07 mesh kernel:  [<c0194846>] destroy_inode+0x36/0x60
Mar 20 06:41:07 mesh kernel:  [<c0194bfc>] dispose_list+0x4c/0x1f0
Mar 20 06:41:07 mesh kernel:  [<c01952e0>] prune_icache+0x190/0x480
Mar 20 06:41:07 mesh kernel:  [<c01955f8>] shrink_icache_memory+0x28/0x30
Mar 20 06:41:07 mesh kernel:  [<c015724f>] shrink_slab+0x11f/0x170
Mar 20 06:41:07 mesh kernel:  [<c0158d1e>] balance_pgdat+0x12e/0x180
Mar 20 06:41:07 mesh kernel:  [<c0158e5d>] kswapd+0xed/0xf0
Mar 20 06:41:07 mesh kernel:  [<c0124ad0>] autoremove_wake_function+0x0/0x50
Mar 20 06:41:07 mesh kernel:  [<c010a2e6>] ret_from_fork+0x6/0x20
Mar 20 06:41:07 mesh kernel:  [<c0124ad0>] autoremove_wake_function+0x0/0x50
Mar 20 06:41:07 mesh kernel:  [<c0158d70>] kswapd+0x0/0xf0
Mar 20 06:41:07 mesh kernel:  [<c01075fd>] kernel_thread_helper+0x5/0x18
Mar 20 06:41:07 mesh kernel: 
Mar 20 06:41:07 mesh kernel: Code: 89 02 31 d2 8b 46 0c 29 c1 89 c8 f7 77 30 89 c1 8b 46 14 89 
Mar 20 06:41:07 mesh kernel:  <6>note: kswapd0[6] exited with preempt_count 1
Mar 20 06:41:07 mesh kernel: mm/slab.c:1647: spin_lock(mm/slab.c:c11bd7c8) already locked by mm/slab.c/1775

		Dave




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266212AbUHGEBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266212AbUHGEBO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 00:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUHGEBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 00:01:14 -0400
Received: from lakermmtao05.cox.net ([68.230.240.34]:52935 "EHLO
	lakermmtao05.cox.net") by vger.kernel.org with ESMTP
	id S266212AbUHGEBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 00:01:10 -0400
Date: Fri, 6 Aug 2004 19:09:24 -0400
From: Chris Shoemaker <c.shoemaker@cox.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gene Heskett <gene.heskett@verizon.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       vda@port.imtp.ilyichevsk.odessa.ua, ak@suse.de,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Possible dcache BUG
Message-ID: <20040806230924.GA15493@cox.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040806073739.GA6617@elte.hu> <20040806004231.143c8bd2.akpm@osdl.org> <200408060751.07605.gene.heskett@verizon.net> <Pine.LNX.4.58.0408060948310.24588@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408060948310.24588@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 06, 2004 at 09:58:35AM -0700, Linus Torvalds wrote:
> 
> Now, Chris Shoemaker reported dentry problems on a intel CPU and said that 
> wli had seen something too, but I'm wondering whether Chris and wli might 
> have been seeing the knfsd/xfs-related dentry bug that I found yesterday.  
> So I think the prefetch theory is still alive, but we should check with 
> Chris. Chris?
> 
> 		Linus

My oopses were not related to nfs or xfs.  I don't use either of these
on this box.

In the interest of contributing more than conspiracy theories, I'm
trying to dig up some records of the dcache problems I was having.
Unfortunately, a period of low free disk space led to some aggressive
"cleaning" on my part since then.  :(

I _was_ able to find the attached oops, but I don't think I have the
corresponding object files, so I hope the decoding it contains is
good enough. 

Just ask if you need some more info.

-chris


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Mar17.4.txt"

Mar 17 16:42:01 peace kernel: Unable to handle kernel paging request at virtual address 0b7eec1c
Mar 17 16:42:01 peace kernel:  printing eip:
Mar 17 16:42:01 peace kernel: c01a6667
Mar 17 16:42:01 peace kernel: *pde = 00000000
Mar 17 16:42:01 peace kernel: Oops: 0000 [#1]
Mar 17 16:42:01 peace kernel: PREEMPT DEBUG_PAGEALLOC
Mar 17 16:42:01 peace kernel: CPU:    0
Mar 17 16:42:01 peace kernel: EIP:    0060:[iput+23/112]    Not tainted
Mar 17 16:42:01 peace kernel: EFLAGS: 00010202
Mar 17 16:42:01 peace kernel: EIP is at iput+0x17/0x70
Mar 17 16:42:01 peace kernel: eax: 0b7eebf8   ebx: c33fee3c   ecx: c33fee4c   edx: c33fee4c
Mar 17 16:42:01 peace kernel: esi: c33f2ef8   edi: cba32000   ebp: cba33e54   esp: cba33e50
Mar 17 16:42:01 peace kernel: ds: 007b   es: 007b   ss: 0068
Mar 17 16:42:01 peace kernel: Process kswapd0 (pid: 7, threadinfo=cba32000 task=cba559e0)
Mar 17 16:42:01 peace kernel: Stack: c33fee3c cba33e88 c019f540 00000066 cba33e60 cba33e60 00000000 00000001 
Mar 17 16:42:01 peace kernel:        00000000 c11bcc40 0000003c 00000080 cba32000 0000009c cba33e90 c01a06d7 
Mar 17 16:42:01 peace kernel:        cba33ec4 c01612d8 000e1048 00000000 000079d9 0000001d 00000000 cbffb654 
Mar 17 16:42:01 peace kernel: Call Trace:
Mar 17 16:42:01 peace kernel:  [prune_dcache+1120/1952] prune_dcache+0x460/0x7a0
Mar 17 16:42:01 peace kernel:  [shrink_dcache_memory+23/32] shrink_dcache_memory+0x17/0x20
Mar 17 16:42:01 peace kernel:  [shrink_slab+280/368] shrink_slab+0x118/0x170
Mar 17 16:42:01 peace kernel:  [balance_pgdat+492/528] balance_pgdat+0x1ec/0x210
Mar 17 16:42:01 peace kernel:  [kswapd+220/240] kswapd+0xdc/0xf0
Mar 17 16:42:01 peace kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Mar 17 16:42:01 peace kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Mar 17 16:42:01 peace kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Mar 17 16:42:01 peace kernel:  [kswapd+0/240] kswapd+0x0/0xf0
Mar 17 16:42:01 peace kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Mar 17 16:42:01 peace kernel: 
Mar 17 16:42:01 peace kernel: Code: 8b 40 24 74 4a 85 c0 74 07 8b 50 14 85 d2 75 39 8d 43 1c ba 

--Qxx1br4bt0+wmkIi--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVEJLtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVEJLtj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 07:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVEJLtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 07:49:39 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:57273 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261616AbVEJLta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 07:49:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG][Resend] 2.6.12-rc3-mm3: Kernel BUG at "mm/slab.c":1219
Date: Tue, 10 May 2005 13:49:59 +0200
User-Agent: KMail/1.8
Cc: ak@suse.de, linux-kernel@vger.kernel.org
References: <200505092239.37834.rjw@sisk.pl> <20050509145424.6ffba49a.akpm@osdl.org>
In-Reply-To: <20050509145424.6ffba49a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505101349.59711.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 9 of May 2005 23:54, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > I get this from 2.6.12-rc3-mm3 on a UP AMD64 box (Asus L5D), 100% of the time:
> > 
> > ]--snip--[
> > ACPI: bus type pci registered
> > PCI: Using configuration type 1
> > mtrr: v2.0 (20020519)
> > kmem_cache_create: Early error in slab <NULL>
> > ----------- [cut here ] --------- [please bite here ] ---------
> > Kernel BUG at "mm/slab.c":1219
> > invalid operand: 0000 [1]
> > CPU 0
> > Modules linked in:
> > Pid: 1, comm: swapper Not tainted 2.6.12-rc3-mm3
> > RIP: 0010:[<ffffffff80179eeb>] <ffffffff80179eeb>{kmem_cache_create+139}
> > RSP: 0000:ffff810001ca1eb8  EFLAGS: 00010292
> > RAX: 0000000000000034 RBX: 0000000000000000 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: 0000000000000dd3 RDI: ffffffff804167e0
> > RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000010 R11: 0000000000000008 R12: 0000000000042000
> > R13: 0000000000000000 R14: 0000ffffffff8010 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffffffff8055a840(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> > CR2: 0000000000004000 CR3: 0000000000101000 CR4: 00000000000006e0
> > Process swapper (pid: 1, threadinfo ffff810001ca0000, task ffff810001c5a7a0)
> > Stack: fffffffffffffff8 0000000000000000 0000000000000000 0000000000000000
> >        0000000000000010 0000000000000000 0000000000000005 0000000000000006
> >        00000000ffffffff 0000ffffffff8010
> > Call Trace:<ffffffff8057a11d>{init_bio+93} <ffffffff8010c0f2>{init+178}
> >        <ffffffff8010fc37>{child_rip+8} <ffffffff8010c040>{init+0}
> >        <ffffffff8010fc2f>{child_rip+0}
> > 
> 
> Something kooky is happening.
> 
> Clearly init_bio() is not passing in a NULL `name' parameter.  Maybe the
> backtrace is screwed due to dopey gcc autoinlining and the bad caller is
> really biovec_init_slabs().  Try removing the
> __cacheline_aligned_mostly_readonly from the declaration of bvec_slabs[].
> 
> Please tell us what gcc and binutils versions you're using.

rafael@albercik:~> gcc -v
]--snip--[
gcc version 3.3.5 20050117 (prerelease) (SUSE Linux)

rafael@albercik:~> ld -v
GNU ld version 2.15.94.0.2.2 20041220 (SuSE Linux)

rafael@albercik:~> as -v
GNU assembler version 2.15.94.0.2.2 (x86_64-suse-linux) using BFD version 2.15.94.0.2.2 20041220 (SuSE Linux)

It's the default setup for SUSE 9.3 64-bit.

Strangely enough, I've compiled 2.6.12-rc4 and 2.6.12-rc3-mm2 with the same
gcc/binutils and they work fine.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

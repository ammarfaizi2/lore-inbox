Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbUAZVWS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 16:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265337AbUAZVWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 16:22:18 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:18881 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S265295AbUAZVWP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 16:22:15 -0500
Date: Mon, 26 Jan 2004 16:22:10 -0500 (EST)
From: Jim Faulkner <jfaulkne@ccs.neu.edu>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG under 2.6.1-mm5
In-Reply-To: <200401261827.50169.arvidjaar@mail.ru>
Message-ID: <Pine.GSO.4.58.0401261613170.12672@denali.ccs.neu.edu>
References: <Pine.GSO.4.58.0401211708090.15123@denali.ccs.neu.edu>
 <20040121144804.598c2998.akpm@osdl.org> <200401261827.50169.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Jan 2004, Andrey Borzenkov wrote:

> On Thursday 22 January 2004 01:48, Andrew Morton wrote:
> > Jim Faulkner <jfaulkne@ccs.neu.edu> wrote:
> > > Hello,
> > >
> > > I am seeing some scary looking kernel bug entries in my dmesg under
> > > 2.6.1-mm5.
> > > ...
> > >
> > > kernel BUG at fs/dcache.c:760!
> > > invalid operand: 0000 [#1]
> > > PREEMPT SMP
> > > CPU:    0
> > > EIP:    0060:[<c0179627>]    Not tainted VLI
> > > EFLAGS: 00010287
> > > EIP is at d_instantiate+0x17/0x90
> > > eax: f7baf200   ebx: c1b8bac0   ecx: 000021a4   edx: 00000000
> > > esi: f7a4f868   edi: f7baf200   ebp: f7a4f840   esp: f7a79e3c
> > > ds: 007b   es: 007b   ss: 0068
> > > Process hotplug (pid: 24, threadinfo=f7a78000 task=c1b06d00)
> > > Stack: 00000000 f7a992e4 c1b8bac0 c1b35940 f7a78000 f7a4f840 c01ad6de
> > > f7a4f840
> > >        f7baf200 f7a4f840 f7a41e1c c1bbeb40 00000000 c1b06d00 c011f5b0
> > > 00000000
> > >        00000000 f7a96d00 c1b06d00 c011bb7d 00000000 c1b06d00 c011f5b0
> > > 00000000
> > > Call Trace:
> > >  [<c01ad6de>] devfs_d_revalidate_wait+0xbe/0x1b0
> > >  [<c011f5b0>] default_wake_function+0x0/0x20
> > >  [<c011bb7d>] do_page_fault+0x32d/0x512
> > >  [<c011f5b0>] default_wake_function+0x0/0x20
> > >  [<c016e868>] do_lookup+0x68/0xb0
> > >  [<c016ede8>] link_path_walk+0x538/0xa30
> > >  [<c016fd03>] open_namei+0x83/0x420
> > >  [<c011b850>] do_page_fault+0x0/0x512
> > >  [<c040d4cb>] error_code+0x2f/0x38
> > >  [<c015e61e>] filp_open+0x3e/0x70
> > >  [<c015eb9b>] sys_open+0x5b/0x90
> > >  [<c040c992>] sysenter_past_esp+0x43/0x65
> >
> > hmm.  There was a patch in that area which I have subsequently dropped
> > because it was really fixing devfs problems in the wrong place.
> >
> hmm ...
>
> > Perhaps Andrey can ask you to test a subsequent patch if he takes another
> > look at this.
>
> please try this one. This basically does the same inside of devfs. It passed
> usual sanity checks here; I cannot reproduce oops you have (do you have SMP
> system?)
>
> I appreciate if someone with more intimate knowledge of fs/namei.c comments if
> conditions in devfs_d_revalidate_wait make sense.
>
> -andrey
>

Yes, I have an SMP system.

Your patch works!  I applied it to 2.6.2-rc1-mm1 (which is the last -mm
version that doesn't kernel panic on me because of an unrelated bug), and
the "kernel BUG" warning has gone away.

thanks!
Jim Faulkner

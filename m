Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268153AbUJOQdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268153AbUJOQdF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268144AbUJOQdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:33:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65514 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268167AbUJOQak
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:30:40 -0400
Date: Fri, 15 Oct 2004 11:44:45 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nathan <lists@netdigix.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel panic issues
Message-ID: <20041015144445.GB3599@logos.cnet>
References: <1094411544.413b65185bdba@mail.dreamtoy.net> <20040905170527.4d2e079c.rddunlap@osdl.org> <20040906234028.GA7778@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040906234028.GA7778@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 08:40:29PM -0300, Marcelo Tosatti wrote:
> 
> 
> Nathan,
> 
> On Sun, Sep 05, 2004 at 05:05:27PM -0700, Randy.Dunlap wrote:
> > On Sun,  5 Sep 2004 12:12:24 -0700 Nathan wrote:
> > 
> > | Hi,  I have a server running debian 3.0r1 kernel 2.4.25 and I get these kernel 
> > | panic about 5 times this week.  If anyone can tell me what it means it would be 
> > | greatly appreciated.  Any additional instructions on how to read kernel panic 
> > | dumps would also be appreciated.
> > 
> > Denis Vlasenko recently did a "howto find oops location" for 2.6.x,
> > but it's probably the best reference for you to look at.
> > It's here:
> >   http://marc.theaimsgroup.com/?l=linux-kernel&m=109257016020612&w=2
> > 
> > 
> > | asdasdkernel BUG as slab.c:1263!
> > | Invalid operand: 0000
> > | CPU:	0
> > | EIP:	0010:[<c012609d>] Not tainted
> > | EFLAGS: 00010012
> > | eax: f31eafff	ebx: c19ad700	ecx: 00000001	edx: 00000001
> > | esi: f31ea800	edi: f31eabd3	ebp: c02cfca8	esp: c02cfc8c
> > | ds: 0018	es: 0018	ss: 0018
> > | Process swapper (pid: 0, stackpage=c02cf000)
> > | Stack:	f69657fc c03397e0 00000020 00000800 00012800 f31eabd3 00000246 c02cfcc4
> > | 	c01f6b5e 0000065c 00000020 00000008 0000001c f74ec160 c02cfcf f887afe3
> > | 	00000620 00000020 00000008 0000001c f74ec160 c01fa090 00000000 f6ebec
> > | Call Trace:	[<c01f6b5e>] [<f887afe3>] [<c01fa090>] [<f887ae58>] [<f887ae58>]
> > | 	[<c0107ee0>] [<c010806f>] [<c0125f2c>] [<c0231d11>] [<c02320c8>] 
> > | [<c0207b60>]
> > | 	[<f887b4ef>] [<c010806f>] [<c0207b60>] [<c02010b7>] [<c0207b60>] 
> > | [<c02079f5>]
> > | 	[<c0207b60>] [<c01fa40b>] [<c01fa4ad>] [<c01fa5bf>] [<c011552b>] 
> > | [<c010809d>]
> > | 	[<c0105260>] [<c0105260>] [<c0105260>] [<c0105260>] [<c0105286>] 
> > | [<c01052f9>]
> > | 	[<c0105000>] [<c010502a>]
> > | 
> > | Code: 0f 0b ef 04 60 33 26 c0 8b 7d f4 f7 c7 00 04 00 00 74 36 b8
> > |  <0>Kernel panic: Aiee, Killing interrupt handler!
> > | In interrupt handler - not syncing
> > 
> > The stack addresses are useless without associating some of (your)
> > kernel symbols with them.  Please read REPORTING-BUGS in the top
> > level of the kernel source tree for full bug-reporting info, and see
> > Documentation/Changes on where to get 'ksymoops' if you don't
> > already have it, then run this panic message text thru ksymoops.
> > That should tell the function call chain to get to slab.c.
> 
> Yes please run ksymoops on the output as Randy suggests.
> 
> 
> > kernel BUG as slab.c:1263!
> 
> Are you using SMP? 
> 
> The BUG happens because kmem_check_poison_obj finds a POISON_END 
> byte not at the end the object .
> 
>         if (cachep->flags & SLAB_POISON)
>                 if (kmem_check_poison_obj(cachep, objp))
>                         BUG();
> Whats your config?
> 
> Have you been able to capture the same oops ie same or similar backtrace,
> also "BUG at slab.c:1263!" more than once?
> 
> Maybe hardware bug, but potentially not (maybe some sort of kernel memory
> overwrite).

Nathan, 

If you answer this questions we will be able to have more of a clue 
of your problem.

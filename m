Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbSJSELI>; Sat, 19 Oct 2002 00:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265518AbSJSELI>; Sat, 19 Oct 2002 00:11:08 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:11382 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265506AbSJSELE>; Sat, 19 Oct 2002 00:11:04 -0400
Date: Sat, 19 Oct 2002 06:16:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@muc.de>
Cc: Jeff Dike <jdike@karaya.com>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>, discuss@x86-64.org, aj@suse.de
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021019041659.GK23930@dualathlon.random>
References: <20021019031002.GA16404@averell> <200210190450.XAA06161@ccure.karaya.com> <20021019040238.GA21914@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021019040238.GA21914@averell>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 06:02:38AM +0200, Andi Kleen wrote:
> [full quote for context]
> 
> On Sat, Oct 19, 2002 at 06:49:59AM +0200, Jeff Dike wrote:
> > ak@muc.de said:
> > > Guess you'll have some problems then with UML on x86-64, which always
> > > uses vgettimeofday. But it's only used for gettimeofday() currently,
> > > perhaps it's  not that bad when the UML child runs with the host's
> > > time.
> > 
> > It's not horrible, but it's still broken.  There are people who depend
> > on UML being able to keep its own time separately from the host.
> > 
> > > I guess it would be possible to add some support for UML to map own
> > > code over the vsyscall reserved locations. UML would need to use the
> > > syscalls then. But it'll be likely ugly. 
> > 
> > Yeah, it would be.
> > 
> > My preferred solution would be for libc to ask the kernel where the vsyscall
> > area is.  That's reasonably clean and virtualizable.  Andrea doesn't like it
> > because it adds a few instructions to the vsyscall address calculation.
> 
> I would have no problems with adding that to the x86-64 kernel. It could
> be passed in by the ELF environment vector and added to the ABI. 
> Overhead should be negligible, it just needs a single table lookup.  
> Andreas, what do you think ? 

see my last email. And I think he needed it as an additional syscall
after execve that he could trap and revirtualize with ptrace as usual
and that would return variable addresses of pointer to functions (that
would be revirtualized inside the uml kernel of course), not an ELF
information that should be valid for both UML and host kernel.

Andrea

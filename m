Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265510AbSJSEke>; Sat, 19 Oct 2002 00:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265511AbSJSEke>; Sat, 19 Oct 2002 00:40:34 -0400
Received: from zero.aec.at ([193.170.194.10]:14086 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S265510AbSJSEke>;
	Sat, 19 Oct 2002 00:40:34 -0400
Date: Sat, 19 Oct 2002 06:45:56 +0200
From: Andi Kleen <ak@muc.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jeff Dike <jdike@karaya.com>, Andi Kleen <ak@muc.de>,
       john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021019044556.GA22201@averell>
References: <20021019031002.GA16404@averell> <200210190450.XAA06161@ccure.karaya.com> <20021019041019.GI23930@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021019041019.GI23930@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 06:10:19AM +0200, Andrea Arcangeli wrote:
> On Fri, Oct 18, 2002 at 11:49:59PM -0500, Jeff Dike wrote:
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
> yes, my preferred solution is still a runtime /proc entry that turns off
> vsyscalls completely by root so you could trap gettimeofday/time via the
> usual ptrace. That would be zero cost. Of course this would be needed

Ok, a sysctl that modifies a variable in the vsyscall page and is
tested by the code. That would be an option, I agree.

For the locked TSC code we will need something like that anyways,
so that locked TSC can force a syscall.

-Andi

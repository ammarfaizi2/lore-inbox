Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265742AbSJTCx0>; Sat, 19 Oct 2002 22:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265743AbSJTCx0>; Sat, 19 Oct 2002 22:53:26 -0400
Received: from zero.aec.at ([193.170.194.10]:65034 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S265742AbSJTCxZ>;
	Sat, 19 Oct 2002 22:53:25 -0400
Date: Sun, 20 Oct 2002 04:59:14 +0200
From: Andi Kleen <ak@muc.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@muc.de>, Jeff Dike <jdike@karaya.com>,
       john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>, discuss@x86-64.org, aj@suse.de
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021020025914.GB15342@averell>
References: <20021019031002.GA16404@averell> <200210190450.XAA06161@ccure.karaya.com> <20021019040238.GA21914@averell> <20021019041659.GK23930@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021019041659.GK23930@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 06:16:59AM +0200, Andrea Arcangeli wrote:
> see my last email. And I think he needed it as an additional syscall
> after execve that he could trap and revirtualize with ptrace as usual
> and that would return variable addresses of pointer to functions (that
> would be revirtualized inside the uml kernel of course), not an ELF
> information that should be valid for both UML and host kernel.

Implementing it per process is tricky. How do you access the per process
state in the vsyscall area ?  To do it properly you would need one dedicated
page per mm_struct that is mapped in there. But it could not be in the
normal vsyscall area (otherwise you couldn't share the kernel pagetables
anymore), but somewhere else in the address space.

I think a global sysctl that just modifies the global vsyscall pages is more
suitable here. It avoids the overhead of needing a per process page.
I see no real need anyways to do it per process. When you have one process
that cannot deal with vsyscalls the whole system will get a bit slower,
but the slowdown shouldn't be noticeable anyways. If you run your highend
database which does thousands of gettimeofday each second just don't set
the sysctl.

-Andi

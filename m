Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265319AbSJRVaa>; Fri, 18 Oct 2002 17:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265322AbSJRVaa>; Fri, 18 Oct 2002 17:30:30 -0400
Received: from cs.columbia.edu ([128.59.16.20]:53664 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S265319AbSJRVaZ>;
	Fri, 18 Oct 2002 17:30:25 -0400
Subject: Re: can chroot be made safe for non-root?
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <aopspi$alg$1@abraham.cs.berkeley.edu>
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net>
	 <20021018190101.GE237@elf.ucw.cz> <aopq2p$9pm$2@abraham.cs.berkeley.edu>
	 <1034975267.2259.81.camel@zaphod>  <aopspi$alg$1@abraham.cs.berkeley.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1034976970.2179.93.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2 (Preview Release)
Date: 18 Oct 2002 17:36:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-18 at 17:00, David Wagner wrote:
> Shaya Potter  wrote:
> >the problem with chroot() is that they dont nest.
> 
> That's *a* problem, but not (IMHO) the most significant problem.
> The biggest disadvantages with chroot() (as I see it) are:
>  * not useable unless you're root

is this a problem from a security perspective, or a design perspective.
i.e. users should be able to chroot their processes, not to gain
security but just to be able to do things.  Or also for security?

>  * too coarse-grained

what exactly do you mean?

>  * only protects the filesystem, but not other resources (e.g., the
network)

yes, chroot doesn't make a jail, but chroot + other stuff can make a
jail, and chroot can give you the fs side for close to free (lost
performance that is)

>  * not suitable for jailing root

b/c root can break out easily, right? to jail root you need other stuff
as I said above.

> 
> > If however, one could provide even a single level of nesting, such
that
> > a chroot outside of a chroot sets the first level, and any other
chroot
> > after that sets the inner level, then even root wouldn't be able to
> > break out of the chroot (presuming it didn't bring any fd's into the
> > chroot w/ it).  
> 
> This is not quite right.  There are LOTS of other ways that root
> can break out of a chroot.

how? the class way is the fchdir, but I guess there are others, but my
brain is not seeing them right now.

> Actually, I suspect that nested chroot()s may not be needed very
> frequently, so I think a simpler approach may be simply to prevent
> a chrooted process from calling chroot() again: i.e., prevent nesting.

well, this would prevent you from using chroot w/ processes that want to
chroot (running an ftpd inside of a chroot, dont some like to chroot for
anonymous access?), I've thought about that in regards to my research
related to our zap system, and I would rather not have to do that.




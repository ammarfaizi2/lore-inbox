Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbTAJHZu>; Fri, 10 Jan 2003 02:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbTAJHY4>; Fri, 10 Jan 2003 02:24:56 -0500
Received: from dp.samba.org ([66.70.73.150]:7660 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263794AbTAJHYo>;
	Fri, 10 Jan 2003 02:24:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, bjornw@axis.com,
       geert@linux-m68k.org, ralf@gnu.org, mkp@mkp.net, willy@debian.org,
       anton@samba.org, gniibe@m17n.org, kkojima@rr.iij4u.or.jp,
       Jeff Dike <jdike@karaya.com>
Subject: Re: Userspace Test Framework for module loader porting 
In-reply-to: Your message of "Mon, 06 Jan 2003 11:38:20 -0800."
             <15897.56108.201340.229554@napali.hpl.hp.com> 
Date: Wed, 08 Jan 2003 22:21:20 +1100
Message-Id: <20030110073328.E45612C4DB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <15897.56108.201340.229554@napali.hpl.hp.com> you write:
> >>>>> On Mon, 06 Jan 2003 13:27:02 +1100, Rusty Russell <rusty@rustcorp.com.a
u> said:
> 
>   Rusty> BTW, the change to use shared objects for modules is going to
>   Rusty> be a 2.7 thing: after 10 architectures, MIPS toolchain issues
>   Rusty> made it non-trivial.  So the current stuff is what is going
>   Rusty> to be there for 2.6, so no point waiting 8)
> 
> What about all the problems that Richard Henderson pointed out with
> the original in-kernel module loader?  Were those solved?

Yes.  Richard withdrew the one about allocation (we used a special
per-arch allocator, he missed it), the one about common section
ordering was fixed by RTH noticing we use -fno-common, so all that
logic was dropped anyway, and his section ordering query was fixed by
his section ordering patch (which changed the arch interface
slightly).

> My gut feeling is that we really want shared objects for kernel
> modules on ia64 (and probably alpha?).

It's certainly simpler.  My ia64 current implementation is around 500
lines, vs 225 lines for the shared version.

But I'm not prepared to shaft an arch over it this late in the cycle,
and the current scheme puts less pressure on toolchains (several other
binutils "issues" were discovered in implementing
modules-as-shared-objects).

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

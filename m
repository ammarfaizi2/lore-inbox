Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSGDMcN>; Thu, 4 Jul 2002 08:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317395AbSGDMcM>; Thu, 4 Jul 2002 08:32:12 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:59664 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317398AbSGDMcL>; Thu, 4 Jul 2002 08:32:11 -0400
Date: Thu, 4 Jul 2002 08:29:03 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Werner Almesberger <wa@almesberger.net>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
In-Reply-To: <20020704032929.N2295@almesberger.net>
Message-ID: <Pine.LNX.3.96.1020704081959.4082A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2002, Werner Almesberger wrote:

> Bill Davidsen wrote:
> > Isn't the right thing to make everything stop using the module before
> > ending it, for any definition of ending?
> 
> This certainly seems to be the most understandable way, yes. I think
> modules follow basically the principle illistrated below (that's case
> 4b in the taxonomy I posted earlier), where deregistration doesn't
> stop everything, but which should be safe except for
> return-after-removal:

There seems no right thing to do when a module get a service request for
something which is not active. Anything at that point would be likely to
corrupt data structures, oops, or leave a process in some unkillable
state.

> I can understand why people don't want to use totally "safe"
> deregistration, e.g.
> 
>  - locking gets more complex and you may run into hairy deadlock
>    scenarios
>  - accomplishing timely removal may become more difficult
>  - nobody likes patches that change the world

Everybody loves them in development kernels ;-) Actually, I think this is
unlikely to result in more than a hang if it fails one way, or no worse
than what we have if it fails the other.

And if I understand the problem, it only is needed when either smp or
preempt are built in, so there would be no overhead for small systems, one
other possible objection to doing it safely.
 
> So the entry/return-after-removal issues may still need to be
> resolved. I'm mainly worried about entry-after-removal, because
> it seems to me that this is likely to imply data races in
> non-modules too, so try_inc_mod_count neither sufficient (for it
> doesn't help with non-modules) nor required (because fixing the
> race would also eliminate entry-after-removal).
> 
> I've seen very few reponses to my analysis. Does everybody think
> I'm nuts (quite possible :-), or is this worth continuing ?

My read is that eliminating actual unloading of modules won't solve these
issues, it would just change them. Therefore if you're having a good time
looking at this I think it would make the kernel more stable, which will
be a goal of 2.6.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


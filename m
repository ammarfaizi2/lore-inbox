Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317328AbSGDEFQ>; Thu, 4 Jul 2002 00:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSGDEFP>; Thu, 4 Jul 2002 00:05:15 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51984 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317328AbSGDEFO>; Thu, 4 Jul 2002 00:05:14 -0400
Date: Thu, 4 Jul 2002 00:02:20 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
In-Reply-To: <20020702151206.GK20920@opus.bloom.county>
Message-ID: <Pine.LNX.3.96.1020703234516.2248E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2002, Tom Rini wrote:

> Sure there is.  It's called stopping feature creep.  O(1) is a nice
> feature, but so is the bio stuff, the initcall levels, and other things
> in 2.5 as well.  But should we back port all of these to 2.4 as well?

None of the other stuff is (a) a solution for any current problem I've
seen (it NEW capability), or (b) has a functional and widely exposed port
to 2.4 already.

The only other feature which which I'm familiar which even remotely fits
those two characteristics is rmap, and with the VM changes Andrea has made
I certainly don't hit really bad VM behaviour on my machines. On some rmap
is a tad better, but compared to 2.4.16 or so 19-preX-aa is acceptable.
 
> > Stable doesn't mean moribund, we are working Andrea's VM stuff in, and
> > that's a LOT more likely to behave differently on hardware with other word
> > length.
> 
> Being someone who actually works on !x86 hardware all of the time, I'm
> slightly warry of Andrea's VM work as well.  But it's also something
> which has been split into numerous small chunks, so hopefully problems
> will be spotted.
> 
> > Keeping inferior performance for another year and then trying to
> > separate 2.5 other unintended features from any possible scheduler issues
> > seems like a reduction in stability for 2.6.
> 
> It's no more of a reduction in stability than not back porting
> everything else.  And making things stable is why eventually Linus says
> 'enough' and kicks out 2.stable.0-test1.  Anyhow, since this isn't a
> subsystem backport, but part of the core kernel, I would think that you
> could only get limited use out of the testing (I remember reading some
> of the O(1) announcments for 2.4.then-current and reading about small
> bugs that weren't in the 2.5 version).

The current scheduler has one big bug; it gives the processor to the wrong
process under some load conditions to the point where the system appears
hung for seconds (or longer). There are two issues, one is best or
acceptable performance, and one is "best worst-case performance." The O(1)
simply doesn't have or hasn't shown me the jackpot case when load changes
on a machine. To me that justifies O(1). Even if it was not faster than
the current scheduler for normal load, the worst case is what needs a fix.

And as I mentioned to Ingo, I don't feel that way about low-latency or
preempt, even though they help a little they don't really fix anything
broken, and I don't argue for inclusion. The current scheduler does behave
very badly in some cases, and should be fixed now, not in 18 months.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


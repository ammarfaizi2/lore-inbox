Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSHASyl>; Thu, 1 Aug 2002 14:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSHASyl>; Thu, 1 Aug 2002 14:54:41 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:31502 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316578AbSHASyk>; Thu, 1 Aug 2002 14:54:40 -0400
Date: Thu, 1 Aug 2002 14:52:16 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ray Lee <ray-lk@madrabbit.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Guarantee APM power status change notifications
In-Reply-To: <1028213816.1027.155.camel@orca>
Message-ID: <Pine.LNX.3.96.1020801144525.15133D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Aug 2002, Ray Lee wrote:

> [Trimmed the cc:]
> On Wed, 2002-07-31 at 13:10, Bill Davidsen wrote:
> > Actually there is one more case, where the BIOS unreliably tells you
> > something has changed. I have an old Toshiba which I bought with Windows
> > installed, and it always noticed pulling the plug and going line=>battery,
> > but only sometimes noticed battery=>line. Of course this might be an o/s
> > bug.
> 
> Well, that's just special. I wonder where the blame lies in that case.
> 
> > Can't test that any more, the battery failed and the transition is
> > now line=>dead.
> 
> Heh.
> 
> > Anyway, if you are paranoid you could just ignore the "I knew that" cases
> > and leave the workaround in place, unless that would generate other
> > issues.
> 
> Hmm. I don't think that would cover everything. Taking your example
> case, and assuming it's the BIOS being flaky, we'd have to just ignore
> all transitions from the BIOS apm and just poll ourselves. Otherwise,
> we'd have line->battery (signaled), battery->line (not signaled),
> line->battery (signaled) and *then* we'd know to be paranoid. In the
> meantime, we lost the second transition, which could have been hours
> ago. The solution in that case would be to infrequently poll (say, twice
> a minute) to verify what the BIOS told us. If it's out of sync, give it
> a bit of a grace period, double-check, then take over the reins for
> reporting.

Okay, I said "other issues" and that certainly is one.
 
> The bottom line is that I didn't want to incur an extra set of BIOS
> calls on systems that don't need it, on general principle. <Shrug> Heck,
> maybe it's fast and the overhead is unnoticeable, but I don't know (ISTR
> some low-latency issues when doing BIOS calls). Considering the APM
> thread is only getting invoked once a second, it's seems that it would
> be unnoticeable and zero risk, but hey, what do I know.
> 
> Anyway, a patch to do double-checking would be fairly straight-forward,
> but without any reports of hardware out there that fails like that...
> dunno. I'll work up a patch when I'm back from my road trip and see if
> it's as clean.

Bear in mind that I was being pedantic to mention the other case, I would
think that if this is worth doing at all (is it?) just an option to ignore
the BIOS might be fine:

  modprobe apm my_bios_sucks=sad_but_true

or some such. If anyone was convinced there was such an issue they could
do it. Again, it could have been the o/s just losing the int when running
slow on battery. M$ losing ints? Nah, can't happen ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVLZUiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVLZUiq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 15:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVLZUiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 15:38:46 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17343 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932141AbVLZUip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 15:38:45 -0500
Date: Mon, 26 Dec 2005 21:38:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks 051221
Message-ID: <20051226203806.GC1974@elf.ucw.cz>
References: <200512210310.51084.kernel@kolivas.org> <20051225171617.GA6929@thunk.org> <20051226025525.GA6697@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051226025525.GA6697@thunk.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I believe the reason why is that the T40 has an extra C state which
> only shows up if you are running on battery; if you are running on the
> AC mains, C4 disappears:

Stupid IBM. I've seen it appearing/disappearing, but did not work out
when.

No-C4-on-AC is bad -- if you just disconnect AC and walk away, you are
running without benefits of C4. Bad. Changing benchmarks depending on
you booting on AC or battery also look nasty.

> 
>    *C1:                  type[C1] promotion[C2] demotion[--] latency[001] usage[00000000] time[00000000000000000000]
>     C2:                  type[C2] promotion[C3] demotion[C1] latency[001] usage[00000000] time[00000000000000000000]
>     C3:                  type[C3] promotion[C4] demotion[C2] latency[085] usage[00000000] time[00000000000000000000]
>     C4:                  type[C3] promotion[--] demotion[C3] latency[185] usage[00000000] time[00000000000000000000]
> 
> With dyntick enabled, the laptop never enters the C4 state, but
> instead bounces back and forth between C2 and C3 (and I notice that we
> never enter C1 state, even when the CPU is completely pegged, but
> that's true with or without dyntick).  

C1 is halt. If your cpu is fully loaded, you don't want to enter any
sleep state, not even C1.

> If dyntick is enabled, the laptop enters C4 state, which presumably is
> a deeper, more power saving state, and it appears power saving effects
> of dyntick is getting balanced off against the fact that C4 is never
> getting entered when it is enabled.

Can you boot on AC power, then go to battery power to verify this theory?

> Looking at acpi/processor_idle.c, there is all sorts of magic special
> cases code for the C2 and C3 states (both for promotion/demotion
> polcies, as well as what to do when idling in those particular
> states), and which doesn't exist for other states, such as C4.
> Presumably this explains why we are only never entering C1, and why
> dyntick enabled C4 never gets reached.  What I don't understand is
> _why_ all of the magic is present for those two states, but not for
> any of the others.
> 
> For future work when I have time, is to actually do some performance
> benchmarks; given that the power consumption doesn't appear to be
> changed either way with dyntick enabled or disabled, does the time
> needed to compile a kernel change significantly with or without
> dyntick?

It should not change at all. If your cpu is loaded, timers should tick
as usual, so that you can properly account user/system times of
processes etc.
								Pavel
-- 
Thanks, Sharp!

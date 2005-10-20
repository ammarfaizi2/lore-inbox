Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbVJTIBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbVJTIBG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 04:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbVJTIBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 04:01:06 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:39578 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751784AbVJTIBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 04:01:05 -0400
Date: Thu, 20 Oct 2005 10:01:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: john stultz <johnstul@us.ibm.com>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
Message-ID: <20051020080107.GA31342@elte.hu>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain> <1129734626.19559.275.camel@tglx.tec.linutronix.de> <1129747172.27168.149.camel@cog.beaverton.ibm.com> <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain> <20051020073416.GA28581@elte.hu> <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > i could imagine the following hardware effects to cause time warps:
> >
> > - the TSC is in fact the 'read counter' method of the local APIC timer
> >   hardware. So there can be interactions in theory: programming the APIC
> >   timer could impact the TSC and vice versa. There have been CPU
> >   erratums in this area in the past.
> 
> Could this cause a 2 second drop backwards?

i dont think so.

> > - the TSC itself could have short, temporary warps. I had a box that
> >   showed such effects.
> 
> Can this be a 2 second warp?

the ones i saw were in the 1000-cycles range.

> My older code first used jiffies as a timer, then I switched to TSC 
> and then to APIC timer, and then finally ktimer.  ktimer was the first 
> to show a backwards get_time.

another thing: the monotonicity check is only in get_ktime_mono(), while 
there are other places where a monotonic clock is used, which this check 
might miss.

	Ingo

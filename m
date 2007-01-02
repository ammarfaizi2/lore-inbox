Return-Path: <linux-kernel-owner+w=401wt.eu-S1754923AbXABTqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbXABTqT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 14:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754935AbXABTqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 14:46:19 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:43018 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754923AbXABTqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 14:46:17 -0500
Subject: Re: [RFC] HZ free ntp
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200701011727.46944.zippel@linux-m68k.org>
References: <20061204204024.2401148d.akpm@osdl.org>
	 <Pine.LNX.4.64.0612132125450.1867@scrub.home>
	 <1166578357.5594.3.camel@localhost>
	 <200701011727.46944.zippel@linux-m68k.org>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 11:42:12 -0800
Message-Id: <1167766932.3141.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-01 at 17:27 +0100, Roman Zippel wrote:
> On Wednesday 20 December 2006 02:32, john stultz wrote:
> 
> > > I know and all you have to change in the ntp and some related code is to
> > > replace HZ there with a variable, thus make it changable, so you can
> > > increase the update interval (i.e. it becomes 1s/hz instead of 1s/HZ).
> >
> > Untested patch below. Does this vibe better with you are suggesting?
> 
> Yes, thanks.
> tick_nsec doesn't require special treatment, in the middle term it's obsolete
> anyway, it could be replaced with (current_tick_length() >>
> TICK_LENGTH_SHIFT) and current_tick_length() being inlined.

If NTP_INTERVAL_FREQ is different then HZ, then tick_nsec still has a
different meaning then (current_tick_length() >> TICK_LENGTH_SHIFT).
So since tick_nsec is still used in quite a few places, so I'm hesitant
to pull it.

> NTP_INTERVAL_FREQ could be a real variable (so it can be initialized at
> runtime), it's already gone from all important paths.

Wait, so you're suggesting NTP_INTERVAL_FREQ be a dynamic variable
instead of a constant? Curious, could you give a bit more detail on why?

> In the short term I'd prefered a clock would store its frequency instead of
> using NTP_INTERVAL_LENGTH in clocksource_calculate_interval(), so it doesn't
> has to be derived there.

I don't follow this at all. clocksources do store their own frequency
(via mult/shift). Could you explain?

thanks
-john


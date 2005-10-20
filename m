Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbVJTI7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVJTI7q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 04:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVJTI7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 04:59:46 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:31112 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750763AbVJTI7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 04:59:45 -0400
Date: Thu, 20 Oct 2005 10:59:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: john stultz <johnstul@us.ibm.com>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
Message-ID: <20051020085955.GB2903@elte.hu>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain> <1129734626.19559.275.camel@tglx.tec.linutronix.de> <1129747172.27168.149.camel@cog.beaverton.ibm.com> <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain> <20051020073416.GA28581@elte.hu> <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain> <20051020080107.GA31342@elte.hu> <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> static inline nsec_t __get_nsec_offset(void)
> {
> 	cycle_t cycle_now, cycle_delta;
> 	nsec_t ns_offset;
> 
> 	/* read clocksource */
> 	cycle_now = read_clocksource(clock);
> 
> 	/* calculate the delta since the last timeofday_periodic_hook */
> 	cycle_delta = (cycle_now - cycle_last) & clock->mask;
> 
> 	/* convert to nanoseconds */
> 	ns_offset = cyc2ns(clock, ntp_adj, cycle_delta);
> 
> 	/* Special case for jiffies tick/offset based systems
> 	 * add arch specific offset
> 	 */
> 	ns_offset += arch_getoffset();
> 
> 	return ns_offset;
> }
> 
> cycle_now is 32 bits.  If the clocksource overflows (which it can in 
> 30 seconds) the cyclec_delta will be wrong.

isnt cycle_t 64 bits?

	Ingo

Return-Path: <linux-kernel-owner+w=401wt.eu-S965301AbXATQNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbXATQNo (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 11:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965302AbXATQNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 11:13:44 -0500
Received: from www.osadl.org ([213.239.205.134]:47926 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965301AbXATQNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 11:13:43 -0500
Subject: Re: [patch 3/3] clockevent driver for arm/pxa2xx
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Luotao Fu <lfu@pengutronix.de>
In-Reply-To: <Pine.LNX.4.60.0701201655020.4223@poirot.grange>
References: <20070109100957.259649000@localhost.localdomain>
	 <20070109101307.715996000@localhost.localdomain>
	 <Pine.LNX.4.60.0701192010490.5127@poirot.grange>
	 <1169235221.6271.19.camel@localhost.localdomain>
	 <Pine.LNX.4.60.0701201655020.4223@poirot.grange>
Content-Type: text/plain
Date: Sat, 20 Jan 2007 17:13:42 +0100
Message-Id: <1169309622.5560.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-20 at 17:08 +0100, Guennadi Liakhovetski wrote:
> > static int hpet_next_event(unsigned long delta,
> >                            struct clock_event_device *evt)
> > {
> >         unsigned long cnt;
> > 
> >         cnt = hpet_readl(HPET_COUNTER);
> >         cnt += delta;
> >         hpet_writel(cnt, HPET_T0_CMP);
> > 
> >         return ((long)(hpet_readl(HPET_COUNTER) - cnt ) > 0);
> > }
> > 
> > The generic code takes care of the already expired event.
> 
> The thing is - 2.6.20-rc5-rt3 didn't provide clockevent on PXA, so, I took 
> Sascha's patch instead of my own, which I've been using with 2.6.18, as 
> his patches were already submitted to various lists and had chances to 
> become mainline. And strait away it didn't work. The code above seems to 
> be doing something close to Sascha's patch, so, I expect it would behave 
> in the same way. And until I introduced a minimum increment for the match 
> register, it didn't work. I either got hangs, or WARN_ON dumps about "time 
> warp detected". I think, any timer related code for PXA has to be tested 
> on real hardware under significant (real-time) load before going upstream. 
> Haven't tested -rt7 though, so, maybe it is already handled there?

No, as I'm reworking clock events a bit and I added the handling for the
match register based devices. The above will catch the event in the past
and the generic code handles that. Will be on -rt soon.

	tglx



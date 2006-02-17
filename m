Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161136AbWBQA2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbWBQA2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 19:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbWBQA2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 19:28:09 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:11407 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161136AbWBQA2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 19:28:07 -0500
Subject: Re: [patch] hrtimer: round up relative start time on low-res arches
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0602162305210.30994@scrub.home>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home>
	 <1139827927.4932.17.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0602131208050.30994@scrub.home>
	 <20060214074151.GA29426@elte.hu>
	 <Pine.LNX.4.61.0602141113060.30994@scrub.home>
	 <20060214122031.GA30983@elte.hu>
	 <Pine.LNX.4.61.0602150033150.30994@scrub.home>
	 <20060215091959.GB1376@elte.hu>
	 <Pine.LNX.4.61.0602151259270.30994@scrub.home>
	 <1140036234.27720.8.camel@leatherman>
	 <Pine.LNX.4.61.0602161244240.30994@scrub.home>
	 <1140116771.7028.31.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0602162305210.30994@scrub.home>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 16:28:04 -0800
Message-Id: <1140136085.7028.65.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-17 at 00:44 +0100, Roman Zippel wrote:
> On Thu, 16 Feb 2006, john stultz wrote:
> > > In the end the simplification of my patches should also 
> > > make your patches simpler, as it precalculates as much as possible and 
> > > reduces the work done in the fast paths. It would avoid a lot of extra 
> > > work, which you currently do.
> > 
> > Well, I'm still cautious, since it still has some dependencies on HZ
> > (see equation below), which I'm trying to avoid.
> 
> There is no real dependency on HZ, it's just that the synchronisations 
> steps and incremental updates are done in fixed intervals. The interval 
> could easily be independent of HZ.

Ok, one concern was that in the cycle->interval conversion, some
interval lengths are not possible due to the clock's resolution.

In my mind, I'd like to provide a interval length to the NTP code and
have the NTP code provide an adjusted interval which can be used in
error accumulation and the resulting multiplier adjustment.

Or, we just write off the cycle->interval error as part of the clock's
natural error and let the NTP daemon compensate for it. Your thoughts?

Regardless, the point is that I'd prefer if the timeofday code to be
able to specify to the NTP code what the interval length is, rather then
the other way around. Does that sound reasonable?

thanks
-john


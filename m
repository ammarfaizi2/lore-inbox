Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030619AbWBQPCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030619AbWBQPCi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030628AbWBQPCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:02:38 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:22430 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030619AbWBQPCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:02:37 -0500
Date: Fri, 17 Feb 2006 16:02:15 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] hrtimer: round up relative start time on low-res arches
In-Reply-To: <1140136085.7028.65.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0602171403140.30994@scrub.home>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home> 
 <1139827927.4932.17.camel@localhost.localdomain>  <Pine.LNX.4.61.0602131208050.30994@scrub.home>
  <20060214074151.GA29426@elte.hu>  <Pine.LNX.4.61.0602141113060.30994@scrub.home>
  <20060214122031.GA30983@elte.hu>  <Pine.LNX.4.61.0602150033150.30994@scrub.home>
  <20060215091959.GB1376@elte.hu>  <Pine.LNX.4.61.0602151259270.30994@scrub.home>
  <1140036234.27720.8.camel@leatherman>  <Pine.LNX.4.61.0602161244240.30994@scrub.home>
  <1140116771.7028.31.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0602162305210.30994@scrub.home>
 <1140136085.7028.65.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 16 Feb 2006, john stultz wrote:

> > There is no real dependency on HZ, it's just that the synchronisations 
> > steps and incremental updates are done in fixed intervals. The interval 
> > could easily be independent of HZ.
> 
> Ok, one concern was that in the cycle->interval conversion, some
> interval lengths are not possible due to the clock's resolution.
> 
> In my mind, I'd like to provide a interval length to the NTP code and
> have the NTP code provide an adjusted interval which can be used in
> error accumulation and the resulting multiplier adjustment.
> 
> Or, we just write off the cycle->interval error as part of the clock's
> natural error and let the NTP daemon compensate for it. Your thoughts?

Here my example does correct for this error, it accumulates the difference 
between the clock update and the desired ntp update and once it's large 
enough, it's corrected by a multiplier change.

> Regardless, the point is that I'd prefer if the timeofday code to be
> able to specify to the NTP code what the interval length is, rather then
> the other way around. Does that sound reasonable?

I don't understand what the advantage would be, the NTP code needs both 
and the time interval is actually the variable part, so AFAICT it would 
make the NTP code only more complex. (NTP changes the amount of time to be 
passed per tick to adjust clock speed and not the other way around.)

bye, Roman

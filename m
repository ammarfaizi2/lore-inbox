Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWHQWct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWHQWct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 18:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWHQWct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 18:32:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:18142 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030239AbWHQWcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 18:32:48 -0400
Subject: Re: Linux time code
From: john stultz <johnstul@us.ibm.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       linux-kernel@vger.kernel.org, Udo van den Heuvel <udovdh@xs4all.nl>
In-Reply-To: <200608171512.00417.jbarnes@virtuousgeek.org>
References: <44E32B23.16949.BBB1EC4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	 <Pine.LNX.4.64.0608171334030.6761@scrub.home>
	 <1155851917.31755.125.camel@cog.beaverton.ibm.com>
	 <200608171512.00417.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 15:32:44 -0700
Message-Id: <1155853964.31755.131.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 15:11 -0700, Jesse Barnes wrote:
> On Thursday, August 17, 2006 2:58 pm, john stultz wrote:
> > On Thu, 2006-08-17 at 13:43 +0200, Roman Zippel wrote:
> > > On Wed, 16 Aug 2006, john stultz wrote:
> > > > > For example there is a POSIX-like sys_clock_gettime() intended
> > > > > to server the end-user directly, but there's no counterpart
> > > > > do_clock_gettime() to server any in-kernel needs.
> > > >
> > > > Hmmm.. ktime_get(), ktime_get_ts() and ktime_get_real(), provide
> > > > this info. Is there something missing here?
> > >
> > > What is missing is the abiltity to map a clock to a posix clock, so
> > > that you would have CLOCK_REALTIME/CLOCK_MONOTONIC as NTP controlled
> > > clocks and other CLOCK_* as the raw clock.
> >
> > Is there a use case for this (wanting non-NTP corrected time on a
> > system running NTPd) you have in mind?
> 
> Isn't this what CLOCK_MONOTONIC[_HR] is for?  It's not supposed to jump 
> around at all, so the basic usage model is to use this source for 
> timestamping purposes...

Well, CLOCK_MONOTONIC is not affected by calls to settimeofday() so it
will never go backward, however it does get frequency correction if
provided by NTP (thus a second will be a correct second and you won't
accumulate error).

Also the _HR clocks have always been out of tree, so there isn't the
binary compatibility worry.

thanks
-john



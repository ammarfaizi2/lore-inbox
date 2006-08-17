Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWHQXCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWHQXCx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 19:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWHQXCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 19:02:53 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:32196 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965150AbWHQXCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 19:02:51 -0400
Subject: Re: Linux time code
From: john stultz <johnstul@us.ibm.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       linux-kernel@vger.kernel.org, Udo van den Heuvel <udovdh@xs4all.nl>
In-Reply-To: <200608171550.31097.jbarnes@virtuousgeek.org>
References: <44E32B23.16949.BBB1EC4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	 <200608171512.00417.jbarnes@virtuousgeek.org>
	 <1155853964.31755.131.camel@cog.beaverton.ibm.com>
	 <200608171550.31097.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 16:02:48 -0700
Message-Id: <1155855768.31755.138.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 15:50 -0700, Jesse Barnes wrote:
> On Thursday, August 17, 2006 3:32 pm, john stultz wrote:
> > On Thu, 2006-08-17 at 15:11 -0700, Jesse Barnes wrote:
> > > On Thursday, August 17, 2006 2:58 pm, john stultz wrote:
> > > > On Thu, 2006-08-17 at 13:43 +0200, Roman Zippel wrote:
> > > > > What is missing is the abiltity to map a clock to a posix clock,
> > > > > so that you would have CLOCK_REALTIME/CLOCK_MONOTONIC as NTP
> > > > > controlled clocks and other CLOCK_* as the raw clock.
> > > >
> > > > Is there a use case for this (wanting non-NTP corrected time on a
> > > > system running NTPd) you have in mind?
> > >
> > > Isn't this what CLOCK_MONOTONIC[_HR] is for?  It's not supposed to
> > > jump around at all, so the basic usage model is to use this source
> > > for timestamping purposes...
> >
> > Well, CLOCK_MONOTONIC is not affected by calls to settimeofday() so it
> > will never go backward, however it does get frequency correction if
> > provided by NTP (thus a second will be a correct second and you won't
> > accumulate error).
> 
> Hm, I guess that's ok for most of the timestamp applications I'm aware of 
> as long as NTP won't cause the clock to stand still...

Nope. Its limited to a +/-500ppm adjustment max.


> FWIW I think many other Unices provide a raw cycle counter via the POSIX 
> clock routines.  I don't imagine they're NTP corrected, since at least 
> on IRIX the application is expected to handle even cycle counter 
> wraparound.

Yea, I just want to make sure we're not creating a
portability/maintenance nightmare by exporting too much raw hardware
information.

thanks
-john


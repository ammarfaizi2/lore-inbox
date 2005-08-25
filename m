Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVHYCOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVHYCOL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 22:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVHYCOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 22:14:11 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:62629 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932488AbVHYCOJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 22:14:09 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: george@mvista.com
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, benh@kernel.crashing.org,
       Anton Blanchard <anton@samba.org>, frank@tuxrocks.com,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <430D227D.2070001@mvista.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508152115480.3728@scrub.home>
	 <1124151001.8630.87.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508162337130.3728@scrub.home>
	 <1124241449.8630.137.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508182213100.3728@scrub.home>
	 <1124505151.22195.78.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508202204240.3728@scrub.home>
	 <1124737075.22195.114.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508230134210.3728@scrub.home>
	 <1124830262.20464.26.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508232321530.3728@scrub.home>
	 <1124838847.20617.11.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508240134050.3743@scrub.home> <430BBF82.2010209@mvista.com>
	 <1124915766.20820.67.camel@cog.beaverton.ibm.com>
	 <430D06D0.4080904@mvista.com>
	 <1124930555.20820.132.camel@cog.beaverton.ibm.com>
	 <430D227D.2070001@mvista.com>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 19:13:57 -0700
Message-Id: <1124936038.20820.155.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-24 at 18:44 -0700, George Anzinger wrote:
> > Ok, so your forcing gettimeofday to be interval aware, so its applying
> > different fixed NTP adjustments to different chunks of the current
> > interval. The issue of course is if you're using fixed adjustments, is
> > that you have to have n ntp adjustments for n intervals, or you have to
> > apply the same ntp adjustment to multiple intervals. 
> 
> Uh, are you saying that one ntpd call can set up several different 
> adjustments?

Well, it allows for frequency adjustments, tick adjustments, and offset
adjustments in a single call or just the singleshot (adjtime)
adjustment. However it does not give multiple scaling factors for
different intervals, so you are correct there. 


>   I was assuming that any given call would set up either a 
> fixed adjustment for ever or a fixed adjustment to be applied for a 
> fixed number of ticks (or until so much correcting was done, which, in 
> the end is the same thing at this point in the code).
> 
> If ntpd has to come back to change the adjustment, I am assuming that 
> some kernel action can be taken at that time to sync the xtime clock and 
> the gettimeofday reading of it.  I.e. we would only have to keep track 
> of one adjustment with a possible pre specified end time.

Well, I guess a component of the adjustment would end at a specified
time, that's true. 


> >>I would argue that only two terms are needed here regardless of 
> >>how late a tick is.  This is because, I would expect the ntp system call 
> >>to sync the two clocks.  This means in your example, the ntp call would 
> >>have been made at, or prior to the timer interrupt at 2 and this is the 
> >>same edge that gettimeofday is to used to start applying the correction.
> > 
> > 
> > If you argue that we only need two adjustments, why not argue for only
> > one? You're saying have one adjustment that you apply for the first
> > tick's worth of time, and a second adjustment that you apply for the
> > following N ticks' worth of time in the interval. Why the odd base
> > case? 
> 
> Correct me if I am wrong here, but I am assuming that ntpd can ask for 
> an adjustment of X amount which the kernel changes into N adjustments of 
> X/N amount spread over the next N ticks.  

No, sorry, you are correct there, I was confusing things. 

It may work, and I had considered a similar idea when developing my
solution, but it seemed far too ugly and complicated. But that could
have just been my fault. :)

thanks
-john


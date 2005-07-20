Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVGTQ1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVGTQ1U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 12:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVGTQ1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 12:27:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:60844 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261398AbVGTQ1F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 12:27:05 -0400
Subject: Re: [RFC - 0/12] NTP cleanup work (v. B4)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <Pine.LNX.4.61.0507171706490.3728@scrub.home>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0507171706490.3728@scrub.home>
Content-Type: text/plain
Date: Wed, 20 Jul 2005 09:26:46 -0700
Message-Id: <1121876812.4259.14.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-17 at 20:00 +0200, Roman Zippel wrote:
> On Fri, 15 Jul 2005, john stultz wrote:
> 
> > 	In my attempts to rework the timeofday subsystem, it was suggested I
> > try to avoid mixing cleanups with functional changes. In response to the
> > suggestion I've tried to break out the majority of the NTP cleanups I've
> > been working out of my larger patch and try to feed it in piece meal. 
> > 
> > The goal of this patch set is to isolate the in kernel NTP state machine
> > in the hope of simplifying the current timeofday code.
> 
> I don't really like, where you taken it with ntp_advance(). With these 
> patches you put half the ntp state machine in there and execute it at 
> every single tick.

Hmm. While second_overflow() has been integrated into ntp_advance, we
are not actually running that code every tick. Instead we keep an
internal interval counter that runs the equivalent second_overflow()
code only once a second. Maybe I'm not understanding specifically which
you're talking about? 


> From the previous patches I can guess where you want to go with this, but 
> I think it's the wrong direction. The code is currently as is for a 
> reason, it's optimized for tick based system and I don't see a reason to 
> change this for tick based system.

Well, with the exception of the last two patches, these changes should
just be cleanups. If you notice a change in behavior in the first 10
patches, please let me know.

> If you want to change this for cycle based system, you have to give more 
> control to the arch/timer source, which simply call a different set of 
> functions and the ntp core system basically just acts as a library to the 
> timer source.
> Tick based timer sources continue to update xtime and cycle based system 
> will modify the cycle multiplier (e.g. what ppc64 does). Don't force 
> everything to use the same set of functions, you'll make it only more 
> complex.

In a sense that's what I'm trying to provide, the NTP state machine will
provide the adjustment that you can either apply completely at tick time
or continually w/ a timesource.

I really don't think the NTP changes I've mailed is very complex.
Please, be specific and point to something you think is an issue and
I'll do my best to fix it.


>  Larger ntp state updates don't have to be done more than once a 
> second and leave the details of how the clock is updated to the clock 
> source (just provide some library functions it can use).

Again, I'm not be doing larger NTP state machine changes every tick.


Thanks again for the feedback, I really do appreciate the review.

thanks
-john


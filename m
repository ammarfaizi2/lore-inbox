Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVIWA0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVIWA0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 20:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVIWA0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 20:26:00 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16313 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751234AbVIWAZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 20:25:59 -0400
Date: Fri, 23 Sep 2005 02:25:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Christopher Friesen <cfriesen@nortel.com>
cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
In-Reply-To: <43333EBA.5030506@nortel.com>
Message-ID: <Pine.LNX.4.61.0509230151080.3743@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0509201247190.3743@scrub.home> <1127342485.24044.600.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0509221816030.3728@scrub.home> <43333EBA.5030506@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 22 Sep 2005, Christopher Friesen wrote:

> Roman Zippel wrote:
> 
> > This no answer at all, you only repeat what you already said above. :(
> > Care to share your knowledge?
> 
> Ingo already gave an example.  "a busy network server can easily have millions
> of timers pending. I once had to increase a server's 16 million tw timer
> sysctl limit ..."

I hoped for a more concrete example (i.e. pointer to source), but this one 
at least gave me enough hints where to look.
There are ways to avoid this huge number of added timers, but this 
requires a better analysis of the problem.

> I see two assumptions that lead to the API using nanoseconds:
> 
> 1) it is desireable to have a human-time-unit timer API, so that people can
> specify timeouts in easily-understood units
> 2) eventually we will use sub-ms resolution timers, so it makes sense to just
> jump to nanoseconds as our base timing unit
> 
> Are these reasonable starting points, or is there disagreement on these?
> 
> Maybe it would make sense to have the API be in nanoseconds and internally use
> 32bit ms for now, and only change to 64bit nanos when we actually move to
> sub-ms resolution timers.

Actually the decision to use ns has nothing to do with API issues. 
<linux/jiffies.h> has already a lot of options to specify timeouts for 
kernel timer. The official userspace API is mostly timespec/timeval.
The nsec_t type is an _internal_ type to manage time, so this makes it 
possible to do something like this:

#ifdef CONFIG_HIRES_TIMER
typedef u64 ktime_t;
#else
typedef u32 ktime_t;
#endif

bye, Roman

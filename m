Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWDROv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWDROv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 10:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWDROv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 10:51:57 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:58393 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932247AbWDROv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 10:51:56 -0400
Subject: Re: [RT] bad BUG_ON in rtmutex.c
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1145370733.17085.110.camel@localhost.localdomain>
References: <1145324887.17085.35.camel@localhost.localdomain>
	 <1145362851.5447.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0604180831390.9005@gandalf.stny.rr.com>
	 <1145365886.5447.28.camel@localhost.localdomain>
	 <1145368228.17085.85.camel@localhost.localdomain>
	 <1145369381.5447.40.camel@localhost.localdomain>
	 <1145370733.17085.110.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 07:51:53 -0700
Message-Id: <1145371913.5447.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 10:32 -0400, Steven Rostedt wrote:

> 
> Actually, where that BUG_ON was is the exiting of the chain walk. So it
> does stop.  It's the higher priority task that needs to be continuing
> the chain walk for that problem to occur.  So really, it already does
> what you suggest :)

I bet you could test for that condition in some other spots too . Like
when it adds to the pi_waiters , you could test if the priorities are
out of sync ..

> > 
> > > To keep latencies down, we are letting the PI chain walk be preempted,
> > > by releasing locks.  It's understood that the chain can then change
> > > while walking (big debate about this between Ingo, tglx and Esben).  But
> > > at the end, we decided on it being better to have latencies down, and
> > > just make adjustments when they arise.  This also keeps the latencies
> > > bounded, since the old way was harder to know the worst case (PI chain
> > > creep).
> > 
> > I can imagine. Seems like PI is always a point of controversy .
> 
> But, as PI matures, it seems to be more and more acceptable.

	I read an article on priority ceiling as another method of doing this.
Priority ceiling doesn't seem better, but at the same time I can't
imagine how you'd implement it in Linux, or not in a straight forward
way .

> Also, I always test on SMP (then I test on UP) and the chain walkers
> were on two CPUs.

Yeah, best policy, I've learned ..

Daniel


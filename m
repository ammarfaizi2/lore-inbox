Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVIERCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVIERCH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 13:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVIERCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 13:02:07 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1691 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932304AbVIERCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 13:02:06 -0400
Date: Mon, 5 Sep 2005 10:02:02 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905170202.GJ25856@us.ibm.com>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050905070053.GA7329@in.ibm.com> <20050905072704.GB5734@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905072704.GB5734@atomide.com>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.2005 [10:27:05 +0300], Tony Lindgren wrote:
> * Srivatsa Vaddagiri <vatsa@in.ibm.com> [050905 10:03]:
> > On Sun, Sep 04, 2005 at 01:10:54PM -0700, Nishanth Aravamudan wrote:
> > > 
> > > Also, I am a bit confused by the use of "dynamic-tick" to describe these
> > > changes. To me, these are all NO_IDLE_HZ implementations, as they are
> > > only invoked from cpu_idle() (or their equivalent) routines. I know this
> > > is true of s390 and the x86 code, and I believe it is true of the ARM
> > > code? If it were dynamic-tick, I would think we would be adjusting the
> > > timer interrupt frequency continuously (e.g., at the end of
> > > __run_timers() and at every call to {add,mod,del}_timer()). I was
> > > working on a patch which did some renaming to no_idle_hz_timer, etc.,
> > > but it's mostly code churn :)
> > 
> > Yes, the name 'dynamic-tick' is misleading!
> 
> Huh? For most people dynamic-tick is much more descriptive name than
> NO_IDLE_HZ or VST!

I understand this. My point is that the structures are *not*
dynamic-tick specific. They are interrupt source specific, generally
(also known as hardware timers) -- dynamic tick or NO_IDLE_HZ are the
users of the interrupt source reprogramming functions, but not the
reprogrammers themselves, in my mind. Also, it still would be confusing
to use dynamic-tick, when the .config option is NO_IDLE_HZ! :)

> If you wanted, you could reprogram the next timer to happen from
> {add,mod,del}_timer() just by calling the timer_dyn_reprogram() there.

I messed with this with my soft-timer rework (which has since has fallen
by the wayside). It is a bit of overhead, especially del_timer(), but
it's possible. This is what I would consider "dynamic-tick." And I would
setup a *different* .config option to enable it. Perhaps depending on
CONFIG_NO_IDLE_HZ.

> And you would want to do that if you wanted sub-jiffie timer
> interrupts.

Yes, true, it does enable that. Well, to be honest, it completely
redefines (in some sense) the jiffy, as it is potentially continuously
changing, not just at idle times.

> So I'd rather not limit the name to the currently implemented
> functionality only :)

I'm not trying to limit the name, but make sure we are tying the
strcutures and functions to the right abstraction (interrupt source, in
my opinion).

Thanks,
Nish

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVIEH1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVIEH1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 03:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVIEH1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 03:27:42 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:61407 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932268AbVIEH1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 03:27:41 -0400
X-ORBL: [67.117.73.34]
Date: Mon, 5 Sep 2005 10:27:05 +0300
From: Tony Lindgren <tony@atomide.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905072704.GB5734@atomide.com>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050905070053.GA7329@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905070053.GA7329@in.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Srivatsa Vaddagiri <vatsa@in.ibm.com> [050905 10:03]:
> On Sun, Sep 04, 2005 at 01:10:54PM -0700, Nishanth Aravamudan wrote:
> > 
> > Also, I am a bit confused by the use of "dynamic-tick" to describe these
> > changes. To me, these are all NO_IDLE_HZ implementations, as they are
> > only invoked from cpu_idle() (or their equivalent) routines. I know this
> > is true of s390 and the x86 code, and I believe it is true of the ARM
> > code? If it were dynamic-tick, I would think we would be adjusting the
> > timer interrupt frequency continuously (e.g., at the end of
> > __run_timers() and at every call to {add,mod,del}_timer()). I was
> > working on a patch which did some renaming to no_idle_hz_timer, etc.,
> > but it's mostly code churn :)
> 
> Yes, the name 'dynamic-tick' is misleading!

Huh? For most people dynamic-tick is much more descriptive name than
NO_IDLE_HZ or VST!

If you wanted, you could reprogram the next timer to happen from
{add,mod,del}_timer() just by calling the timer_dyn_reprogram() there.

And you would want to do that if you wanted sub-jiffie timer interrupts.

So I'd rather not limit the name to the currently implemented functionality
only :)

Tony

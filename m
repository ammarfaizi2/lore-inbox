Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWH2AWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWH2AWz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 20:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWH2AWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 20:22:55 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:49633 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964938AbWH2AWy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 20:22:54 -0400
Date: Tue, 29 Aug 2006 05:53:02 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Paul E McKenney <paulmck@us.ibm.com>
Subject: Re: [PATCH 0/4] RCU: various merge candidates
Message-ID: <20060829002302.GC32697@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060828160845.GB3325@in.ibm.com> <20060828120611.afad8b0f.akpm@osdl.org> <20060828191642.GA32697@in.ibm.com> <20060828124058.cca5f5ab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828124058.cca5f5ab.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 12:40:58PM -0700, Andrew Morton wrote:
> On Tue, 29 Aug 2006 00:46:42 +0530
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> 
> >
> > rcutorture fix patches independent of rcu implementation changes
> > in this patchset.
> 
> So this patchset is largely orthogonal to the presently-queued stuff?

Yes, it should be.

> > > Now what?
> > 
> > Heh. I can always re-submit against -mm after I wait for a day or two
> > for comments :)
> 
> That would be good, thanks.  We were seriously considering merging all the
> SRCU stuff for 2.6.18, because

I think non-srcu rcutorture patches can be merged in 2.6.19. srcu
is a tossup. Perhaps srcu and this patchset may be merge candidates
for 2.6.20 should things go well in review and testing. Should I re-submit
against 2.6.18-mm1 or so (after your patchset reduces in size) ?
What is a convenient time ?

> cpufreq-make-the-transition_notifier-chain-use-srcu.patch fixes a cpufreq
> down()-in-irq-disabled warning at suspend time.
> 
> But that's a lot of new stuff just to fix a warning about something which
> won't actually cause any misbehaviour.  We could just as well do
> 
> 	if (irqs_disabled())
> 		down_read_trylock(...);	/* suspend */
> 	else
> 		down_read(...);
> 
> in cpufreq to temporarily shut the thing up.

GAh! cpufreq. Already I am having to look at all of cpufreq and the
cpufreq drivers, change notifiers for the whole locking model for
the other (hotplug) cleanup. I will keep this in mind.

Thanks
Dipankar

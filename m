Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbWHXVuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWHXVuh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030481AbWHXVuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:50:37 -0400
Received: from ns.suse.de ([195.135.220.2]:9619 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030383AbWHXVuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:50:35 -0400
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: [RFC] maximum latency tracking infrastructure
References: <1156441295.3014.75.camel@laptopd505.fenrus.org>
	<200608241408.03853.jbarnes@virtuousgeek.org>
	<44EE1801.3060805@linux.intel.com>
	<200608241429.45791.jbarnes@virtuousgeek.org>
From: Andi Kleen <ak@suse.de>
Date: 24 Aug 2006 23:50:27 +0200
In-Reply-To: <200608241429.45791.jbarnes@virtuousgeek.org>
Message-ID: <p73r6z5erbw.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@virtuousgeek.org> writes:

> On Thursday, August 24, 2006 2:20 pm, Arjan van de Ven wrote:
> > Jesse Barnes wrote:
> > > On Thursday, August 24, 2006 10:41 am, Arjan van de Ven wrote:
> > >> The reason for adding this infrastructure is that power management
> > >> in the idle loop needs to make a tradeoff between latency and power
> > >> savings (deeper power save modes have a longer latency to running
> > >> code again).
> > >
> > > What if a processor was already in a sleep state when a call to
> > > set_acceptable_latency() latency occurs?
> >
> > there's nothing sane that can be done in that case; any wake up
> > already will cause the unwanted latency! A premature wakeup is only
> > making it happen *now*, but now is as inconvenient a time as any...
> > (in fact it may be a worst case time scenario, say, an audio
> > interrupt...)
> 
> Depends on what's going on.  What if you have a two socket machine, and 
> one CPU is in C3 when the latency setting occurs?

I didn't think there were currently any multi socket machines with C3 
support? The best you get is dual core.

> Shouldn't you wake it 
> up and prevent it from going that deep again?  But you're right, you 
> won't necessarily improve anything...

Generally there are so many events that wake up CPUs that the case is pretty 
academic -- all CPUs will eventually wake up in a reasonable time
(before your driver initialization finished likely) and then follow
the new latency settings.

Maybe at some point if all the idle breaking events in Linux have been
fixed up it might be a problem, but I think that's a long time off.

-Andi


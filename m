Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUC3OpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 09:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263689AbUC3OpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 09:45:16 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:7084 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263685AbUC3OpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 09:45:06 -0500
Date: Tue, 30 Mar 2004 20:13:24 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Dave Miller <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andrew Morton <akpm@osdl.org>
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040330144324.GA3778@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040329184550.GA4540@in.ibm.com> <20040329222926.GF3808@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329222926.GF3808@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 12:29:26AM +0200, Andrea Arcangeli wrote:
> the only real starvation you can claim is in presence of an _hard_irq
> flood, not a softirq one. Ingo had some patch for the hardirq
> throttling, unfortunately those pathes were mixed with irrelevant
> softirq changes, but the hardirq part of these patches was certainly
> valid (though in most business environments I imagine if one is under
> hardirq attack in the local ethernet, the last worry is probably the
> throttling of hardirqs ;)

Hmm.. What about firewalls and routers on the internet ? Shouldn't
they care ?

> So you're simply asking the ksoftirqd offloading to become more
> aggressive, and to make the softirq even more scheduler friendly,
> something I never had a reason to do yet, since ksoftirqd already
> eliminates the starvation issue, and secondly because I did care about
> the performance of softirq first (delaying softirqs is derimental for
> performance if it happens frequently w/o this kind of flood-load). I
> even got a patch for 2.4 doing this kind of changes to the softirqd for
> similar reasons on embedded systems where the cpu spent on the softirqs
> would been way too much under attack. I had to back it out since it was
> causing drop of performance in specweb or something like that and nobody
> but the embdedded people needed it.  But now here we've a case where it
> makes even more sense since the hardirq aren't strictly related to this
> load, this load with the rcu-routing-cache is just about letting the
> scheduler go together witn an intensive softirq load. So we can try
> again with a truly userspace throttling of the softirqs (and in 2.4 I
> didn't change the nice from 19 to -20 so maybe this will just work
> perfectly).

Tried it and it didn't work. I still got dst cache overflows. I will dig
out more numbers about what what happened - is ksoftirqd a pig still or
we are mostly doing short softirq bursts on the back of a hardirq
flood.

Thanks
Dipankar

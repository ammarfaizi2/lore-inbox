Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271589AbRIJSww>; Mon, 10 Sep 2001 14:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271592AbRIJSwm>; Mon, 10 Sep 2001 14:52:42 -0400
Received: from ns.caldera.de ([212.34.180.1]:13289 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S271589AbRIJSwe>;
	Mon, 10 Sep 2001 14:52:34 -0400
Date: Mon, 10 Sep 2001 20:52:50 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010910205250.B22889@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20010910175416.A714@athlon.random> <200109101741.f8AHfwx17136@ns.caldera.de> <20010910200344.C714@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010910200344.C714@athlon.random>; from andrea@suse.de on Mon, Sep 10, 2001 at 08:03:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2001 at 08:03:44PM +0200, Andrea Arcangeli wrote:
> > Do we really need yet-another per-CPU thread for this?  I'd prefer to have
> > the context thread per-CPU instead (like in Ben's asynchio patch) and do
> > this as well.
> 
> The first desing solution I proposed to Paul and Dipankar was just to
> use ksoftirqd for that (in short set need_resched and wait it to be
> cleared), it worked out nicely and it was a sensible improvement with
> respect to their previous patches. (also it was reliable, we cannot
> afford allocations in the wait_for_rcu path to avoid having to introduce
> fail paths) it was also a noop to the ksoftirqd paths.
> 
> However they remarked ksoftirqd wasn't a RT thread so under very high
> load it could introduce an higher latency to the wait_for_rcu calls.

Hmm, I don't see why latency is important for rcu - we only want to
free datastructures.. (mm load?).

On the other hands they are the experts on RCU, not I so I'll believe them.

> So in short if you really are in pain for 8k per cpu to get the best
> runtime behaviour and cleaner code I'd at least suggest to use the
> ksoftirqd way that should be the next best step.

My problem with this appropech is just that we use kernel threads for
more and more stuff - always creating new ones.  I think at some point
they will sum up badly.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263501AbTICG2k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 02:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263559AbTICG2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 02:28:40 -0400
Received: from dp.samba.org ([66.70.73.150]:59790 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263501AbTICG2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 02:28:38 -0400
Date: Wed, 3 Sep 2003 16:28:17 +1000
From: Anton Blanchard <anton@samba.org>
To: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030903062817.GA19894@krispykreme>
References: <20030903040327.GA10257@work.bitmover.com> <20030903041850.GA2978@krispykreme> <20030903042953.GC10257@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903042953.GC10257@work.bitmover.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > I've frequently tried to make the point that all the scaling for
> > > lots of processors is nonsense.  Mr Dell says it better:
> > > 
> > >     "Eight-way (servers) are less than 1 percent of the market and
> > >     shrinking pretty dramatically," Dell said. "If our competitors
> > >     want to claim they're No. 1 in eight-ways, that's fine. We
> > >     want to lead the market with two-way and four-way (processor
> > >     machines)."
> > > 
> > > Tell me again that it is a good idea to screw up uniprocessor
> > > performance for 64 way machines.  Great idea, that.  Go Dinosaurs!
> > 
> > And does your 4 way have hyperthreading?
> 
> What part of "shrinking pretty dramatically" did you not understand?
> Maybe you know more than Mike Dell.  Could you share that insight?

Ok. But only because you asked nicely.

Mike Dell wants to sell 2 and 4 processor boxes and Intel wants to sell 
processors with hyperthreading on them. Scaling to 4 or 8 threads is just
like scaling to 4 or 8 processors, only worse.

However, lets not end up in a yet another 64 way scalability argument here.

The thing we should be worrying about is the UP -> 2 way SMP scalability
issue. If every chip in the future has hyperthreading then all of sudden
everyone is running an SMP kernel. And what hurts us?

atomic ops
memory barriers

Ive always worried about those atomic ops that only appear in an SMP
kernel, but Rusty recently reminded me its the same story for most of the
memory barriers.

Things like RCU can do a lot for this UP -> 2 way SMP issue. The fact it
also helps the big end of town is just a bonus.

Anton

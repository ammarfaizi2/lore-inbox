Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759181AbWK3Izh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759181AbWK3Izh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759183AbWK3Izh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:55:37 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:2491 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1759179AbWK3Izg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:55:36 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: paulmck@linux.vnet.ibm.com
Subject: Re: [RCU] adds a prefetch() in rcu_do_batch()
Date: Thu, 30 Nov 2006 09:55:52 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
References: <a769871e0611211233n20eb9d74j661cd73e9315fade@mail.gmail.com> <200611221602.29597.dada1@cosmosbay.com> <20061130012528.GJ2335@us.ibm.com>
In-Reply-To: <20061130012528.GJ2335@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611300955.52293.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 November 2006 02:25, Paul E. McKenney wrote:
> On Wed, Nov 22, 2006 at 04:02:29PM +0100, Eric Dumazet wrote:
> > On some workloads, (for example when lot of close() syscalls are done),
> > RCU qlen can be quite large, and RCU heads are no longer in cpu cache
> > when rcu_do_batch() is called.
> >
> > This patches adds a prefetch() in rcu_do_batch() to give CPU a hint to
> > bring back cache lines containing 'struct rcu_head's.
> >
> > Most list manipulations macros include prefetch(), but not open coded
> > ones (at least with current C compilers :) )
> >
> > I got a nice speedup on a trivial benchmark  (3.48 us per iteration
> > instead of 3.95 us on a 1.6 GHz Pentium-M)
> > while (1) { pipe(p); close(fd[0]); close(fd[1]);}
>
> Interesting!  How much of the speedup was due to the prefetch() and how
> much to removing the extra store to rdp->donelist?

I only benchmarked the prefetch() case.
 
Then, when cooking the patch I found I could do the rdp->donelist affectation 
after the loop. I am not sure it's worth to do another benchmark for this 
trivial optimization (Please dont tell me its not a valid one :) )

Eric

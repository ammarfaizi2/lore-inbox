Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUGOQXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUGOQXV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 12:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266238AbUGOQXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 12:23:20 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:18215 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264633AbUGOQXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 12:23:01 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: dipankar@in.ibm.com
Subject: Re: [RFC] Lock free fd lookup
Date: Thu, 15 Jul 2004 12:22:24 -0400
User-Agent: KMail/1.6.2
Cc: Chris Wright <chrisw@osdl.org>, Ravikiran G Thirumalai <kiran@in.ibm.com>,
       linux-kernel@vger.kernel.org
References: <20040714045345.GA1220@obelix.in.ibm.com> <200407151022.53084.jbarnes@engr.sgi.com> <20040715161054.GB3957@in.ibm.com>
In-Reply-To: <20040715161054.GB3957@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407151222.24843.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 15, 2004 12:10 pm, Dipankar Sarma wrote:
> Chris raises an interesting issue. There are two ways we can benefit from
> lock-free lookup - avoidance of atomic ops in lock acquisition/release
> and avoidance of contention. The latter can also be provided by
> rwlocks in read-mostly situations like this, but rwlock still has
> two atomic ops for acquisition/release. So, in another
> thread, I have suggested looking into the contention angle. IIUC,
> tiobench is threaded and shares fd table.

I must have missed that thread...  Anyway, that's a good idea.

>
> That said, atomic counters weren't introduced in this patch,
> they are already there for refcounting. cmpxchg is costly,
> but if you are replacing read_lock/atomic_inc/read_unlock,
> lock-free + cmpxchg, it might not be all that bad.

Yeah, I didn't mean to imply that atomics were unique to this patch.

> Atleast, 
> we can benchmark it and see if it is worth it. And in heavily
> contended cases, unlike rwlocks, you are not going to have
> starvation.

Which is good.

> > It seems to me that RCU is basically rwlocks on steroids, which means
> > that using it requires the same care to avoid starvation and/or other
> > scalability problems (i.e. we'd better be really sure that a given
> > codepath really should be using rwlocks before we change it).
>
> The starvation is a problem with rwlocks in linux, not RCU. The
> reader's do not impede writers at all with RCU. There are other
> issues with RCU that one needs to be careful about, but certainly
> not this one.

That's good, I didn't think that RCU would cause starvation, but based on 
previous reading of the code it seemed like it would hurt a lot in other 
ways... but I'm definitely not an expert in that area.

Thanks,
Jesse

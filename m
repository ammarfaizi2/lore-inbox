Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131811AbRCOTpn>; Thu, 15 Mar 2001 14:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131812AbRCOTpd>; Thu, 15 Mar 2001 14:45:33 -0500
Received: from gateway.sequent.com ([192.148.1.10]:48573 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S131811AbRCOTpP>; Thu, 15 Mar 2001 14:45:15 -0500
Date: Thu, 15 Mar 2001 11:44:25 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: J Sloan <jjs@toyota.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: How to optimize routing performance
Message-ID: <20010315114425.C1060@w-mikek2.sequent.com>
In-Reply-To: <Pine.LNX.4.33.0103152304570.1320-100000@duckman.distro.conectiva> <3AB1153F.802BEBA9@toyota.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3AB1153F.802BEBA9@toyota.com>; from jjs@toyota.com on Thu, Mar 15, 2001 at 11:17:19AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2001 at 11:17:19AM -0800, J Sloan wrote:
> Rik van Riel wrote:
> 
> > On Thu, 15 Mar 2001, J Sloan wrote:
> >
> > > There are some scheduler patches that are not part of the
> > > main kernel tree at this point (mostly since they have yet to
> > > be optimized for the common case) which make quite a big
> > > difference under heavy load - you might want to check out:
> > >
> > >     http://lse.sourceforge.net/scheduling/
> >
> > Unrelated.   Fun, but unrelated to networking...
> 
> Fun, yes, and perhaps not directly related, however
> under high load, where the sheer numbet of interrupts
> per second begins to overwhelm the kernel, might it
> not be relevant? After all, the benchmarks do point to
> tangible improvements in the performance of network
> server apps.

I'm not sure if these patches would be of any use here.

One benefit of the multi-queue scheduling patches is that
they allow multiple 'wakeups' to run in parallel instead
of being serialized by the global runqueue lock.  Now if
you are getting lots of interrupts which result in task
wakeups that could potentially be run in parallel (on
separate CPUS with no other serialization in the way)
then you 'might' see some benefit.  Those are some big IFs.

I know little about the networking stack or this workload.
Just wanted to explain how this scheduling work 'could'
be related to interrupt load.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center

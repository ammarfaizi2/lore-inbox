Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbSLDBOG>; Tue, 3 Dec 2002 20:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbSLDBOG>; Tue, 3 Dec 2002 20:14:06 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:24960 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S266771AbSLDBOF>;
	Tue, 3 Dec 2002 20:14:05 -0500
Date: Wed, 4 Dec 2002 02:21:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Christoph Hellwig <hch@sgi.com>,
       rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <20021204012144.GR11730@dualathlon.random>
References: <20021202192652.A25938@sgi.com> <1919608311.1038822649@[10.10.2.3]> <3DEBB4BD.F64B6ADC@digeo.com> <20021202195003.GC28164@dualathlon.random> <3DED18CC.5770EA90@digeo.com> <20021204000618.GG11730@dualathlon.random> <3DED4CA4.5B9A20EA@digeo.com> <20021204004234.GL11730@dualathlon.random> <3DED5700.C32DC2B0@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DED5700.C32DC2B0@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 05:14:40PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > On Tue, Dec 03, 2002 at 04:30:28PM -0800, Andrew Morton wrote:
> > > load is just one or more busywaits.  It has to be a compilation.  It
> > > could be something to do with all the short-lived processes, or gcc -pipe)
> > 
> > could be that we think they're very interactive or something like that.
> 
> I just retested.  This is on uniprocessor.  Running `make -j1 bzImage',
> while typing into a StarOffice 5.2 document:
> 
> - 2.4.19-pre4: smooth
> - 2.4.20aa1: Jerky.  Sometimes it's OK, sometimes a few characters
>   lag.
> 
> Then I disabled `-pipe' in the build and restarted it:
> 
> - 2.4.19-pre4: smooth
> - 2.4.20aa1: Quite a lot more jerky.  Enough to be a bit irritating.
> 
> > ...
> > >
> > > This problem is the "changed sched_yield semantics".  It was actually
> > > tested on uniprocessor.  The difference between 2.4 and 2.4-aa is
> > > still noticeable here, but it is not a terrible problem now.
> > 
> > strange, the algorithm should be nearly the same now (modulo RT). Still
> > I wonder that's something else on the short lived gcc processes side.
> 
> Could be.  Removing -pipe affected it quite a bit.


you could try decreasing PARENT_PENALTY to 50. I would like to see if
the scheduler *still* thinks they're interactive stuff then.

Andrea

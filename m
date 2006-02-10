Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWBJHYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWBJHYT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 02:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWBJHYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 02:24:19 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:40325 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751174AbWBJHYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 02:24:18 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] sched: remove smpnice
Date: Fri, 10 Feb 2006 18:23:28 +1100
User-Agent: KMail/1.9.1
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, npiggin@suse.de,
       mingo@elte.hu, rostedt@goodmis.org, pwil3058@bigpond.net.au,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20060207142828.GA20930@wotan.suse.de> <20060209230145.A17405@unix-os.sc.intel.com> <20060209231703.4bd796bf.akpm@osdl.org>
In-Reply-To: <20060209231703.4bd796bf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101823.29530.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 18:17, Andrew Morton wrote:
> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> > On Tue, Feb 07, 2006 at 03:36:17PM -0800, Andrew Morton wrote:
> > > Suresh, Martin, Ingo, Nick and Con: please drop everything,
> > > triple-check and test this:
> > >
> > > From: Peter Williams <pwil3058@bigpond.net.au>
> > >
> > > This is a modified version of Con Kolivas's patch to add "nice" support
> > > to load balancing across physical CPUs on SMP systems.
> >
> > I have couple of issues with this patch.
> >
> > a) on a lightly loaded system, this will result in higher priority job
> > hopping around from one processor to another processor.. This is because
> > of the code in find_busiest_group() which assumes that SCHED_LOAD_SCALE
> > represents a unit process load and with nice_to_bias calculations this is
> > no longer true(in the presence of non nice-0 tasks)
> >
> > My testing showed that 178.galgel in SPECfp2000 is down by ~10% when run
> > with nice -20 on a 4P(8-way with HT) system compared to a nice-0 run.
> >
> > b) On a lightly loaded system, this can result in HT scheduler
> > optimizations being disabled in presence of low priority tasks... in this
> > case, they(low priority ones) can end up running on the same package,
> > even in the presence of other idle packages.. Though this is not as
> > serious as "a" above...
>
> Thanks very much for discvoring those things.
>
> That rather leaves us in a pickle wrt 2.6.16.
>
> It looks like we back out smpnice after all?

Give it the arse.

> Whatever we do, time is pressing.

We did without smp nice from 2.6.0 till 2.6.14, we can do without it again for 
some more time. Put it back in -mm for more tweaking and hopefully this added 
attention will get it more testing before being pushed.

Cheers,
Con

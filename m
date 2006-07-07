Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWGGASJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWGGASJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWGGASJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:18:09 -0400
Received: from mga07.intel.com ([143.182.124.22]:5730 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750916AbWGGASI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:18:08 -0400
X-IronPort-AV: i="4.06,214,1149490800"; 
   d="scan'208"; a="62375085:sNHT636619333"
Date: Thu, 6 Jul 2006 17:08:24 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: vatsa@in.ibm.com, nickpiggin@yahoo.com.au, mingo@elte.hu, hawkes@sgi.com,
       dino@in.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com, ak@suse.de
Subject: Re: [PATCH 2.6.16-mm1 2/2] sched_domains: Allocate sched_groups dynamically
Message-ID: <20060706170824.E13512@unix-os.sc.intel.com>
References: <20060325082804.GB17011@in.ibm.com> <20060706170151.cdb1dc6c.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060706170151.cdb1dc6c.pj@sgi.com>; from pj@sgi.com on Thu, Jul 06, 2006 at 05:01:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have reviewed Srivatsa's code back then and made sure it fixes
the problem in the presence of multi-core too. Based on my review,
I provided feedback to Srivatsa then.

In short, multi-core was broken too and Srivatsa's patch fixed it.

thanks,
suresh

On Thu, Jul 06, 2006 at 05:01:51PM -0700, Paul Jackson wrote:
> Several months ago, Srivatsa wrote:
> > I couldn't test this on a multi-core machine, since I don't think we
> > have one in our lab.
> > 
> > Suresh, would you mind testing the patch on a multi-core machine, in case you 
> > have access to one?
> > 
> > Basically you would need to do create a exclusive CPUset with one CPU in it 
> > (ensure that its sibling in the same core is not part of the same
> > CPUset). As soon as you make the CPUset exclusive, you would hit some
> > kind of hang. With this patch, the hang should go away.
> 
> 
> Summary: Where do we stand with multi-core and this bug?
> 
> 
> I don't see a reply from Suresh on whether he could test on multi-core.
> 
> I finally happened to be running on a hyper-threaded box last week,
> and stumbled over this bug that Srivatsa's patch fixes.  Hawkes
> remembered Srivatsa's patch, I tried it, and it worked.  Thanks!
> 
> But now I'm quite confused as to the situation with multi-core.
> 
> Details of my confusions, for the bored:
> 
>     From Srivatsa's remark, I would have guessed that multi-core was
>     at risk for this bug too, but Srivatsa was hopeful that his patch
>     would fix that too.
> 
>     Early this week, a couple of people who shall remain anonymous here
>     raised the question of whether we had the same problem with multi-core.
>     One of them believed that multi-core did have the same problem.
> 
>     I got a little time on a multi-core system this morning to test it,
>     and while running what I -thought- was a kernel -without- Srivatsa's
>     patch, I could not find any problem.  I made a cpuset with just a
>     single logical cpu in it, and marked it cpu_exclusive, and the
>     system did not hang.
> 
>     It will be another day before I can get on that multi-core system
>     again to verify my findings.
> 
>     I was hoping that someone could actually -read- this code and state
>     with confidence that one of the following held:
>      * it was already working ok on multi-core (a one CPU cpu_exclusive cpuset),
>      * it was broken, but Srivatsa's patch fixes it, or
>      * it's still broken, even with Srivatsa's patch.
> 
>     I tried a couple of times to read the code myself, but could not
>     make any headway there.
> 
> So ... what's up with multi-core and this bug?
> 
> -- 
>                   I won't rest till it's the best ...
>                   Programmer, Linux Scalability
>                   Paul Jackson <pj@sgi.com> 1.925.600.0401

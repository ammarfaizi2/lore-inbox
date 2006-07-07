Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWGGACN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWGGACN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWGGACN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:02:13 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:41170 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750881AbWGGACM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:02:12 -0400
Date: Thu, 6 Jul 2006 17:01:51 -0700
From: Paul Jackson <pj@sgi.com>
To: vatsa@in.ibm.com
Cc: nickpiggin@yahoo.com.au, mingo@elte.hu, hawkes@sgi.com, dino@in.ibm.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org, suresh.b.siddha@intel.com,
       ak@suse.de
Subject: Re: [PATCH 2.6.16-mm1 2/2] sched_domains: Allocate sched_groups
 dynamically
Message-Id: <20060706170151.cdb1dc6c.pj@sgi.com>
In-Reply-To: <20060325082804.GB17011@in.ibm.com>
References: <20060325082804.GB17011@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several months ago, Srivatsa wrote:
> I couldn't test this on a multi-core machine, since I don't think we
> have one in our lab.
> 
> Suresh, would you mind testing the patch on a multi-core machine, in case you 
> have access to one?
> 
> Basically you would need to do create a exclusive CPUset with one CPU in it 
> (ensure that its sibling in the same core is not part of the same
> CPUset). As soon as you make the CPUset exclusive, you would hit some
> kind of hang. With this patch, the hang should go away.


Summary: Where do we stand with multi-core and this bug?


I don't see a reply from Suresh on whether he could test on multi-core.

I finally happened to be running on a hyper-threaded box last week,
and stumbled over this bug that Srivatsa's patch fixes.  Hawkes
remembered Srivatsa's patch, I tried it, and it worked.  Thanks!

But now I'm quite confused as to the situation with multi-core.

Details of my confusions, for the bored:

    From Srivatsa's remark, I would have guessed that multi-core was
    at risk for this bug too, but Srivatsa was hopeful that his patch
    would fix that too.

    Early this week, a couple of people who shall remain anonymous here
    raised the question of whether we had the same problem with multi-core.
    One of them believed that multi-core did have the same problem.

    I got a little time on a multi-core system this morning to test it,
    and while running what I -thought- was a kernel -without- Srivatsa's
    patch, I could not find any problem.  I made a cpuset with just a
    single logical cpu in it, and marked it cpu_exclusive, and the
    system did not hang.

    It will be another day before I can get on that multi-core system
    again to verify my findings.

    I was hoping that someone could actually -read- this code and state
    with confidence that one of the following held:
     * it was already working ok on multi-core (a one CPU cpu_exclusive cpuset),
     * it was broken, but Srivatsa's patch fixes it, or
     * it's still broken, even with Srivatsa's patch.

    I tried a couple of times to read the code myself, but could not
    make any headway there.

So ... what's up with multi-core and this bug?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

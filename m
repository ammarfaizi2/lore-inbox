Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945984AbWJSG57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945984AbWJSG57 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 02:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945987AbWJSG57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 02:57:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11139 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1945984AbWJSG56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 02:57:58 -0400
Date: Wed, 18 Oct 2006 23:57:46 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: holt@sgi.com, suresh.b.siddha@intel.com, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: exclusive cpusets broken with cpu hotplug
Message-Id: <20061018235746.95343e77.pj@sgi.com>
In-Reply-To: <45371CBB.2030409@yahoo.com.au>
References: <20061017192547.B19901@unix-os.sc.intel.com>
	<20061018001424.0c22a64b.pj@sgi.com>
	<20061018095621.GB15877@lnx-holt.americas.sgi.com>
	<20061018031021.9920552e.pj@sgi.com>
	<45361B32.8040604@yahoo.com.au>
	<20061018231559.8d3ede8f.pj@sgi.com>
	<45371CBB.2030409@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> I don't understand why you think the "implicit" (as in, not directly user
> controlled?) linkage is wrong.

Twice now I've given the following specific example.  I am not yet
confident that I have it right, and welcome feedback.

However, Suresh has apparently agreed with my conclusion that one
can use the current linkage between cpu_exclusive cpusets and sched
domains to get unexpected and perhaps undesirable sched domain setups.

What's your take on this example:

> Example:
> 
>     As best as I can tell (which is not very far ;), if some hapless
>     user does the following:
> 
> 	    /dev/cpuset		cpu_exclusive == 1; cpus == 0-7
> 	    /dev/cpuset/a	cpu_exclusive == 1; cpus == 0-3
> 	    /dev/cpsuet/b	cpu_exclusive == 1; cpus == 4-7
> 
>     and then runs a big job in the top cpuset (/dev/cpuset), then that
>     big job will not load balance correctly, with whatever threads
>     in the big job that got stuck on cpus 0-3 isolated from whatever
>     threads got stuck on cpus 4-7.
> 
> Is this correct?

If I have concluded incorrectly what happens in the above example
(good chance) then please educate me on how this stuff works.

I should warn you that I have demonstrated a remarkable resistance
to being educatible on this subject ;).

If this interface has no material affect on users programs, then
implicit may well be ok.  But if it has material affect on the
behaviour, such as CPU placement or scope of load balancing, of user
programs, then I am strongly in favor of making that affect explicit,
understandable, and visible at runtime, on production systems.

That, or getting rid of the affect, and replacing it with something
that is simple, understandable, explicit and visible ... my current
plan.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbUC3JnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbUC3JnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:43:11 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:28358 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263582AbUC3JnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:43:03 -0500
Date: Tue, 30 Mar 2004 00:45:40 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, raybry@sgi.com,
       akpm@osdl.org
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040330004540.0144215d.pj@sgi.com>
In-Reply-To: <20040330063805.GI791@holomorphy.com>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1080606618.6742.89.camel@arrakis>
	<20040330012744.GZ791@holomorphy.com>
	<20040329172725.255e4829.pj@sgi.com>
	<20040330063805.GI791@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's just as bad, since cpus_addr() does that now.

Excellent - I missed that one somehow.

How about I change my cpus_raw back to cpus_addr ?
Would that meet with your approval ?

> What I'm really trying to point out on this front is that you should
> survey/lobby (sub)arch maintainers to get the requirement lifted, not me.

Good point.

> Compiler-specific operational semantics and compiler version
> dependencies are *REALLY* scary from a portability POV and have already
> burned the cpumask_t codebase once in the case of the bitmap inlines.

Mention of such past difficulties, without any elaboration of details,
serves only to discourage change.

If you can provide sufficient details that we can make a useful
evaluation of whether such concerns are still a show stopper for
this work, then I welcome your presentation of such.

If not, then I can do nothing with this observation.  In that case,
given the clear and substantial simplifications that appear possible,
I can only push on.

> Okay, I checked and a staged migration isn't needed given the number
> of callers:

Good - thanks for checking.

> Your assessment of it appears to be off-base, as that kind of
> type ambiguity is effectively mandated by the requirements of
> not incurring indirection overhead for smaller systems while
> simultaneously transparently falling back to call-by-reference
> semantics for larger ones.

I agree that if that's the general requirement, then cpumask_const_t
is an appropriate answer.

The only decent example of any such requirement ever being needed that I
have been able to locate so far came from the sparc architecture.  After
a useful discussion of this with David Miller, on a subthread of
Matthew's thread last week (IIRC), this only applied to sparc32 and
those folks are a ways from providing SMP.  Also, I could not find
any performance critical paths in the kernel that pass a cpumask_t
as an argument to a real (non-inline) function.  So all in all, the
chance that we need this, on an architecture with structure passing
constraints, is getting pretty small.

And if ever we do, then I would have to recommend we balance the
'requirement' for transparent argument type adaption with the
'requirement' to keep things simple.  If one call had to pass an
explicit pointer, or even had to wrap the real function call with a
macro, that selectively passed a value or a pointer, depending on
cpumask_t size, then that would be an alternative well worth
considering, in my view, over the alternative of providing an entire
parallel set of mask headers that provide this 'const' capability.

Some requirements are better met with narrowly focused special cases,
than with fully generalized solutions.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

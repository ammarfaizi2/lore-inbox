Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbVDYOk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVDYOk3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 10:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbVDYOk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 10:40:29 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:54224 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262595AbVDYOkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 10:40:18 -0400
Date: Mon, 25 Apr 2005 07:38:48 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [Lse-tech] Re: [RFC PATCH] Dynamic sched domains aka Isolated
 cpusets
Message-Id: <20050425073848.2d2abf9f.pj@sgi.com>
In-Reply-To: <20050425115321.GA3944@in.ibm.com>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050418225427.429accd5.pj@sgi.com>
	<20050419093438.GB3963@in.ibm.com>
	<20050419102348.118005c1.pj@sgi.com>
	<20050420071606.GA3931@in.ibm.com>
	<20050420120946.145a5973.pj@sgi.com>
	<20050421162738.GA4200@in.ibm.com>
	<20050423153059.0ab5fdc2.pj@sgi.com>
	<20050425115321.GA3944@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar, replying to pj:
> > I don't understand why what's there now isn't sufficient.  I don't see
> > that this patch provides any capability that you can't get just by
> > properly placing tasks in cpusets that have the desired cpus and nodes.
> > This patch leaves the per-cpu kernel threads with no cpuset that allows
> > what they need, and it complicates the semantics of things, in ways that
> > I still don't entirely understand.
> 
> You are forgetting the fact that the scheduler is still load balancing
> across all CPUs and tries to pull tasks only to find that the task's
> cpus_allowed mask prevents it from being moved

Well, I haven't forgotten, but I am having a difficult time figuring out
what your real (most likely just one or two) essential requirements are.

A few days ago, you provided a six step list, under the introduction:
> Ok, Let me begin at the beginning and attempt to define what I am 
> doing here

I suspect those six steps were not really your essential requirements,
but one possible procedure that accomplishes them.

So far I am guessing that your requirement(s) are one or both of the
following two items:

 (1) avoid having the scheduler wasting too much time trying to
     load balance tasks that only turn out to be not allowed on
     the cpus the scheduler is considering, and/or
 (2) provide improved administrative control of a system by being
     able to construct a cpuset that is guaranteed to have no
     overlap of allowed cpus with its parent or any other cpuset
     not descendent from it.

If (1) is one of your essential requirements, then I have described a
couple of implementations that mark some existing cpusets to form a
partition (in the mathematical sense of a disjoint covering of subsets)
of the system to define isolated scheduler domains.  I did this without
adding any additional bitmasks to each cpuset.

If (2) is one of your essential requirements, then I believe this can be
done with the current cpuset kernel code, entirely with additional user
level code.

> I am working on a minimalistic design right now and will get back in
> a day or two

Good.

Hopefully, you will also be able to get through my thick head what you
essential requirement(s) is or are.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401

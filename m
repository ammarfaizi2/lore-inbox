Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVEBSCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVEBSCg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 14:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVEBSCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 14:02:36 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:11424 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261233AbVEBSCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 14:02:08 -0400
Date: Mon, 2 May 2005 11:01:35 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, colpatch@us.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org
Subject: Re: [RFC PATCH] Dynamic sched domains (v0.5)
Message-Id: <20050502110135.173cbdd7.pj@sgi.com>
In-Reply-To: <20050501190947.GA5204@in.ibm.com>
References: <20050501190947.GA5204@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the minimalist patch.  I'll review it in more detail when I
get a chance.  It looks promising, more promising than before.


My current concerns include:
 o Having it work on ia64 would facilitate my testing.
 o _Still_ no clear statement of the requirements - see below.
 o Does this patch ensure that isolated sched domains form
      a partition (disjoint cover) of a systems CPUs?  Should it?
 o Does this change any documented semantics of cpusets?  I don't
      see offhand that it does.  Perhaps that's good.  Perhaps
      I missed something.


I am still in the frustrating position of playing guessing games with
what are you essential requirements, the one or two features that you
require.  The closest we got was a six step list which was really more
like pseudo code for a prior implementation.

I see nothing on first glance in your latest patch that responds to my
previous attempt to ask this.  I don't see how I can improve on the
wording of that question, so I repeat myself ...

On April 25, pj wrote:
======================

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

Hopefully, you will also be able to get through my thick head what your
essential requirement(s) is or are.


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401

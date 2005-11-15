Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbVKOSKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbVKOSKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbVKOSKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:10:34 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51080 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964984AbVKOSKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:10:34 -0500
Date: Tue, 15 Nov 2005 10:10:31 -0800
From: Paul Jackson <pj@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org, frankeh@watson.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-Id: <20051115101031.10064301.pj@sgi.com>
In-Reply-To: <1132049230.6108.23.camel@localhost>
References: <20051114212341.724084000@sergelap>
	<20051114153649.75e265e7.pj@sgi.com>
	<20051115010155.GA3792@IBM-BWN8ZTBWAO1>
	<20051114175140.06c5493a.pj@sgi.com>
	<20051115022931.GB6343@sergelap.austin.ibm.com>
	<20051114193715.1dd80786.pj@sgi.com>
	<20051115051501.GA3252@IBM-BWN8ZTBWAO1>
	<20051114223513.3145db39.pj@sgi.com>
	<20051115081100.GA2488@IBM-BWN8ZTBWAO1>
	<20051115010624.2ca9237d.pj@sgi.com>
	<1132049230.6108.23.camel@localhost>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well ... from your response, Dave, I think you understood what I was
saying.  Thanks.

> The main issues I worry about with such a static allocation scheme are
> getting the allocation patterns right, without causing new restrictions
> on the containers.

Yes - the basic problem with pre-allocating static containers is that
you have to pre-allocate them ;).


> This kind of scheme is completely thrown out the
> window if someone wanted to start a process on their disconnected laptop
> and later migrate it to another machine when they connect back up to the
> network.  

Transparent relocation without anticipating and preparing in _some_
way for that relocation prior to starting the job has the potential
to be one of those "Just say no to crazy requirements" moments.  I am
sure some marketing folks don't agree.


> You're basically concerned about pids "leaking" across containers, and
> confusing applications in the process?  That's a pretty valid concern.

Partly that, yes.  Pids have been a system-wide notion since forever.
They get buried in lots of places and uses.

There is a natural tendency in these virtualization efforts to put
blinders on, and be encouraged by the potential ease of solving the
first 80% or 90% of the problem.

The kernel needs to be clear and consistent in what notions it
supports, avoiding getting caught between two inconsistent models
without a clear definition of which model applies when.


> we'll end up modifying a _ton_ of stuff in the process of doing this.

That's the kicker.  Pid remapping seems useless by itself unless the
rest of this stuff is modified as well, to make a workable solution.
I'm looking for the larger design, before deciding on individual
patches.

My intuition is that somehow or other, jobs that have the potential
to be restarted or relocated have to start their life in a container
that isolates them.

My mind is wandering now to something Xen like, perhaps.  Something
Open Source, available to us all, but with key virtualizations in
middleware rather then the kernel.  See also the results of a Google
search on "checkpoint restart comparison zap" and the pods of Zap:
http://www.cs.cmu.edu/~sosman/publications/osdi2002/ZAP-OSDI.html.

This Zap paper is a good example of the design overview required to
motivate the individual patches needed to provide such a solution.
Their pod construct is not exactly what I was concocting in my
replies on this thread so far, but is far better thought out and more
persuasive, even to me.

A proposal that integrated a next generation Zap into the kernel
would be most interesting.  We don't have to keep it isolated to a
loadable kernel module that hacks the system call table, which may
give us leverage on improving it in other ways.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

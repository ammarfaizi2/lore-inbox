Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161326AbWJSGQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161326AbWJSGQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 02:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161329AbWJSGQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 02:16:22 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16310 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161326AbWJSGQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 02:16:21 -0400
Date: Wed, 18 Oct 2006 23:15:59 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: holt@sgi.com, suresh.b.siddha@intel.com, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: exclusive cpusets broken with cpu hotplug
Message-Id: <20061018231559.8d3ede8f.pj@sgi.com>
In-Reply-To: <45361B32.8040604@yahoo.com.au>
References: <20061017192547.B19901@unix-os.sc.intel.com>
	<20061018001424.0c22a64b.pj@sgi.com>
	<20061018095621.GB15877@lnx-holt.americas.sgi.com>
	<20061018031021.9920552e.pj@sgi.com>
	<45361B32.8040604@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know if you want customers do know what domains they have. I think
> you should avoid having explicit control over sched-domains in your cpusets
> completely, and just have the cpusets create partitioned domains whenever
> it can.

We have a choice to make.  I am increasingly convinced that the
current mechanism linking cpusets with sched domains is busted,
allowing people to easily and unspectingly set up broken sched domain
configs, without even being able to see what they are doing.
Certainly that linkage has been confusing to some of us who are
not kernel/sched.c experts.  Certainly users on production systems
cannot see what sched domains they have ended up with.

We should either make this linkage explicit and understandable, giving
users direct means to construct sched domains and probe what they have
done, or we should remove this linkage.

My patch to add sched_domain flags to cpusets was an attempt to
make this control explicit.

I am now 90% convinced that this is the wrong direction, and that
the entire chunk of code linking cpu_exclusive cpusets to sched
domains should be nuked.

The one thing I found so far today that people actually needed from
this was that my real time people needed to be able to something like
marking a cpu isolated.  So I think we should have runtime support for
manipulating the cpu_isolated_map.

I will be sending in a pair of patches shortly to:
 1) nuke the cpu_exclusive - sched_domain linkage, and
 2) support runtime marking of isolated cpus.

Does that sound better to you?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

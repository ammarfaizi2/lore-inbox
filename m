Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWJWGQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWJWGQk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWJWGQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:16:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49609 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751586AbWJWGQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:16:39 -0400
Date: Sun, 22 Oct 2006 23:16:23 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: suresh.b.siddha@intel.com, mbligh@google.com, akpm@osdl.org,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       dino@in.ibm.com, rohitseth@google.com, holt@sgi.com,
       dipankar@in.ibm.com, clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-Id: <20061022231623.70daba00.pj@sgi.com>
In-Reply-To: <453C5AF4.8070707@yahoo.com.au>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	<4537527B.5050401@yahoo.com.au>
	<20061019120358.6d302ae9.pj@sgi.com>
	<4537D056.9080108@yahoo.com.au>
	<4537D6E8.8020501@google.com>
	<20061022035135.2c450147.pj@sgi.com>
	<20061022222652.B2526@unix-os.sc.intel.com>
	<20061022225456.6adfd0be.pj@sgi.com>
	<453C5AF4.8070707@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> It is somewhat improved. The load balancing will now retry other CPUs,
> but this is pretty costly

Ah - ok.  Sounds like a sticky problem.

I am beginning to appreciate Martin's preference for not using
cpus_allowed to pin tasks when load balancing is also needed.

For the big HPC apps that I worry about the most, with hundreds of
parallel, closely coupled threads, one per cpu, we pin all over the
place.  But we make very little use of load balancing in that
situation, with one compute bound thread per cpu, humming along for
hours.  The scheduler pretty quickly figures out that it has no
useful load balancing to do.

On the other hand, as someone already noted, one can't simulate pinning
to overlapping cpus_allowed masks using overlapping sched domains, as
tasks can just wander off onto someone elses cpu that way.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

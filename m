Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVDSHCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVDSHCQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 03:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVDSHCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 03:02:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10465 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261224AbVDSHCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 03:02:10 -0400
Date: Mon, 18 Apr 2005 23:59:02 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-Id: <20050418235902.7632d68a.pj@sgi.com>
In-Reply-To: <1113891575.5074.46.camel@npiggin-nld.site>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050418225427.429accd5.pj@sgi.com>
	<1113891575.5074.46.camel@npiggin-nld.site>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
>  Basically you just have to know that it has the
> capability to partition the system in an arbitrary disjoint set
> of sets of cpus.
> 
> If you can make use of that, then we're in business ;)

You read fast ;)

So you do _not_ want to consider nested sched domains, just disjoint
ones.  Good.


> From what I gather, this partitioning does not exactly fit
> the cpusets architecture. Because with cpusets you are specifying
> on what cpus can a set of tasks run, not dividing the whole system.

My evil scheme, and Dinakar's as well, is to provide a way for the user
to designate _some_ of their cpusets as also defining the partition that
controls which cpus are in each sched domain, and so dividing the
system.

  "partition" == "an arbitrary disjoint set of sets of cpus"

This fits naturally with the way people use cpusets anyway.  They divide
up the system along boundaries that are natural topologically and that
provide a good fit for their jobs, and hope that the kernel will adapt
to such localized placement.  They then throw a few more nested (smaller)
cpusets at the problem, to deal with various special needs.  If we can
provide them with a means to tell us which of their cpusets define the
natural partitioning of their system, for the job mix and hardware
topology they have, then all is well.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401

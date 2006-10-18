Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbWJROey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWJROey (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWJROey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:34:54 -0400
Received: from mga05.intel.com ([192.55.52.89]:42247 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161029AbWJROex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:34:53 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,325,1157353200"; 
   d="scan'208"; a="5144903:sNHT376247061"
Date: Wed, 18 Oct 2006 07:14:47 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>, Robin Holt <holt@sgi.com>,
       suresh.b.siddha@intel.com, dino@in.ibm.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, mbligh@google.com,
       rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: exclusive cpusets broken with cpu hotplug
Message-ID: <20061018071447.A25760@unix-os.sc.intel.com>
References: <20061017192547.B19901@unix-os.sc.intel.com> <20061018001424.0c22a64b.pj@sgi.com> <20061018095621.GB15877@lnx-holt.americas.sgi.com> <20061018031021.9920552e.pj@sgi.com> <45361B32.8040604@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <45361B32.8040604@yahoo.com.au>; from nickpiggin@yahoo.com.au on Wed, Oct 18, 2006 at 10:16:50PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 10:16:50PM +1000, Nick Piggin wrote:
> Paul Jackson wrote:
> >  1) I don't know how to tell what sched domains/groups a system has, nor

Paul, atleast for debugging one can know that by defining SCHED_DOMAIN_DEBUG

> >     how to tell my customers how to see what sched domains they have, and
> 
> I don't know if you want customers do know what domains they have. I think

At the first glance, I have to agree with Nick. All the customer wants is a
mechanism to specify group these cpus together for scheduling...

But looking at how cpusets interact with sched-domains and especially for
large systems, it will probably be useful if we export the topology through /sys

> cpusets is the only thing that messes with sched-domains (excluding the
> isolcpus -- that seems to require a small change to partition_sched_domains,
> but forget that for now).
> 
> And so you should know what partitioning to build at any point when asked.
> So we could have a call to cpusets at the end of arch_init_sched_domains,
> which asks for the domains to be partitioned, no?

yes.

Robin, Right now everyone is calling arch_init_sched_domain() with
cpu_online_map. We can remove this argument and in the presence of cpusets,
this routine can go through exclusive cpusets and partition the domains
accordinly. Otherwise we can simply build one domain partition with
cpu_online_map.

thanks,
suresh

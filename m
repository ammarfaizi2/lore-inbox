Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUJFCrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUJFCrY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 22:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUJFCos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 22:44:48 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:49536 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266366AbUJFCmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 22:42:36 -0400
Date: Tue, 5 Oct 2004 19:39:53 -0700
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: mbligh@aracnet.com, pwil3058@bigpond.net.au, frankeh@watson.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, Simon.Derr@bull.net, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041005193953.6edc83b2.pj@sgi.com>
In-Reply-To: <1097014749.4065.48.camel@arrakis>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<1097014749.4065.48.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew  wrote:
> 
> I feel that the actual implementation, however, is taking
> a wrong approach, because it attempts to use the cpus_allowed mask to
> override the scheduler in the general case.  cpus_allowed, in my
> estimation, is meant to be used as the exception, not the rule.

I agree that big chunks of a large system that are marching to the beat
of two distinctly different drummers would better have their schedulers
organized along the domains that you describe, than by brute force abuse
of the cpus_allowed mask.

I look forward to your RFC, Matthew.  Though not being a scheduler guru,
I will mostly have to rely on the textual commentary in order to
understand what it means.

Existing finer grain placement of CPUs (sched_setaffinity) and Memory
(mbind, set_mempolicy) already exists, and is required by parallel
threaded applications such as OpenMP and MPI are commonly used to
develop.

The finer grain use of non-exclusive cpusets, in order to support
such workload managers as PBS and LSF in managing this finer grained
placement on a system (domain) wide basis should not be placing any
significantly further load on the schedulers or resource managers.

The top level cpusets must provide additional isolation properties so
that separate scheduler and resource manager domains can work in
relative isolation.  I've tried hard to speculate what these additional
isolation properties might be.  I look forward to hearing from the CKRM
and scheduler folks on this.  I agree that simple unconstrained (ab)use
of the cpus_allowed and mems_allowed masks, at that scale, places an
undo burden on the schedulers, allocators and resource managers.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268141AbUHKRzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268141AbUHKRzn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 13:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268136AbUHKRzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 13:55:42 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:973 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268141AbUHKRxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 13:53:20 -0400
Date: Wed, 11 Aug 2004 23:35:58 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH] new bitmap list format (for cpusets)
Message-ID: <20040811180558.GA4066@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040811131155.GA4239@in.ibm.com> <20040811091732.411edb6d.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811091732.411edb6d.pj@sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 09:17:32AM -0700, Paul Jackson wrote:
> Dinakar wrote:
> > Considering that cpu_possible_map does not get fully initialized
> > until smp_prepare_cpus gets called by init(), I thought it right
> > to move cpuset_init() to after smp initialization.
> 
> Thank-you.  I suspect you're right.
> 
> Could you also provide some motivation for the other changes in your
> patch, moving struct cpuset, enum cpuset_flagbits_t, and struct cpuset
> top_cpuset definitions from kernel/cpuset.c to include/linux/cpuset.h?
> I had found it rather pleasing that these structures did not need to
> be known outside of kernel/cpuset.c.

Since init() is executed by a kernel_thread that does a do_fork(),
it already expects the top_cpuset to be initialized. Since this can
be achieved by initializing the task structure (INIT_TASK), I had
to move the structure definitions to the header file.

A related Q, I was wondering why the nodemask_t needed to be part 
of the task_struct, since cpuset would anyway have a reference to it. 
Sorry if this is something very obvious, I didn't really look to see 
why it was there

> 
> Another approach that might work, in order to ensure that the top_cpuset
> has its cpus_allowed set to the proper value of cpu_possible_map, would
> be to add a routine, say cpuset_init_smp(), called from init/main.c
> init() just after smp_init() returns, to update the cpus_allowed in
> top_cpuset from the fully initialized value of cpu_possible_map.  This
> seems to resemble the call sched_init_smp(), also made in init/main.c
> init() just after smp_init() returns, to finish initializing some sched
> stuff.

Yes that would be fine too.

> 
> If you take your approach, should we remove the __init qualifier from
> kernel/cpuset.c cpuset_init()?
> 
The qualifier would still be valid I think, no ?

Regards,

Dinakar

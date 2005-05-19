Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVESUJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVESUJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 16:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVESUJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 16:09:44 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:31411 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261241AbVESUJh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 16:09:37 -0400
Message-ID: <428CF277.4070500@us.ibm.com>
Date: Thu, 19 May 2005 13:09:27 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dino@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Simon Derr <Simon.Derr@bull.net>, Dipankar Sarma <dipankar@in.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [PATCH 1/3] Dynamic sched domains: sched changes
References: <20050519150435.GA6073@in.ibm.com>
In-Reply-To: <20050519150435.GA6073@in.ibm.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar Guniguntala wrote:
> Hello Andrew,
> 
> The following patches add dynamic sched domains functionality that was
> extensively discussed on lkml and lse-tech.
> I would like to see this added to -mm
> 
> o The main advantage with this feature is that it ensures that the scheduler
>   load balacing code only balances against the cpus that are in the sched
>   domain as defined by an exclusive cpuset and not all of the cpus in the
>   system. This removes any overhead due to load balancing code trying to
>   pull tasks outside of the cpu exclusive cpuset only to be prevented by
>   the tasks' cpus_allowed mask.
> o cpu exclusive cpusets are useful for servers running orthogonal
>   workloads such as RT applications requiring low latency and HPC
>   applications that are throughput sensitive
> 
> o It provides a new API partition_sched_domains in sched.c
>   that makes dynamic sched domains possible.
> o cpu_exclusive cpusets sets are now associated with a sched domain.
>   Which means that the users can dynamically modify the sched domains
>   through the cpuset file system interface
> o ia64 sched domain code has been updated to support this feature as well
> o Currently, this does not support hotplug. (However some of my tests
>   indicate hotplug+preempt is currently broken)
> o I have tested it extensively on x86.
> o This should have very minimal impact on performance as none of
>   the fast paths are affected
> 
>         -Dinakar
> 
> Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>
> Acked-by: Paul Jackson <pj@sgi.com>
> Acked-by: Nick Piggin <nickpiggin@yahoo.com.au>
> 
>  linux-2.6.12-rc4-mm1-1/include/linux/sched.h     |    2
>  linux-2.6.12-rc4-mm1-1/kernel/sched.c            |  130 +++++++++++++++--------
>  linux-2.6.12-rc4-mm1-2/Documentation/cpusets.txt |   16 ++
>  linux-2.6.12-rc4-mm1-2/kernel/cpuset.c           |   89 +++++++++++++--
>  linux-2.6.12-rc4-mm1-3/arch/ia64/kernel/domain.c |   76 +++++++------
>  5 files changed, 225 insertions(+), 88 deletions(-)

Looks good to me, Dinakar!

Acked-by: Matthew Dobson <colpatch@us.ibm.com>

-Matt

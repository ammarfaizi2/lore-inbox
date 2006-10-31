Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946027AbWJaX6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946027AbWJaX6l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 18:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946176AbWJaX6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 18:58:41 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:26807 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1946027AbWJaX6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 18:58:40 -0500
Date: Tue, 31 Oct 2006 15:58:19 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: dino@in.ibm.com, nickpiggin@yahoo.com.au, akpm@osdl.org, mbligh@google.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset:  Explicit dynamic sched domain cpuset flag
Message-Id: <20061031155819.29621173.pj@sgi.com>
In-Reply-To: <20061031064300.10a97c13.pj@sgi.com>
References: <20061030212615.GA10567@in.ibm.com>
	<20061030212922.GA20369@in.ibm.com>
	<20061031064300.10a97c13.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pj wrote:
> 9) Finally, we really do need a way, on a production system, for user
>    space to ask the kernel where load balancing is limited.
>    
>    For example one possible interface would have user space pass a
>    cpumask to the kernel, and get back a Boolean value, indicating
>    whether or not there are any limitations on load balancing between
>    any two CPUs specified in that cpumask.

Ah - a simpler API, more user friendly, more "cpuset API style"
friendly:

    A read-only, per-cpuset Boolean flag that indicates whether the
    scheduler is fully load balancing across all 'cpus' of that cpuset.

    Internally, the kernel would answer this by seeing whether or
    not the cpusets cpus_allowed cpumask was a subset of one of the
    members of the scheduler domains partition.

Call this per-cpuset flag something such as:

    sched_is_fully_load_balanced	# read-only Boolean

This goes along with having the control flag named something such as:

    sched_ok_not_to_load_balance	# read-write Boolean

If a task was in a cpuset that had 'sched_is_fully_load_balanced'
False, then it might not get load balanced.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946388AbWJSTEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946388AbWJSTEf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946382AbWJSTEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:04:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10166 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946386AbWJSTEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:04:09 -0400
Date: Thu, 19 Oct 2006 12:03:58 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-Id: <20061019120358.6d302ae9.pj@sgi.com>
In-Reply-To: <4537527B.5050401@yahoo.com.au>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	<4537527B.5050401@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> You shouldn't need to, assuming cpusets doesn't mess it up.

I'm guessing we're agreeing that the routines update_cpu_domains()
and related code in kernel/cpuset.c are messing things up.

I view that code as a failed intrustion of some sched domain code into
cpusets, and apparently you view that code as a failed attempt to
manage sched domains coming from cpusets.

Oh well ... finger pointing is such fun ;).

(Fortunately I've forgotten who wrote these routines ... best
I don't know.  Whoever you are, don't take it personally.  It
was nice clean code, caught between the rock and the flood.)


> +	non_partitioned = top_cpuset.cpus_allowed;
> +	update_cpu_domains_children(&top_cpuset, &non_partitioned);
> +	partition_sched_domains(&non_partitioned);

So ... instead of throwing the baby out, you want to replace it
with a puppy.  If one attempt to overload cpu_exclusive didn't
work, try another.

I have two problems with this.

1) I haven't found any need for this, past the need to mark some
   CPUs as isolated from the scheduler balancing code, which we
   seem to be agreeing on, more or less, on another patch.

   Please explain why we need this or any such mechanism for user
   space to affect sched domain partitioning.

2) I've had better luck with the cpuset API by adding new flags
   when I needed some additional semantics, rather than overloading
   existing flags.  So once we figure out what's needed and why,
   then odds are I will suggest a new flag, specific to that purpose.

   This new flag might well logically depend on the cpu_exclusive
   setting, if that's useful.  But it would probably be a separate
   flag or setting.

   I dislike providing explicit mechanisms via implicit side affects.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

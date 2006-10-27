Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946152AbWJ0DtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946152AbWJ0DtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 23:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946155AbWJ0DtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 23:49:10 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:20445 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1946152AbWJ0DtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 23:49:08 -0400
Date: Fri, 27 Oct 2006 09:19:25 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: ego@in.ibm.com, rusty@rustcorp.com.au, torvalds@osdl.org, mingo@elte.hu,
       akpm@osdl.org, linux-kernel@vger.kernel.org, paulmck@us.ibm.com,
       vatsa@in.ibm.com, dipankar@in.ibm.com, gaughen@us.ibm.com,
       arjan@linux.intel.org, davej@redhat.com, venkatesh.pallipadi@intel.com,
       kiran@scalex86.org
Subject: Re: [PATCH 4/5] lock_cpu_hotplug: Redesign - Lightweight implementation of lock_cpu_hotplug.
Message-ID: <20061027034925.GA4023@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061026104858.GA11803@in.ibm.com> <20061026105058.GB11803@in.ibm.com> <20061026105342.GC11803@in.ibm.com> <20061026105523.GD11803@in.ibm.com> <20061026105731.GE11803@in.ibm.com> <20061026141450.53b48b88.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026141450.53b48b88.pj@sgi.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 02:14:50PM -0700, Paul Jackson wrote:
> Gautham wrote:
> + *- Readers assume control iff:					*
> + *    a) No other reader has a reference and no writer is writing.	*
> + *    OR								*
> + *    b) Atleast one reader (on *any* cpu) has a reference.		*
> 
> Isn't this logically equivalent to stating:
> 
>   *- Readers assume control iff no writer is writing

It is logically equivalent, but...

> (Or if it's not equivalent, it might be interesting to state why.)

I think it needs to be rephrased. 

Because there may be a situation where nr_readers = 0, when a writer
arrives. The writer sets the flag to WRITER_WAITING and performs
a synchronize_sched.

During this time, if a new reader arrives at the scene, it would still
go to sleep, because there are no other active readers in the system.
This despite the fact that the writer is not *writing*.

Thanks for pointing that out :-)

> 
> -- 
>                   I won't rest till it's the best ...
>                   Programmer, Linux Scalability
>                   Paul Jackson <pj@sgi.com> 1.925.600.0401

Regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, 
which is still a bargain, because Freedom is priceless!"

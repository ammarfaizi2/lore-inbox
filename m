Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVEMUel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVEMUel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbVEMUeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:34:02 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:25063 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262534AbVEMUWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:22:42 -0400
Date: Sat, 14 May 2005 01:50:59 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: vatsa@in.ibm.com, dino@in.ibm.com, ntl@pobox.com, Simon.Derr@bull.net,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050513202058.GE5044@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto> <20050513123216.GB3968@in.ibm.com> <20050513172540.GA28018@in.ibm.com> <20050513125953.66a59436.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513125953.66a59436.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 12:59:53PM -0700, Paul Jackson wrote:
> Srivatsa, replying to Dinakar:
> > This in fact was the reason that we added lock_cpu_hotplug
> > in sched_setaffinity.
> 
> We do need to be clear about how these locks work, their semantics, what
> they require and what they insure, and their various interactions.
> 
> This is not easy stuff to get right.
> 
> I notice that the documentation for lock_cpu_hotplug() is a tad on
> the skimpy side:
> 
> 	/* Stop CPUs going up and down. */
> 
> That's it, so far as I can see.  Interaction of hotplug locking with
> the rest of the kernel has been, is now, and will continue to be, a
> difficult area.  More care than this needs to be put into explaining
> the use, semantics and interactions of any locking involved.
> 
> In particular, in my view, locks should guard data.  What data does
> lock_cpu_hotplug() guard?  I propose that it guards cpu_online_map.
> 
> I recommend considering a different name for this lock.  Perhaps
> 'cpu_online_sem', instead of 'cpucontrol'?   And perhaps the
> lock_cpu_hotplug() should be renamed, to say 'lock_cpu_online'?

No. CPU hotplug uses two different locking - see both lock_cpu_hotplug()
and __stop_machine_run(). Anyone reading cpu_online_map with
preemption disabled is safe from cpu hotplug even without taking
any lock.

Thanks
Dipankar

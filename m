Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129529AbRCMJll>; Tue, 13 Mar 2001 04:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130214AbRCMJlb>; Tue, 13 Mar 2001 04:41:31 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:45064 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129529AbRCMJlV>;
	Tue, 13 Mar 2001 04:41:21 -0500
Date: Tue, 13 Mar 2001 10:40:47 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: static scheduling - SCHED_IDLE?
Message-ID: <20010313104047.A23780@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.33.0103081747010.1314-100000@duckman.distro.conectiva> <3AA93124.EC22CC8A@mvista.com> <3AA93ABE.7000707@humboldt.co.uk> <20010312190527.A23065@pcep-jamie.cern.ch> <3AAD2592.4060109@humboldt.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AAD2592.4060109@humboldt.co.uk>; from adrian@humboldt.co.uk on Mon, Mar 12, 2001 at 07:37:54PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Cox wrote:
> >> Jamie Lokier's suggestion of raising priority when in the kernel doesn't 
> >> help. You need to raise the priority of the task which is currently in 
> >> userspace and will call up() next time it enters the kernel. You don't 
> >> know which task that is.
> 
> > Dear oh dear.  I was under the impression that kernel semaphores are
> > supposed to be used as mutexes only -- there are other mechanisms for
> > signalling between processes.
> 
> I think most of the kernel semaphores are used as mutexes, with 
> occasional producer/consumer semaphores. I think the core kernel code is 
> fine, the risk mostly comes from miscellaneous character devices. I've 
> written code that does this for a specialised device driver. I wanted 
> only one process to have the device open at once, and for others to 
> block on open. Using semaphores meant that multiple shells could do "cat 
>  > /dev/mywidget" and be serialised.

Oh, it's you :-)

In this case we don't care if process A is blocked waiting for idle
process B to release the device, do we?

> Locking up users of this strange piece of hardware doesn't bring down 
> the system, so your suggestion could work. We need a big fat warning in 
> semaphore.h, and a careful examination of the current code.

If it weren't for the weight of history, they could be called `struct
mutex' just to rub it in.

-- Jamie

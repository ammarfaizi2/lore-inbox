Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbVDAODI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVDAODI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 09:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbVDAODH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 09:03:07 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:60302 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262747AbVDAOCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 09:02:50 -0500
Date: Fri, 1 Apr 2005 19:42:25 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] Add support for semaphore-like structure with support for asynchronous I/O
Message-ID: <20050401141225.GA3707@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1112219491.10771.18.camel@lade.trondhjem.org> <20050330143409.04f48431.akpm@osdl.org> <1112224663.18019.39.camel@lade.trondhjem.org> <1112309586.27458.19.camel@lade.trondhjem.org> <20050331161350.0dc7d376.akpm@osdl.org> <1112318537.11284.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112318537.11284.10.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 08:22:17PM -0500, Trond Myklebust wrote:
> to den 31.03.2005 Klokka 16:13 (-0800) skreiv Andrew Morton:
> > Trond Myklebust <trondmy@trondhjem.org> wrote:
> > >
> > >  on den 30.03.2005 Klokka 18:17 (-0500) skreiv Trond Myklebust:
> > >  > > Or have I misunderstood the intent?  Some /* comments */ would be appropriate..
> > >  > 
> > >  > Will do.
> > > 
> > >  OK. Plenty of comments added that will hopefully clarify what is going
> > >  on and how to use the API. Also some cleanups of the code.
> > 
> > Ah, so that's what it does ;)
> > 
> > I guess once we have a caller in-tree we could merge this.  I wonder if
> > there's other existing code which should be converted to iosems.
> 
> I can put it into the NFS client stream which feeds into the -mm kernel.
> That will enable me to queue up the NFSv4 patches that depend on it
> too...
> 
> > You chose to not use the aio kernel threads?
> 
> I thought I'd do that in a separate patch since the aio workqueue is
> currently statically defined in aio.c.

I'll take a look at the patch over the weekend. I had a patch
for aio semaphores a long while back, but I need to spend some time
to understand how different this is.

Regards
Suparna

> 
> > Does iosem_lock_and_schedule_function() need locking?  It nonatomically
> > alters *lk_state.
> 
> iosem_lock_and_schedule_function() will always be called with the
> iosem->wait.lock held, since it is a waitqueue notification function.
> 
> In practice it is called by iosem_unlock(). The call to wake_up_locked()
> will trigger a call to __wake_up_common() which again tries the
> notification function of each waiter on the queue until it finds one
> that succeeds.
> 
> Cheers,
>   Trond
> 
> -- 
> Trond Myklebust <trond.myklebust@fys.uio.no>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


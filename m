Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267346AbRGKQDd>; Wed, 11 Jul 2001 12:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267347AbRGKQDX>; Wed, 11 Jul 2001 12:03:23 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:54404 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267346AbRGKQDN>; Wed, 11 Jul 2001 12:03:13 -0400
Date: Wed, 11 Jul 2001 09:02:57 -0700
From: Mike Anderson <mike.anderson@us.ibm.com>
To: Dipankar Sarma <dipankar@sequent.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010711090257.B27097@us.ibm.com>
In-Reply-To: <20010710172545.A8185@in.ibm.com> <20010710160512.A25632@us.ibm.com> <20010711142311.B9220@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010711142311.B9220@in.ibm.com>; from dipankar@sequent.com on Wed, Jul 11, 2001 at 02:23:11PM +0530
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the slow fingers just trying to catch up on this thread.

Dipankar Sarma [dipankar@sequent.com] wrote:
> Hi Mike,
> 
> On Tue, Jul 10, 2001 at 04:05:12PM -0700, Mike Anderson wrote:
> > The call to do_aic7xxx_isr appears that you are running the aic7xxx_old.c
> > code. This driver is using the io_request_lock to protect internal data.
> > The newer aic driver has its own lock. This is related to previous
> > comments by Jens and Eric about lower level use of this lock.
> 
> There were some problems booting with the new aic7xxx driver and 2.4.4
> kernel. This may have been fixed in later kernels, so we will check
> this again. Besides, I wasn't aware that the new aic7xxx driver uses
> a different locking model. Thanks for letting me know.
> 
> >  
> >  I would like to know why the request_freelist is going empty? Having
> >  __get_request_wait being called alot would appear to be not optimal.
> 
> It is not unreasonable for request IOCB pools to go empty, the important
> issue is at what rate ? If a large portion of I/Os have to wait for
> request structures to be freed, we may not be able to utilize the available
> hardware bandwidth of the system optimally when we need, say, large
> # of IOs/Sec. On the other hand, having large number of request structures
> available may not necessarily give you large IOs/sec. The thing to look
> at would be - how well are we utilizing the queueing capablility
> of the hardware given a particular type of workload.

Jens, I think Dipankar might have stated my comment about questioning
optimal utilization of a pool of resources shared by all device queues in
the last sentence of the above paragraph. 

My thought was that if one has enough IO that cannot be merged on a queue
you eat up request descriptors. If a request queue contains more requests
than can be put in flight by the lower level to a spindle than this
resource might be better used by other request queues.

I might be missing something and I will look at the code some more.

Thanks.

> 
> Thanks
> Dipankar
> -- 
> Dipankar Sarma  <dipankar@sequent.com> Project: http://lse.sourceforge.net
> Linux Technology Center, IBM Software Lab, Bangalore, India.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Michael Anderson
mike.anderson@us.ibm.com


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267239AbRGKIs4>; Wed, 11 Jul 2001 04:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbRGKIsi>; Wed, 11 Jul 2001 04:48:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27846 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267236AbRGKIsb>;
	Wed, 11 Jul 2001 04:48:31 -0400
Date: Wed, 11 Jul 2001 14:23:11 +0530
From: Dipankar Sarma <dipankar@sequent.com>
To: Mike Anderson <mike.anderson@us.ibm.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010711142311.B9220@in.ibm.com>
Reply-To: dipankar@sequent.com
In-Reply-To: <20010710172545.A8185@in.ibm.com> <20010710160512.A25632@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010710160512.A25632@us.ibm.com>; from mike.anderson@us.ibm.com on Tue, Jul 10, 2001 at 04:05:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Tue, Jul 10, 2001 at 04:05:12PM -0700, Mike Anderson wrote:
> The call to do_aic7xxx_isr appears that you are running the aic7xxx_old.c
> code. This driver is using the io_request_lock to protect internal data.
> The newer aic driver has its own lock. This is related to previous
> comments by Jens and Eric about lower level use of this lock.

There were some problems booting with the new aic7xxx driver and 2.4.4
kernel. This may have been fixed in later kernels, so we will check
this again. Besides, I wasn't aware that the new aic7xxx driver uses
a different locking model. Thanks for letting me know.

>  
>  I would like to know why the request_freelist is going empty? Having
>  __get_request_wait being called alot would appear to be not optimal.

It is not unreasonable for request IOCB pools to go empty, the important
issue is at what rate ? If a large portion of I/Os have to wait for
request structures to be freed, we may not be able to utilize the available
hardware bandwidth of the system optimally when we need, say, large
# of IOs/Sec. On the other hand, having large number of request structures
available may not necessarily give you large IOs/sec. The thing to look
at would be - how well are we utilizing the queueing capablility
of the hardware given a particular type of workload.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@sequent.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131538AbRCUPqW>; Wed, 21 Mar 2001 10:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131528AbRCUPqD>; Wed, 21 Mar 2001 10:46:03 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:4961 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130940AbRCUPpt>; Wed, 21 Mar 2001 10:45:49 -0500
Date: Wed, 21 Mar 2001 16:46:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: nigel@nrg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
Message-ID: <20010321164642.Y6567@athlon.random>
In-Reply-To: <Pine.LNX.4.05.10103201920410.26853-100000@cosmic.nrg.org> <22991.985166394@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22991.985166394@ocs3.ocs-net>; from kaos@ocs.com.au on Wed, Mar 21, 2001 at 08:19:54PM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2001 at 08:19:54PM +1100, Keith Owens wrote:
> Ouch.  What about all the per cpu structures in the kernel, how do you
> handle them if a preempted task can be rescheduled on another cpu?
> 
>  int count[NR_CPUS], *p;
>  p = count+smp_processor_id(); /* start on cpu 0, &count[0] */
>  if (*p >= 1024) {
>    /* preempt here, reschedule on cpu 1 */
>    *p = 1;  /* update cpu 0 count from cpu 1, oops */
>   }
> 
> Unless you find every use of a per cpu structure and wrap a spin lock
> around it, migrating a task from one cpu to another is going to be a
> source of wierd and wonderful errors.  Since the main use of per cpu
> structures is to avoid locks, adding a spin lock to every structure
> will be a killer.  Or have I missed something?

That's why Linus suggested it for UP only.

Andrea

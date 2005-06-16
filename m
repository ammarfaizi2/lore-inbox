Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVFPMxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVFPMxc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 08:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVFPMxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 08:53:32 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:54965 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261672AbVFPMxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 08:53:25 -0400
Date: Thu, 16 Jun 2005 18:32:39 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] aio_down() for i386 and x86_64
Message-ID: <20050616130239.GA4839@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050614215022.GC21286@kvack.org> <20050615165349.GA4521@in.ibm.com> <20050615191830.GA28261@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615191830.GA28261@kvack.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 03:18:30PM -0400, Benjamin LaHaise wrote:
> On Wed, Jun 15, 2005 at 10:23:49PM +0530, Suparna Bhattacharya wrote:
> > Interesting approach - using ki_wait.private for this.
> > Could we make aio_down take a wait queue parameter as well instead of
> > the iocb ?
> 
> Hmmm, I guess there might be instances where someone has to wait on 
> multiple wait queues.  Will add that to the next version of the patch.
> 
> > Need to think a little about impact on io cancellation.
> 
> It should be possible to cancel semaphore operations fairly easily -- 
> the aio_down function can set ->ki_cancel to point to a semaphore cancel 
> routine.  I'll give coding that a try.
> 
> > BTW, is the duplication of functions across architectures still needed ? I
> > thought that one of advantages of implementing a separate aio_down
> > routine vs modifiying down to become retryable was to get away from
> > that ... or wasn't it ?
> 
> Good point.  The fast path for down() will probably need to remain a 
> separate function, but we could well unify the code with the 
> down_interruptible() codepath.
> 
> > Meanwhile, I probably need to repost my aio_wait_bit patches - there
> > may be some impact here.
> 
> Sure -- any version of those would be useful to build on.  Cheers!

http://www.kernel.org/pub/linux/kernel/people/suparna/aio/2610-rc2/ has
the patchset. 

I just updated the AIO wait bit ones to 2.6.12-rc6, will post them
in a separate thread.

Regards
Suparna

> 
> 		-ben
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


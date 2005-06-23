Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVFWN1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVFWN1A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 09:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVFWNXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 09:23:36 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:18590 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262406AbVFWNUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 09:20:10 -0400
Date: Thu, 23 Jun 2005 18:59:26 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: aio_down() patch series -- cancellation support added
Message-ID: <20050623132926.GA6669@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050620213835.GA6628@kvack.org> <20050620214614.GC6628@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620214614.GC6628@kvack.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 05:46:14PM -0400, Benjamin LaHaise wrote:
> Add linux-kernel to the Cc list...
> 
> On Mon, Jun 20, 2005 at 05:38:35PM -0400, Benjamin LaHaise wrote:
> > Hello all,
> > 
> > The patch series at http://www.kvack.org/~bcrl/patches/aio-2.6.12-A1/ 
> > now adds support for cancellation of an aio_down() operation.  The 
> > races should be correctly handled by introducing per-kiocb locking 
> > that serialises ->ki_cancel() and ->ki_retry().  The interesting patch 
> > additions are 40_lock_kiocb 50_aio_down_cancel.diff.  Comments?
> > 
> > 		-ben
> > -- 

One quick question.
Since lock_kiocb() may block, does that mean that the aio worker thread
could be put to sleep while an iocb cancellation is in progress, even though
there may be other iocbs/ioctx's to process ?

Looking at the rest a little more closely in terms of how everything
will fit together, a few questions come to mind - need to think
about it a little more. I guess the main reason you need the aio_down_wait
callback is to make sure the semaphore is grabbed right in the context
of the wakeup rather than at retry time, is that correct ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135676AbRDSOAA>; Thu, 19 Apr 2001 10:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135678AbRDSN7u>; Thu, 19 Apr 2001 09:59:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18695 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135676AbRDSN7j>;
	Thu, 19 Apr 2001 09:59:39 -0400
Date: Thu, 19 Apr 2001 15:59:30 +0200
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: block devices don't work without plugging in 2.4.3
Message-ID: <20010419155930.G22517@suse.de>
In-Reply-To: <20010419152443.B22517@suse.de> <200104191354.f3JDs7C27006@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104191354.f3JDs7C27006@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Thu, Apr 19, 2001 at 03:54:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19 2001, Peter T. Breuer wrote:
> OK - agreed. But while I have your attention...
> 
> "Jens Axboe wrote:"
> > On the contrary, you are now given an exceptional opportunity to clean
> > up your code and get rid of blk_queue_pluggable and your noop plugging
> > function.
> 
> In summary: blk_queue_pluggable can be removed for all driver codes
> aimed at all 2.4.* kernels, because the intended effect can be obtained
> through merge_reqeusts function controls.

Yes

> My unease derives, I think, from the fact that I have occasionally used
> plugging for other purposes. Namely for throttling the device. These
> uses have always been experimental and uniformly unsuccessful, because
> throttling that way backs up the VFS with dirty buffers and provokes
> precisely the deadlock against VFS that I was trying to avoid. So ..
> 
>  ... how can I tell when VFS is nearly full?  In those circumstances I
> want to sync every _other_ device, thus giving me enough buffers at
> least to flush something to the net with, thus freeing a request of
> mine, plus its buffers.

You can't, there's currently no way of doing what you suggest. The block
layer will throttle locked buffers for you. Besides, this would be the
very wrong place to do it. If you reject or throttle requests, you are
effectively throttling stuff that is already locked down and cannot be
touched.

-- 
Jens Axboe


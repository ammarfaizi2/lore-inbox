Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129866AbRBTXww>; Tue, 20 Feb 2001 18:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130035AbRBTXwm>; Tue, 20 Feb 2001 18:52:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54788 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129852AbRBTXwj>;
	Tue, 20 Feb 2001 18:52:39 -0500
Date: Wed, 21 Feb 2001 00:52:24 +0100
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: plugging in 2.4. Does it work?
Message-ID: <20010221005224.C1447@suse.de>
In-Reply-To: <20010221003757.A1447@suse.de> <200102202348.f1KNmMQ03100@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200102202348.f1KNmMQ03100@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Wed, Feb 21, 2001 at 12:48:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21 2001, Peter T. Breuer wrote:
> I recall that in 2.2 the make_request code tested that the
> buffers were contiguous in memory. From 2.2.18:
> 
>                         /* Can we add it to the end of this request? */
>                         if (back) {
>                                 if (req->bhtail->b_data + req->bhtail->b_size
>                                     != bh->b_data) {
>                                         if (req->nr_segments < max_segments)
>                                                 req->nr_segments++;
>                                         else break;
>                                 }
> 
> It looks to me like it tested that the b_data char* pointers of the
> two requests being considered are exactly distant by the declared
> size of one.
> 
> Is that no longer the case? If so, that's my answer.

It will still cluster, the code above checks if the next bh is
contigious -- if it isn't, then check if we can grow another segment.
So you may be lucky that some buffer_heads in the chain are indeed
contiguous, that's what the segment count is for. This is exactly
the same in 2.4.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135668AbRDSNZ6>; Thu, 19 Apr 2001 09:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135666AbRDSNZv>; Thu, 19 Apr 2001 09:25:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58886 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135667AbRDSNY5>;
	Thu, 19 Apr 2001 09:24:57 -0400
Date: Thu, 19 Apr 2001 15:24:43 +0200
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: block devices don't work without plugging in 2.4.3
Message-ID: <20010419152443.B22517@suse.de>
In-Reply-To: <20010419144025.T16822@suse.de> <200104191309.f3JD93V24427@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104191309.f3JD93V24427@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Thu, Apr 19, 2001 at 03:09:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19 2001, Peter T. Breuer wrote:
> "Jens Axboe wrote:"
> > Examine _why_ you don't want plugging. In 2.2, you would have to edit
> > the kernel manually to disable it for your device.
> 
> True. Except that I borrowed a major which already got that special
> treatment.

Ok

> >                                            For 2.4, as long as
> > there has been blk_queue_pluggable, there has also been the
> > disable-merge function mentioned. Why are you disabling plugging??
> 
> Fundamentally, to disable merging, as you suggest. I had merging
> working fine in 2.0.*. Then I never could figure out what had to be
> done in 2.2.*, so I disabled it. In 2.4, things work nicely - I don't
> have to do anything and it all happens magically.

Great

> Nevertheless, I am left with baggage that I have to maintain -
> certainly the driver has to work in 2.2 as well as in 2.4. Removing
> the blah_plugging function now in 2.4 after having started off 2.4 
> with it around gives me one more #ifdef kernel_version in my code.

On the contrary, you are now given an exceptional opportunity to clean
up your code and get rid of blk_queue_pluggable and your noop plugging
function.

> I don't think that's good for my code, and in general I don't think one
> should remove this function half way through a stable series. Leave it
> there, mark it as deprecated in big letters, and make it do nothing,
> but leave it there, no?

Because most people are using it for the wrong reason anyway, so I'd
consider it a not-so-subtle hint. There should be no need for extra
ifdef's, on the contrary.

-- 
Jens Axboe


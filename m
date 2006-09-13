Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751609AbWIMGQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbWIMGQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 02:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWIMGQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 02:16:27 -0400
Received: from brick.kernel.dk ([62.242.22.158]:13088 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751606AbWIMGQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 02:16:26 -0400
Date: Wed, 13 Sep 2006 08:14:40 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 11/20] nbd: request_fn fixup
Message-ID: <20060913061440.GC23515@kernel.dk>
References: <20060912143049.278065000@chello.nl> <20060912144904.197253000@chello.nl> <20060912224710.GB23515@kernel.dk> <45074EF2.3080407@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45074EF2.3080407@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >Generally the block device rule is that once you are invoked due to an
> >unplug (or whatever) event, it is the responsibility of the block device
> >to run the queue until it's done. So if you bail out of queue handling
> >for whatever reason (might be resource starvation in hard- or software),
> >you must make sure to reenter queue handling since the device will not
> >get replugged while it has requests pending. Unless you run into some
> >software resource shortage, running of the queue is done
> >deterministically when you know resources are available (ie an io
> >completes). The device plugging itself is only ever done when you
> >encounter a shortage outside of your control (memory shortage, for
> >instance) _and_ you don't already have pending work where you can invoke
> >queueing from again.
> 
> Or he could employ the blk_{start,stop}_queue() functions, if that model 
> is easier for the driver (and brain).

Definitely, yes.

-- 
Jens Axboe


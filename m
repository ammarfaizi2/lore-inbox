Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263227AbUEOTu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUEOTu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 15:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264717AbUEOTu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 15:50:26 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:38412 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263227AbUEOTuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 15:50:25 -0400
Date: Sat, 15 May 2004 20:50:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slabify iocontext + request_queue
Message-ID: <20040515205022.A4788@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@suse.de>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040515190735.A4189@infradead.org> <20040515173004.GA962@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040515173004.GA962@suse.de>; from axboe@suse.de on Sat, May 15, 2004 at 07:30:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 07:30:04PM +0200, Jens Axboe wrote:
> > While I agree on the io_context part, slabifying request_queue is a space
> > waste on most machines out there.  The averange desktop has less than a
> > handfull of these, and even for smaller servers it doesn't exactly look
> > like a gain.
> 
> See the thread last week on queue congestion threshold calculations,
> there were some numbers in there.

Maybe my math is completely off, but with slab you'd need a page at least,
the kmem_cache_t and maybe a kmem_bufctl_t

So for the usual two or three queue desktops we went from 1024 or 1536
to 4096 + N.

Cutoff point is at aproximately 9 queues which I think most machines running
linux won't reach.

Anyway, not that this is really important, I think we just need to question
all this silent bloating a little..


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbTLaKdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 05:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbTLaKdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 05:33:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51433 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264129AbTLaKdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 05:33:14 -0500
Date: Wed, 31 Dec 2003 11:32:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Andrew Morton <akpm@osdl.org>, Miquel van Smoorenburg <miquels@cistron.nl>,
       linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: System hangs after echo value > /sys/block/dm-0/queue/nr_requests
Message-ID: <20031231103258.GT3086@suse.de>
References: <20031229130055.GA30647@cistron.nl> <20031230034239.27950054.akpm@osdl.org> <3FF21BE1.9070603@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF21BE1.9070603@cs.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30 2003, Mike Christie wrote:
> Andrew Morton wrote:
> 
> >Where queue_requests_store() does wake_up(&rl->wait[READ]);
> >
> >It looks like nobody has called blk_init_queue() for this queue and the
> >waitqueue head is uninitialised.
> >
> 
> DM, MD, rd and loop use blk_alloc_queue and blk_queue_make_request to 
> initialize their queue, because they only use the make_request_fn. The 
> attached patch prevents the queue from being registered if only 
> blk_alloc_queue was called.

I'm fine with that patch since we don't have any attributes in there
that apply to just remappers.

-- 
Jens Axboe


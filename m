Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263049AbTCWMRQ>; Sun, 23 Mar 2003 07:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263048AbTCWMRQ>; Sun, 23 Mar 2003 07:17:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63891 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263044AbTCWMRO>;
	Sun, 23 Mar 2003 07:17:14 -0500
Date: Sun, 23 Mar 2003 13:28:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Subodh S <subodh_s_1975@mail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Servicing of requests
Message-ID: <20030323122810.GC2371@suse.de>
References: <20030323121850.48607.qmail@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323121850.48607.qmail@mail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23 2003, Subodh S wrote:
> Hi,
> 
> Whenever I read data of 'x'k size using one read() system call, I find
> batches of some 'y' no. of make_requests calls followed by the same
> no. of end_io's. Something like :

> make_req
> make_req
> make_req
> end_io
> end_io
> end_io
> make_req
> make_req
> make_req
> end_io
> end_io
> end_io
> 
> The output above gives me an idea that 3(hypothetical no.)
> buffer_heads above form a request.  (since 1 make_request corresponds
> to 1 buffer_head) and maybe since 1 request is serviced at a time I
> can see 3 make_req's together. Is my understanding right ??
> 
> But, I have read that sd uses some optimization algorithm to club
> requests so that the disk seek time is reduced. In which case since
> all requests are to adjecents sectors it should create a single
> request of all 'x'k assuming 1 buffer_head is of size 1k.
> 
> Does this make sense ??

First of all, please line wrap your emails at 72 chars. Your mail reads
horribly.

Second, what is your question? Yes typically buffer_heads can get
clustered into a request so that contig regions on disk are handed to
the driver as a single request that may contain X buffer_heads. sd
doesn't do this on its own, the block layer does it for the driver. And
it happens for all drivers.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUB2JuW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 04:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbUB2JuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 04:50:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5811 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262026AbUB2JuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 04:50:20 -0500
Date: Sun, 29 Feb 2004 10:49:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Ming Zhang <mingz@ele.uri.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: can generic_make_request in 2.4 kernel sleep?
Message-ID: <20040229094945.GG3149@suse.de>
References: <1077984402.4422.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077984402.4422.36.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28 2004, Ming Zhang wrote:
> Hi, I have a quick question.
> 
> In 2.4 kernel, can generic_make_request sleep?

yes

> I read the 2.4.24 kernel and find that there is printk in it. so i
> assume it can sleep. if so, why the per queue make_request_fn can not
> sleep base on the LDD book? and i do not see any place that the
> io_request_lock is held. is this lock removed from system? or we do not
> need this lock at this place any more?
> 
> and in md code, it use blk_queue_make_request to use its own request_fn
> instead a queue, for example, in raid1_make_request(), it calls
> raid1_alloc_r1ch() which also call schedule() if need, then this own
> request_fn can sleep?
> 
> i think i am little confused about the LDD (linux device driver 2nd)
> book and the new kernel code. can anybody point out some latest
> reference for me?

->make_request_fn() is not entered with the queue/io_request_lock. It
can sleep, it's not recommended since on writeout you are blocking
kswapd/bdflush.

-- 
Jens Axboe


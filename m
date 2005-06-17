Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVFQOLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVFQOLP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 10:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVFQOLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 10:11:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29651 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261979AbVFQOKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 10:10:53 -0400
Date: Fri, 17 Jun 2005 16:12:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Cc: linux-kernel@vger.kernel.org, j-nomura@ce.jp.nec.com
Subject: Re: [PATCH] __cfq_get_queue() fix for 2.6.12-rc5
Message-ID: <20050617141204.GM6957@suse.de>
References: <20050608.131941.41628326.k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608.131941.41628326.k-ueda@ct.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08 2005, Kiyoshi Ueda wrote:
> Hello,
> 
> I resend this e-mail, as it may not be sent properly.
> Please excuse me, if you receive same one.
> 
> 
> I found a possible bug by which the first get_request() for a process
> fails in cfq I/O scheduler.
> If it's a bug, please consider to apply the patch for 2.6.12-rc5 below.
> 
> 
> When cfq I/O scheduler is selected, get_request() in __make_request()
> calls __cfq_get_queue().
> __cfq_get_queue() finds an existing queue (struct cfq_queue) of the
> current process for the device and returns it.  If it's not found,
> __cfq_get_queue() creates and returns a new one if __cfq_get_queue()
> is called with __GFP_WAIT flag, or __cfq_get_queue() returns NULL
> (this means that get_request() fails) if no __GFP_WAIT flag.
> 
> On the other hand, in __make_request(), get_request() is called
> without __GFP_WAIT flag at the first time.
> Thus, the get_request() fails when there is no existing queue,
> typically when it's called for the first I/O request of the process
> to the device.
> 
> Though it will be followed by get_request_wait() for general case,
> __make_request() will just end the I/O with an error (EWOULDBLOCK)
> when the request was for read-ahead.

Good analysis, the patch looks correct. I've applied it, thanks.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264858AbTFCJtV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 05:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264872AbTFCJtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 05:49:21 -0400
Received: from ns.suse.de ([213.95.15.193]:43789 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264858AbTFCJtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 05:49:19 -0400
Date: Tue, 3 Jun 2003 12:02:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: Counter-kludge for 2.5.x hanging when writing to block device
Message-ID: <20030603100255.GJ482@suse.de>
References: <200306030848.h538mwE22282@freya.yggdrasil.com> <20030603091018.GI482@suse.de> <20030603030023.69d39d6e.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603030023.69d39d6e.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03 2003, Andrew Morton wrote:
> > Does something like this work? Andrew, what's the point of doing the
> > wait if the queue isn't congested?!
> 
> We need to wait until the amount of dirty memory in the machine is below
> the designated limits.  This is unrelated to queue congestion.  The way the
> logic is now we can have 256 megs worth of requests queues on a 32M machine
> and everything throttles and clamps as intended.
> 
> 
> There are several things wrong with blk_congestion_wait(), including:
> 
> a) it should be called throttle_on_io()

Well...

> b) it should check that there are still requests in flight after parking
>    itself on the waitqueue rather than relying on the timeout.

This is important, would be much nicer to pass in the backing dev. This
is a big problem, imho. It's broken right now.

> As for Adam's hang: dunno.  I and many others have run mkfs and dd an
> unbelievable number of times.  He needs to debug it more.

Agree

-- 
Jens Axboe


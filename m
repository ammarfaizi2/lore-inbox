Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751958AbWHNIuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbWHNIuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 04:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbWHNIuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 04:50:10 -0400
Received: from brick.kernel.dk ([62.242.22.158]:39978 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751958AbWHNIuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 04:50:09 -0400
Date: Mon, 14 Aug 2006 10:51:47 +0200
From: Jens Axboe <axboe@suse.de>
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: softirq considered harmful
Message-ID: <20060814085147.GL4231@suse.de>
References: <20060812.180944.51301787.davem@davemloft.net> <20060812182234.605b4fb4.akpm@osdl.org> <20060814073724.GJ4231@suse.de> <20060814.014448.30183193.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060814.014448.30183193.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14 2006, David Miller wrote:
> From: Jens Axboe <axboe@suse.de>
> Date: Mon, 14 Aug 2006 09:37:25 +0200
> 
> > Hopefully you often end up doing > 1 request for a busy IO sub system,
> > otherwise the softirq stuff is pointless. But it's still pretty bad for
> > single requests.
> 
> Note that the per-cpu softirq completion of I/O events means
> that the queue can be processed lockless.
> 
> I'm not saying this justifies softirq I/O completion, I'm just
> mentioning it as one benefit of the scheme.  This is also why
> networking uses softirqs for the core irq events instead of
> tasklets.

As I wrote, the actual processing of the completion can often be done
lockless in the first place, so there's little benefit to offloading
those to softirq completion. We definitely have room for improvement.

> It appears the scsi code uses hw IRQ locking for all of it's
> locking so that should be fine.

Yep

> However there might be some scsi exception handling dependencies
> on the completions being run in software irq context, but this is
> just a guess.
> 
> iSCSI would need to be checked out too.

It certainly isn't an easy job, lots of stuff needs to be eye balled.

-- 
Jens Axboe


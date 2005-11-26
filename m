Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932704AbVKZDZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbVKZDZa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 22:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbVKZDZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 22:25:30 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:63620 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932704AbVKZDZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 22:25:29 -0500
Date: Sat, 26 Nov 2005 11:33:32 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Bart Samwel <bart@samwel.tk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 16/19] readahead: laptop mode support
Message-ID: <20051126033332.GB7226@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Bart Samwel <bart@samwel.tk>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20051125151210.993109000@localhost.localdomain> <20051125151723.001129000@localhost.localdomain> <43873681.6030609@samwel.tk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43873681.6030609@samwel.tk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2005 at 05:06:25PM +0100, Bart Samwel wrote:
> Wu Fengguang wrote:
> >When the laptop drive is spinned down, defer look-ahead to spin up time.
> 
> Just a n00b question: isn't readahead something that happens at read 
> time at the block device level? And doesn't the fact that you're reading 
> something imply that the drive is spun up? Or can readahead be triggered 
> by reading from cache?

Yes, both the old and new read-ahead logic issue read-ahead requests before
the pages are immediately needed. It is called look-ahead in the new logic,
which achieves I/O pipelining, and helps hide the I/O latency.

> >For crazy laptop users who prefer aggressive read-ahead, here is the way:
> >
> ># echo 1000 > /proc/sys/vm/readahead_ratio
> ># blockdev --setra 524280 /dev/hda      # this is the max possible value
> 
> These amounts of readahead are absolutely useless though. I've done 
> measurements about a year ago, that show that at a spindown time of two 
> minutes you've basically achieved all the power savings you can get. 
> More than 10 minutes of spindown is absolutely useless unless you have a 
> desktop drive, because those don't normally support more than 50,000 
> spinup cycles. The only apps I can think of that work on this amount of 
> data in such a short period of time are all apps where you shouldn't be 
> concerned about power drawn by the hard drive. :)

Thanks, I have read about the paper, quite informative :)

It's just that some one suggested about the feature, and it's just a matter of
lifting some limit values in the code - so I did it :)

Regards,
Wu

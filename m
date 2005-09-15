Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030541AbVIOROO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030541AbVIOROO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 13:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030542AbVIOROO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 13:14:14 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:61512
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1030541AbVIORON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 13:14:13 -0400
Date: Thu, 15 Sep 2005 19:14:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-task-predictive-write-throttling-1
Message-ID: <20050915171420.GG4122@opteron.random>
References: <20050914220334.GF4966@opteron.random> <200509151044.24002.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509151044.24002.kernel@kolivas.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 10:44:23AM +1000, Con Kolivas wrote:
> Nice idea!
> 
> I suspect the reason 5 seconds is good is probably because it's the same value 
> as dirty_writeback_centisecs.
> 
> I think this patch will sit nicely in my tree thanks :).

Fine ;) it's in -mm too, I hope it's stable and it doesn't introduce
regressions ;).

BTW, I tested dbench (not after a fresh mke2fs so there might be
minor fragmentation variations) and it doesn't seem affected by it (it's
in the noise range) and I take it as a good thing. dbench keeps looking
weird, if you notice the lower bandwidth of 273 completed in 12m13s
while the higher bandwidth of 291 completed in 12m15s... perhaps it
prints the best bandwith of the passes and it's not an average.

set to 500:

Throughput 288.217 MB/sec 50 procs

real    12m14.921s
user    9m49.185s
sys     25m38.896s
Throughput 306.644 MB/sec 50 procs

real    12m15.696s
user    10m18.207s
sys     26m39.704s


set to 0:

Throughput 291.415 MB/sec 50 procs

real    12m15.668s
user    9m50.229s
sys     26m58.341s
Throughput 273.05 MB/sec 50 procs

real    12m13.098s
user    9m28.964s
sys     23m58.430s
xeon:/mnt # 

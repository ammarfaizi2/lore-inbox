Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbVIOAlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVIOAlB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 20:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOAlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 20:41:01 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:50853 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932495AbVIOAlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 20:41:00 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] per-task-predictive-write-throttling-1
Date: Thu, 15 Sep 2005 10:44:23 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050914220334.GF4966@opteron.random>
In-Reply-To: <20050914220334.GF4966@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509151044.24002.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2005 08:03 am, Andrea Arcangeli wrote:
> I wrote a patch to try avoiding making dirty about half the ram of the
> computer when a single task is writing to disk (like during untarring or
> rsyncing). I try to detect how many pages this task wrote durign the
> last dirty_ratio_centisecs (sysctl configurable), and I assume that
> those pages are already dirty (since they'll be soon anyway).
>
> This way a write-hog task will not lock dirty half the cache for no good
> reason and other tasks will be allowed to use the dirty cache to avoid
> blocking during writes. It's not like the write will not be noticeable,
> but it should become substantially more responsive.
>
> I did a basic test to verify that the performance of the write-hog task
> didn't suffer, the bandwidth remains the same (difference of 2 seconds
> over 1 min and 20sec of workload). [though this should be tested in
> other configurations, it may not be stable yet, the dirty level can go
> down to zero to the point of nr_reclaimable reaching 0, hence the check
> needed to avoid locking up in blk_congestion_wait]
>
> /proc/<pid>/future_pages tells about the current prediction.
> /proc/sys/vm/dirty_ratio_centisecs enables/disables the feature, setting
> it to 0 makes the kernel behave like current mainline, no difference,
> setting it close to zero means almost disabled, large values means very
> enabled, a reasonable value is 5 sec, predicting too much in the future
> may not lead the best results in real life as you can guess ;).

Nice idea!

I suspect the reason 5 seconds is good is probably because it's the same value 
as dirty_writeback_centisecs.

I think this patch will sit nicely in my tree thanks :).

Cheers,
Con

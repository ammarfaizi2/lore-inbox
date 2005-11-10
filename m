Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVKJRJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVKJRJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 12:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVKJRJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:09:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61990 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751169AbVKJRJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:09:49 -0500
Date: Thu, 10 Nov 2005 18:10:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cfq-iosched: fix slice_left calculation
Message-ID: <20051110171051.GD3699@suse.de>
References: <20051110140042.GA25774@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110140042.GA25774@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10 2005, Tejun Heo wrote:
> When cfq slice expires, remainder of slice is calculated and stored in
> cfqq->slice_left.  Current code calculates the opposite of remainder -
> how many jiffies the cfqq has used past slice end.  This patch fixes
> the bug.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
> --- a/block/cfq-iosched.c
> +++ b/block/cfq-iosched.c
> @@ -861,8 +861,8 @@ __cfq_slice_expired(struct cfq_data *cfq
>  	 * store what was left of this slice, if the queue idled out
>  	 * or was preempted
>  	 */
> -	if (time_after(now, cfqq->slice_end))
> -		cfqq->slice_left = now - cfqq->slice_end;
> +	if (time_after(cfqq->slice_end, now))
> +		cfqq->slice_left = cfqq->slice_end - now;
>  	else
>  		cfqq->slice_left = 0;

That looks more correct, good spotting. Applied.

-- 
Jens Axboe


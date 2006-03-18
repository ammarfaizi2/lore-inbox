Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752249AbWCRIQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbWCRIQI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 03:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752348AbWCRIQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 03:16:08 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:41424 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1752249AbWCRIQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 03:16:07 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.16-rc6 patch] fix interactive task starvation
Date: Sat, 18 Mar 2006 19:15:47 +1100
User-Agent: KMail/1.9.1
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu
References: <1142658480.8262.38.camel@homer> <20060318000549.4bb35800.akpm@osdl.org>
In-Reply-To: <20060318000549.4bb35800.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603181915.48098.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 19:05, Andrew Morton wrote:
> Mike Galbraith <efault@gmx.de> wrote:
> > The patch below fixes a starvation problem that occurs when a stream of
> >  highly interactive tasks delay an array switch for extended periods
> >  despite EXPIRED_STARVING(rq) being true.  AFAIKT, the only choice is to
> >  enqueue awakening tasks on the expired array in this case.
> >
> >  Without this patch, it can be nearly impossible to remotely login to a
> >  busy server, and interactive shell commands can starve for minutes.
> >
> >  This has not been verified by anyone.  Comments?
>
> What does that question mean, btw?

He's waiting for me to say I don't like it. But I do like it.

> -mm is looking like linux-2.6.38 at present so of course things got tangled
> up - sched-activate-sched-batch-expired.patch modifies __activate_task().
>
> I ended up with the below.
>
> Which do we think is more likely to be true - batch_task(p) or
> expired_starving(rq)?  batch_task() looks cheaper to evaluate so I put that
> first.  But I guess it's less likely to be true.  hmm.

Depends entirely on workload so it's impossible to predict in advance. Any 
order will do I suspect.

> +	if (unlikely(batch_task(p) || expired_starving(rq)))

Looks good to me.

Acked-by: Con Kolivas <kernel@kolivas.org>

Cheers,
Con

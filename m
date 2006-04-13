Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWDMKRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWDMKRQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 06:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWDMKRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 06:17:16 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:12218 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964869AbWDMKRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 06:17:16 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Thu, 13 Apr 2006 20:16:44 +1000
User-Agent: KMail/1.9.1
Cc: bert hubert <bert.hubert@netherlabs.nl>,
       lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
References: <1144402690.7857.31.camel@homer> <1144681009.8493.17.camel@homer> <1144914061.9352.25.camel@homer>
In-Reply-To: <1144914061.9352.25.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604132016.45512.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 April 2006 17:41, Mike Galbraith wrote:
> This way also allowed me to eliminate the interactive agony of an array
> switch when at 100% cpu.  Seems to work well.  No more agony, only tiny
> pin pricks.
>
> Anyway, interested readers will find a copy of irman2.c, which is nice
> for testing interactive starvation, attached.   The effect is most
> noticeable with something like bonnie, which otherwise has zero chance
> against irman2.  Just about anything will do though.  Trying to fire up
> Amarok is good for a chuckle.  Whatever.  (if anyone plays with irman2
> on 2.6.16 or below, call it with -S 1)

Comments.

> +repeat:
> +	while ((idx = find_next_bit(bitmap, MAX_PRIO, idx)) < MAX_PRIO) {

...

> +		goto repeat;

...

> +               if (rq->nr_running > 1)
> +                       requeue_starving(rq, now);

An O(n) function in scheduler_tick is probably not the way to tackle this.

-- 
-ck

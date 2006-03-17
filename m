Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWCQNrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWCQNrl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbWCQNrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:47:41 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:7908 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751075AbWCQNrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:47:41 -0500
Date: Fri, 17 Mar 2006 14:47:40 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, ck@vds.kolivas.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: [PATCH] sched: activate SCHED BATCH expired
Message-ID: <20060317134740.GA7121@rhlx01.fht-esslingen.de>
References: <200603081013.44678.kernel@kolivas.org> <200603172338.10107.kernel@kolivas.org> <441AB8FA.10609@yahoo.com.au> <200603180036.11326.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603180036.11326.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 18, 2006 at 12:36:10AM +1100, Con Kolivas wrote:
> I'm not attached to the style, just the feature. If you think it's warranted 
> I'll change it.

Seconded.

An even nicer way (this solution seems somewhat asymmetric) than

   prio_array_t *target = rq->active;
   if (batch_task(p))
     target = rq->expired;
   enqueue_task(p, target);

may be

   prio_array_t *target;
   if (batch_task(p))
     target = rq->expired;
   else
     target = rq->active;
   enqueue_task(p, target);

and thus (but this coding style may be considered overloaded):

   prio_array_t *target;
   target = batch_task(p) ?
	rq->expired : rq->active;
   enqueue_task(p, target);


But this discussion is clearly growing out of control now ;)

Andreas Mohr

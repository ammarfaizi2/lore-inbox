Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWDPX0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWDPX0U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 19:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWDPX0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 19:26:19 -0400
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:35969 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750831AbWDPX0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 19:26:19 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: was Re: quell interactive feeding frenzy
Date: Mon, 17 Apr 2006 09:26:06 +1000
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org
References: <200604112100.28725.kernel@kolivas.org> <200604162037.02044.kernel@kolivas.org> <200604162203.32193.a1426z@gawab.com>
In-Reply-To: <200604162203.32193.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604170926.07516.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 April 2006 05:03, Al Boldi wrote:
> It's not bad, but it seems to allow cpu-hogs to steal left-over timeslices,
> which increases unfairness as the proc load increases.

Spot on.

> Conditionalizing 
> prio-boosting based on hogginess maybe one way to compensate for this. 
> This would involve resisting any prio-change unless hogged, which should be
> scaled by hogginess, something like SleepAVG but much simpler and less
> fluctuating.

Not interested in hacking on something like that onto it. It was more of an 
experiment in the simplest possible starvation free design that still 
supported nice levels.

> Really, the key to a successful scheduler would be to build it step by step
> by way of abstraction, modularization, and extension.  Starting w/ a
> noop/RR-scheduler, each step would need to be analyzed for stability and
> efficiency, before moving to the next step, thus exposing problems as you
> move from step to step.

While this may be the key, it is not the reason we aren't getting maximum 
roundness in our designs in linux. Our major enemy is cpu accounting of work 
done in kernel context on behalf of everyone else. Putting architecture 
dependant hooks into the assembly code to account for entry and exit would be 
the accurate way of doing this.

-- 
-ck

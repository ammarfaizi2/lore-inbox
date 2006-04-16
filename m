Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWDPTFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWDPTFX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 15:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWDPTFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 15:05:23 -0400
Received: from [212.33.166.183] ([212.33.166.183]:53255 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750789AbWDPTFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 15:05:23 -0400
From: Al Boldi <a1426z@gawab.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: was Re: quell interactive feeding frenzy
Date: Sun, 16 Apr 2006 22:03:31 +0300
User-Agent: KMail/1.5
Cc: ck list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org
References: <200604112100.28725.kernel@kolivas.org> <200604161131.02585.a1426z@gawab.com> <200604162037.02044.kernel@kolivas.org>
In-Reply-To: <200604162037.02044.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604162203.32193.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Al Since you have an unhealthy interest in cpu schedulers you may also
> want to look at my ultimate fairness with mild interactivity builtin cpu
> scheduler I hacked on briefly. I was bored for a couple of days and came
> up with the design and hacked it together. I never got around to finishing
> it to live up fully to its design intent but it's working embarassingly
> well at the moment. It makes no effort to optimise for interactivity in
> anyw way. Maybe if I ever find some spare time I'll give it more polish
> and port it to plugsched. Ignore the lovely name I give it; the patch is
> for 2.6.16. It's a dual priority array rr scheduler that iterates over all
> priorities. This is as opposed to staircase which is a single priority
> array scheduler where the tasks themselves iterate over all priorities.

It's not bad, but it seems to allow cpu-hogs to steal left-over timeslices, 
which increases unfairness as the proc load increases.  Conditionalizing 
prio-boosting based on hogginess maybe one way to compensate for this.  This 
would involve resisting any prio-change unless hogged, which should be 
scaled by hogginess, something like SleepAVG but much simpler and less 
fluctuating.

Really, the key to a successful scheduler would be to build it step by step 
by way of abstraction, modularization, and extension.  Starting w/ a 
noop/RR-scheduler, each step would need to be analyzed for stability and 
efficiency, before moving to the next step, thus exposing problems as you 
move from step to step.

Thanks!

--
Al


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbUCPMVT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 07:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbUCPMVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 07:21:18 -0500
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:34469 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261738AbUCPMVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 07:21:15 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Kurt Garloff <garloff@suse.de>
Subject: Re: bonus inheritance
Date: Tue, 16 Mar 2004 23:21:04 +1100
User-Agent: KMail/1.6.1
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040315225459.GY4452@tpkurt.garloff.de> <405696A9.3060304@cyberone.com.au> <20040316114820.GM4452@tpkurt.garloff.de>
In-Reply-To: <20040316114820.GM4452@tpkurt.garloff.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403162321.04933.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2004 10:48 pm, Kurt Garloff wrote:
> Hi Nick,
>
> On Tue, Mar 16, 2004 at 04:54:49PM +1100, Nick Piggin wrote:
> > Does it help any actual interactivity problem? Unfortunately
> > practically any you make to the scheduler is bound to make
> > things worse for at least one person, so it is difficult to
> > just test things out.
>
> Well, the interactivity problems existed with O(1) in 2.4.
> The 50% penalty hurt freshly started processes a lot.

There are at least 4 different O(1) schedulers in different 2.4 trees still in 
existence and the value of the penalty only started changing when 2.5 
development began. Therefore, no one value is what was in "2.4 O(1)" since 
there was no "standard" O(1). 2.6 is a completely different beast in 
estimating interactivity than the 2.4 O(1) kernels so changes do not work as 
expected upstream.

> To fix this, the penalty has been set to 95 (5% penalty)
> in 2.6.

Actually that's what it used to be on the first O(1) patches for 2.4

> I believe it's cleaner to draw the bonus towards the average
> and inherit a percentage, and thus I set a inheritance percentage
> of 50 in 2.4.
>
> It was successful in 2.4. In a measurable way.
>
> In 2.6, it likely will not make a big difference as with giving
> 95% of the bonus, you don't change much ...

Even less than that logic would reveal because this particular part of the 
estimator is far less important with the heuristics examining process 
behaviour very rapidly in 2.6. This value is more important in the estimator 
in preventing a fork bomb more than anything else.

> So it's more a question of have the concept in there which is
> clearer. More a theoretical thing. Assuming that with 95% chance
> your child has the same character w.r.t. to interactiveness is
> rather high.

See above; it is a penalty the way the estimator currently works.

> It will be very hard to measure 80% inheritance to 95% penalty
> as for the most important case (starting a process from a shell),
> the results are almost the same.
>
> The fact that we are more likely to start new processes towards
> the center in our bonus scale certainly makes it faster for the
> scheduler to put them in the right category, so there should be
> some benefit w.r.t. interactiveness. However, those are not easy
> to measure :-(

As I said; the 2.6 estimator does much in determining interactive tasks 
shortly after forking than just this simple knob affects.

> I'll see whether we can get some benchmarks anyway.

Please don't use contest as this does _not_ measure interactivity; it measures 
responsiveness which is quite different. Interactivity is avoiding scheduling 
latency and scheduling jitter in tasks where that latency and jitter would be 
palpable. I have ideas for coding a benchmark to measure such a thing but not 
the time to do it.

Please I encourage you to try whatever testing and modifications you want; but 
this is nowhere near as simple as it appears on the surface.

Con

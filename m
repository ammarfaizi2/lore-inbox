Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbUCRQAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 11:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbUCRQAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 11:00:36 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33417
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262729AbUCRQA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 11:00:27 -0500
Date: Thu, 18 Mar 2004 17:01:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@ximian.com>
Cc: Andrew Morton <akpm@osdl.org>, mjy@geizhals.at,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040318160109.GJ2246@dualathlon.random>
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <20040318015004.227fddfb.akpm@osdl.org> <20040318145129.GA2246@dualathlon.random> <1079624062.2136.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079624062.2136.21.camel@localhost>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Thu, Mar 18, 2004 at 10:34:22AM -0500, Robert Love wrote:
> I also feel you underestimate the improvements kernel preemption gives. 

Takashi benchmarked the worst case latency in very good detail.  2.6
stock with PREEMPT=y has a worst case latency of 2.4-aa. This is a fact.

With Takashi's lowlatency fixes the latency goes below 2.4-aa, w/ or w/o
PREEMPT.

PREEMPT=y doesn't and cannot improve the worst case latency. This is
true today like it was true 4 years ago.

> Yes, the absolute worst case latency probably remains because it tends
> to occur under lock (although, it is now easier to pinpoint that latency
> and work some magic on the locks).  But the variance of the latency goes
> way down, too.  We smooth out the curve.  And these are differences that
> matter.

I don't think they can matter when the worst case is below 0.2msec.

> And it can be turned off, so if you don't care about that and are not
> debugging atomicity (which preempt is a big help with, right?) then turn
> it off.

I want to implement my aged idea that is to do the opposite of preempt.

I believe that is a much more efficient way to smooth the curve at lower
overhead and no kernel complexity.

Preempt is always enabled as soon as the cpu enters kernel. And it can
be disabled on demand.

I want preempt to be disabled as soon as teh cpu enters kernel, and I
want to enable it on demand _only_ during the copy user, or similar cpu
intensive operations, also guaranteeing that those operations comes to
an end to avoid RCU starvation.

Then I would like to ompare the average latency (the curve) I doubt
they'll be any different, and the overhead will be zero (we've to check
need_resched anyways after a copy-user, so we can as well do
preempt_enable preembt_disable around it).

> Oh, and if the PREEMPT=n overhead is really an issue, then I agree that
> needs to be fixed :)

It's not a big issue of course (very low prio thing ;).

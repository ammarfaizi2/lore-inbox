Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275988AbRJGBM3>; Sat, 6 Oct 2001 21:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275983AbRJGBMU>; Sat, 6 Oct 2001 21:12:20 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:14886 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S275982AbRJGBMF>; Sat, 6 Oct 2001 21:12:05 -0400
Subject: Re: low-latency patches
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3BBEA8CF.D2A4BAA8@zip.com.au>
In-Reply-To: <20011006010519.A749@draal.physics.wisc.edu> 
	<3BBEA8CF.D2A4BAA8@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 06 Oct 2001 21:12:34 -0400
Message-Id: <1002417157.2263.96.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-06 at 02:46, Andrew Morton wrote:
> [...]
> > My questions are:
> > 1) Which of these two projects has better latency performance?  Has anyone
> >     benchmarked them against each other?
> 
> I haven't seen any rigorous latency measurements on Rob's stuff, and
> I haven't seriously measured the reschedule-based patch for months.  But
> I would expect the preempt patch to perform significantly worse because
> it doesn't attempt to break up the abovementioned long-held locks.  (It can
> do so, though - a straightforward adaptation of the reschedule patch's
> changes will fix it).

We've gotten some great benchmarks (I originally asked all the users for
them), I would be happy to send some your way if I can dig them up.

Basically we saw average latency drop to under 5ms; 1ms in many cases. 
Worst-case latency tended to be around 50ms, but we have measured locks
(using the preempt-stats) which are still in the way-to-long range.

I think preemption is a very natural and clean solution the problem --
its the way things should just be, anyhow.

Nonetheless, running a lock-breaking patch on top of preemption is
interesting.  I am looking into doing this with the lock times I have
collected.

> > 2) Will either of these ever be merged into Linus' kernel (2.5?)
> 
> Controversial.  My vague feeling is that they shouldn't.  Here's
> why:
> 
> The great majority of users and applications really only need
> a mostly-better-than-ten-millisecond latency.  This gives good
> responsiveness for user interfaces and media streaming.  This
> can trivially be achieved with the current kernel via a thirty line
> patch (which _should_ be applied to 2.4.x.  I need to get off my
> butt).
> 
> But the next rank of applications - instrumentation, control systems,
> media production sytems, etc require 500-1000 usec latencies, and
> the group of people who require this is considerably smaller.  And their
> requirements are quite aggressive.  And maintaining that performance
> with either approach is a fair bit of work and impacts (by definition)
> the while kernel.  That's all an argument for keeping it offstream.

With preemption, we can gain the <10ms that most "regular" users want. 
Without it, we don't have it.

With preemption, we can come super close to the 0.5-1ms latency (on
average) the specialized groups list want.  With preemption and perhaps
some other work (something akin to your low-latency patch) we can
achieve it for sure ... perhaps better.

If we can achieve such great results, and keep throughput low, and do it
with such little complexity -- of course, after we prove all this -- why
not merge it?  Anyhow, its a configure option!

> [...]


	Robert Love


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUGBHix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUGBHix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 03:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbUGBHix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 03:38:53 -0400
Received: from holomorphy.com ([207.189.100.168]:10428 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266491AbUGBHif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 03:38:35 -0400
Date: Fri, 2 Jul 2004 00:37:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK
Message-ID: <20040702073749.GK21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Davis <paul@linuxaudiosystems.com>,
	Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
References: <20040701181401.GB21066@holomorphy.com> <200407020327.i623RT0J010592@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407020327.i623RT0J010592@localhost.localdomain>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 01:03:56PM -0500, Matt Mackall wrote:
>>> I'm afraid these "brave souls" have shown up to the baby shower after
>>> the child's been accepted to college. Developers getting around to
>>> testing 2.6 after multiple vendors are shipping it should not be
>>> characterized as courageous.

On Thu, Jul 01, 2004 at 11:27:28PM -0400, Paul Davis wrote:
> I call BS on this response.
> We were told by A(ndrew)M(orton) and several other people that 2.6
> would not be as good as 2.4 for low latency real time audio. It was
> made clear that the preemption patches were considered more
> appropriate even though they did not do anywhere near as reliable an
> improvement as AM's lowlat patches. We found out (and I mean no
> discredit to AM whatsoever - he did an amazing job on the 2.4 lowlat
> patches) that the author of the premiere lowlat patches for 2.4 would
> not be maintaining a similar set for 2.6. We also found during the
> development of 2.5 that there were a number of areas of real concern,
> (the VM subsystem and the scheduler and the disk subsystems) but that
> many notable kernel developers were not particularly interested in our
> needs - we were considered odd, edge case studies.

Not only are lowlat-alike changes in mainline 2.6, the algorithms where
lowlat found explicit preemption points were necessary have been changed
in a number of cases to be asymptotically faster.

So you gave no feedback. What do you expect us to do? There are
enough other bugreports to keep us busy without testing the known
universe on behalf of you or anyone else sitting around waiting
silently for their needs to magically be addressed.


On Thu, Jul 01, 2004 at 11:27:28PM -0400, Paul Davis wrote:
> So we just punted and said "ah, its OK, we still have 2.4 and that
> works really, really well". I spent a lot of time working debugging,
> testing, measuring and playing with on 2.3 and 2.4. I even tested the
> HRT patches with great anticipation (they didn't work very well at
> all, and I didn't have time to spend tracking that down then). I'm
> terribly sorry, but I don't have time to do full-scale kernel
> debugging and also develop applications that have already taken 4+
> years to get to "useful". Frankly, the mess of dealing with the
> development process for 2.3/2.4, with a VM subsystem that took a year
> to stabilize into a situation where we could reliably stream realistic
> audio workloads didn't make me feel too good when I started reading
> about similar issues in 2.5 before it was even half-done. I tested
> just about every MM patch from andrea and rik that came out for
> 2.3/2.4 - I did not have time to do that with 2.5.

This level of participation is by no means a requirement. Just show
up, say, "I've got a problem, latency sucked $HERE while doing $THIS",
and it will be quashed in a manner similar to other performance and
functional issues when they're properly reported.

	At some point in the past, you wrote:
	>>> However, the ONLY way to get even vaguely reasonable
	>>> performance in this area is to disable the use of NPTL
	>>> using LD_ASSUME_KERNEL. With NPTL in use, there are a
	>>> series of apparently interlocking problems with scheduler
	>>> parameter inheritance, scheduler performance and decision
	>>> making. Its more or less impossible to run JACK-enabled audio
	>>> systems on 2.6 with NPTL. A series of ugly kludges are
	>>> beginning to emerge within the Linux audio community, and
	>>> I think its time we cut them off before things get out of hand.

The thing that went wrong here is that the report is very non-specific.
mingo, jakub, and uli had to go diving into your app's source etc.
hunting for bugs in your app, which is very nice of them to do, but not
really the way things are supposed to work. Narrowing the presumed
kernel issue down to a small enough userspace testcase or section of
code that you can reasonably post it is pretty much a burden you should
have taken on.

For one, the description of the nasty kludges or code that worked in
2.4 but not 2.6 should have been up-front. e.g. "I'm trying to get an
app to SCHED_FIFO, $FOO isn't working in 2.6 but does in 2.4" and bonus
points for "and my workaround to get it set up in 2.6 is $BAR" and so on.


On Thu, Jul 01, 2004 at 11:27:28PM -0400, Paul Davis wrote:
> And 2.4.19+ does work really well. The problem is that users are now
> booting up 2.6 and finding out that (1) the deep changes in the thread
> system have not been fully tested with real time thread applications
> and (2) the scheduler, VM and disk subsystems appear to be conspiring
> to prevent performance equivalent to 2.4+lowlat. Are we suprised? No,
> we knew this would be the case? Are we complaining? Not really. Are we
> asking for help? Are we offering to try to help as best we can? Yes,
> we certainly are.

The RT threading bits sounded largely like a userspace API change that
broke the app's initialization sequence, and that appears to be getting
fielded by mingo, jakub, and uli.


On Thu, Jul 01, 2004 at 11:27:28PM -0400, Paul Davis wrote:
> Courageous? Yes, because they are willing to start testing a kernel
> that has been developed with an open admission by the kernel
> development group that our needs are not considered particularly
> important or relevant (and there is nothing wrong with that, just to
> be clear about it). Linus made it clear 2 years ago that we weren't
> going to get what we needed any time soon, and personally, I am
> entirely happy with telling people to use 2.4+lowlat instead. There
> are several distributions of Linux that build precisely this kernel
> for users, and those users are very happy with it.

The userbase is so broad no one user group's needs are particularly
dominant. Surprise! You're coexisting with everyone else.


On Thu, Jul 01, 2004 at 11:27:28PM -0400, Paul Davis wrote:
> But NPTL has muddied the situation considerably. People did test NPTL
> when it came out. It seemed to work perfectly OK. So we just assumed
> that it would always work perfectly OK. It turns out, however, that it
> no longer does. And therefore I wrote to try to find out what we could
> do figure it out. 

This is too vague to do anything with; write up a coherent bug/problem
report for glibc and/or kernel maintainers to do something about.
"LD_ASSUME_KERNEL mysteriously makes app run smoother" is really
something you should have determined a proximal cause for before broad
sweeping statements about 2.6 ignoring the needs of whatever category
of apps this is in some misguided attempt to motivate someone to
discover the root cause and repair it on your behalf. Otherwise, if
LD_ASSUME_KERNEL fixes it for you, why would we care?


At some point in the past, I wrote:
>> I appear to have nuked the thread you're replying to in disgust over
>> this precise issue.

On Thu, Jul 01, 2004 at 11:27:28PM -0400, Paul Davis wrote:
> Disgust? Thanks for sharing.

Yes, disgust. You presume you are an isolated case, or potentially
"special". This is not so. There are people crawling out of the woodwork
all the time complaining about vague "$BIZARRE_ANCIENT_KERNEL did better
than -CURRENT" issues. Thus far your postings are indistinguishable
from those, and whether you like it or not, they're being classified
right alongside those due to their lack of specificity. Everyone's got
some kind of substance hidden somewhere. Presentation matters. We're
pulled in too many different directions to play guessing games and dive
into every userspace app whose author screams "regression!" that comes along.

In summary:
(1) please try to present adequate information directly
	-- describe your situation directly instead of needing people
	-- to debug your apps for you
(2) please avoid vague generalizations like "2.6 is ignoring RT audio"
	-- they're noninformative and inflammatory
(3) please test major kernel versions promptly after release
	-- this doesn't require particularly much effort, major kernel
	-- versions are infrequently released, and we don't actually
	-- need intense debugging/etc. from you, merely self-contained
	-- examples or descriptions of whatever is going wrong in
	-- userspace. Your description (not example) was not self-contained.


-- wli

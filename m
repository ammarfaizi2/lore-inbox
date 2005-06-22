Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVFVX2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVFVX2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVFVX2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 19:28:54 -0400
Received: from opersys.com ([64.40.108.71]:24081 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262590AbVFVX1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 19:27:36 -0400
Message-ID: <42B9F673.4040100@opersys.com>
Date: Wed, 22 Jun 2005 19:38:27 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Bill Huey <bhuey@lnxw.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, andrea@suse.de,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com> <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com> <20050622220428.GA28906@elte.hu>
In-Reply-To: <20050622220428.GA28906@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> please retest using recent (i.e. today's) -RT kernels. There were a
> whole bunch of fixes that could affect these numbers.

At this point, we're bound to rerun some of the tests. But there's
only so many times that one can claim that such and such test isn't
good enough because it doesn't have all the latest bells and whistles.
Surely there's more to this overhead than just rudimentary bugfixes.

Sorry, but it's just kind of frustrating to put so much time on
something like this and have results offhandidly dismissed just
because it isn't the truely bleeding edge. These results are
similar to our previous testset, which was on another version of
preempt_rt, which we were told then had had a bunch of fixes ...

Like I suggested earlier, there should be an automated test by
which each preempt_rt release is lmbenched against vanilla.

> (But i'm sure you
> know very well that you cannot expect a fully-preemptible kernel to have
> zero runtime cost. In that sense, if you want to be fair, you should
> compare it to the SMP kernel, as total preemptability is a similar
> technological feat and has very similar parallelism constraints.)

With this line of defense I sense things can get hairy fairly
rapidely. So I'll try to tread carefully.

Bare in mind here that what we're trying to find out with such
tests is what is the bare minimum cost of the proposed rt
enhancements to Linux, and how well do these perform in their
rt duties, the most basic of which being interrupt latency.

We understand that none of these approaches have zero cost, and
we also understand that not all approaches provide the same
mechanisms. However, a critical question must be answered:

What is the least-intrusive change, or sets of changes, that can
be applied to the Linux kernel to obtain rt, and what mechanisms
can, or cannot, be built on top of it (them)? (the unknown here
being that rt is defined differently by different people.)

One answer is what we postulated as being a combination of
PREEMPT_RT and the Ipipe, each serving a separate problem space.

Speaking just for myself here:
To be honest, however, I have a very hard time, as a user, to
convince myself that I should enable preempt_rt under any but
the most dire situations given the results I now have in front
of me. Surely there's more of an argument than "this will cost
you as much as SMP" for someone deploying UP systems, which
apparently is the main target of preempt_rt with things like
audio and embedded systems.

I want to believe, but accepting more than >50% overhead over
regular system calls requires more than just religion ...

Any automated test, as suggested above, that would show some
sort of performance impact decrease over release iterations
would be helpful for sure. But that 50%+ is going to have to
melt significantly along the way ... for me at least.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

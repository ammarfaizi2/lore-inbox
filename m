Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVFVRzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVFVRzE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVFVRxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:53:24 -0400
Received: from opersys.com ([64.40.108.71]:5646 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261749AbVFVRrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:47:49 -0400
Message-ID: <42B9A6D6.4060109@opersys.com>
Date: Wed, 22 Jun 2005 13:58:46 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com>
In-Reply-To: <20050622162718.GD1296@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney wrote:
> I have big hands, so 7us could indeed qualify as a "handful".

:)

> Any insights as to what leads to the larger maximum delay?  Some guesses
> include worst-case cache-miss patterns and interrupt disabling that I
> missed in my quick scan of the patch.

Beats me. Given that PREEMPT_RT and the I-pipe get to the same maximum
by using two entirely different approaches, I'm guessing this has more
to do with hardware-related contention than anything inside the patches
themselves.

> If I understand your analysis correctly (hah!!!), your breakdown
> of the maximum delay assumes that the maximum delays for the logger
> and the target are correlated.  What causes this correlation?

No it doesn't. I'm just inferring the maximum and average using the
data obtained in the ipipe-to-ipipe setup. In that specific case,
I'm assuming that the interrupt latency on both systems for the
same type of interrupt is identical (after all, these machines are
physically identical, albeit one has 512MB or RAM and the other
256.)

There is no correlation. Just the assumption that what's actually
being measured is twice the latency of the ipipe in that specific
setup.

Given that the interrupt latency of preempt_rt is measured using one
machine runing adeos (read ipipe) and the other preempt_rt, I'm
deducing the latency of preempt_rt based on the numbers obtained
for the ipipe by looking at the ipipe-to-ipipe setup.

> My (probably hopelessly naive) assumption would be that there would
> be no such correlation.  In absence of correlation, one might
> approximate the maximum ipipe delay by subtracting the -average-
> ipipe delay from the maximum preemption delay, for 55us - 7us = 48us.
> Is this the case, or am I missing something here?

Not directly. You'd have to start by saying that the true maximum ipipe
delay is obtained by substracting the average ipipe delay from the
measured maximum ipipe delay (to play safe you could even substract
the minimum.)

However such a maximum isn't correlated by the data. If indeed there
was a difference between the maximums, averages and minimums of the
ipipe and preempt_rt, the shear quantity of measurements would not
have shown such latency similarities. IOW, it is expected that at
least once in a blue moon we'll hit that case where both the target
and the logger demonstrate their highest possible latency. That's
what we can safely assume 55us is, again given the number of samples.
Remember that on the first run, we sometimes observed a maximum
ipipe-to-ipipe response time of 21us. That's because in those runs
the blue-moon scenario didn't materialize.

> Of course, in the case of the -average- preemption measurements, dividing
> by two to get the average ipipe delay makes perfect sense.

There's no correlation, so I don't see this one.

> Whatever the answer to my maximum-delay question, the same breakdown of
> the raw latency figures would apply to the CONFIG_PREEMPT_RT case, right?

Sure, but again see the above caveats.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

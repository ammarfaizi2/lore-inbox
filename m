Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbUJZFFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbUJZFFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 01:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUJZFBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 01:01:46 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:22802 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261924AbUJZBgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:36:31 -0400
Message-ID: <33313.192.168.1.5.1098733224.squirrel@192.168.1.5>
In-Reply-To: <20041025141628.GA14282@elte.hu>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
    <20041025104023.GA1960@elte.hu> <417CDE90.6040201@cybsft.com>
    <20041025111046.GA3630@elte.hu> <20041025121210.GA6555@elte.hu>
    <20041025152458.3e62120a@mango.fruits.de>
    <20041025132605.GA9516@elte.hu>
    <20041025160330.394e9071@mango.fruits.de>
    <20041025141008.GA13512@elte.hu> <20041025141628.GA14282@elte.hu>
Date: Mon, 25 Oct 2004 20:40:24 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Florian Schmidt" <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "Bill Huey" <bhuey@lnxw.com>,
       "Adam Heath" <doogie@debian.org>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Alexander Batyrshin" <abatyrshin@ru.mvista.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 25 Oct 2004 19:42:55.0449 (UTC) FILETIME=[D2B58C90:01C4BACA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>> ok, i've added it and uploaded -V0.2 together with another fix: there
>> was a scheduler recursion possible via the delayed-put mechanism using
>> workqueues - now it's using its own separate lists and per-CPU
>> threads.
>
> -V0.2 seems to behave quite well on my testboxes - i'm unable to
> reproduce the selinux boot hang anymore.
>

OK. RT-V0.2 boots on my laptop (P4/UP), sometimes ;)

I know that my early impressions are illusive, rather subjective, but I do
feel overall behavior is getting worst, when regarding low-latency audio
work with jackd -R.

To put things straight with RT-V0.2, I get trouble with much less load
than even before.

I noticed that something is, now and then, topping the cpu to 99%, leaving
the system to a crawl, eventually returning back to normal. Can't figure
out who or what, just because ps or top are stalling to silence, only
returning results after when the crawl ends, which are of no useful
evidence. When I'm lucky enough to let top (and gkrellm) telling me
something, it does look like that most of the time is spent on kernel mode
(sys time) and none of the running processes are at stake. Puzzled. It's
just like you're about to loose confidence on the procps tools.

OTOH, jackd -R xruns are awfully back, even thought I (re)prioritize the
relevant IRQ thread handlers to be always higher than jackd's. This just
doesn't seem like an improvement, not at all :( IMO, given the xrun rate
I'm experiencing with RT-V0.2, it all seems that I'm running on vanilla
2.6.9, with pretty much instability added to the picture.

About that jackd -R issue, which has been hosing the complete system
occasionally, is still an annoyance on RT-V0.2. On this same laptop
(P4/UP), it does happen only if PREEMPT_REALTIME is set. However, I think
I've narrowed it's reproducibility: loading more than two fluidsynth
instances was the easiest way to get the box frozen in less than one
minute, at least on RT-U10.3. With RT-V0.2 is even easier, with just two
fluidsynth instances, or even one.

Sorry for this kind of rant, but I had to distress myself, somehow ;)

Nevertheless, I'll keep on going with my user level trials... and let you
informed, of course.

Cheers,
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



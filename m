Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263381AbUJ2Pfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263381AbUJ2Pfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbUJ2Pff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:35:35 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:6713 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S263406AbUJ2PCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 11:02:19 -0400
Message-ID: <32870.192.168.1.5.1099062000.squirrel@192.168.1.5>
In-Reply-To: <20041029073001.GB30400@elte.hu>
References: <20041027211957.GA28571@elte.hu>
    <33083.192.168.1.5.1098919913.squirrel@192.168.1.5>
    <20041028063630.GD9781@elte.hu>
    <20668.195.245.190.93.1098952275.squirrel@195.245.190.93>
    <20041028085656.GA21535@elte.hu>
    <26253.195.245.190.93.1098955051.squirrel@195.245.190.93>
    <20041028093215.GA27694@elte.hu>
    <43163.195.245.190.94.1098981230.squirrel@195.245.190.94>
    <20041028191605.GA3877@elte.hu>
    <32806.192.168.1.5.1099007364.squirrel@192.168.1.5>
    <20041029073001.GB30400@elte.hu>
Date: Fri, 29 Oct 2004 16:00:00 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 29 Oct 2004 15:02:17.0340 (UTC) FILETIME=[481103C0:01C4BDC8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> * Rui Nuno Capela wrote:
>
>> BTW, this means that I have to re-enable LATENCY_TIMING back again?
>
> yes. I'd suggest to start with the simplest setup - i.e. just one
> fluidsynth instance running. I suspect 3-4 instances later on will be
> enough to trigger some xruns or at least some of the bigger delays.
>
> you possibly wont be able to debug the 'production' setup, but that's
> not an issue because the latencies should show up under just 2-3
> instances running as well.
>
>> > Also, i'd suggest to simply remove that line (or apply the attached
>> > patch) - does the driver still work fine with that?
>> >
>>
>> Now that you call, I remember to hack that very same line, some time
>> go, but couldn't get no better than a udelay(33). Removing that line
>> just ended in some kind of malfunction, but can't remember what
>> exactly. One thing's for sure, sound didn't came out of it :-/
>
> ugh. Possibly some sort of interaction with the firmware and/or an
> outright driver bug?
>

Just confirmed that, by removing that udelay(100) line on ali5451.c, the
result is crappy sound (worst than normally is :) and most relevant to the
subject, I get a nasty jackd XRUN storm, without even blinking an eye.
Useless.

Regarding my test results, maybe this is just a distraction. I was just
comparing the kernels, not the hardware, jackd or the ali5451 alsa driver,
which were kept as constants along the evaluation.

In fact, those tests were only about to confirm, by numbers on-the-field,
that RT-V0 is on par to RT-U3. Don't bother to compare it to your own
setup and/or hardware. These are the kind of things that YMMCV = Your
Mileage Certainly Varies :)

For example, in my own case, if those tests are done with ACPI disabled
(yes, with acpi=off), this laptop of mine just skews the results
completely: vanilla 2.6.9 gets better results, while the RT ones go
slumber. Go figure ;)

OK. I'm really running out of time now. Family's calling for the weekend.

On the next few days I'll take the latency_trace route, as Ingo proposed,
patching ali5451 and jackd to issue a sys_gettimeofday(0, 0) and
gettimeofday(0, 1) trace on/off instrumentation respectively, while using
a proper RT-V0.5.x kernel patch line (or newer).

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272619AbRIWSbQ>; Sun, 23 Sep 2001 14:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272677AbRIWSbG>; Sun, 23 Sep 2001 14:31:06 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:47636 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S272619AbRIWSaq>; Sun, 23 Sep 2001 14:30:46 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@tech9.net>
To: Andre Pang <ozone@algorithm.com.au>
Cc: linux-kernel@vger.kernel.org, safemode@speakeasy.net,
        Dieter.Nuetzel@hamburg.de, iafilius@xs4all.nl, ilsensine@inwind.it,
        george@mvista.com
In-Reply-To: <1001246632.952193.13493.nullmailer@bozar.algorithm.com.au>
In-Reply-To: <1000939458.3853.17.camel@phantasy>
	<1001131036.557760.4340.nullmailer@bozar.algorithm.com.au>
	<1001139027.1245.28.camel@phantasy>
	<1001143341.117502.5311.nullmailer@bozar.algorithm.com.au>
	<1001228764.864.53.camel@phantasy> 
	<1001246632.952193.13493.nullmailer@bozar.algorithm.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.21.20.26 (Preview Release)
Date: 23 Sep 2001 14:31:17 -0400
Message-Id: <1001269889.1325.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-09-23 at 08:03, Andre Pang wrote:
> I found out why, it's the driver.  I'm an idiot for not trying
> this before ... I was previously using ALSA's snd-card-ymfpci
> driver; I switchted to the OSS ymfpci driver that comes with the
> kernel.  My latencies used to be 15ms on average, with spikes >
> 30ms; they're now ~3ms with some occasional spikes up to 10ms.

You are the second or third person to report high latencies with ALSA
drivers.  I wonder what braindead locking they do?

Good find.

> The graphs and numbers are up at
> http://www.algorithm.com.au/hacking/linux-lowlatency/

Nice results.

> > maybe the problem is in the "overruns" -- I don't know what that means
> > exactly.  maybe someone else on the list can shed some light? 
> > otheriwse, you can email the author perhaps.
> 
> An over-run occurs when the latencytest program, which plays a
> continuous sound, doesn't get re-scheduled quickly enough.  This
> results in a sound dropout because it can't re-fill its buffer.
> This is similar to what you would get in XMMS, except that
> latencytest simulates professional audio applications which must
> run with _very_ small buffers in order to get low latencies.
> (Imagine your computer being sync'ed in realtime with lots of
> other music equipment and have it drag behind by 30ms -- it
> doesn't sound good :).

Oh, ok -- its pretty much the number of times the scheduling latency was
greater than the audio buffer time.

> But I guess my problem's solved ... thanks so much to Andrew,
> yourself, MontaVista, Dietel and all the other guys who spend
> their hours benchmarking so this can be improved!  If you still
> want me to run benchmarks, let me know.  The 15 kernels I've
> compiled since starting testing have gotta be useful for
> something.

You are welcome :)

I should probably take a look at ALSA stuff and see if I can find what
exactly is the culprit.

Thank you for the feedback, now we know.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net


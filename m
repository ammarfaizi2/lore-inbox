Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273419AbRIWMEl>; Sun, 23 Sep 2001 08:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273421AbRIWMEX>; Sun, 23 Sep 2001 08:04:23 -0400
Received: from co3000407-a.belrs1.nsw.optushome.com.au ([203.164.252.88]:60646
	"EHLO bozar") by vger.kernel.org with ESMTP id <S273419AbRIWMEL>;
	Sun, 23 Sep 2001 08:04:11 -0400
Date: Sun, 23 Sep 2001 22:03:52 +1000
From: Andre Pang <ozone@algorithm.com.au>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, safemode@speakeasy.net,
        Dieter.Nuetzel@hamburg.de, iafilius@xs4all.nl, ilsensine@inwind.it,
        george@mvista.com
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Mail-Followup-To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
	safemode@speakeasy.net, Dieter.Nuetzel@hamburg.de,
	iafilius@xs4all.nl, ilsensine@inwind.it, george@mvista.com
In-Reply-To: <1000939458.3853.17.camel@phantasy> <1001131036.557760.4340.nullmailer@bozar.algorithm.com.au> <1001139027.1245.28.camel@phantasy> <1001143341.117502.5311.nullmailer@bozar.algorithm.com.au> <1001228764.864.53.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1001228764.864.53.camel@phantasy>
User-Agent: Mutt/1.3.22i
Message-Id: <1001246632.952193.13493.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 03:05:41AM -0400, Robert Love wrote:

> You are right, those older kernels are showing much better response
> times than your kernel.  One would think your newer kernel, with
> preemption or low-latency patch, would be an improvement.
> 
> I honestly don't know what to tell you.  It could be a piece of hardware
> (or, more accurately) its driver ... 

I found out why, it's the driver.  I'm an idiot for not trying
this before ... I was previously using ALSA's snd-card-ymfpci
driver; I switchted to the OSS ymfpci driver that comes with the
kernel.  My latencies used to be 15ms on average, with spikes >
30ms; they're now ~3ms with some occasional spikes up to 10ms.

The graphs and numbers are up at
http://www.algorithm.com.au/hacking/linux-lowlatency/

> the /proc/latencytimes output shows us that no single lock is accounting
> for your bad times.  In fact, all your locks aren't that bad, so...
> 
> maybe the problem is in the "overruns" -- I don't know what that means
> exactly.  maybe someone else on the list can shed some light? 
> otheriwse, you can email the author perhaps.

An over-run occurs when the latencytest program, which plays a
continuous sound, doesn't get re-scheduled quickly enough.  This
results in a sound dropout because it can't re-fill its buffer.
This is similar to what you would get in XMMS, except that
latencytest simulates professional audio applications which must
run with _very_ small buffers in order to get low latencies.
(Imagine your computer being sync'ed in realtime with lots of
other music equipment and have it drag behind by 30ms -- it
doesn't sound good :).

But I guess my problem's solved ... thanks so much to Andrew,
yourself, MontaVista, Dietel and all the other guys who spend
their hours benchmarking so this can be improved!  If you still
want me to run benchmarks, let me know.  The 15 kernels I've
compiled since starting testing have gotta be useful for
something.


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save

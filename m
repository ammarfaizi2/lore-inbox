Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbUJ0Mpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbUJ0Mpu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUJ0Mpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:45:50 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:2188 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262413AbUJ0MpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:45:20 -0400
Message-ID: <5225.195.245.190.94.1098880980.squirrel@195.245.190.94>
Date: Wed, 27 Oct 2004 13:43:00 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.3
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
References: <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
       <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>   
    <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu>   
    <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu>   
    <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu>   
    <20041027001542.GA29295@elte.hu>
In-Reply-To: <20041027001542.GA29295@elte.hu>
X-OriginalArrivalTime: 27 Oct 2004 12:45:16.0298 (UTC) FILETIME=[CF1E0EA0:01C4BC22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> i have released the -V0.3 Real-Time Preemption patch, which can be
> downloaded from:
>
> 	http://redhat.com/~mingo/realtime-preempt/
>
> this is a fixes-only release, but still experimental.

OK. Currently with RT-V0.3.2.

So it seems that the jackd -R is no more an issue here.

I've tested several times now, and can even start more than 7 (yes,
seven!) fluidsynth instances, with respective soundfonts loaded, all
running without problems, besides the cpu cost topping to 80% (user) and
memory is near the swappiness edge, which is usually a normal behavior, or
so I believe.

Remember that having just 2 (two) fluidsynth instances was quite enough
for hosing the system in no time, on RT-V0.2.

However (oh no!:) those jackd -R xruns are still frequent, much frequent
than RT-U3, which is my stable RT kernel atm.

OK. I'll take this time for some questions:

What's the rationale that you guys are using on tunning the IRQ threading
policies and priorities?

What's the best approach to take, regarding the jackd, soundcard, usb,
keyboard, mouse, whatever IRQ handlers?

I've heard somewhat contraditory opinions elsewhere, but would like to
know what's in the road ahead ;)

As a side note, while I was testing this snd-usb-usx2y ALSA development
module for my Tascam US-224 USB audio/midi control interface, I've found
that the best and stable results are achieved by leveraging the ohci_hcd
IRQ handler (normally IRQ 10) to a higher priority than jackd's.

I've been doing just that with e.g. chrt -p -f 60 `pidof "IRQ 10"`.
Failing to do so just makes jackd (or it's alsa backend) missing some
deadline and drop out very easily. This has been my conclusion while
testing with RT-U3. Don't know what is reserved by RT-V0.3.2, yet. I'll do
that later.

Take care.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbUKZWvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbUKZWvu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbUKZWtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:49:45 -0500
Received: from zeus.kernel.org ([204.152.189.113]:49861 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263439AbUKZTuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:50:04 -0500
Message-ID: <21889.195.245.190.93.1101377024.squirrel@195.245.190.93>
In-Reply-To: <20041124112745.GA3294@elte.hu>
References: <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
    <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
    <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
    <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
    <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
    <20041124112745.GA3294@elte.hu>
Date: Thu, 25 Nov 2004 10:03:44 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-0
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 25 Nov 2004 10:04:37.0103 (UTC) FILETIME=[2BB05FF0:01C4D2D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> i have released the -V0.7.31-0 Real-Time Preemption patch, which can be
> downloaded from the usual place:
>
>     http://redhat.com/~mingo/realtime-preempt/
>
> this is a merge of the -30-10 patch to 2.6.10-rc2-mm3. There are no
> other changes.
>

I have a problem. Better said, one half-of-a-problem :)

I've been testing the RT patches on both of my personal machines, one
laptop (P4/UP) and a desktop (P4/SMT). That you probably already know.

On the P4/UP side everything has evolved smoothly, with the only major
quirk now being the loopback device hanging while on mkinitrd. It's not a
system lockup, only the "mkinitrd" and "mount -o loop" processes gets
stuck (distro is Mandrake 10.1c). OTOH, audio performance when regarding
jackd low-latency has reached such levels never dreamt before. To seal my
confidence on the RT I've committed to be the primary kernel that boots by
default and production. I'm happy here, so let's get to the topic.

On the P4/SMP/HT side, history has tought quite a different tale. It was
already late on the VP era when this was even able to boot to the
login-prompt. Then it suffered from all sorts of lockups and starvations
when able to start jackd. Then happily, all that has been ironed out. One
last thing, at the moment, that "reliably" locks up the machine is
accessing the floppy-disk (dev/fd0). Yes, I still have one here, and it
was just yesterday that I've tried to mount on it and bang! power-off and
a cold-boot follows. Reproducibility? ALWAYS is often enough. Nothing
shows up via serial console.

OTOH, my confidence goes down the drain when I compare the jackd
low-latency performance between the latest RT-V0.7.31-3 kernel and the one
supplied from SUSE 9.2 Pro (2.6.8-24). I have been checking and
double-checking this too far many times with even stressful workloads:
SUSE's non-RT kernel has an edge over the latest RT ones. Jackd XRUN rates
are pretty low and on the same level (e.g. less than 5 per hour with the
default jack_test3.1 test), but SUSE's 2.6.8-24 is consistently on par of
RT-V0.7.31-3, and even better if the RT kernel is built with some
preempt-debugging options set.

Is this black-magic or what? :)

Oh well. But let's get back to reality :) How can I help on fixing this
floppy showstopper? I've tried with almost every debug option set and
nothing is dumped either on syslog or serial console. The only visible
thing is that, once the floppy starts spinning (LED is on) the machine
freezes. Weird.

Nuff said.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



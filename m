Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbUKVOk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbUKVOk6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 09:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbUKVOhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:37:07 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:2538 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262126AbUKVOVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:21:21 -0500
Message-ID: <65529.195.245.190.94.1101133129.squirrel@195.245.190.94>
In-Reply-To: <20041122142744.0a29aceb@mango.fruits.de>
References: <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu>
    <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu>
    <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu>
    <20041122005411.GA19363@elte.hu>
    <20041122020741.5d69f8bf@mango.fruits.de>
    <20041122094602.GA6817@elte.hu>
    <56781.195.245.190.93.1101119801.squirrel@195.245.190.93>
    <20041122132459.GB19577@elte.hu>
    <20041122142744.0a29aceb@mango.fruits.de>
Date: Mon, 22 Nov 2004 14:18:49 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Florian Schmidt" <mista.tapas@gmx.net>
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Lee Revell" <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, "Bill Huey" <bhuey@lnxw.com>,
       "Adam Heath" <doogie@debian.org>,
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
X-OriginalArrivalTime: 22 Nov 2004 14:21:19.0475 (UTC) FILETIME=[88FA9430:01C4D09E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schmidt wrote:

> Ingo Molnar wrote:
>
>> > Just made some test-runs with RT-V0.7.30-2, with my jackd-R +
>> > 8*fluidsynth benchmark on my laptop (P4/UP), and the results don't
>> > seem to be eligible to the hall of fame, at least when compared with
>> > RT-0.7.7 as the ones I last posted here a few weeks ago.
>> >
>> > I hate to say this, but the XRUN rate has increased since RT-0.7.7,
>> > and the maximum scheduling delay reported by jackd has also degraded
>> > to 1000 usecs (was around 600 usecs).
>>
>> well, life would be too easy if two bugs were fixed at once ;)
>
> Hi,
>
> i just wanted to mention that a good share of jack clients have issues
> themself, doing all kinds of funky stuff in the RT thread which they
> shouldn't do. Maybe the RP kernel just exposes this misuse in a greater
> visible way. I don't know if fluidsynth is one of them. We could only find
> out by code inspection.
>

Yes, I know all this, and I warned before that this tests were strictly
and specific to the hardware, jackd and fludisynth code which are
intentionally kept the same along the several RT kernels that have been
issued.

Note that I've kept this consistency to my self, and applies /only/ to my
laptop, where the tests are being evaluated. Again, this test-suite of
mine has the sole intention to compare the jackd workload performance
across kernels, in an almost real softsynth scenario. All kernels tested
are built with no debug options, ressembling production ones as far as
possible.

For example, these are the results-du-jour, which serves as a straight
comparison RT-V0.7.30-2, with the previous posted ones from RT-V0.7.7:

                                  RT-V0.7.7 RT-V0.7.30-2
                                  --------- ------------
  XRUN Rate . . . . . . . . . . :     45.6        292.0  /hour
  Delay Rate (>spare time)  . . :     43.2        265.3  /hour
  Delay Rate (>1000 usecs)  . . :      3.6         29.3  /hour
  Delay Maximum . . . . . . . . :   1249         1045    usecs
  Cycle Maximum . . . . . . . . :    946         1127    usecs
  Average DSP Load. . . . . . . :     55.2         60.1  %
  Average CPU System Load . . . :     13.2         15.5  %
  Average CPU User Load . . . . :     41.9         46.2  %
  Average CPU Nice Load . . . . :      0.0          0.0  %
  Average CPU I/O Wait Load . . :      0.1          0.1  %
  Average CPU IRQ Load  . . . . :      0.0          0.0  %
  Average CPU Soft-IRQ Load . . :      0.0          0.0  %
  Average Interrupt Rate  . . . :   1675.4       1673.8  /sec
  Average Context-Switch Rate . :  13940.9      14894.7  /sec

The only thing that has changed here was the kernel image, as everything
else has remained constant.


> Another way to test a more complex scenario than just jackd running with
> an empty graph (assuming that jackd itself isn't to blame) while avoiding
> the risk of getting bad data due to insane clients would be to code up an
> example jackd client that does nothing but putting some load onto the
> jackd graph but in a strictly RT fashion (no blocking stuff whatsoever).
>
> Attached you probably find the most minimal jack client thinkable that
> does nothing but copy data from its input to its output port. Its only
> parameter is the time in seconds it will run (default 60). The jack client
> name is determined by the PID, so it can be started multiple times (jackd
> requires a unique name for each client).
>
> compile with
>
> g++ -o jack_test jack_test.cc -ljack
>
> This code can easily be adapted to produce more load (just do some math
> stuff with the data in the process callback).
>
> It seems jackd has a limitation to 14 clients atm (don't ask me why). The
> 15th kills jackd ;)
>

So true.

> Also i wanted to mention that a good share of ALSA drivers have issues,
> too, and aren't nessecarily suited to low latency audio work. I don't know
> how to rule these out except for using the ALSA dummy soundcard driver
> (which might have its own issues, but it's probably simple enough to work
> reliable. it just doesn't use any hw IRQ's so it's maybe not a good
> measure for what we want to test) or to use a soundcard with a proven good
> driver.
>

Of course, and the "reference" driver used on my tests is no exception
(snd-ali5451). But again, it's been kept the same on all tests, and the
improvement along the progression of the RT kernel development has been
outstanding nevertheless.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbUKZXm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbUKZXm3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbUKZXjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:39:55 -0500
Received: from zeus.kernel.org ([204.152.189.113]:49861 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263171AbUKZTqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:46:34 -0500
Message-ID: <4798.195.245.190.93.1101379116.squirrel@195.245.190.93>
In-Reply-To: <20041125111344.GA17786@elte.hu>
References: <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
    <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
    <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
    <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
    <20041124112745.GA3294@elte.hu>
    <21889.195.245.190.93.1101377024.squirrel@195.245.190.93>
    <20041125111344.GA17786@elte.hu>
Date: Thu, 25 Nov 2004 10:38:36 -0000 (WET)
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
X-OriginalArrivalTime: 25 Nov 2004 10:39:32.0306 (UTC) FILETIME=[0C86FB20:01C4D2DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

>
> * Rui Nuno Capela wrote:
>
>> last thing, at the moment, that "reliably" locks up the machine is
>> accessing the floppy-disk (dev/fd0). Yes, I still have one here, and
>> it was just yesterday that I've tried to mount on it and bang!
>> power-off and a cold-boot follows. Reproducibility? ALWAYS is often
>> enough. Nothing shows up via serial console.
>
> will take a look.
>

Thanks, as always ;)


>> [...] Jackd XRUN rates are pretty low and on the same level (e.g. less
>> than 5 per hour with the default jack_test3.1 test), [...]
>
> could you post the jack_test summary outputs?
>

Of course, but only later tonight (12 hours from now?). Sorry.


>> Oh well. But let's get back to reality :) How can I help on fixing
>> this floppy showstopper? I've tried with almost every debug option set
>> and nothing is dumped either on syslog or serial console. The only
>> visible thing is that, once the floppy starts spinning (LED is on) the
>> machine freezes. Weird.
>
> how hard of a freeze is it? I.e. if you log in over the text console,
> and do:
>
> 	chrt -f 99 -p `pidof 'IRQ 1'`
> 	chrt -f 99 -p $$
>
> can you access the sysrq keys after the freeze happens?

The lockup is pretty hard indeed. Complete lockup. No sysrq, not even any
output thru serial console. The only action that has some visible effect
is turning the power/reset switch off :)


> If not, can you access them if you do:
>
> 	echo 1 > /proc/sys/kernel/debug_direct_keyboard
>
> ? And finally, if the above experiments suggest that it's a hard lockup,
> do you have a working NMI watchdog? (i.e. do the NMI counts in
> /proc/interrupt increase on all CPUs?)
>

Yes, nmi_watchdog=1 was set but have to double-check if the NMI counts
does really pump on /proc/interrupts. Will retry and check later, again.

Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


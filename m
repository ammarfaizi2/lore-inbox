Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUKZT37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUKZT37 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbUKZTVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:21:36 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262219AbUKZTTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:19:55 -0500
Date: Thu, 25 Nov 2004 12:13:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-0
Message-ID: <20041125111344.GA17786@elte.hu>
References: <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041124112745.GA3294@elte.hu> <21889.195.245.190.93.1101377024.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21889.195.245.190.93.1101377024.squirrel@195.245.190.93>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> last thing, at the moment, that "reliably" locks up the machine is
> accessing the floppy-disk (dev/fd0). Yes, I still have one here, and
> it was just yesterday that I've tried to mount on it and bang!
> power-off and a cold-boot follows. Reproducibility? ALWAYS is often
> enough. Nothing shows up via serial console.

will take a look.

> [...] Jackd XRUN rates are pretty low and on the same level (e.g. less
> than 5 per hour with the default jack_test3.1 test), [...]

could you post the jack_test summary outputs?

> Oh well. But let's get back to reality :) How can I help on fixing
> this floppy showstopper? I've tried with almost every debug option set
> and nothing is dumped either on syslog or serial console. The only
> visible thing is that, once the floppy starts spinning (LED is on) the
> machine freezes. Weird.

how hard of a freeze is it? I.e. if you log in over the text console,
and do:

	chrt -f 99 -p `pidof 'IRQ 1'`
	chrt -f 99 -p $$

can you access the sysrq keys after the freeze happens? If not, can you 
access them if you do:

	echo 1 > /proc/sys/kernel/debug_direct_keyboard

? And finally, if the above experiments suggest that it's a hard lockup,
do you have a working NMI watchdog? (i.e. do the NMI counts in
/proc/interrupt increase on all CPUs?)

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263174AbUJ2JP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUJ2JP5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 05:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUJ2JP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 05:15:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9655 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263174AbUJ2JMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 05:12:03 -0400
Date: Fri, 29 Oct 2004 11:09:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029090957.GA1460@elte.hu>
References: <1099008264.4199.4.camel@krustophenia.net> <200410290057.i9T0v5I8011561@localhost.localdomain> <20041029080247.GC30400@elte.hu> <1099038063.22387.534.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099038063.22387.534.camel@thomas>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> The sound subsystem uses a lot of sleep_on() variants. We know that
> they are racy. Might this be related ?

i doubt it is related - sleep_on() is mostly racy on SMP and Rui is
doing UP tests. Also, for a sleep_on() race to occur you'd have to race
with the wakeup - but in the Jackd case that is highly unlikely because
it sleeps well before the next interrupt is due. So while a sleep_on()
race could in theory make _existing_ latencies worse, it cannot by
itself introduce the first latency.

but now it should be possible to prove that Jackd itself doesnt
introduce latencies, via the userspace-atomicity mode feature in -V0.5.5
:-) If that proves that the latencies dont occur in Jackd (and if it's
not another, even higher prio thread that causes the delay) then we can
pass the ball back to the kernel.

	Ingo

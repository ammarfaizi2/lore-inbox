Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbULAOh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbULAOh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 09:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbULAOh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 09:37:59 -0500
Received: from mx1.elte.hu ([157.181.1.137]:43929 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261261AbULAOhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 09:37:53 -0500
Date: Wed, 1 Dec 2004 15:37:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041201143738.GA12563@elte.hu>
References: <20041123154103.56c25300@mango.fruits.de> <200412011357.iB1DviWR003613@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412011357.iB1DviWR003613@localhost.localdomain>
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


* Paul Davis <paul@linuxaudiosystems.com> wrote:

> we know that writes to FIFOs are not really RT-safe, [...]

in kernels -V0.7.30-9 or later they are RT-safe when PREEMPT_RT is
enabled.

also, the problem is that jackd uses _named_ fifos, which are tied to
the raw FS and might trigger journalling activities. Normal pipes
(unnamed fifos) would not cause such problems. Would it be possible to
change jackd to use a pair of pipes, instead of a fifo?

> [...] i have outlined an idea to ingo that florian and i cooked up one
> evening on IRC that would provide true RT-safe IPC mechanisms, but as
> i recall, he didn't seem to think that much of it :)

actually, my answer (sent on Nov 1) was:

> futexes are nearly lock-free. [and even those locks are short-held so
> combined with priority-inheritance they should be lockfree in
> essence.] Would futexes suit your purposes?

to which suggestion i got no reply yet :-)

	Ingo

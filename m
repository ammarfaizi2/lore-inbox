Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVA1QRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVA1QRN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 11:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVA1QRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 11:17:13 -0500
Received: from mx2.elte.hu ([157.181.151.9]:39811 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261454AbVA1QRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 11:17:09 -0500
Date: Fri, 28 Jan 2005 17:16:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       mark_h_johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Shane Shrybman <shrybman@aei.ca>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15)
Message-ID: <20050128161645.GA17216@elte.hu>
References: <20041214113519.GA21790@elte.hu> <Pine.OSF.4.05.10412271404440.25730-100000@da410.ifa.au.dk> <20050128073856.GA2186@elte.hu> <20050128115640.GP10843@holomorphy.com> <20050128152802.GA15508@elte.hu> <20050128155549.GR10843@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128155549.GR10843@holomorphy.com>
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


* William Lee Irwin III <wli@holomorphy.com> wrote:

> The performance relative to mutual exclusion is quantifiable and very
> reproducible. [...]

yes, i dont doubt the results - my point is that it's not proven that
the other, more read-friendly types of locking underperform rwlocks. 
Obviously spinlocks and rwlocks have the same cache-bounce properties,
so rwlocks can outperform spinlocks if the read path overhead is higher
than that of a bounce, and reads are dominant. But it's still a poor
form of scalability. In fact, when the read path is really expensive
(larger than say 10-20 usecs) an rwlock can produce the appearance of
linear scalability, when compared to spinlocks.

> As far as performance relative to RCU goes, I suspect cases where
> write-side latency is important will arise for these. Other lockless
> methods are probably more appropriate, and are more likely to dominate
> rwlocks as expected. For instance, a reimplementation of the radix
> trees for lockless insertion and traversal (c.f. lockless pagetable
> patches for examples of how that's carried out) is plausible, where
> RCU memory overhead in struct page is not.

yeah.

	Ingo

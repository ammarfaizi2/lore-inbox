Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbULIMM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbULIMM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 07:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbULIMM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 07:12:58 -0500
Received: from mx1.elte.hu ([157.181.1.137]:29579 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261512AbULIMMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 07:12:07 -0500
Date: Thu, 9 Dec 2004 13:11:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041209121133.GB23077@elte.hu>
References: <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <41B6839B.4090403@cybsft.com> <20041208083447.GB7720@elte.hu> <41B726D1.6030009@cybsft.com> <41B7BC60.1060407@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B7BC60.1060407@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> OK dumb question. I am going out to get my own personal brown paper
> bag, since I seem to be wearing it so often. I forgot tasks get
> removed from the runqueue when they are sleeping, etc. so the active
> array should empty most of the time. However, with more RT tasks and
> interactive tasks being thrown back into the active queue I could see
> this POSSIBLY occasionally starving a few processes???

interactive tasks do get thrown back, but they wont ever preempt RT
tasks. RT tasks themselves can starve any lower-prio process
indefinitely. Interactive tasks can starve other tasks up to a certain
limit, which is defined via STARVATION_LIMIT, at which point we empty
the active array and perform an array switch. (also see
EXPIRED_STARVING())

	Ingo

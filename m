Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbUK3Qnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbUK3Qnh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbUK3Qng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:43:36 -0500
Received: from mx1.elte.hu ([157.181.1.137]:49846 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262183AbUK3Qml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:42:41 -0500
Date: Tue, 30 Nov 2004 17:42:07 +0100
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
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
Message-ID: <20041130164207.GA29659@elte.hu>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <20041129111634.GB10123@elte.hu> <41358.195.245.190.93.1101734020.squirrel@195.245.190.93> <20041129143316.GA3746@elte.hu> <20041129152344.GA9938@elte.hu> <48590.195.245.190.94.1101810584.squirrel@195.245.190.94> <20041130131956.GA23451@elte.hu> <17532.195.245.190.94.1101829198.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17532.195.245.190.94.1101829198.squirrel@195.245.190.94>
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

> Done that.
> 
> New XRUN traces are attached, while running RT-V0.7.31-15 now.
> However, I don't seem to get any notorious difference on the results,
> since previous ones. All latencies traced ca. 26-27 usecs.

hm, weird. Next idea: could you activate trace_freerunning and change
the alsa_driver.c count hack to do:

	if (!count) {
		gettimeofday(0,1);
		count = 1;
	}

this means that tracing will only be activated once, and the tracing
goes on non-stop from that point on, up until the first xrun, at which
point the full tracebuffer is saved. Ok?

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbULIUQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbULIUQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 15:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbULIUQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 15:16:19 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:36568 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261604AbULIUQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 15:16:15 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
From: Lee Revell <rlrevell@joe-job.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Mark_H_Johnson@raytheon.com, Florian Schmidt <mista.tapas@gmx.net>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Rui Nuno Capela <rncbc@rncbc.org>, Shane Shrybman <shrybman@aei.ca>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <Pine.OSF.4.05.10412091907430.4626-100000@da410.ifa.au.dk>
References: <Pine.OSF.4.05.10412091907430.4626-100000@da410.ifa.au.dk>
Content-Type: text/plain
Date: Thu, 09 Dec 2004 15:16:13 -0500
Message-Id: <1102623373.21688.6.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-09 at 20:04 +0100, Esben Nielsen wrote:
> IRQ threading makes the system more predictable but for many, many
> devices it is very expensive. I am predicting that many interrupt routines 
> have to be turned back to running in interrupt context.

It's important to keep in mind that for the type of applications that
would want PREEMPT_DESKTOP, the IRQ threading is only necessary because
of the amount of work the IDE subsystem does in hardirq context.  There
was some discussion a while back and Jens posted a patch to move the IDE
IO completion to a softirq.  IIRC there was not a lot of comment on it.
But, it seems to me that this approach would give the most favorable
balance of performance and low latency for many uses.  My tests show
that with softirq preemption this should allow jackd to run at 64 frames
or so without IRQ threading.

Lee



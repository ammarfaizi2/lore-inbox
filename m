Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbUKDPR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbUKDPR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 10:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbUKDPQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 10:16:12 -0500
Received: from mx1.elte.hu ([157.181.1.137]:61408 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262257AbUKDPPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 10:15:42 -0500
Date: Thu, 4 Nov 2004 16:16:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Message-ID: <20041104151631.GA24056@elte.hu>
References: <OF4142E065.5AF4099C-ON86256F42.00513CF0@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF4142E065.5AF4099C-ON86256F42.00513CF0@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> Let me follow up briefly on the regression I noticed yesterday on ping
> responses from an SMP system with one real time task running. [...]

icmp/ping replies are handled by ksoftirqd. Once a networking request
has been handed to ksoftirqd it cannot be redirected to another CPU,
because softirq processing is fundamentally per-CPU. So if the network
interrupt hits the CPU where the RT-task is running then the RT task
will starve that ksoftirq instance (and hence the reply) even if another
CPU in the system is idle.

i agree that this is an SMP/RT artifact that should be fixed. hardirq
workload can be redirected to other CPUs because it's single-threaded,
but it's not that easy for softirq workload.

i suspect the same phenomenon causes some of the other scheduling
artifacts ('frozen' X) you've noticed.

	Ingo

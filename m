Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbUJ1N5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUJ1N5e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 09:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbUJ1N5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 09:57:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21654 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261211AbUJ1Nz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 09:55:57 -0400
Date: Thu, 28 Oct 2004 15:57:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5.2
Message-ID: <20041028135706.GA25849@elte.hu>
References: <20041027135309.GA8090@elte.hu> <12917.195.245.190.94.1098890763.squirrel@195.245.190.94> <20041027205126.GA25091@elte.hu> <20041027211957.GA28571@elte.hu> <33083.192.168.1.5.1098919913.squirrel@192.168.1.5> <20041028063630.GD9781@elte.hu> <20668.195.245.190.93.1098952275.squirrel@195.245.190.93> <20041028085656.GA21535@elte.hu> <26253.195.245.190.93.1098955051.squirrel@195.245.190.93> <20041028093215.GA27694@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028093215.GA27694@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> (right now it's not possible to do wakeup-timing without
> LATENCY_TRACE, i'll fix that.)

i've fixed this in -RT-V0.5.2. Also, the trace_enabled=4 method is
deprecated now and the new mechanism is to use:

    /proc/sys/kernel/preempt_wakeup_timing

this flag is default-enabled. So starting at -RT-V0.5.2 to activate
wakeup timing it's enough to enable PREEMPT_TIMING and reset the max
after bootup:

    echo 0 > /proc/sys/kernel/preempt_max_latency

this will switch back to critical-section timing/tracing:

    echo 0 > /proc/sys/kernel/preempt_wakeup_timing

	Ingo

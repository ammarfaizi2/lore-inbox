Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbUK2LGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbUK2LGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 06:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUK2LGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 06:06:41 -0500
Received: from mx1.elte.hu ([157.181.1.137]:52438 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261666AbUK2LFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 06:05:44 -0500
Date: Mon, 29 Nov 2004 12:05:07 +0100
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
Message-ID: <20041129110507.GA10123@elte.hu>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_50_75 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

>   config-2.6.10-rc2-mm3-RT-V0.7.31-7.gz
>      - kernel configuration as of my laptop, taken from /proc/config.gz

Here are some .config suggestion to reduce tracing costs. Here's the
relevant portion of your .config:

 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_DEBUG_PREEMPT=y
 CONFIG_WAKEUP_TIMING=y
 CONFIG_PREEMPT_TRACE=y
 CONFIG_CRITICAL_PREEMPT_TIMING=y
 CONFIG_CRITICAL_IRQSOFF_TIMING=y
 CONFIG_CRITICAL_TIMING=y
 CONFIG_LATENCY_TIMING=y
 CONFIG_LATENCY_TRACE=y
 CONFIG_MCOUNT=y
 CONFIG_RT_DEADLOCK_DETECT=y
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_FRAME_POINTER=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_DEBUG_STACKOVERFLOW=y

i'd suggest to use the following one:

 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 CONFIG_WAKEUP_TIMING=y
 # CONFIG_CRITICAL_PREEMPT_TIMING is not set
 # CONFIG_CRITICAL_IRQSOFF_TIMING is not set
 CONFIG_LATENCY_TIMING=y
 CONFIG_LATENCY_TRACE=y
 CONFIG_MCOUNT=y
 # CONFIG_RT_DEADLOCK_DETECT is not set
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_FRAME_POINTER=y
 CONFIG_EARLY_PRINTK=y
 # CONFIG_DEBUG_STACKOVERFLOW is not set

especially PREEMPT_TIMING, IRQSOFF_TIMING and RT_DEADLOCK_DETECT are
quite expensive options.

	Ingo

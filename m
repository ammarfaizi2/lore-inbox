Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbULIROF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbULIROF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 12:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbULIROD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 12:14:03 -0500
Received: from mx1.elte.hu ([157.181.1.137]:6095 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261322AbULIRNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 12:13:34 -0500
Date: Thu, 9 Dec 2004 18:13:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041209171303.GA7975@elte.hu>
References: <OF7A3735CE.0606A36B-ON86256F65.00512706@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF7A3735CE.0606A36B-ON86256F65.00512706@raytheon.com>
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

> Comparison of .32-5RT and .32-5PK results
> RT has PREEMPT_RT,
> PK has PREEMPT_DESKTOP and no threaded IRQ's.
> 2.4 has lowlat + preempt patches applied
> 
>       within 100 usec
>        CPU loop (%)   Elapsed Time (sec)    2.4
> Test   RT     PK        RT      PK   |   CPU  Elapsed
> X     90.46  99.88      67 *    63+  |  97.20   70
> top   83.03  99.87      35 *    33+  |  97.48   29
> neto  91.69  97.57     360 *   320+* |  96.23   36
> neti  88.37  97.79     360 *   300+* |  95.86   41
> diskw 87.73  67.41     360 *    57+* |  77.64   29
> diskc 86.35  99.39     360 *   320+* |  84.12   77
> diskr 81.57  99.89     360 *   320+* |  90.66   86
> total                 1902    1413   |         368
>  [higher is better]  [lower is better]
> * wide variation in audio duration
> + long stretch of audio duration "too fast"

i think this could be the effect of the "CPU loop" being at a lower
priority (prio 30?) than all of the IRQ threads. The SMP scheduler is
now better at distributing high-prio RT tasks i.e. of IRQ threads, all
of which are higher prio than the CPU loop.

could you do one run with the CPU loop being prio 90, soundcard IRQ
being prio 91 and timer IRQ being prio 92 - so that we can see what the
RT kernel could be capable of, if the IRQ threads didnt interfere?

also, i'd like to take a look at latency traces, if you have them for
this run.

	Ingo

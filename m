Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263336AbUJ2O3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbUJ2O3c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbUJ2O0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:26:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26846 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263346AbUJ2OYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:24:48 -0400
Date: Fri, 29 Oct 2004 16:25:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
Message-ID: <20041029142538.GC25204@elte.hu>
References: <20041027205126.GA25091@elte.hu> <20041027211957.GA28571@elte.hu> <33083.192.168.1.5.1098919913.squirrel@192.168.1.5> <20041028063630.GD9781@elte.hu> <20668.195.245.190.93.1098952275.squirrel@195.245.190.93> <20041028085656.GA21535@elte.hu> <26253.195.245.190.93.1098955051.squirrel@195.245.190.93> <20041028093215.GA27694@elte.hu> <43163.195.245.190.94.1098981230.squirrel@195.245.190.94> <20041029163135.1886d67f@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029163135.1886d67f@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> Here's some setup info:
> 
> ksoftirqd/0:
> mango:~# chrt -p 2
> pid 2's current scheduling policy: SCHED_FIFO
> pid 2's current scheduling priority: 99

dont do this ... ksoftirqd can spend alot of time processing various
stuff and it should not be relevant to the audio path. It should be
SCHED_OTHER.

> Hmm, it seems i haven't disabled all debugging. This is from dmesg:
> 
> BUG: atomic counter underflow at:
>  [<c010649e>] dump_stack+0x1e/0x20 (20)
>  [<c025f319>] qdisc_destroy+0xd9/0xe0 (28)

this is automatic and doesnt introduce alot of overhead (unless the
printout happens while you are testing latencies). You can remove the
WARN_ON from include/asm-i386/atomic.h.

	Ingo

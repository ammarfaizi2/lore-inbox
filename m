Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbUGULOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUGULOL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 07:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUGULOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 07:14:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43450 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266490AbUGULOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 07:14:08 -0400
Date: Wed, 21 Jul 2004 10:52:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721085246.GA19393@elte.hu>
References: <1089673014.10777.42.camel@mindpipe> <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721082218.GA19013@elte.hu>
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


> below i've also attached a softirq.c patch against 2.6.8-rc2 that does
> unconditional deferring. (this patch is of course not intended to be
> merged upstream as-is, since normally we want to process softirqs
> right after the irq context.)

i've got a more complete patch against vanilla 2.6.8-rc2:

 http://redhat.com/~mingo/voluntary-preempt/defer-softirqs-2.6.8-rc2-A2

which introduces the following tunable:

    /proc/sys/kernel/defer_softirqs  (default: 0)

this, if enabled, causes all softirqs to be processed within ksoftirqd,
and it also breaks out of the softirq loop if preemption of ksoftirqd
has been triggered by a higher-prio task.

I've also added this additional break-out to the -H6 patch of
voluntary-preempt:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-H6

it's enabled by default.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUIOJhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUIOJhu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 05:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUIOJhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 05:37:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27326 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262605AbUIOJhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 05:37:48 -0400
Date: Wed, 15 Sep 2004 11:38:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
Message-ID: <20040915093859.GA1629@elte.hu>
References: <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu> <1094597710.16954.207.camel@krustophenia.net> <1094598822.16954.219.camel@krustophenia.net> <32930.192.168.1.5.1094601493.squirrel@192.168.1.5> <20040908082358.GB680@elte.hu> <20040908083158.GA1611@elte.hu> <37312.195.245.190.93.1094728166.squirrel@195.245.190.93> <1095210962.2406.79.camel@krustophenia.net> <19084.195.245.190.94.1095240596.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19084.195.245.190.94.1095240596.squirrel@195.245.190.94>
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

> b) When CONFIG_SCHED_SMT is not set, I can run all along with
> softirq-preempt=1, hardirq-preempt=1 et al. While running jackd in
> realtime mode, I get NO hard-locks, but unfortunately XRUNs are
> plenty. A real storm. However I've noticed that the whole seems pretty
> much stable, as I didn't experience one single system hang. Regression
> to softirq-preempt=0 and hardirq-preempt=0 dissolves the xrun storm to
> nothing again.

when you set softirq-preempt=1 and hardirq-preempt=1 then you also need
to make the soundcard's IRQ non-threaded via /proc/irq/*/*/threaded
(pick the right one that is your soundcard). E.g. i have a CMI8738-MC6 
on IRQ11, so i'd have to do this:

	echo 0 > /proc/irq/11/CMI8738-MC6/threaded

to mark the soundcard's interrupt as directly-executed.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267975AbUHKHau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267975AbUHKHau (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 03:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267978AbUHKHan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 03:30:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:52626 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267975AbUHKHa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 03:30:26 -0400
Date: Wed, 11 Aug 2004 09:31:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
Message-ID: <20040811073149.GA4312@elte.hu>
References: <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <1092174959.5061.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092174959.5061.6.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> (jackd/12427): 10882us non-preemptible critical section violated 400
> us preempt threshold starting at kernel_fpu_begin+0x10/0x60 and ending
> at fast_clear_page+0x75/0xa0

to make sure this is a real latency and not some rdtsc weirdness, could
you try the latest version of preempt-timing:

 http://redhat.com/~mingo/voluntary-preempt/preempt-timing-on-2.6.8-rc3-O5-A2

this adds jiffies-based latency values to the printout, e.g.:

  (ksoftirqd/0/2): 3860us [3 jiffy] non-preemptible critical section
  violated 100 us preempt threshold starting at ___do_softirq+0x1b/0x90
  and ending at cond_resched_softirq+0x57/0x70

shows that a 10 jiffy (10 msec) latency happened - which matches the
rdtsc-based 3860 usecs value.

	Ingo

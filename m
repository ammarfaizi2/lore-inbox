Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269021AbUI2Ub5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269021AbUI2Ub5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269015AbUI2UaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:30:01 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:48038 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269017AbUI2U3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:29:19 -0400
Date: Wed, 29 Sep 2004 22:30:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
Message-ID: <20040929203056.GA7707@elte.hu>
References: <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <1096483257.1600.44.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096483257.1600.44.camel@krustophenia.net>
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

> On Mon, 2004-09-27 at 20:05, Ingo Molnar wrote:
> > i've released the -S7 VP patch:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm4-S7
> 
> Disabling latency tracing does not seem to work.  To demonstrate:
> 
> 	echo 0 > /proc/sys/kernel/preempt_max_latency
> 	echo 0 > /proc/sys/kernel/trace_enabled
> 	modprobe foo-module (will reliably cause a ~3-600 usec latency in resolve_symbol)
> 	check /proc/latency_trace, or dmesg, it will be the modprobe latency.
> 	cat /proc/sys/kernel/trace_enabled, it is still 0
> 
> This definitely worked at one point.  Not sure when it broke.

is it the full modprobe latency trace, or just the header?  Putting zero
into trace_enabled wont disable the critical-section-timing code - it
only disables the function tracer. Since /proc/latency_trace takes the
header portion from the latency-timing code that might change. To
disable both do something like:

  echo 100000000 > /proc/sys/kernel/preempt_max_latency
  echo 0 > /proc/sys/kernel/trace_enabled

	Ingo

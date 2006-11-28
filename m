Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936041AbWK1UL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936041AbWK1UL1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936083AbWK1UL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:11:26 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:39062 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S936041AbWK1ULZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:11:25 -0500
Date: Tue, 28 Nov 2006 21:09:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc6-rt8: alsa xruns
Message-ID: <20061128200927.GA26934@elte.hu>
References: <1164743931.15887.34.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164743931.15887.34.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Hi, I'm trying out the latest -rt patch and getting alsa xruns when 
> using jackd and jack clients. This is a sample from the output of 
> qjackctl / jackd (jack 0.102.25, qjackctl 0.2.21):

> (            japa-4096 |#0): new 17 us maximum-latency wakeup.
> (         beagled-3412 |#1): new 19 us maximum-latency wakeup.
> (          IRQ 18-1081 |#1): new 26 us maximum-latency wakeup.
> (             snd-4040 |#1): new 1107 us maximum-latency wakeup.
> (            japa-4096 |#0): new 1445 us maximum-latency wakeup.
> (            japa-4096 |#0): new 2110 us maximum-latency wakeup.
> (        qjackctl-4038 |#1): new 2328 us maximum-latency wakeup.
> (            japa-4096 |#0): new 2548 us maximum-latency wakeup.
> (          IRQ 18-1081 |#0): new 10291 us maximum-latency wakeup.

hm, lets fix this. Could you enable tracing (on the yum rpm) via:

	echo 1 > /proc/sys/kernel/trace_enabled

does /proc/latency_trace have any meaningful events included for such a 
long delay? If not then it would be nice to rebuild the kernel with 
CONFIG_LATENCY_TRACING - and in any case my previous suggestion holds 
too: booting with maxcpus=1 to reproduce the latencies will give easier 
to interpret latency traces. (but if it's SMP-only then no problem, the 
latency traces are still valuable)

	Ingo

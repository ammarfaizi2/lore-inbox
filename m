Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbVIAHcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbVIAHcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 03:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVIAHcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 03:32:11 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:61643 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965074AbVIAHcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 03:32:10 -0400
Date: Thu, 1 Sep 2005 09:32:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "Jack O'Quin" <joq@io.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       jackit-devel@lists.sourceforge.net, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, cc@ccrma.Stanford.EDU,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [Jackit-devel] Re: jack, PREEMPT_DESKTOP, delayed interrupts?
Message-ID: <20050901073241.GA6641@elte.hu>
References: <1125453795.25823.121.camel@cmn37.stanford.edu> <20050831073518.GA7582@elte.hu> <7q64tmnwbb.fsf@io.com> <20050831175036.5640e221@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831175036.5640e221@mango.fruits.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> > JACK sources already include a CHECK_PREEMPTION() macro which expands
> > to Ingo's special gettimeofday() calls.  The trace is turned on and
> > then off automatically before and after the realtime critical section
> > in the process thread (see libjack/client.c).  
> 
> Just for completeness sake:
> 
> you need to build jackd with --enable-preemption-check

this is another feature, unrelated to latency tracing. So (an adapted 
version of) the latency-tracing patch i sent should still be tried.

--enable-preemption-check does the 'send SIGUSR2 if jackd gets scheduled 
unexpectedly'. That might unearth latencies, but it does not by itself 
measure latencies. Right now we are more interested in the latencies 
themselves.

i suspect the confusion comes from the API hacks i'm using: user-space 
tracing is started/stopped via:

	gettimeofday(0,1);
	gettimeofday(0,0);

while 'jackd does not want to be scheduled' flag is switched on/off via:

	gettimeofday(1,1);
	gettimeofday(1,0);

(introducing extra syscalls for this is an overkill.)

	Ingo

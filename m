Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVJaOVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVJaOVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVJaOVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:21:44 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:30414 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751244AbVJaOVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:21:44 -0500
Date: Mon, 31 Oct 2005 15:22:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.14-rt1 - xruns in a certain circumstance
Message-ID: <20051031142204.GA6136@elte.hu>
References: <5bdc1c8b0510301828p29ea517ew467a5f6503435314@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0510301828p29ea517ew467a5f6503435314@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Knecht <markknecht@gmail.com> wrote:

> What I'm seeing is that when using basic menus, or when watching 
> videos I get no xruns. However, if I'm in the preview menu I get an 
> xrun every few minutes. [...]

this could be some sort of hardware latency, as Lee suspects. Videocards 
are known to be pretty agressively holding the system bus, for the last 
few percentiles of Quake performance ... Also, mainboard chipsets are 
sometimes not that good at enforcing fairness between DMA agents - 
possibly starving the CPU itself for lengthly amounts of time. We have 
seen such incidents before, and latency tracing ought to be able to show 
this with reasonable certainty. If it's some sort of generic hardware 
latency then you ought to see weird traces when enabling WAKEUP_TIMING 
and LATENCY_TRACING in the .config. No need for any other debug options 
or Jack level hackery at this point - just enable these and do a:

	echo 0 > /proc/sys/kernel/preempt_max_latency

and try to trigger as large latencies as possible via MythTV. (you wont 
necessarily see a large latency reported by the kernel when you see an 
xrun. We can trace xruns too, but that needs Jackd changes and is more 
effort to set up.)

	Ingo

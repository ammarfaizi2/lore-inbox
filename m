Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVJNEfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVJNEfk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 00:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVJNEfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 00:35:40 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:54195 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751278AbVJNEfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 00:35:39 -0400
Date: Fri, 14 Oct 2005 06:35:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: john stultz <johnstul@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched_clock -> check_tsc_unstable -> tsc_read_c3_time ?!?
Message-ID: <20051014043555.GA13595@elte.hu>
References: <1129233687.16243.52.camel@mindpipe> <1129234306.27168.7.camel@cog.beaverton.ibm.com> <1129234407.16243.58.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129234407.16243.58.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.4 required=5.9 tests=AWL,PLING_QUERY autolearn=disabled SpamAssassin version=3.0.3
	0.9 PLING_QUERY            Subject has exclamation mark and question mark
	-0.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Thu, 2005-10-13 at 13:11 -0700, john stultz wrote:
> > Yea, you're right about the inlining. Although I'm not sure why those
> > functions should take microseconds to execute. That's very strange. 
> 
> Latency tracing overhead plus a slow (600MHz) machine?

yeah. The micro-timings of latency tracing can be misleading. Function 
calls are very fast on most CPUs (even on a 600MHz one), but with the 
latency tracer generating one trace entry per function call, there's 
considerable added overhead.

we could in theory calibrate the tracing overhead and subtract it from 
cycle readings [i've done this in a previous mcount() based tracer 
implementation, years ago], but that would make the latency trace 
timestamps less useful as a global time reference.

	Ingo

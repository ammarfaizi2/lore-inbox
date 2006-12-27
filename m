Return-Path: <linux-kernel-owner+w=401wt.eu-S932874AbWL0AvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932874AbWL0AvY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 19:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932872AbWL0AvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 19:51:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:30889 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932874AbWL0AvX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 19:51:23 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,211,1165219200"; 
   d="scan'208"; a="181968830:sNHT20912220"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.19-rt14 slowdown compared to 2.6.19
Date: Tue, 26 Dec 2006 16:51:21 -0800
Message-ID: <9D2C22909C6E774EBFB8B5583AE5291C019998CA@fmsmsx414.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-rt14 slowdown compared to 2.6.19
Thread-Index: AccmgcK5XbX9CwpDTLOSu6UfsDiNjgCwbNUg
From: "Chen, Tim C" <tim.c.chen@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>
X-OriginalArrivalTime: 27 Dec 2006 00:51:22.0863 (UTC) FILETIME=[2126CFF0:01C72951]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> cool - thanks for the feedback! Running the 64-bit kernel, right?
> 

Yes, 64-bit kernel was used.

> 
> while some slowdown is to be expected, did in each case idle time
> increase significantly? 

Volanomark and Re-Aim7 ran close to 0% idle time for 2.6.19 kernel.
Idle time
increase significantly for Volanomark (to 60% idle) and Re-Aim7 (to 20%
idle) 
with the rt kernel.  For netperf, the system was 60% idle for 
both 2.6.19 and rt kernel and changes in idle time was not significant.

> If yes then this is the effect of lock
> contention. Lock contention effects are 'magnified' by PREEMPT_RT. For
> example if you run 128 threads workload that all use the same lock
> then 
> the -rt kernel can act as if it were a 128-way box (!). This way by
> running -rt you'll see scalability problems alot sooner than on real
> hardware. In other words: PREEMPT_RT in essence simulates the
> scalability behavior of up to an infinite amount of CPUs. (with the
> exception of cachemiss emulation ;) [the effect is not this precise,
> but 
> that's the rough trend]

Turning off PREEMPT_RT for 2.6.20-rc2-rt0 kernel
restored most the performance of Volanaomark
and Re-Aim7.  Idle time is close to 0%.  So the benchmarks
with large number of threads are affected more by PREEMPT_RT.

For netperf TCP streaming, the performance improved from 40% down to 20%
down from 2.6.20-rc2 kernel.  There is only a server and a client
process
for netperf.  The underlying reason for the change in performance
is probably different.

> 
> If you'd like to profile this yourself then the lowest-cost way of
> profiling lock contention on -rt is to use the yum kernel and run the
> attached trace-it-lock-prof.c code on the box while your workload is
> in 'steady state' (and is showing those extended idle times):
> 
>   ./trace-it-lock-prof > trace.txt
> 

Thanks for the pointer.  Will let you know of any relevant traces.

Thanks.

Tim

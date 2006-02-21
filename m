Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWBUQLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWBUQLd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 11:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932743AbWBUQLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 11:11:33 -0500
Received: from mxsf16.cluster1.charter.net ([209.225.28.216]:5553 "EHLO
	mxsf16.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932295AbWBUQLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 11:11:32 -0500
X-IronPort-AV: i="4.02,135,1139202000"; 
   d="scan'208"; a="1966986255:sNHT104899128"
Message-ID: <43FB3BAC.6000204@cybsft.com>
Date: Tue, 21 Feb 2006 10:11:24 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.15-rt17
References: <20060221155548.GA30146@elte.hu>
In-Reply-To: <20060221155548.GA30146@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the 2.6.15-rt17 tree, which can be downloaded from the 
> usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> lots of changes all across the map. There are several bigger changes:
> 
> the biggest change is the new PI code from Esben Nielsen, Thomas 
> Gleixner and Steven Rostedt. This big rework simplifies and streamlines 
> the PI code, and fixes a couple of bugs and races:
> 
>   - only the top priority waiter on a lock is enqueued into the pi_list
>     of the task which holds the lock. No more pi list walking in the
>     boost case.
> 
>   - simpler locking rules
> 
>   - fast Atomic acquire for the non contended case and atomic release 
>     for non waiter case is fully functional now
> 
>   - use task_t references instead of thread_info pointers
> 
>   - BKL handling for semaphore style locks changed so that BKL is
>     dropped before the scheduler is entered and reaquired in the return
>     path. This solves a possible deadlock situation in the BKL reacquire
>     path of the scheduler.
> 
> another change is the reworking of the SLAB code: it now closely matches 
> the upstream SLAB code, and it should now work on NUMA systems too 
> (untested though).
> 
> the tasklet code was reworked too to be PREEMPT_RT friendly: the new PI 
> code unearthed a fundamental livelock scenario with PREEMPT_RT, and the 
> fix was to rework the tasklet code to get rid of the 'retrigger 
> softirqs' approach.
> 
> other changes: various hrtimers fixes, latency tracer enhancements - and 
> more. (Robust-futexes are not expected to work in this release.)
> 
> please report any new breakages, and re-report any old breakages as 
> well.
> 
> to build a 2.6.15-rt17 tree, the following patches should be applied:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.15-rt17
> 
> 	Ingo

Ingo I think you fat fingered the name of the patchfile on your site. :)

-- 
   kr

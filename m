Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267283AbUJNS67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUJNS67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267335AbUJNS44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:56:56 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4593 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S267283AbUJNSw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:52:56 -0400
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041014002433.GA19399@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
	 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu>  <20041014002433.GA19399@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1097779972.30253.947.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Oct 2004 11:52:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 17:24, Ingo Molnar wrote:
> To solve all these fundamental problems, i improved/fixed/changed all of
> these locking methods to be preemption-friendly. Most of the time it was
> necessary to introduce an additional API variant because e.g.
> rcu_read_lock() is anonymous (it doesnt identify the data protected), so
> i introduced a variant that takes the write-lock as an argument. In the
> PREEMPT_REALTIME case we can thus properly serialize on that lock.

When I was reviewing this it seemed like it would be possible to keep
RCU anonymous by moving the callback processing out of the tasklet . The
reason it was moved into a tasklet was to reduce latency. But if you
serialize it like you have, aren't you removing all the benefits of the
RCU type lock in those section that are converted to the new API ?


> For per-cpu variables i introduced a new API variant that creates a
> spinlock-array for the per-cpu-variable, and users must make sure the
> cpu field doesnt change. Migration to another CPU can happen within the
> critical section, but 'statistically' the variable is still per-CPU and
> update correctness is fully preserved.

Why not have a per cpu mutex instead of a per variable per cpu mutex?
I'm not sure what the trade off are, except size.




Daniel


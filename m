Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRCUAtT>; Tue, 20 Mar 2001 19:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129344AbRCUAtJ>; Tue, 20 Mar 2001 19:49:09 -0500
Received: from nrg.org ([216.101.165.106]:8044 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S129242AbRCUAs6>;
	Tue, 20 Mar 2001 19:48:58 -0500
Date: Tue, 20 Mar 2001 16:48:01 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Keith Owens <kaos@ocs.com.au>
cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <851.985080735@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.05.10103201625430.26853-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Keith Owens wrote:
> The preemption patch only allows preemption from interrupt and only for
> a single level of preemption.  That coexists quite happily with
> synchronize_kernel() which runs in user context.  Just count user
> context schedules (preempt_count == 0), not preemptive schedules.

I'm not sure what you mean by "only for a single level of preemption."
It's possible for a preempting process to be preempted itself by a
higher priority process, and for that process to be preempted by an even
higher priority one, limited only by the number of processes waiting for
interrupt handlers to make them runnable.  This isn't very likely in
practice (kernel preemptions tend to be rare compared to normal calls to
schedule()), but it could happen in theory.

If you're looking at preempt_schedule(), note the call to ctx_sw_off()
only increments current->preempt_count for the preempted task - the
higher priority preempting task that is about to be scheduled will have
a preempt_count of 0.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com


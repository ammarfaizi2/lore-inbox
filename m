Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267804AbUHRVaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267804AbUHRVaB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267800AbUHRVaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:30:00 -0400
Received: from ultra7.eskimo.com ([204.122.16.70]:59141 "EHLO
	ultra7.eskimo.com") by vger.kernel.org with ESMTP id S267799AbUHRV3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:29:34 -0400
Date: Wed, 18 Aug 2004 14:29:11 -0700
From: Elladan <elladan@eskimo.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Thomas Charbonnel <thomas@undata.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P3
Message-ID: <20040818212911.GA26965@eskimo.com>
References: <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040818141231.4bd5ff9d@mango.fruits.de> <20040818122703.GA17301@elte.hu> <20040818150148.4d2c56ec@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818150148.4d2c56ec@mango.fruits.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 03:01:48PM +0200, Florian Schmidt wrote:
> On Wed, 18 Aug 2004 14:27:03 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > Btw: one question: at one point in time the IRQ handlers were in the
> > > SCHED_FIFO scheduling class. Why has this changed?
> > 
> > so that they dont starve the audio threads by default - the audio IRQ
> > has to get another priority anyway. Maybe we could try a default
> > SCHED_FIFO prio lower than the typical rt_priority of jackd - e.g. 30?
> 
> Oh, upon rereading the chrt manpage i found out why i failed to set them
> to SCHED_FIFO manually. So it was my error. I thought the
> scheduling of the IRQ handlers was not changable at runtime. Thus my
> question to make them SCHED_FIFO by default.
> 
> Well, i still think they should be SCHED_FIFO by default, so no user
> process that is not itself SCHED_FIFO can starve them [X11 was able to
> starve mouse irq's on my system with the defualt IRQ handlers
> running SCHED_OTHER FWIW]. To make starving of user-SCHED_FIFO processes
> unprobably maybe use a default static prio of 0.
> 
> Afaik jackd uses priorities > 0 for its audio threads when runing
> SCHED_FIFO anyways..
> 
> But since the user will have to tweak his IRQ handlers manually anyways
> [set soundcard irq higher prio than the rest, etc..], it doesn't really
> make a difference.

This doesn't take into account SCHED_RR processes, which expect to
behave just like SCHED_FIFO unless there's another SCHED_RR process of
the same priority...

-J

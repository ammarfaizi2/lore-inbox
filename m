Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbUKWWZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbUKWWZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUKWWXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:23:40 -0500
Received: from bgm-24-95-139-53.stny.rr.com ([24.95.139.53]:50826 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261559AbUKWWXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:23:03 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0,
	and 30-9
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1101246438.1594.3.camel@krustophenia.net>
References: <OF73D7316A.42DF9BE5-ON86256F54.0057B6DC@raytheon.com>
	 <Pine.LNX.4.58.0411222237130.2287@gradall.private.brainfood.com>
	 <20041123115201.GA26714@elte.hu>
	 <Pine.LNX.4.58.0411231206240.2146@gradall.private.brainfood.com>
	 <Pine.LNX.4.58.0411231316300.2242@gradall.private.brainfood.com>
	 <1101244924.32068.6.camel@localhost.localdomain>
	 <1101246438.1594.3.camel@krustophenia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Tue, 23 Nov 2004 17:22:55 -0500
Message-Id: <1101248575.32068.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 16:47 -0500, Lee Revell wrote:
> On Tue, 2004-11-23 at 16:22 -0500, Steven Rostedt wrote:
> > Just curious to why you scale the interrupts from 49 down to 25.  What
> > would be wrong with keeping all of them at 49 (or whatever). Being a
> > FIFO, no interrupt would preempt another. Why would you want the first
> > IRQs to be registered have higher priority than (and thus will preempt)
> > irqs registered later.
> 
> I raised this issue before.  I agree that all interrupts should get the
> same RT prio by default.  Otherwise the default behavior is arbitrary.
> 
> Lee

I'll even add that the default behavior slows the system down with extra
scheduling switches.  If IRQ 10 is preempted by IRQ 2 then there's an
extra switch to get back and finish IRQ 10. For every IRQ that comes
during a "lower" priority IRQ there's an extra switch needed. If the
IRQs really don't have a order of priority, then they should be the
same. Some cases you need to set IRQs at different priorities, but that
should be done by the user and not the kernel giving the first irq
preference.

-- 
Steven Rostedt
Senior Engineer
Kihon Technologies

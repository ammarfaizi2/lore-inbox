Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268041AbUIBJKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268041AbUIBJKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 05:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268026AbUIBJKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 05:10:39 -0400
Received: from smtp.nedstat.nl ([194.109.98.184]:27835 "HELO smtp.nedstat.nl")
	by vger.kernel.org with SMTP id S268041AbUIBJIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 05:08:00 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: mika.penttila@kolumbus.fi, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040902083205.GA22416@elte.hu>
References: <20040902075712.DGPM28426.fep02-app.kolumbus.fi@mta.imail.kolumbus.fi>
	 <20040902083205.GA22416@elte.hu>
Content-Type: text/plain
Message-Id: <1094116003.28961.207.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 11:06:43 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 10:32, Ingo Molnar wrote:
> * mika.penttila@kolumbus.fi <mika.penttila@kolumbus.fi> wrote:
> 
> > Ingo,
> > 
> > I think there might be a problem with voluntary-preempt's hadling of
> > softirqs. Namely, in cond_resched_softirq(), you do
> > __local_bh_enable() and local_bh_disable(). But it may be the case
> > that the softirq is handled from ksoftirqd, and then the preempt_count
> > isn't elevated with SOFTIRQ_OFFSET (only PF_SOFTIRQ is set). So the
> > __local_bh_enable() actually makes preempt_count negative, which might
> > have bad effects. Or am I missing something?
> 
> you are right. Fortunately the main use of cond_resched_softirq() is via
> cond_resched_all() - which is safe because it uses softirq_count(). But
> the kernel/timer.c explicit call to cond_resched_softirq() is unsafe.
> I've fixed this in my tree and i've added an assert to catch the
> underflow when it happens.
> 
> 	Ingo

I've had linux-2.6.9-rc1-bk8-Q7 lock up on me this morning not long
after starting a glibc compile resulting from: emerge -uo gnome
although it did survive a make World on xorg-cvs.

Could this have been caused by the bug under discussion?

Unfortunatly I don't have much testing time before I go on hollidays,
so for now I went back to linux-2.6.9-rc1-bk6-Q5 which on my machine is
rock solid.

Peter


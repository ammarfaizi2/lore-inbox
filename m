Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbUKXC0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbUKXC0i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 21:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbUKXC0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 21:26:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:13970 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261687AbUKXCZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 21:25:51 -0500
Date: Wed, 24 Nov 2004 04:27:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Steven Rostedt <rostedt@kihontech.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0, and 30-9
Message-ID: <20041124032757.GB12028@elte.hu>
References: <OF73D7316A.42DF9BE5-ON86256F54.0057B6DC@raytheon.com> <Pine.LNX.4.58.0411222237130.2287@gradall.private.brainfood.com> <20041123115201.GA26714@elte.hu> <Pine.LNX.4.58.0411231206240.2146@gradall.private.brainfood.com> <Pine.LNX.4.58.0411231316300.2242@gradall.private.brainfood.com> <1101244924.32068.6.camel@localhost.localdomain> <1101246438.1594.3.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101246438.1594.3.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2004-11-23 at 16:22 -0500, Steven Rostedt wrote:
> > Just curious to why you scale the interrupts from 49 down to 25.  What
> > would be wrong with keeping all of them at 49 (or whatever). Being a
> > FIFO, no interrupt would preempt another. Why would you want the first
> > IRQs to be registered have higher priority than (and thus will preempt)
> > irqs registered later.
> 
> I raised this issue before.  I agree that all interrupts should get
> the same RT prio by default.  Otherwise the default behavior is
> arbitrary.

i agree that it's arbitrary. There are two reasons for the ordering:

1) _usually_ the IRQs that get registered first are the 'more important'
    ones. E.g. timer and keyboard interrupts will preempt the IDE
    interrupt.  This is in no way a generic thing though.

2) testing: if all IRQs are at the same priority level then alot less 
   inter-IRQ preemption occurs, and testing coverage is lower. With all 
   irqs on different levels the bugs will trigger sooner.

To solve this cleanly some userspace policy code is needed that would
take some settings (e.g. sound_highprio) through which the priority
setup could be configured. It's not a simple task as that could would
have to discover the type of devices that are in the system and their
irqs - possibly a component of udev could do this?

	Ingo

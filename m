Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVJLACv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVJLACv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 20:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVJLACv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 20:02:51 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:27537 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932376AbVJLACu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 20:02:50 -0400
Subject: Re: Latency data - 2.6.14-rc3-rt13
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0510111545n29b77010h8558a1b69c4bf12a@mail.gmail.com>
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
	 <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com>
	 <5bdc1c8b0510101428o475d9dbct2e9bdcc6b46418c9@mail.gmail.com>
	 <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com>
	 <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com>
	 <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com>
	 <5bdc1c8b0510102045u7e4bc9eeld5b690b5e96c4a5f@mail.gmail.com>
	 <20051011111700.GA15892@elte.hu>
	 <5bdc1c8b0510111545n29b77010h8558a1b69c4bf12a@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 20:02:48 -0400
Message-Id: <1129075368.7094.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 15:45 -0700, Mark Knecht wrote:
> On 10/11/05, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Mark Knecht <markknecht@gmail.com> wrote:
> >
> > > > ( softirq-timer/0-3    |#0): new 3997 us maximum-latency critical section.
> > >
> > > So the root cause of this 4mS delay is the 250Hz timer. If I change
> > > the system to use the 1Khz timer then the time in this section drops,
> > > as expected, to 1mS.
> >
> > this was a bug in the critical-section-latency measurement code of x64.
> > The timer irq is the one that leaves userspace running for the longest
> > time, between two kernel calls.
> >
> > I have fixed these bugs in -rc4-rt1, could you try it? It should report
> > much lower latencies, regardless of PM settings.
> >
> >         Ingo
> >
> 
> Ingo,
>    This test now reports much more intersting data:
> 
> (           dmesg-8010 |#0): new 13 us maximum-latency critical section.
>  => started at timestamp 117628604: <do_IRQ+0x29/0x50>
>  =>   ended at timestamp 117628618: <do_IRQ+0x39/0x50>

This is the expected, correct behavior - very small maximum latency
critical sections.  Do you get anything longer (say 300 usecs or more)
if you leave it running?

So far the latency tracer on my much slower system has only gone up to
123 usecs.  So the bug seems to be fixed at least on i386.

Lee


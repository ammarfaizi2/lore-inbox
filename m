Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbVJKGu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbVJKGu4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 02:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVJKGu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 02:50:56 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:7866 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751394AbVJKGuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 02:50:55 -0400
Date: Tue, 11 Oct 2005 02:46:59 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Mark Knecht <markknecht@gmail.com>
cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: Latency data - 2.6.14-rc3-rt13
In-Reply-To: <5bdc1c8b0510102045u7e4bc9eeld5b690b5e96c4a5f@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0510110241250.30989@localhost.localdomain>
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com> 
 <1128977359.18782.199.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com> 
 <5bdc1c8b0510101428o475d9dbct2e9bdcc6b46418c9@mail.gmail.com> 
 <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com> 
 <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com> 
 <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com>
 <5bdc1c8b0510102045u7e4bc9eeld5b690b5e96c4a5f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Oct 2005, Mark Knecht wrote:

> On 10/10/05, Mark Knecht <markknecht@gmail.com> wrote:
> >
> > ( softirq-timer/0-3    |#0): new 3997 us maximum-latency critical section.
>
> So the root cause of this 4mS delay is the 250Hz timer. If I change
> the system to use the 1Khz timer then the time in this section drops,
> as expected, to 1mS.
>
> ( softirq-timer/0-3    |#0): new 998 us maximum-latency critical section.
>  => started at timestamp 121040020: <acpi_processor_idle+0x20/0x379>
>  =>   ended at timestamp 121041019: <thread_return+0xb5/0x11a>
>
> So, thinking very interesting here I think.
>
> Back to the drawing board as to my xruns.
>

Are your xruns showing the same type of latency?  If you switch to the
1000Hz do you get only 1mS latency on your xruns too?  This sounds like
the application might have gone to sleep and didn't wake up until
something scheduled it in.  Or something else with the scheduler.  I doubt
that this has to due with preemption or interrupts being off, but
something that uses jiffies to calculate.

-- Steve


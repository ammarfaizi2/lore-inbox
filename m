Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbULKRCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbULKRCs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 12:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbULKRCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 12:02:48 -0500
Received: from mail.timesys.com ([65.117.135.102]:25783 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261969AbULKRCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 12:02:40 -0500
Message-ID: <41BB2785.7020006@timesys.com>
Date: Sat, 11 Dec 2004 11:59:49 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>, Ingo Molnar <mingo@elte.hu>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       john cooper <john.cooper@timesys.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
References: <OF737A0ECF.4ECB9A35-ON86256F65.006249D6@raytheon.com> <1102722147.3300.7.camel@localhost.localdomain>
In-Reply-To: <1102722147.3300.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Dec 2004 16:55:04.0937 (UTC) FILETIME=[29A19D90:01C4DFA2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

> [RFC]  Has there been previously any thought of adding priority
> inheriting wait queues. With the IRQs that run as threads, have hooks in
> the code that allows a driver or socket layer to attach a thread to a
> wait queue, and when a RT priority task waits on the queue, a function
> is call to increase (if needed) the priority of the attached thread. I
> know that this would take some work, and would make the normal kernel
> and RT diverge more, but it would really help to solve the problem of a
> high priority process waiting for an interrupt that can be starved by
> other high priority processes.

I think there are two issues here.  One being as above which
addresses allowing the server thread to compete for CPU time
at a priority equal to its highest waiting client.  Essentially
the server needs no inherent priority of its own, rather its
priority is automatically inherited.  The semantics seem
straightforward even in the general case of servers themselves
becoming clients of other servers.

Another issue is the fact the server thread is effectively
non-preemptive.  Otherwise a newly arrived waiter of priority
higher than a client currently being serviced would receive
immediate attention.  One problem to be solved here is how to
save/restore client context when a "context switch" is required.

-john


-- 
john.cooper@timesys.com

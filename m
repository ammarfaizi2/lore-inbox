Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbULJXnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbULJXnH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 18:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbULJXnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 18:43:07 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:29575 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261875AbULJXm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 18:42:58 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>
Cc: Ingo Molnar <mingo@elte.hu>, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <OF737A0ECF.4ECB9A35-ON86256F65.006249D6@raytheon.com>
References: <OF737A0ECF.4ECB9A35-ON86256F65.006249D6@raytheon.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Fri, 10 Dec 2004 18:42:27 -0500
Message-Id: <1102722147.3300.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-09 at 12:10 -0600, Mark_H_Johnson@raytheon.com wrote:
> >but you never want your real application be delayed by things like IDE
> >processing or networking workloads, correct?
> For the most part, that I/O workload IS because I have the RT application
> running. That was one of my points. I cannot reliably starve any of
> those activities. The disk reads in my real application simulate a disk
> read from a real world device. That data is needed for RT processing
> in the simulated system. Some of the network traffic is also RT since
> we generate a data stream that is interpreted in real time by other
> systems.

[RFC]  Has there been previously any thought of adding priority
inheriting wait queues. With the IRQs that run as threads, have hooks in
the code that allows a driver or socket layer to attach a thread to a
wait queue, and when a RT priority task waits on the queue, a function
is call to increase (if needed) the priority of the attached thread. I
know that this would take some work, and would make the normal kernel
and RT diverge more, but it would really help to solve the problem of a
high priority process waiting for an interrupt that can be starved by
other high priority processes.

Just a thought.

-- Steve


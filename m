Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbULIUuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbULIUuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 15:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbULIUuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 15:50:24 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:39511 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S261615AbULIUuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 15:50:03 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFAE40B913.02DD0387-ON86256F65.006EEC09@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 9 Dec 2004 14:38:41 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/09/2004 02:38:54 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:
>
>> I don't expect turning the debugging off will make that much of a
>> difference but I can try it tomorrow. [...]
>
>so basically this is your setup:
>- prio 99: all IRQ threads and ksoftirqd threads
Plus events/0 and /1 at RT FIFO 99.

> - prio 30: 'CPU loop' from latencytest, generating ~80% CPU load
That is the nominal case. It may be a little higher in some of the
runs (where the audio loop is consistently "fast") but never over
100% of a CPU unless you ask for a periodic sync [which I don't].

> - SCHED_OTHER: workload generators
Two primary tasks as SCHED_OTHER:
 - cpu_burn (nice w/ default, according to manpage its 10)
 - whatever workload generator is active (not nice)
I tend to also run with one or more "data collectors" which are
shell scripts that I run like this...
  chrt -f 1 ./get_ltrace.sh 250
They do sleeps of various durations (seconds) before looking at
/proc for data.

>and the metric is "delays in the prio 30 CPU loop", correct?
The % within 100 usec is always in the prio 30 CPU loop. The max
latency I sometimes mention is for that CPU loop as well
(80% of nominal audio duration). For the max latency, I try to
mention if its the delta or total time. (but sometimes forget)

The elapsed time is for the workload generator / RT application,
whichever gets done first. That is because the script starts both
(latencytest in background) and there is a killall after the
workload generator gets finished (which latencytest traps & dumps
its data to the output files). latencytest will automatically
stop after about 250000 samples - hence the upper limit of about
6 minutes for the test time.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>


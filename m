Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbULIOxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbULIOxH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbULIOwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:52:37 -0500
Received: from bos-gate4.raytheon.com ([199.46.198.233]:50091 "EHLO
	bos-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S261482AbULIOwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:52:18 -0500
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
Message-ID: <OFDB636A6F.24158127-ON86256F65.00504E6B@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 9 Dec 2004 08:46:14 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/09/2004 08:46:24 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>interactive tasks do get thrown back, but they wont ever preempt RT
>tasks. RT tasks themselves can starve any lower-prio process
>indefinitely.
Definitely the behavior I want to see.

> Interactive tasks can starve other tasks up to a certain
>limit, which is defined via STARVATION_LIMIT, at which point we empty
>the active array and perform an array switch. (also see
>EXPIRED_STARVING())
Could this somehow be the cause of the relatively poor performance
I am seeing with the following combination on a 2 CPU system:
 a one RT task with nominal 80% CPU usage / output to audio
 b one non RT, nice task at 100% CPU usage (cpu_burn)
 c one non RT, not nice task doing lots of I/O
 d a hundred non RT tasks, relatively idle
The elapsed time of (c) goes from under 40 seconds to over
300 seconds (basically does little to no work while the RT task is
active).

I should have only 1 CPU's worth of work as RT and based on what
the comments in sched.c indicate the nice job should get preempted
by the not nice job on a regular basis (but somehow that doesn't
seem to happen).

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>


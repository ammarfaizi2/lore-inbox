Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbUKKQrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbUKKQrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 11:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbUKKQrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 11:47:52 -0500
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:34911 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S262285AbUKKQro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 11:47:44 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
From: Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-0
Date: Thu, 11 Nov 2004 10:46:31 -0600
Message-ID: <OF3F836225.78DCFCB0-ON86256F49.005C260B-86256F49.005C2643@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/11/2004 10:46:32 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have released the -V0.7.25-0 Real-Time Preemption patch, which can be
>downloaded from the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
>this release includes fixes, new features and latency improvements.

It may be coincidence, but when I did
  chrt -p -f 99 2
(to set IRQ 0 to max RT priority, like the other IRQ's)

I got the following deadlock.

==========================================
[ BUG: lock recursion deadlock detected! |
------------------------------------------
already locked:  [c140c2e0] {&base->lock}
.. held by:       ksoftirqd/0:    4 [c17953f0, 105]
... acquired at:  run_timer_softirq+0x108/0x470

------------------------------
| showing all locks held by: |  (ksoftirqd/0/4 [c17953f0, 105]):
------------------------------

#001:             [c140c2e0] {&base->lock}
... acquired at:  run_timer_softirq+0x108/0x470

#002:             [c0576b6c] {&timer->lock}
... acquired at:  __mod_timer+0x47/0x1d0

There are a LOT of messages that stream out after this problem.
I will be sending the full serial console log separately.

Will reboot shortly and see if this is a repeatable problem or not.

  --Mark


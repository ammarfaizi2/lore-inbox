Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbUKBWqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbUKBWqY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbUKBWoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:44:17 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:58726 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S262314AbUKBWgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:36:37 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Date: Tue, 2 Nov 2004 16:35:16 -0600
Message-ID: <OF9F489E60.B8B3EA93-ON86256F40.007C1401-86256F40.007C1430@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/02/2004 04:35:19 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Does this also happen if you chrt ksoftirqd to FIFO prio 1?
>Does the 'LOC' count increase for both cpus in /proc/interrupts?

With -V0.6.9, I got some slightly different symptoms. I did the change
chrt change (though I looked up the PID by hand, my attempt to use
pidof with 'ksoftirqd/0' did not work).

The LOC count did increase on both CPU's during my test (up until
I got the deadlock listed below). I also noticed that almost all
interrupts were processed by CPU0; should have checked before starting
the real time test to see if that was consistent when the system
was idle. I was about to send you a message from the test system with
that data when the system locked up.

The crash sequence was...

 - boot to single user (uneventful)
 - telnet 5 (uneventful)
 - X and top tests (uneventful)
 - network test started (and did not finish)
 - 2343 usec latency dumped
 - 55962 usec latency dumped
 - 74229 usec latency dumped
 - 83374 usec latency dumped
 - deadlock
 - long string of other BUG messages

I tried to Sync & reboot with Alt-SysRq keys at this point and was
unable to do so. Hard reset to reboot. Serial console output to
follow separately.
  --Mark


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUKDSIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUKDSIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUKDSIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:08:43 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:22117 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S262350AbUKDSCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:02:39 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
To: Ingo Molnar <mingo@elte.hu>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF21951A86.850E776A-ON86256F42.00610EF0@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 4 Nov 2004 11:52:22 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/04/2004 11:52:28 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Perhaps "should be fine" but the test I just ran indicates otherwise.
>The kernel is -V0.7.7 plus the patch you just sent me.
>All IRQ and /# tasks were set to RT priority 99.

A follow up to my previous message since the test just completed
with the following results:

2.6.10-rc1-mm2-RT-V0.7.7
181 packets lost (5%)
0.343, 2525.872, 213979, 21685 (min, average, max, deviation)
elapsed time was 3090 seconds

There was a burst of lost packets between seq 1777 and 1959,
that appears to cover all the lost ones. There was also a big
delay (up to 27305 msec) at seq 1665 through 1699 but no lost
packets. If I throw out those data points, the max drops to
something like 1800 msec and the average is in the 0.4 to 0.5
msec range.

The display lockup on the top test was a little odd. The window
that should have shown top appeared blank, stayed on the screen
for several seconds and then disappeared by itself. Apparently
top didn't even get enough CPU time to display the first cycle
before its time ran out. The audio test continued to run a while
after than & then stopped itself when the script noticed that top
was done.

The display lockups on the other tests (network and disk I/O)
were much less severe though still present at times.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>


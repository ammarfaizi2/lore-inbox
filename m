Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbUJ0QTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbUJ0QTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbUJ0QRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:17:16 -0400
Received: from lax-gate4.raytheon.com ([199.46.200.233]:13127 "EHLO
	lax-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S262487AbUJ0QNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:13:41 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
To: Ingo Molnar <mingo@elte.hu>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFB2831BD0.16B54A00-ON86256F3A.00544150@raytheon.com>
From: Mark_H_Johnson@RAYTHEON.COM
Date: Wed, 27 Oct 2004 11:12:04 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/27/2004 11:12:08 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have released the -V0.4 Real-Time Preemption patch, which can be
>downloaded from:

I built with this (and not V0.4.1) and had the following results:

[1] No problems with the build.

[2] Booting to single user without problems.

[3] telinit 3 - still have the atomic counter underflow BUG related
to qdisc_destroy. Otherwise, normal boot messages.

[4] telinit 5 - normal boot messages and display came up OK. Able
to login and start testing.

[5] Running my stress test, the first test (X server) appeared to
run OK. The second test (/proc or top) did not run properly. The
RT audio test appeared to take the whole system (both CPU's) and
the terminal window showing top did not appear until the audio
test finished (and was quickly taken down by the script). Could not
move the mouse at all during that test. The third test (network
output) ran a short period and then the machine locked up. Had
to use the hardware reset to recover.

The only message in the system log that was unusual was
nrpe[4151]: Error: Could not complete SSL handshake.
(no messages after this one)
everything before that was OK in the system log.

Looking at the application level charts from the first two
tests (after rebooting with -T3), the measured CPU time was
VERY SMOOTH, almost no blips until the end of the first test
and start of the second test(680 usec and 570 usec respectively).
The audio loop had some (6) spikes, 4 in the first test and 2 in
the second. The longest spike was over 60 msec in duration.

My script that samples latency traces > 200 usec had no
output. Not sure if that is because it didn't run or if there
were no traces to record.

I looked at the updated patch (V0.4.1) but I am not sure it
fixes this lock up problem. Please advise.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUKCUrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUKCUrc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbUKCUpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:45:06 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:47099 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S261866AbUKCUma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:42:30 -0500
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
Message-ID: <OFB0917CE0.7B8A1BDB-ON86256F41.006FCA71@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Wed, 3 Nov 2004 14:40:44 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/03/2004 02:40:54 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reran my tests on -T3 to see if the same symptoms I saw with -V0.7.7
were present with the older (preempt, not RT) patches.

> - whenever the real time test was active, responses to ping from another
>system would basically stop until the real time test was done. In one case
>about 25 ping packets were returned after a huge delay. From that, it
>appears they were received but the return was delayed.
Same with -T3. What's really odd is that it stopped during the network
tests as well; may indicate that the network tests don't actually run
during the real time audio test. Hmm. Will modify the stress_neti and
stress_neto scripts I use to dump after each file transfer & see if
this is true or not. That certainly was not the case on 2.4 kernels
so this looks like a serious regression.

> - cat /proc/interrupts showed that LOC was increasing on both CPU's
>during the tests.
Did not check this, but I wasn't seeing the severe lockups of the display
on -T3 either. Yes - it is sometimes slow to update, but not stopping
display updates for extended periods.

> - the scheduler seems to prefer run my cpu_burn (nice'd) task instead
>of updating the X display, doing the latency timing checks, ping
responses,
>and anything else that does useful work.
To some extent, I see this symptom too. I watched the system with top
during the network and disk tests and it would stop updating for several
seconds (should be one second updates) during the test (and usually show
cpu_burn at > 90% CPU), then do a flurry of updates, and then sometimes
settle down to the one per second update for several seconds in a row.

> - the disk write test was REALLY SLOW, perhaps hundreds of Kbytes per
>second instead of what I normally see. I took much longer than the real
>time audio test. I checked with top and noticed that "fam" was taking
>near 100% of CPU time. I closed my konqueror window (just happened to be
>looking at my test directory) and fam usage went away and the disk writes
>sped up considerably.
This was much less severe in -T3. What I saw was that fam would show up
for several seconds and then disappear from the top list for several
seconds. The disk transfer speed also appeared to be much faster on -T3
than -V0.7.7 when fam was active. (based on how much clock time the
test took to perform)

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>


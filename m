Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUKJReX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUKJReX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 12:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbUKJReX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 12:34:23 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:62140 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S262020AbUKJReR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 12:34:17 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Date: Wed, 10 Nov 2004 11:31:31 -0600
Message-ID: <OF2786F37D.F4A38B6B-ON86256F48.00604518-86256F48.0060454F@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/10/2004 11:33:24 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I may do a variant on this anyway. I think its important to see if
>the symptom (> 100 usec CPU delay) is really:
>- lots of short delays
>OR
>- relatively few long delays
>and I have an idea of how to code that up and add to latencytrace.

A follow up on this message. My first test completed with the following
results. The new code indicates:

X     - Min delay was     0. Max delay was     3. Ave delay was  0.015295.
top   - Min delay was     0. Max delay was    23. Ave delay was  0.025659.
netO  - Min delay was     0. Max delay was    31. Ave delay was  1.169024.
netI  - Min delay was     1. Max delay was    35. Ave delay was  1.182864.
diskW - Min delay was     0. Max delay was    18. Ave delay was  1.166944.
diskC - Min delay was     0. Max delay was    18. Ave delay was  1.080036.
diskR - Min delay was     0. Max delay was     7. Ave delay was  0.803804.

A "delay" was counted if 1000 iterations of the CPU inner loop took
longer than 10 usec. For comparison, I moved this code to my 2.4 system
and got the following results:

X     - Min delay was     0. Max delay was    17. Ave delay was  1.277730.
top   - Min delay was     0. Max delay was    12. Ave delay was  1.452692.
netO  - Min delay was     0. Max delay was    12. Ave delay was  1.633742.
netI  - Min delay was     0. Max delay was    12. Ave delay was  1.626565.
diskW - Min delay was     0. Max delay was    14. Ave delay was  1.566188.
diskC - Min delay was     0. Max delay was    12. Ave delay was  1.701542.
diskR - Min delay was     0. Max delay was    12. Ave delay was  1.650909.

Looks pretty comparable at this level. The 2.4 results appear to be more
consistent.

Grr. The new code does have an impact on the application measurements
under 2.4. It appears the TSC accesses are being delayed while the disk
is active. The within 100 usec rate was only 77% (was 90%) but the peak
is still pretty close (2.60 vs. 2.38 msec).

I am also not sure this is the "right" measurement either. I probably
need to count the delays or divide the overall loop time by the number
of delays to see if that is a more meaningful value.

  --Mark


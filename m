Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbULMUKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbULMUKX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 15:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbULMUG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 15:06:59 -0500
Received: from bos-gate2.raytheon.com ([199.46.198.231]:15607 "EHLO
	bos-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S261342AbULMUD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 15:03:56 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
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
Message-ID: <OF400780A2.F355C2F4-ON86256F69.006AD194@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Mon, 13 Dec 2004 14:02:55 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/13/2004 02:03:08 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A comparison of PREEMPT_RT (no tracing) to PREEMPT_DESKTOP
(no tracing) to help answer previous requests.

Comparison of .32-20RT and .32-20PK results
20RT has PREEMPT_RT (all tracing disabled)
20PK has PREEMPT_DESKTOP and no threaded IRQ's (all tracing disabled)
2.4 has lowlat + preempt patches applied

      within 100 usec
       CPU loop (%)   Elapsed Time (sec)    2.4
Test   RT     PK        RT      PK   |   CPU  Elapsed
X     99.87  99.75      65 *    59 * |  97.20   70
top   99.35  99.97      31 *    30 * |  97.48   29
neto  96.94  98.65     113 *   135 * |  96.23   36
neti  97.05  98.59     119 *   140 * |  95.86   41
diskw 94.36  91.69      30 *    70 * |  77.64   29
diskc 93.85  98.88      98 *   151 * |  84.12   77
diskr 99.39  99.92     133 *   210 * |  90.66   86
total                  589     795   |         368
 [higher is better]  [lower is better]
* wide variation in audio duration
+ long stretch of audio duration "too fast"

With the two versions of -20, they are quite similar in the
percentage of CPU loop duration within 100 usec of nominal.

Looking at ping response time:
  RT 0.134 / 0.208 / 1.502 / 0.075 msec
  PK 0.089 / 0.159 / 0.467 / 0.047 msec
for min / average / max / mdev values. You can see that
-20PK does much better than -20RT in this measure.

The maximum duration of the CPU loop (as measured by the
application) is in the range of 1.42 msec to 2.57 compared
to the nominal 1.16 msec duration for -20RT. The equivalent
numbers for -20PK are 1.28 to 1.93 msec. Its a little odd
that the big outlier for -20PK was during the X 11 stress
test. Its chart was one of the smoothest (less variation)
than the others.

I repeated the test without cpu_burn (non RT, nice) for the
20PK kernel as well.  For -20PK, all the elapsed times were
reduced [as I expected for both RT and PK] and with exception
of the network tests, were roughly the same as the 2.4 results.

-20RT
  with cpu_burn      65  31 113 119  30  98 133
  without cpu_burn   63  30 121 150  32  87  97
-20PK
  with cpu_burn      59  30 135 140  70 151 210
  without cpu_burn   62  30  94  60  27  89  93

I reran the 2.4 tests and the network tests ran in 39 and 37
seconds respectively. I guess this shows we have something odd
going on in the network stack under 2.6.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>


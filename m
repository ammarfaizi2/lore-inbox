Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbULIPUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbULIPUi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 10:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbULIPUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 10:20:12 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:56943 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S261527AbULIPR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 10:17:57 -0500
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
Message-ID: <OF7A3735CE.0606A36B-ON86256F65.00512706@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 9 Dec 2004 09:16:49 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/09/2004 09:16:51 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comparison of .32-5RT and .32-5PK results
RT has PREEMPT_RT,
PK has PREEMPT_DESKTOP and no threaded IRQ's.
2.4 has lowlat + preempt patches applied

      within 100 usec
       CPU loop (%)   Elapsed Time (sec)    2.4
Test   RT     PK        RT      PK   |   CPU  Elapsed
X     90.46  99.88      67 *    63+  |  97.20   70
top   83.03  99.87      35 *    33+  |  97.48   29
neto  91.69  97.57     360 *   320+* |  96.23   36
neti  88.37  97.79     360 *   300+* |  95.86   41
diskw 87.73  67.41     360 *    57+* |  77.64   29
diskc 86.35  99.39     360 *   320+* |  84.12   77
diskr 81.57  99.89     360 *   320+* |  90.66   86
total                 1902    1413   |         368
 [higher is better]  [lower is better]
* wide variation in audio duration
+ long stretch of audio duration "too fast"

The max CPU latencies in RT are worse than PK as well. The
values for RT range from 3.00 msec to 5.43 msec and on
PK range from 1.45 msec to 2.24 msec.

This is the first set of charts I have seen where _RT is
basically worse than _PK in all the application measures.

To contrast, there were plenty of > 250 usec latency traces
in the _PK run and none during _RT. The PK run also had
three of the "starvation" periods where the 5 second sleep
took 212, 70, and 248 seconds and the RT run had one
starvation period of 11 seconds.

Not quite sure why these measures are so inconsistent..

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>


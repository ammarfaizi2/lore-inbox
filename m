Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbULCWeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbULCWeD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 17:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbULCWeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 17:34:03 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:47087 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S262441AbULCWdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 17:33:47 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-0
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
Message-ID: <OFAD4DDF01.33613E58-ON86256F5F.007AE759@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Fri, 3 Dec 2004 16:33:20 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/03/2004 04:33:23 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comparison of .32-0 and .31-15 results


      within 100 usec
       CPU loop (%)   Elapsed Time (sec)    2.4
Test   32-0  31-15     32-0   31-15  |   CPU  Elapsed
X     94.58  99.22      67      68   |  97.20   70
top   95.29  97.96      39      34   |  97.48   29
neto  94.24  99.98     360     360   |  96.23   36
neti  94.83  98.31     360     350   |  95.86   41
diskw 90.77  99.57     360     360 * |  77.64   29
diskc 93.47  97.49     360     360   |  84.12   77
diskr 93.49  98.35     320     180   |  90.66   86
total                 1866    1712   |         368
* wide variation in audio duration

Grr. This appears that .32-0 is MUCH WORSE than 31.15 at
keeping the relatively small (100 usec) latencies down.
Probably due to the CPU task switch that prevents the
longer ones from occurring. The MAX CPU latencies are down
in most cases (over 4 msec down to about 3 msec) which
is a good result.

The long elapsed times appear to indicate that we are
starving the "stress test" application (and likely
running the niced, non RT cpu_burn instead).

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>


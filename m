Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbUK3OfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbUK3OfR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 09:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbUK3OfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 09:35:17 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:35204 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S262091AbUK3OfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 09:35:06 -0500
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Amit Shah" <amit.shah@codito.com>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       emann@mrv.com, "Gunther Persoons" <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Rui Nuno Capela" <rncbc@rncbc.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Lee Revell" <rlrevell@joe-job.com>, "Shane Shrybman" <shrybman@aei.ca>,
       "Esben Nielsen" <simlo@phys.au.dk>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFF4F89D90.B89E0767-ON86256F5C.004C735C@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Tue, 30 Nov 2004 08:33:05 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/30/2004 08:33:07 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have results from two builds of -V0.7.31-9. The first
build is CONFIG_RT (RT) and the second is CONFIG_DESKTOP (PK or
as described in .config help - Preempt Kernel).

Both booted OK - so the SMP lockup on _DESKTOP appears to
be fixed. Both ran my test series faster than previous 2.6
kernels. I was seeing run times over 30 minutes before
(mainly due to starvation of non-RT tasks) but both completed
in about 20 minutes.

General notes:

[1] Audio duration was much more variable on the PK than the
RT kernel. The variability on PK audio duration is about 30%
of nominal time. The RT kernel was less variable but tended to
finish well before the nominal time (and you could hear the
difference). The PK results look like buffering inside ALSA
that was not present in OSS?. Not sure why the RT kernel
is almost always finishing too soon.

[2] The PK kernel has much longer latencies as measured by
the in kernel tracing code. The RT kernel basically had NO
latencies > 50 usec where the PK kernel had several over a
millisecond (usually related to disk writes). By this measure
the RT kernel is clearly better.

[3] The overhead of RT (as measured by the CPU loop timing and
by pings from remote systems) is more than the PK kernel. I
believe this is due to the IRQ threading overhead. By these
measures, the PK kernel is better. By elapsed time, the 2.4
kernel is far superior.

More specifics:
The 2.4 numbers are from 2.4.24 w/ low latency / preempt patches.

      within 100 usec
       CPU loop (%)   Elapsed Time (sec)    2.4
Test    PK     RT       PK      RT   |   CPU  Elapsed
X     99.69  99.34      90      70   |  97.20   70
top   99.31  98.33      30      31   |  97.48   29
neto  97.28  97.69     205     315   |  96.23   36
neti  97.76  98.11     198     325   |  95.86   41
diskw 69.16* 94.98      51     115   |  77.64   29
diskc 96.44  98.39     230     250   |  84.12   77
diskr 99.60  98.77     240     180   |  90.66   86
total                 1044    1286   |         368

* several multiple millisecond latencies measured by the
tracing code. Will send traces separately.

           min     ave       max     mdev
PK ping - 0.100 / 0.176 /   1.009 / 0.053
RT ping - 0.194 / 0.322 / 527.635 / 2.263
[not sure why the high max on RT, but I did see a few
1 msec or longer ping responses and many over 400 usec]

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbUKDPFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbUKDPFK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 10:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbUKDPFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 10:05:10 -0500
Received: from lax-gate6.raytheon.com ([199.46.200.237]:11481 "EHLO
	lax-gate6.raytheon.com") by vger.kernel.org with ESMTP
	id S262246AbUKDPFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 10:05:03 -0500
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
Message-ID: <OF4142E065.5AF4099C-ON86256F42.00513CF0@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 4 Nov 2004 09:02:01 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/04/2004 09:02:25 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me follow up briefly on the regression I noticed yesterday on ping
responses from an SMP system with one real time task running. Two systems
were used for the tests, both dual 866 Mhz Pentium III systems, identical
except for the software. The "old" machine is running Red Hat 7.3 with a
2.4.24 preempt, low latency kernel. The "new" machine is running Fedora
Core 2 with a 2.6 kernel as indicated below. The other difference that may
be significant is the "old" system uses OSS and the new one uses ALSA for
the audio output (source of latencytest application is unchanged for all
three tests).

The data below is from using another machine to ping the system under test.

2.4.24 preempt + low latency on "old" machine

430 seconds for the complete series of tests
0 lost packets
0.248, 0.322, 2.82, 0.145 (min, average, max, deviation)

2.6.5-1.358smp [from fedora core 2] on "new" machine

658 seconds for the complete series of tests
0 lost packets
0.148, 0.207, 1.952, 0.097 (min, average, max, deviation)
This system also lost the mouse (screaming interrupts, IRQ 10 disabled).

2.6.9-rc3-mm3-VP-T3 on "new machine"

955 seconds for the complete series of tests
539 lost packets
0.215, 17971, 287799, 63054 (min, average, max, deviation)

I did not repeat the tests on -V0.7.7, but I expect them to come out
similar to -T3 above based on what I saw yesterday. In any case, the loss
of network data appears significant with both the voluntary preempt &
realtime preempt patches on 2.6 kernels.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>


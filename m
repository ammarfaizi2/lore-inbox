Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267504AbUIAXD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267504AbUIAXD6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268058AbUIAXAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:00:47 -0400
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:11885 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S267490AbUIAW5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 18:57:10 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q7
To: Thomas Charbonnel <thomas@undata.org>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFA48649D2.721211FD-ON86256F02.007CEFE1@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Wed, 1 Sep 2004 17:56:22 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/01/2004 05:56:28 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>With Q7 I still get rx latency issues (> 130 us non-preemptible section
>from rtl8139_poll). Moreover network connections were extremely slow
>(almost hung) until I set /proc/sys/net/core/netdev_backlog_granularity
>to 2.

The default of 1 caused a couple services to fail start up - most
annoying failure was NIS. I changed netdev_backlog_granularity to
eight (8) in /etc/sysctl.conf and came up fine. The system is under
test right now, though will probably tomorrow before I get full
results.

It appears to have fewer > 500 usec traces than previous
tests so the -Q7 stuff appears to work (though has not made it to
the disk tests where I generally have more problems yet).

One place where we may need to consider more mcount() calls is in
the scheduler. I got another 500+ msec trace going from dequeue_task
to __switch_to.

I also looked briefly at find_first_bit since it appears in a number
of traces. Just curious, but the coding for the i386 version is MUCH
different in style than several other architectures (e.g, PPC64, SPARC).
Is there some reason why it is recursive on the x86 and a loop in the
others?

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>


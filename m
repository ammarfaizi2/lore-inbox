Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270629AbUJUO5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270629AbUJUO5M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270754AbUJUOyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:54:07 -0400
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:51177 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S270736AbUJUOxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:53:10 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFDF180689.447B12FA-ON86256F34.004EF945@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 21 Oct 2004 09:51:04 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/21/2004 09:51:07 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>do you have PREEMPT_REALTIME enabled? The above trace is a direct
>interrupt - only the timer interrupt is allowed to execute directly in
>the PREEMPT_REALTIME model - things break badly if it happens for any
>other interrupt (such as the soundcard IRQ).
Yes I have PREEMPT_REALTIME enabled.

The thing that comes to mind is I do have a script that does
  echo 0 > '/proc/irq/10/Esoniq AudioPCI/threaded
as part of ensuring the all the preemption stuff was set right. I may
have run that script prior to getting those messages. I thought you
said before that the non threaded IRQ stuff was disabled. Perhaps this
interface needs to be disabled as well [unless you really decide to
fix this limitation...].

I was already going into that script to add something like...
  for N in 1 3 4 6 8 10 11 12 14 15 ; do
    chrt -p -f 99 `pidof "IRQ $N"`
  done
to make all the threaded IRQ's max priority RT fifo tasks. I can
certainly comment out the IRQ thread disable code while I'm at it.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>


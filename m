Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbUKDQ4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbUKDQ4Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 11:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbUKDQ4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 11:56:16 -0500
Received: from bos-gate1.raytheon.com ([199.46.198.230]:52526 "EHLO
	bos-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S262275AbUKDQ4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 11:56:13 -0500
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
Message-ID: <OFC352F5E4.491ED072-ON86256F42.005C579E@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 4 Nov 2004 10:53:58 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/04/2004 10:54:09 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I can set those as well but then I'd probably have to follow with
>> the X server and everything else in the chain. The starvation problem
>> ripples across the system.
>
>X should be scheduled on the other CPU just fine. Only per-CPU kernel
>threads (which are affine to their particular CPU) are affected by this
>problem - ordinary tasks not. I.e. the system threads that have /0 and
>/1 in their name. In theory you should not even need to chrt the hardirq
>threads, those should schedule fine too.
Perhaps "should be fine" but the test I just ran indicates otherwise.
The kernel is -V0.7.7 plus the patch you just sent me.
All IRQ and /# tasks were set to RT priority 99.

Started the X test and the display locked up almost immediately while
ping responses continued to flow on a regular basis. After several seconds
I could see the display update / move the mouse & then the display locked
up again. It went back and forth a couple cycles and did not get unstuck
until the RT audio application quit (over 250000 samples).

I will let it run to see if I can reproduce the deadlock or if the symptoms
change with one of the other tests.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>


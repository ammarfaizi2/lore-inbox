Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbUJ1HD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbUJ1HD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 03:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUJ1HD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 03:03:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62391 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262803AbUJ1HDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 03:03:00 -0400
Date: Thu, 28 Oct 2004 09:03:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@Raytheon.com
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
Message-ID: <20041028070357.GC10488@elte.hu>
References: <OF45330B99.149A2C07-ON86256F3A.00757C16@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF45330B99.149A2C07-ON86256F3A.00757C16@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@Raytheon.com <Mark_H_Johnson@Raytheon.com> wrote:

> I am aware of slow responses normally during tests. However the audio
> test should only use one CPU out of two. The other CPU is busy as well
> with a cpu burner (nice 10) but that should leave me CPU cycles to
> move the mouse, swap windows, etc.  The "lock up" I saw this time was
> a lot more severe (no mouse motion for several minutes at a time). I
> knew the system was still running since the audio continued to play.

the way i typically debug such scenarios is to set up a separate
'highprio console' of some sorts. E.g. log in via the network from
another box and make sure all processing of that console is SCHED_FIFO. 
(in the network case that would mean the network IRQ, ksoftirqd, sshd,
login and bash.) Such a 'highprio console' should have a higher priority
than any other task in the system. If you run alot of stuff in it then
it will surely disturb your measurements (and largely invalidate them),
but otherwise it can be useful to have it around just in case you
experience a lockup that you suspect to be some sort of livelock or
starvation. Whenever the lockup happens, check out what's going on, via
the highprio console.

another useful 'highprio console' is the text console itself - in this
case only login and bash has to be chrt-ed, and the runtime impact on
the test is smaller as well. This is only useful if you can start your
'bad' workload over ssh or via networked X.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUKBJpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUKBJpP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 04:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbUKBJpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 04:45:15 -0500
Received: from mx2.elte.hu ([157.181.151.9]:53429 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261271AbUKBJhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 04:37:05 -0500
Date: Tue, 2 Nov 2004 10:37:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5 (networking problems)
Message-ID: <20041102093758.GA28014@elte.hu>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <417F7D7D.5090205@stud.feec.vutbr.cz> <20041027134822.GA7980@elte.hu> <417FD9F2.8060002@stud.feec.vutbr.cz> <20041028115719.GA9563@elte.hu> <20041030000234.GA20986@nietzsche.lynx.com> <20041102085650.GA3973@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041102085650.GA3973@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <bhuey@lnxw.com> wrote:

> On Fri, Oct 29, 2004 at 05:02:34PM -0700, Bill Huey wrote:
> > This is in -V5.14
> 
> [nasty networking crash trace]
> 
> Didn't fix it all...

thanks for the trace - i've uploaded -V0.6.6 to the usual place:

    http://redhat.com/~mingo/realtime-preempt/

which attempts to fix this particular deadlock.

other changes in -V0.6.6:

 - increased debuggability by turning deadlock detection on for ordinary
   Linux semaphores and rwsems. I suspect that some of the recently
   reported hangs were semaphore related deadlocks. Those who see hangs 
   please re-try with -V0.6.6 and deadlock detection turned on, does it
   produce a usable deadlock printout?

 - show_all_locks() build bug fix from Daniel Walker.

 - another debuggability feature: deadlock tracing stops after the 
   first dump and the kernel tries to continue (we tried to do this
   before but it wasnt complete). Sometimes the deadlock is in fact some
   'interesting' use of Linux semaphores and the system will not
   really deadlock. The dump we can use to fix up that interesting use
   of semaphores, and the system wont crash.

 - crash fix: the dump_own_stack() code was buggered - removed it. The 
   stock kernel does pretty good stackdumping by itself, all that was
   needed to activate it was to set CONFIG_FRAME_POINTERS.

	Ingo

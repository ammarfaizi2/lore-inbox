Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbULOJdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbULOJdP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 04:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbULOJdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 04:33:14 -0500
Received: from mx2.elte.hu ([157.181.151.9]:451 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262304AbULOJdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 04:33:00 -0500
Date: Wed, 15 Dec 2004 10:32:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       George Anzinger <george@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Message-ID: <20041215093246.GE13551@elte.hu>
References: <1103064432.14699.69.camel@krustophenia.net> <200412142257.iBEMvYPj014838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412142257.iBEMvYPj014838@localhost.localdomain>
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


* Paul Davis <paul@linuxaudiosystems.com> wrote:

> the latter. to send MIDI Clock or MIDI Timecode requires an interrupt
> source that is not locked to jiffie-ish intervals or power-of-2
> related intervals. For example, MTC requires sending 2 bytes roughly
> every 0.8msec. Sending them every msec isn't good enough, in general.

yeah, i can understand that - 20% slower music is bad, even to kernel
hackers ;-)

> my understanding of the HRT patch is that it allows the timer to be
> reprogrammed to elapse with nanosecond resolution. i don't understand
> why linus has been so reluctant to move linux in this direction, other
> than it being hard to fit into the existing fixed interval timer
> framework.

i dont think there's any particular type of feeling from Linus towards
HRT - it's always the quality of the patch (and the underlying
fundamental issues) that controls, plus 'demand'. So integrating this
stuff is not a matter of will, it's a matter of having good enough code.

the current 'fixed interval timer framework' is one reason that makes
Linux scale so well on big networked boxes, which can easily have
millions of timers running (per CPU). Sub-jiffy solutions i've seen so
far tended to concentrate on making sub-jiffies work, while keeping
fixed interval timers only as a side-effect. That's not how usage
demands it - right now fixed interval timers are king in terms of usage
(and will be king even if we had HRT integrated), so subjiffy timers
must be very precisely engineered to not hurt fixed interval timers.
Plus if we touch the timer code then maybe it could be made more
deterministic (cascading isnt quite deterministic right now) - which
further complicates things. It's not a simple and clear-cut task for
sure.

	Ingo

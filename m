Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbUJ1HLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbUJ1HLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 03:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbUJ1HLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 03:11:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38864 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262795AbUJ1HKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 03:10:52 -0400
Date: Thu, 28 Oct 2004 09:11:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041028071134.GD10488@elte.hu>
References: <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com> <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com> <20041027132926.GA7171@elte.hu> <417FB7F0.4070300@cybsft.com> <20041027150548.GA11233@elte.hu> <20041027204935.GA24732@nietzsche.lynx.com> <20041027205445.GB24732@nietzsche.lynx.com> <20041027210120.GA24868@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027210120.GA24868@nietzsche.lynx.com>
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

> On Wed, Oct 27, 2004 at 01:54:45PM -0700, Bill Huey wrote:
> > It was originally mean to go in between the irq-thread wake attempt and
> > the actual running of the thread body itself. Somehow this is breaking
> > in my effort to integrate this logic into Ingo's (your) stuff. Brain
> > farting severely right now.
> 
> Another note, it's not meant to be a high resolution latency stats
> patch as much as giving a general feel of irq latency in the system.
> That information is just useful to have in general, but won't be
> sufficient enough to track down specific problems in the kernel.
> Extending this code to track all wake ups is beyond the original
> intention of these measurements. [...]

yeah, the wakeup-tracing we have now is mostly for debugging, it doesnt
generate a histogram at the moment. But you could extend it to be that -
the trace_start_sched_wakeup() and trace_stop_sched_switched() hooks in
the latest patch are precisely that. Note the magic done there, it is
important to establish that only the _highest prio_ task's wakeup
latency counts, and the tests in those functions do just that. 
(otherwise we'd have to do nested latency tracing which is quite
elaborous. I've done it before and it's neither fun, nor truly useful.)

So i think you can put a histogram generator into check_wakeup_timing()
(without needing any outside code), the 'latency' variable established
there is precisely the latency you want to track.

	Ingo

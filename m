Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbUKFHld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbUKFHld (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 02:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbUKFHld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 02:41:33 -0500
Received: from mx2.elte.hu ([157.181.151.9]:1240 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261334AbUKFHlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 02:41:23 -0500
Date: Sat, 6 Nov 2004 08:42:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: john cooper <john.cooper@timesys.com>, Mark_H_Johnson@raytheon.com,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Message-ID: <20041106074219.GD8285@elte.hu>
References: <OF5DB3F102.6D3B4834-ON86256F42.00598BFD@raytheon.com> <20041104163012.GA3498@elte.hu> <20041104163254.GA3810@elte.hu> <418A7BFB.6020501@timesys.com> <20041104194416.GC10107@elte.hu> <20041105214238.GA11075@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105214238.GA11075@yoda.timesys>
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


* Scott Wood <scott@timesys.com> wrote:

> > is the order of locks in the dependency chain really unpredictable? If
> > two chain walkers get two locks in opposite order, doesnt that mean that
> > the lock ordering (as attempted by the blocked tasks) is deadlock-prone
> > already? I.e. this scenario should not happen.
> 
> It *shouldn't*, but bugs do happen, and it'd be nice if a mutex
> deadlock didn't get promoted into a less debuggable spinlock deadlock.
> [...]

well, deadlock detection happens at lock-acquire time, so the deadlock
will be detected _first_, any PI spinlock-locking will happen on already
blocked (== no deadlock detected) tasks. This would also serve as a nice
secondary check for the deadlock detector.

> [...] Plus, if there's any intention of ever exporting this priority
> inheritance mechanism to userspace locks, we don't want to promote a
> userspace deadlock into a kernel one.

agreed.

> Given how rarely contention should occur, I don't think that a single
> lock would be a bottleneck except for obscenely large SMP machines.

well, blocking on a mutex happens quite frequently. But i dont have a
problem with the big lock other than the usual "if we can do better then
we should do better" attitude :-)

	Ingo

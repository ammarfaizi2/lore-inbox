Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbUKDTqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbUKDTqt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbUKDTqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:46:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11495 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262412AbUKDTnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:43:14 -0500
Date: Thu, 4 Nov 2004 20:44:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john cooper <john.cooper@timesys.com>
Cc: Mark_H_Johnson@raytheon.com, Karsten Wiese <annabellesgarden@yahoo.de>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Message-ID: <20041104194416.GC10107@elte.hu>
References: <OF5DB3F102.6D3B4834-ON86256F42.00598BFD@raytheon.com> <20041104163012.GA3498@elte.hu> <20041104163254.GA3810@elte.hu> <418A7BFB.6020501@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418A7BFB.6020501@timesys.com>
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


* john cooper <john.cooper@timesys.com> wrote:

> > plus there's the 'priority inheritance dependency-chain closure' bug
> > noticed by John Cooper - that should only affect the latency of RT 
> > tasks though.
> 
> This is a fairly gnarly problem to address.  The obvious solution is
> to hold spinlocks in the mutexes as the dependency tree is atomically
> traversed.  However this will deadlock under MP due to the
> unpredictable order of mutexes traversed.  If the dependency chain is
> not traversed (and semantics applied) atomically, races exist which
> cause promotion decisions to be made on [now] stale data.

is the order of locks in the dependency chain really unpredictable? If
two chain walkers get two locks in opposite order, doesnt that mean that
the lock ordering (as attempted by the blocked tasks) is deadlock-prone
already? I.e. this scenario should not happen.

	Ingo

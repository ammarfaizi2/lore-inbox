Return-Path: <linux-kernel-owner+willy=40w.ods.org-S289492AbUKBIB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S289492AbUKBIB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 03:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S450223AbUKBIB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 03:01:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44172 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S289492AbUKBIBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 03:01:47 -0500
Date: Tue, 2 Nov 2004 09:02:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041102080236.GA21359@elte.hu>
References: <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu> <20041101135358.GA19718@elte.hu> <20041101140630.GA20448@elte.hu> <1099324040.3337.32.camel@thomas> <20041101184615.GB32009@elte.hu> <20041101233037.314337c8@mango.fruits.de> <20041101224047.GA19186@nietzsche.lynx.com> <20041101235125.2ae638a4@mango.fruits.de> <20041101225906.GA19276@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101225906.GA19276@nietzsche.lynx.com>
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

> The lock chains aren't that deep in Linux so the algorithmic
> complexity is not going to hit some crazy polynomial time unless
> there's some seriously nasty contention at a certain point in the
> kernel (billions of readers for example against a write aquire). But
> when we start to see things like that under pressure is when we need
> to start shortening the need for that/those lock(s) for that/those
> critical section(s) in question.

also note that in the -U series i removed the true 'read' logic from
semaphores. What we have now are single writers only, plus readers
emulated as a writer plus the ability to self-recurse. ('writers' are
not allowed to self-recurse.) This is quite close to the semantic needs
of Linux rwlocks and rwsems and it simplified both locking, deadlock
detection and PI quite significantly.

	Ingo

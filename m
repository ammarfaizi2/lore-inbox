Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263287AbUJ2Lma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263287AbUJ2Lma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbUJ2LjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:39:00 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17808 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263268AbUJ2Lfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:35:44 -0400
Date: Fri, 29 Oct 2004 13:36:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029113652.GC32204@elte.hu>
References: <20041029111408.GA28259@elte.hu> <200410291126.i9TBQuFu002731@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410291126.i9TBQuFu002731@localhost.localdomain>
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

> >my main suspicion is that either the main jackd thread itself calls the
> >kernel where the kernel (unexpectedly for jackd) schedules away for
> >whatever reason, or that the chain of wakeup in the audio path somehow
> >gets violated (i.e. a kernel problem). There's one quick thing we could
> 
> the "max delay" measurement isn't a reflection of the runtime activity
> of jackd. its simply a measurement of the delay between when jackd
> expected to be next woken from poll and when it actually was.
> 
> as you noted, jackd generally goes back to sleep in poll typically a
> long time before the next interrupt is expected. hence any delay in
> the wakeup is between the interrupt handler and the scheduler getting
> jackd's main thread back on the processor. i think.

this brings up the next question: does the jackd measurement also
timestamp the time when it calls poll() - hence detecting in-jackd
processing delays? If yes, which value is this from Rui's stats? If not
then it might make sense to add it.

	Ingo

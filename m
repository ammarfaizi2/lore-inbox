Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264644AbUKAOew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264644AbUKAOew (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 09:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbUKAOeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:34:50 -0500
Received: from mx1.elte.hu ([157.181.1.137]:45972 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265257AbUKAO3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:29:40 -0500
Date: Mon, 1 Nov 2004 15:30:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041101143049.GA22221@elte.hu>
References: <20041101134235.GA18009@elte.hu> <200411011354.iA1Dsleg008831@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411011354.iA1Dsleg008831@localhost.localdomain>
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

> >
> >* Florian Schmidt <mista.tapas@gmx.net> wrote:
> >
> >> new max. jitter: 4.3% (41 usec)
> >> new max. jitter: 4.9% (47 usec)
> >
> >a couple of conceptual questions: why does rtc_wakeup poll() on
> >/dev/rtc? Shouldnt a read() be enough?
> 
> i suggested to florian that it should model jackd's behaviour as
> closely as possible. because jackd requires duplex operation, using
> just read/write doesn't work.

ok - but i think there should at least be an option to turn the
poll()-ing off. To showcase the best-possible wakeup latency offered by
the kernel :-)

poll() is quite complex and with a good number of locks in the path the
maximum latency increases accordingly.

btw., couldnt jackd use a separate input and output thread (of identical
priority), to be purely read()/write() based? This method should also
solve the priority problems of poll(): the thread woken up later will do
the work later. (hence the _earlier_ interrupt source will be handled
first.) With poll() how do you tell which fd needs attention first, if
both are set?

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263461AbVBCVjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbVBCVjD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbVBCVhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:37:39 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48850 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261574AbVBCVhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:37:09 -0500
Date: Thu, 3 Feb 2005 22:36:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, "Jack O'Quin" <joq@io.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050203213645.GB27255@elte.hu>
References: <42014C10.60407@bigpond.net.au> <200502022303.j12N3nZa002055@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502022303.j12N3nZa002055@localhost.localdomain>
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

> Just a reminder: setuid root is precisely what we are attempting to
> avoid. 
> 
> >If you have the source code for the programs then they could be modified 
> >to drop the root euid after they've changed policy.  Or even do the 
> 
> This is insufficient, since they need to be able to drop RT scheduling
> and then reacquire it again later.

i believe RT-LSM provides a way to solve this cleanly: you can make your
audio app setguid-audio (note: NOT setuid), and make the audio group
have CAP_SYS_NICE-equivalent privilege via the RT-LSM, and then you
could have a finegrained per-app way of enabling SCHED_FIFO scheduling,
without giving _users_ the blanket permission to SCHED_FIFO. Ok?

this way if jackd (or a client) gets run by _any_ user, all jackd
processes will be part of the audio group and can do SCHED_FIFO - but
users are not automatically trusted with SCHED_FIFO.

you are currently using RT-LSM to enable a user to do SCHED_FIFO, right? 
I think the above mechanism is more secure and more finegrained than
that.

	Ingo

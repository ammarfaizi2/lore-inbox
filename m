Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270635AbUJUKvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270635AbUJUKvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbUJUKqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:46:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:5288 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270640AbUJUKpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:45:45 -0400
Date: Thu, 21 Oct 2004 12:42:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@suse.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021104222.GA8747@elte.hu>
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <30690.195.245.190.93.1098349976.squirrel@195.245.190.93> <1098350190.26758.24.camel@thomas> <20041021095344.GA10531@suse.de> <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de> <1098353505.26758.38.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098353505.26758.38.camel@thomas>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > > This is used to wait for command completion and therefor we have the
> > > completion API. It was used this way because the ancestor of completion
> > > (sleep_on) was racy !
> > 
> > I didn't look at the USB code, I'm just saying that it's perfectly valid
> > use of a semaphore the pattern you describe (process A holding it,
> > process B releasing it).
> 
> Yeah, for a semaphore it is, but not for a mutex.

but mutexes dont exist in upstream Linux as a separate entity. (they
exist in my tree but that's another ballgame.)

> IMHO, this is not clearly seperated and therefor produces a lot of
> confusion.

if used to complete some work then semaphores are indeed a tad unclean
and slightly slower than completions - but they are fully correct kernel
code. And there are much worse offenders of cleanliness around.

	Ingo

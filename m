Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbVAKU71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbVAKU71 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVAKU70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:59:26 -0500
Received: from mx1.elte.hu ([157.181.1.137]:19872 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262407AbVAKU7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:59:11 -0500
Date: Tue, 11 Jan 2005 21:58:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Chris Wright <chrisw@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, Paul Davis <paul@linuxaudiosystems.com>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111205809.GB21308@elte.hu>
References: <20050110212019.GG2995@waste.org> <200501111305.j0BD58U2000483@localhost.localdomain> <20050111191701.GT2940@waste.org> <20050111125008.K10567@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111125008.K10567@build.pdx.osdl.net>
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


* Chris Wright <chrisw@osdl.org> wrote:

> > We have not established that at all. In principle, because SCHED_OTHER
> > tasks running at full priority lie on the boundary between SCHED_OTHER
> > and SCHED_FIFO, they can be made to run arbitrarily close to the
> > performance of tasks in SCHED_FIFO. With the upside that they won't be
> > able to deadlock the machine.
> 
> I don't think they lie quite so neatly on this boundary.  There's one
> fundamental difference which is how the dynamic priority is adjusted
> which alters the basic preemptibility rules.

but at nice level -20 this adjustment is at most +5 priority levels -
i.e. down to an equivalent of nice -15. Consider that a nice 0 task can
at most get a -5 priority boost gives a nice -5 task worst-case - so the
nice -20 task still preempts the lower prio task.

so this could work in theory. But practice shows it doesnt work at the
moment, and nobody has analyzed why, yet.

(There are some other differences in scheduling like starvation
prevention adding potential delays, but those should in theory not
affect the basic tests that were done so far. There are also some
differences in timeslice management, but with the huge timeslices that
nice -20 tasks get this shouldnt be causing problems either. So my
current thinking is that there's an unknown scheduling effect causing
latency regression of nice -20 tasks, compared to the latencies of
RT-prio-1 tasks.)

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVAOISh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVAOISh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 03:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVAOISh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 03:18:37 -0500
Received: from pop.gmx.de ([213.165.64.20]:58005 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262240AbVAOISe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 03:18:34 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20050115080420.00bf2c90@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sat, 15 Jan 2005 09:06:14 +0100
To: "Jack O'Quin" <joq@io.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Cc: Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Chris Wright <chrisw@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       Matt Mackall <mpm@selenic.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <87llav7atz.fsf@sulphur.joq.us>
References: <5.2.1.1.2.20050114171907.00c05e38@pop.gmx.net>
 <20050113214320.GB22208@devserv.devel.redhat.com>
 <20050111214152.GA17943@devserv.devel.redhat.com>
 <200501112251.j0BMp9iZ006964@localhost.localdomain>
 <20050111150556.S10567@build.pdx.osdl.net>
 <87y8ezzake.fsf@sulphur.joq.us>
 <20050112074906.GB5735@devserv.devel.redhat.com>
 <87oefuma3c.fsf@sulphur.joq.us>
 <20050113072802.GB13195@devserv.devel.redhat.com>
 <878y6x9h2d.fsf@sulphur.joq.us>
 <20050113210750.GA22208@devserv.devel.redhat.com>
 <1105651508.3457.31.camel@krustophenia.net>
 <20050113214320.GB22208@devserv.devel.redhat.com>
 <5.2.1.1.2.20050114171907.00c05e38@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0453-1, 12/31/2004), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:14 PM 1/14/2005 -0600, Jack O'Quin wrote:
>Mike Galbraith <efault@gmx.de> writes:
>
> > At 05:31 PM 1/13/2005 -0600, Jack O'Quin wrote:
> >>Yes.  However, my tests have so far shown a need for "actual FIFO as
> >>long as the task behaves itself."
> >
> > I for one wonder why that appears to be so.  What happens if you use
> > SCHED_RR instead of SCHED_FIFO?
> >
> > (ie is the problem just one of running out of slice at a bad time, or
> > is it the dynamic priority adjustment)
>
>I have no quick and easy test for that.
>
>If it's important, I can modify a version of JACK to use SCHED_RR,
>instead.

I think the problem you're seeing is strange enough to consider trying the 
(possibly odd sounding) test.  I haven't seen an explanation of why nice 
-20 doesn't work for you.

>I very much doubt it would make any difference, since we normally only
>run one realtime thread at a time.  Each client taps the next on the
>shoulder when it is time for it to run, so there is essentially no
>concurrency among them.

It may not make any difference.  Seeing that would at least be an 
additional datapoint.  The only significant difference I see between a 
gaggle of SCHED_FIFO tasks and one of nice -20 tasks, who are alone in 
their top-of-the-heap queue, and who are not cpu hogs, is the timeslice.  I 
don't recall there being any wakeup/preempt logic differences, ergo the 
SCHED_RR suggestion.

         -Mike 


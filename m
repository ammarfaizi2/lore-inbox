Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVAOXsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVAOXsh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 18:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVAOXsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 18:48:37 -0500
Received: from mail.joq.us ([67.65.12.105]:65410 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262368AbVAOXri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 18:47:38 -0500
To: Mike Galbraith <efault@gmx.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Chris Wright <chrisw@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       Matt Mackall <mpm@selenic.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
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
	<5.2.1.1.2.20050115080420.00bf2c90@pop.gmx.net>
From: "Jack O'Quin" <joq@io.com>
Date: Sat, 15 Jan 2005 17:48:20 -0600
In-Reply-To: <5.2.1.1.2.20050115080420.00bf2c90@pop.gmx.net> (Mike
 Galbraith's message of "Sat, 15 Jan 2005 09:06:14 +0100")
Message-ID: <87r7kmtfsr.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> writes:

> At 07:14 PM 1/14/2005 -0600, Jack O'Quin wrote:
>>Mike Galbraith <efault@gmx.de> writes:
>>
>> > At 05:31 PM 1/13/2005 -0600, Jack O'Quin wrote:
>> >>Yes.  However, my tests have so far shown a need for "actual FIFO as
>> >>long as the task behaves itself."
>> >
>> > I for one wonder why that appears to be so.  What happens if you use
>> > SCHED_RR instead of SCHED_FIFO?
>> >
>> > (ie is the problem just one of running out of slice at a bad time, or
>> > is it the dynamic priority adjustment)
>>
>>I have no quick and easy test for that.
>>
>>If it's important, I can modify a version of JACK to use SCHED_RR,
>>instead.
>
> I think the problem you're seeing is strange enough to consider trying
> the (possibly odd sounding) test.  I haven't seen an explanation of
> why nice -20 doesn't work for you.

The simplest explanation that makes any sense to me is that the
non-realtime threads are interfering with the realtime ones.  These
threads don't do much in this test, although they would in a real
audio application.  Still, there are enough things going on before and
after the sleep() in the main thread to possibly generate the number
of xruns we're seeing.

This is why I don't think nice is an appropriate solution for the
problem we're trying to solve.  It's too blunt an instrument for audio
work.

>>I very much doubt it would make any difference, since we normally only
>>run one realtime thread at a time.  Each client taps the next on the
>>shoulder when it is time for it to run, so there is essentially no
>>concurrency among them.
>
> It may not make any difference.  Seeing that would at least be an
> additional datapoint.  The only significant difference I see between a
> gaggle of SCHED_FIFO tasks and one of nice -20 tasks, who are alone in
> their top-of-the-heap queue, and who are not cpu hogs, is the
> timeslice.  I don't recall there being any wakeup/preempt logic
> differences, ergo the SCHED_RR suggestion.

I think you're missing the fact that SCHED_FIFO is per-thread while
nice() is per-process.
-- 
  joq

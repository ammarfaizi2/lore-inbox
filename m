Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVASCCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVASCCI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 21:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVASCCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 21:02:08 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49320 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261444AbVASCCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 21:02:03 -0500
Subject: Re: [ck] [PATCH][RFC] sched: Isochronous class for unprivileged
	soft rt	scheduling
From: Lee Revell <rlrevell@joe-job.com>
To: "Jack O'Quin" <joq@io.com>
Cc: hihone@bigpond.net.au, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>,
       paul@linuxaudiosystems.com
In-Reply-To: <87d5w2u2xd.fsf@sulphur.joq.us>
References: <41ED08AB.5060308@kolivas.org> <41ED2F1F.1080905@bigpond.net.au>
	 <87d5w2u2xd.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 21:02:01 -0500
Message-Id: <1106100122.30792.23.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-18 at 10:17 -0600, Jack O'Quin wrote:
> Cal <hihone@bigpond.net.au> writes:
> 
> > There's a collection of test summaries from jack_test3.2 runs at
> > <http://www.graggrag.com/ck-tests/ck-tests-0501182249.txt>
> >
> > Tests were run with iso_cpu at 70, 90, 99, 100, each test was run
> > twice. The discrepancies between consecutive runs (with same
> > parameters) is puzzling.  Also recorded were tests with SCHED_FIFO and
> > SCHED_RR.
> 
> It's probably suffering from some of the same problems of thread
> granularity we saw running nice --20.  It looks like you used
> schedtool to start jackd.  IIUC, that will cause all jackd processes
> to run in the specified scheduling class.  JACK is carefully written
> not to do that.  Did you also use schedtool to start all the clients?
> 
> I think your puzzling discrepancies are probably due to interference
> from non-realtime JACK threads running at elevated priority.

Isn't this going to be a showstopper?  If I understand the scheduler
correctly, a nice -20 task is not guaranteed to preempt a nice -19 task,
if the scheduler decides that one is more CPU bound than the other and
lowers its dynamic priority.  The design of JACK, however, requires the
higher priority threads to *always* preempt the lower ones.

Lee


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbVKBAdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbVKBAdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbVKBAdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:33:03 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:3465 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S1751481AbVKBAdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:33:02 -0500
Date: Wed, 2 Nov 2005 01:32:58 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Carlos Antunes <cmantunes@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime-preempt performs worse for many threads?
In-Reply-To: <cb2ad8b50511011629g3e5c4b41t82c1763b029acae2@mail.gmail.com>
Message-Id: <Pine.OSF.4.05.10511020130510.3269-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Nov 2005, Carlos Antunes wrote:

> On 11/1/05, Carlos Antunes <cmantunes@gmail.com> wrote:
> > On 11/1/05, Esben Nielsen <simlo@phys.au.dk> wrote:
> > > On Tue, 1 Nov 2005, Carlos Antunes wrote:
> > >
> > > > Hi!
> > > >
> > > > I've been developing some code for the OpenPBX project
> > > > (http://www.openpbx.org) and wrote a program to test how the system,
> > > > responds when hundreds of threads are spawned. These threads run at
> > > > high priority (SCHED_FIFO) and use clock_nanocleep with absolute
> > > > timeouts on a 20ms loop cycle.
> > > >
> > > > With the stock 2.6.14 kernel, I get latencies in the order of several
> > > > milliseconds (but less than 20ms) when running 1250 threads
> > > > simultaneously. However, when I switch to a kernel patched with
> > > > realtime-preempt latency increases to several hundred milliseconds in
> > > > many cases.
> > >
> > > There is only one explanation:
> > > Some of the operations (task switch, nanosleep etc.) are more expensive in
> > > the RT kernel. Thus your 1250 threads spend 100% CPU doing what they do.
> > > You therefore get very bad latencies.
> > >
> >
> > Esben,
> >
> > Thanks for replying. Let me chalenge this assumption of yours, though.
> >
> > I just ran a test with those 1250 threads (all they do is sleep for
> > 20ms, wake up, increment a number, and repeat the process). The CPU
> > was 86% *IDLE* while running this. One thread took 1.3 seconds to wake
> > up once. Do you think this is, well, normal, given how RT is supposed
> > to operate?
> >
> 
> Esben,
> 
> If, instead of SCHD_FIFO, I use SCHED_OTHER, I get max latency in the
> order 13ms running those 1250 threads. With SCHED_FIFO (the only
> change), I get 1.3 seconds. Makes sense to you?
> 

No. I can't explain that one. You might have discovered a bug in
SCHED_FIFO. What about SCHED_RR?

Esben

> Thanks!
> 
> Carlos
> 
> --
> "We hold [...] that all men are created equal; that they are
> endowed [...] with certain inalienable rights; that among
> these are life, liberty, and the pursuit of happiness"
>         -- Thomas Jefferson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


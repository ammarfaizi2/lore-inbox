Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbUCALxo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 06:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbUCALxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 06:53:44 -0500
Received: from mail008.syd.optusnet.com.au ([211.29.132.212]:59026 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261227AbUCALxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 06:53:24 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] SMT Nice 2.6.4-rc1-mm1
Date: Mon, 1 Mar 2004 22:53:03 +1100
User-Agent: KMail/1.6
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200403011752.56600.kernel@kolivas.org> <4043205C.7050109@cyberone.com.au> <200403012240.34535.kernel@kolivas.org>
In-Reply-To: <200403012240.34535.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403012253.03363.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004 10:40 pm, Con Kolivas wrote:
> On Mon, 1 Mar 2004 10:37 pm, Nick Piggin wrote:
> > Con Kolivas wrote:
> > >On Mon, 1 Mar 2004 05:52 pm, Con Kolivas wrote:
> > >>This patch provides full per-package priority support for SMT
> > >> processors (aka pentium4 hyperthreading) when combined with
> > >> CONFIG_SCHED_SMT.
> > >
> > >And here are some benchmarks to demonstrate what happens.
> > >P4 3.06Ghz booted with bios HT off as UP (up), SMP with mm1(mm1), SMP
> > > with mm1-smtnice(sn)
> >
> > Pretty impressive numbers.
> >
> > How does it go on the desktop when running mprime at nice +19?
> > How much worse can latencies of the niced tasks become? Any idea?
>
> Worst case scenario is easy to model; if a nice -19 task starts at exactly
> the same time as a nice +19 task, the timeslices are 200 and 10ms. On
> uniprocessor the nice+19 task will wait _at least_ 200 ms. On SMT nice SMP
> it will be 200 - (200 * 15 / 100) so 170ms. That is of course worst case
> scenario and still better than UP since the latency will be less, the task
> will definitely start (interactive reinsertion wont affect it) and it will
> be on a second runqueue.

Ok if you're having trouble with working that out it's because it's wrong 
goddamn it. It's when the timeslice of the high priority task drops to 10 * 
100 / 85 so when it drops to 12ms. ie 188 ms latency.

Con

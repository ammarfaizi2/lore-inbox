Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265669AbUATTqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265686AbUATTqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:46:13 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:31367 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265669AbUATTqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:46:08 -0500
Date: Tue, 20 Jan 2004 11:45:51 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Busy-wait delay in qmail 1.03 after upgrading to Linux 2.6
Message-ID: <20040120194551.GG23765@srv-lnx2600.matchmail.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040120021353.39e9155e.akpm@osdl.org> <400D746D.7030409@colorfullife.com> <20040120192216.GA7685@s.chello.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120192216.GA7685@s.chello.no>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 08:22:16PM +0100, Haakon Riiser wrote:
> [Manfred Spraul]
> > If a thread switch happens in the indicated line, then the reader will 
> > loop, until it's timeslice expires - one full timeslice delay between 
> > the two gettimeofday() calls.
> 
> Exactly.  But on 2.6, the delay between the two gettimeofday()
> calls are sometimes up to 300 ms, which is 300 timeslices in
> 2.6, right?  I have never observed more than _one_ timeslice
> delay in 2.4.
> 
> > Running the reader with nice -20 resulted in delays of 200-1000 ms for 
> > each write call, nice 20 resulted in no slow calls. In both cases 100% 
> > cpu load.
> 
> But when the listener and the writer have the same nice value,
> how is it possible to have a delay of 300 ms?  Both the writer
> and the listener are ready to run, so wouldn't a 300 ms delay
> mean that the listener was given the CPU 300 times in a row?

The scheduler can do this for you with its priority modification heuristics.

Try running a test with Nick's scheduler, and see how much your timings
change.

Also, there is a scheduling patch in -mm that's not in 2.6.1 that might
affect you also.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbSKSPD0>; Tue, 19 Nov 2002 10:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSKSPD0>; Tue, 19 Nov 2002 10:03:26 -0500
Received: from ns.suse.de ([213.95.15.193]:4112 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265424AbSKSPDZ>;
	Tue, 19 Nov 2002 10:03:25 -0500
Date: Tue, 19 Nov 2002 16:10:28 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>
Cc: Paul Larson <plars@linuxtestproject.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [LTP] Re: LTP - gettimeofday02 FAIL
Message-ID: <20021119151028.GA13979@wotan.suse.de>
References: <200211190127.gAJ1RWg11023@linux.local.suse.lists.linux.kernel> <1037713044.24031.15.camel@plars.suse.lists.linux.kernel> <p73adk5vdra.fsf@oldwotan.suse.de> <1037719651.12118.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037719651.12118.7.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 03:27:31PM +0000, Alan Cox wrote:
> On Tue, 2002-11-19 at 14:24, Andi Kleen wrote:
> > It is very hard to solve properly and efficiently. When you search the
> > list archives you will find long threads about the problem
> > (search for "TSC" and gettimeofday and perhaps HPET or cyclone). Last one 
> > was one or two weeks ago.
> > 
> > The problem has been there always in some way in linux, now it is just
> > exposed in LTP because it tests for it.
> 
> Dual ppro boxes normally run with a locked synchronous TSC clock. That
> suggests the newer code broke stuff. It may also be due to the bug in

It is because of the HZ=1000. See Jim Houston's mail on the same topic,
he analyzed the failure.

Basically the current code cannot handle missing ticks properly on SMP and with
the new 1ms tick it is much more likely that a timer interrupt gets lost.

-Andi

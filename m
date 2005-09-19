Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932641AbVISWu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbVISWu5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbVISWu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:50:57 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:51105 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932641AbVISWu4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:50:56 -0400
Subject: Re: [ANNOUNCE] ktimers subsystem
From: john stultz <johnstul@us.ibm.com>
To: tglx@linutronix.de
Cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, paulmck@us.ibm.com
In-Reply-To: <1127169849.24044.279.camel@tglx.tec.linutronix.de>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com>
	 <1127168232.24044.265.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.62.0509191521400.27238@schroedinger.engr.sgi.com>
	 <1127169849.24044.279.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 15:50:52 -0700
Message-Id: <1127170253.3455.236.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-20 at 00:44 +0200, Thomas Gleixner wrote:
> On Mon, 2005-09-19 at 15:24 -0700, Christoph Lameter wrote:
> 
> > > We should rather ask glibc people why gettimeofday() / clock_getttime()
> > > is called inside the library code all over the place for non obvious
> > > reasons.
> > 
> > You can ask lots of application vendors the same question because its all 
> > over lots of user space code. The fact is that gettimeofday() / 
> > clock_gettime() efficiency is very critical to the performance of many 
> > applications on Linux. That is why the addtion of one add instruction may 
> > better be carefully considered. 
> 
> Hmm. I don't understand the argument line completely. 
> 
> 1. The kernel has to provide ugly mechanisms because a lot of
> applications implementations are doing the Wrong Thing ?
> 
> 2. All gettimeofday implementations I have looked at do a lot of math
> anyway, so its definitely more interesting to look at those oddities
> rather than discussing a single add. John Stulz timeofday rework have a
> clean solution for this - please do not argue about the div64 in his
> original patches which he is reworking at the moment.

The simplest solution is to keep wall-time maintained in a timespec as
well as the nsec_t based system_time/wall_time_offset combo. This avoids
the extra add in the hotpath, and only costs an extra add at interrupt
time.

I'll have an updated patch that includes some of Roman's suggestions
from earlier soon.

> > Many platforms can execute gettimeofday 
> > without having to enter the kernel.
> 
> Which ones ? How is this achieved with respect to all the time adjust,
> correction... code ?

Many arches have userspace gtod implementations (x86-64, ppc64, and ia64
as well). Although my timeofday code allows for this as well (I had it
working for x86-64 awhile back). 

thanks
-john



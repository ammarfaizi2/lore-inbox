Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbVLTOET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbVLTOET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 09:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbVLTOET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 09:04:19 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:26805 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751029AbVLTOET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 09:04:19 -0500
Date: Tue, 20 Dec 2005 09:04:05 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.15-rc5-rt2 slowness
In-Reply-To: <20051220135725.GA29392@elte.hu>
Message-ID: <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
References: <dnu8ku$ie4$1@sea.gmane.org> <1134790400.13138.160.camel@localhost.localdomain>
 <1134860251.13138.193.camel@localhost.localdomain> <20051220133230.GC24408@elte.hu>
 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com> <20051220135725.GA29392@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Ingo Molnar wrote:
>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > > Now, is the solution to bring the SLOB up to par with the SLAB, or to
> > > > make the SLAB as close to possible to the mainline (why remove NUMA?)
> > > > and keep it for PREEMPT_RT?
> > > >
> > > > Below is the port of the slab changes if anyone else would like to see
> > > > if this speeds things up for them.
> > >
> > > ok, i've added this back in - but we really need a cleaner port of SLAB
> > > ...
> > >
> >
> > Actually, how much do you want that SLOB code?  For the last couple of
> > days I've been working on different approaches that can speed it up.
> > Right now I have one that takes advantage of the different caches.
> > But unfortunately, I'm dealing with a bad pointer some where that
> > keeps making it bug. Argh!
>
> well, the SLOB is mainly about being simple and small. So as long as
> those speedups are SMP-only, they ought to be fine. The problems are
> mainly SMP related, correct?

Actually, no.  My test is to do a make install over NFS of a kernel that
has already been built.

The times I'm getting for the SLAB is ~26 seconds, the time for the SLOB
is 1 minute 32 seconds.  So your looking at >300% slowness here.  The test
bed is a UP.  (I do that first before looking into SMP).

I'm still trying to keep the SLOB simple.  It's the lack of sleep that is
making it hard ;)

-- Steve


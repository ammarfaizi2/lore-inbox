Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbVLTWM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVLTWM5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVLTWM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:12:57 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:51173 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932080AbVLTWM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:12:56 -0500
Subject: Re: [PATCH RT 00/02] SLOB optimizations
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0512201346550.20807@graphe.net>
References: <dnu8ku$ie4$1@sea.gmane.org>
	 <1134790400.13138.160.camel@localhost.localdomain>
	 <1134860251.13138.193.camel@localhost.localdomain>
	 <20051220133230.GC24408@elte.hu>
	 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
	 <20051220135725.GA29392@elte.hu>
	 <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
	 <1135093460.13138.302.camel@localhost.localdomain>
	 <20051220181921.GF3356@waste.org>
	 <1135106124.13138.339.camel@localhost.localdomain>
	 <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com>
	 <1135114971.13138.396.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0512201346550.20807@graphe.net>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 17:11:55 -0500
Message-Id: <1135116715.13138.409.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 13:52 -0800, Christoph Lameter wrote:
> On Tue, 20 Dec 2005, Steven Rostedt wrote:
> 
> > What other interest have you pulled up on this?  I mean, have others
> > shown interest in pushing something like this.  Today's slab system is
> > starting to become like the IDE where nobody, but a select few
> > sado-masochis, dare to venture in. (I've CC'd them ;)  Perhaps it would
> > make the addition of NUMA easier.
> 
> Hmm. The basics of the SLAB allocator are rather simple. 
> 
> I'd be interested in seeing an alternate approach. There is the danger
> that you will end up end up with the same complexity as before.

True.  I understand the basics of the SLAB allocator very well, but I
stumble over the slab.c code quite a bit.  This topic came up when Ingo
replaced slab with slob in the rt patch and it killed the performance.
I introduced a cross between the slab and the slob that sped up the
system almost to that of the current slab.

Matt Mackall needs a memory management that uses the smallest amount of
memory to handle embedded systems, and brought up the approach
referenced in the paper by Bonwick.

> 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=113510997009883&w=2
> 
> Quite a long list of unsupported features. These academic papers
> usually only focus on one thing. The SLAB allocator has to work
> for a variety of situations though.
> 
> It would help to explain what ultimately will be better in the new slab 
> allocator. The complexity could be taken care of by reorganizing the code.
> 

Honestly, what I would like is a simpler solution, whether we go with a
new approach or reorganize the current slab.  I need to get -rt working,
and the code in slab is pulling my resources more than they can extend.
I'm capable to convert slab today as it is for RT but it will probably
take longer than I can afford.

Yes, if we go with a new system, it would not have all the features that
the slab has today, but I can live with that, and if I'm involved in the
work as it grows, I'll understand it better.  The problem is, I wasn't
involved in the evolution of slab, and I have to deal with what it grew
into, without being there to see why it does what it does today.

-- Steve



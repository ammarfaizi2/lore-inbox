Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTLPR5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 12:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTLPR5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 12:57:55 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57354 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262030AbTLPR5s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 12:57:48 -0500
Date: Tue, 16 Dec 2003 12:46:08 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: [CFT][RFC] HT scheduler
In-Reply-To: <3FDC3023.9030708@cyberone.com.au>
Message-ID: <Pine.LNX.3.96.1031216123911.32602D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Dec 2003, Nick Piggin wrote:

> 
> 
> Jamie Lokier wrote:
> 
> >Nick Piggin wrote:
> >
> >>>Shared runqueues sound like a simplification to describe execution units
> >>>which have shared resourses and null cost of changing units. You can do
> >>>that by having a domain which behaved like that, but a shared runqueue
> >>>sounds better because it would eliminate the cost of even considering
> >>>moving a process from one sibling to another.
> >>>
> >>You are correct, however it would be a miniscule cost advantage,
> >>possibly outweighed by the shared lock, and overhead of more
> >>changing of CPUs (I'm sure there would be some cost).
> >>
> >
> >Regarding the overhead of the shared runqueue lock:
> >
> >Is the "lock" prefix actually required for locking between x86
> >siblings which share the same L1 cache?
> >
> 
> That lock is still taken by other CPUs as well for eg. wakeups, balancing,
> and so forth. I guess it could be a very specific optimisation for
> spinlocks in general if there was only one HT core. Don't know if it
> would be worthwhile though.

Well, if you're going to generalize the model, I would think that you
would want some form of local locking within each level, so you don't do
excess locking in NUMA config. It might be that you specify a lock and
lock type for each level, and the type of lock for shared L1 cache
siblings could be NONE.

I'm not sure what kind of generalized model you have in mind for the
future, so I may be totally off in the weeds, but I would assume that a
lock would ideally have some form of locality. In the came socket, on the
same board, on the same backplane, same rack, same room, same planet,
whatever.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


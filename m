Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTLPRqD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 12:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTLPRqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 12:46:03 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54026 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261974AbTLPRp5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 12:45:57 -0500
Date: Tue, 16 Dec 2003 12:34:17 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][RFC] HT scheduler
In-Reply-To: <3FDBC876.3020603@cyberone.com.au>
Message-ID: <Pine.LNX.3.96.1031216122208.32602C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Dec 2003, Nick Piggin wrote:

> 
> 
> bill davidsen wrote:
> 
> >In article <3FDAB517.4000309@cyberone.com.au>,
> >Nick Piggin  <piggin@cyberone.com.au> wrote:

> >Shared runqueues sound like a simplification to describe execution units
> >which have shared resourses and null cost of changing units. You can do
> >that by having a domain which behaved like that, but a shared runqueue
> >sounds better because it would eliminate the cost of even considering
> >moving a process from one sibling to another.
> >
> 
> You are correct, however it would be a miniscule cost advantage,
> possibly outweighed by the shared lock, and overhead of more
> changing of CPUs (I'm sure there would be some cost).


> >| But if sched domains are accepted, there is no need for shared runqueues,
> >| because as I said they can do anything sched domains can, so the code would
> >| just be a redundant specialisation - unless you specifically wanted to share
> >| locks & data with siblings.
> >
> >I doubt the gain would be worth the complexity, but what do I know?
> >
> 
> Sorry I didn't follow, gain and complexity of what?

Doing without shared runqueues is what I meant. A single runqueue appears
to avoid having to move processes between runqueues, or considering
*where* to move a process.

> 
> Earlier in the thread Ingo thought my approach is simpler. code size is the
> same size, object size for my patch is significantly smaller, and it does
> more. Benchmarks have so far shown that my patch is as performant as shared
> runqueues.

If Ingo is happy, I am happy. I find shared runqueues very easy to
understand as a way to send tasks to a single HT chip, which is the only
case which comes to mind in which a CPU change is free. Clearly it isn't
going to apply to CPUs which don't share cache and behave more like
individual packages.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


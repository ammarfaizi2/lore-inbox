Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288553AbSANBWu>; Sun, 13 Jan 2002 20:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSANBWk>; Sun, 13 Jan 2002 20:22:40 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36359 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S288553AbSANBWY>; Sun, 13 Jan 2002 20:22:24 -0500
Date: Sun, 13 Jan 2002 20:22:16 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <1010524653.3225.109.camel@phantasy>
Message-ID: <Pine.LNX.3.96.1020113201316.17441K-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Robert Love wrote:

> On Tue, 2002-01-08 at 15:59, Daniel Phillips wrote:
> 
> > And while I'm enumerating differences, the preemptable kernel (in this 
> > incarnation) has a slight per-spinlock cost, while the non-preemptable kernel 
> > has the fixed cost of checking for rescheduling, at intervals throughout all 
> > 'interesting' kernel code, essentially all long-running loops.  But by clever 
> > coding it's possible to finesse away almost all the overhead of those loop 
> > checks, so in the end, the non-preemptible low-latency patch has a slight 
> > efficiency advantage here, with emphasis on 'slight'.
> 
> True (re spinlock weight in preemptible kernel) but how is that not
> comparable to explicit scheduling points?  Worse, the preempt-kernel
> typically does its preemption on a branch on return to interrupt
> (similar to user space's preemption).  What better time to check and
> reschedule if needed?

I'm not sure that preempt and low latency really are attacking the same
problem. What I am finding is the LL improves overall performance when a
process does something which is physically slow, like a find in a
directory with 20k files. On the other hand PK makes the response of the
system better to changes. In particular I see the DNS servers which have
other work running, even backups or reports, are more responsive with PK,
as are usenet news servers. I find it hard to measure "feels faster" with
either approach, although like the supreme court "I know it when I see
it."

I'd like to hope that some of each will get in the main kernel, PK has
been stable for me for a while, LL has never been unstable but I've run it
less.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


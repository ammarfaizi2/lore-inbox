Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268364AbTBWRSR>; Sun, 23 Feb 2003 12:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268410AbTBWRSR>; Sun, 23 Feb 2003 12:18:17 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48962 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S268364AbTBWRSQ>; Sun, 23 Feb 2003 12:18:16 -0500
To: Rik van Riel <riel@imladris.surriel.com>
Cc: Hanna Linder <hannal@us.ibm.com>, "" <lse-tech@lists.sourceforge.net>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
References: <96700000.1045871294@w-hlinder>
	<m1smufn7xu.fsf@frodo.biederman.org>
	<Pine.LNX.4.50L.0302231126380.2206-100000@imladris.surriel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Feb 2003 10:28:04 -0700
In-Reply-To: <Pine.LNX.4.50L.0302231126380.2206-100000@imladris.surriel.com>
Message-ID: <m1of52nbyz.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@imladris.surriel.com> writes:

> On Sat, 22 Feb 2003, Eric W. Biederman wrote:
> 
> > Note: rmap chains can be restricted to an arbitrary length, or an
> > arbitrary total count trivially. All you have to do is allow a fixed
> > limit on the number of people who can map a page simultaneously.
> >
> > The selection of which chain to unmap can be a bit tricky but is
> > relatively straight forward.  Why doesn't someone who is seeing
> > this just hack this up?
> 
> I'm not sure how useful this feature would be. 

The problem.  There is no upper bound to how many rmap
entries there can be at one time.  And the unbounded
growth can overwhelm a machine.

The goal is to provide an overall system cap on the number
of rmap entries.

> Also,
> there are a bunch of corner cases in which you cannot
> limit the number of processes mapping a page, think
> about eg. mlock, nonlinear vmas and anonymous memory.

Unless something has changed for nonlinear vmas, and anonymous
memory we have been storing enough information to recover
the page in the page tables for ages.  

For mlock we want a cap on the number of pages that are locked,
so it should not be a problem.  But even then we don't have to
guarantee the page is constantly in the processes page table, simply
that the mlocked page is never swapped out.

> All in all I suspect that the cost of such a feature
> might be higher than any benefits.

Cost?  What Cost?

The simple implementation is to walk the page lists and unmap 
the pages that are least likely to be used next.

This is not something new.  We have been doing this in 2.4.x and
before for years.  Before it just never freed up rmap entries, as well
as preparing a page to be paged out.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVCPKXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVCPKXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVCPKXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:23:41 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:3785 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262333AbVCPKXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 05:23:39 -0500
Date: Wed, 16 Mar 2005 05:23:25 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
In-Reply-To: <20050316101209.GA16893@elte.hu>
Message-ID: <Pine.LNX.4.58.0503160520250.11824@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain> <20050315120053.GA4686@elte.hu>
 <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu>
 <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain> <20050316085029.GA11414@elte.hu>
 <20050316011510.2a3bdfdb.akpm@osdl.org> <20050316095155.GA15080@elte.hu>
 <20050316020408.434cc620.akpm@osdl.org> <20050316101209.GA16893@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Mar 2005, Ingo Molnar wrote:

>
> * Andrew Morton <akpm@osdl.org> wrote:
> >
> > ooh, I'd rather not.  I spent an intense three days removing all the
> > sleeping locks from ext3 (and three months debugging the result).
> > Ended up gaining 1000% on 16-way.
> >
> > Putting them back in will really hurt the SMP performance.
>
> ah. Yeah. Sniff.
>
> if we gain 1000% on a 16-way then there's something really wrong about
> semaphores (or scheduling) though. A semaphore is almost a spinlock, in
> the uncontended case - and even under contention we really (should) just
> spend the cycles that we'd spend spinning. There will be some
> intermediate contention level where semaphores hurt, but 1000% sounds
> truly excessive.
>

Could it possibly be that in the process of removing all the sleeping
locks from ext3, that Andrew also removed a flaw in ext3 itself that is
responsible for the 1000% improvement?

-- Steve


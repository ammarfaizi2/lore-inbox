Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVGRMLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVGRMLF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 08:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVGRMLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 08:11:05 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:20196 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261375AbVGRMLD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 08:11:03 -0400
Date: Mon, 18 Jul 2005 14:10:31 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Dave Chinner <dgc@sgi.com>, greg@kroah.com,
       Nathan Scott <nathans@sgi.com>, Steve Lord <lord@xfs.org>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: RT and XFS
In-Reply-To: <20050714160835.GA19229@infradead.org>
Message-Id: <Pine.OSF.4.05.10507171848440.14250-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2005, Christoph Hellwig wrote:

> On Thu, Jul 14, 2005 at 08:56:58AM -0700, Daniel Walker wrote:
> > This reminds me of Documentation/stable_api_nonsense.txt . That no one
> > should really be dependent on a particular kernel API doing a particular
> > thing. The kernel is play dough for the kernel hacker (as it should be),
> > including kernel semaphores.
> > 
> > So we can change whatever we want, and make no excuses, as long as we
> > fix the rest of the kernel to work with our change. That seems pretty
> > sensible , because Linux should be an evolution. 
> 
> Daniel, get a fucking clue.  Read some CS 101 literature on what a semaphore
> is defined to be.  If you want PI singing dancing blinking christmas tree
> locking primites call them a mutex, but not a semaphore.
>

As a matter of fact I just finished what corresponds to your "CS 101" (I
study CS in spare time while having a full time job coding RT stuff):
To the one lecture I attended they talked about sempahores. They tought
students to use binary semphores for locking. Based on real-life
experience (and the Pathfinder story), I complained and told
them they ought to teach the students to use a mutex instead. They had no
clue "It is the same thing they said". Yes, a mutex can be implemented
just as a binary semaphore but the semantics of it is different. In RT the
difference is very important and even without-RT it is a good idea to
maintain the difference for readability and deadlock detection. If you
later on want to optimize the semaphore for what it is used for it is also
good to have maintained that information. It is a bit like discarding
the type information from you programs. You want to keep the type information 
even though the compilere end up producing the same code.

The kernel developer clearly have followed the same lectures and used
plain binary semaphores, sometimes calling the mutex sometimes semaphore.
I believe that the semaphore ought to be removed. Either use a mutex or
a completion. Far the most code is using a sempahore as either signalling 
- i.e. as a completion - or critical sections - i.e. as a mutex. If code
mixes the usage it is must likely very hard to read....

Unfortunately, one of the goals of the preempt-rt branch is to avoid
altering too much code. Therefore the type semaphore can't be removed
there. Therefore the name still lingers ... :-(

Esben




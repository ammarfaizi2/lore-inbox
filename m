Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269531AbRHHS3G>; Wed, 8 Aug 2001 14:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269532AbRHHS24>; Wed, 8 Aug 2001 14:28:56 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:436 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S269531AbRHHS2v>;
	Wed, 8 Aug 2001 14:28:51 -0400
Date: Wed, 8 Aug 2001 11:28:00 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hubertus Franke <frankeh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Scalable Scheduling
Message-ID: <20010808112800.F1088@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <Pine.LNX.4.33.0108081041260.8047-100000@penguin.transmeta.com> <Pine.LNX.4.33.0108081058420.8103-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108081058420.8103-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Aug 08, 2001 at 11:00:50AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 11:00:50AM -0700, Linus Torvalds wrote:
> 
> On Wed, 8 Aug 2001, Linus Torvalds wrote:
> >
> > The only thing that looked really ugly was that real-time runqueue
> > thing. Does it _really_ have to be done that way?

The issue here is maintaining FIFO and RR semantics for real-time
tasks.  If the real-time tasks are distributed among multiple
runqueues, maintaining these semantics can be quite difficult.  We
thought the best way to handle this would be a separate real-time
runqueue.  Granted, it is not beautiful but it was the simplest
solution that we could come up with.  We'll give it some more
thought when cleaning up the code.

> Oh, and as I didn't actually run it, I have no idea about what performance
> is really like. I assume you've done lmbench runs across wide variety (ie
> UP to SMP) of machines with and without this?

Yes we have, we'll provide those numbers with the updated patch.
One challenge will be maintaining the same level of performance
for UP as in the current code.  The current code has #ifdefs to
separate some of the UP/SMP code paths and we will try to eliminate
these.

-- 
Mike Kravetz                                 mkravetz@sequent.com

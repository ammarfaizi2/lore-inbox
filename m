Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132643AbRDUOSO>; Sat, 21 Apr 2001 10:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132642AbRDUORz>; Sat, 21 Apr 2001 10:17:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48139 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132636AbRDUORs>;
	Sat, 21 Apr 2001 10:17:48 -0400
Date: Sat, 21 Apr 2001 15:17:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "D . W . Howells" <dhowells@astarte.free-online.co.uk>,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: x86 rwsem in 2.4.4pre[234] are still buggy [was Re: rwsem benchmarks [Re: generic rwsem [Re: Alpha "process table hang"]]]
Message-ID: <20010421151737.A7576@flint.arm.linux.org.uk>
In-Reply-To: <20010420191710.A32159@athlon.random> <Pine.LNX.4.31.0104201639070.6299-100000@penguin.transmeta.com> <20010421160327.A17757@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010421160327.A17757@athlon.random>; from andrea@suse.de on Sat, Apr 21, 2001 at 04:03:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 04:03:27PM +0200, Andrea Arcangeli wrote:
> On Fri, Apr 20, 2001 at 04:45:32PM -0700, Linus Torvalds wrote:
> > I would suggest the following:
> > 
> >  - the generic semaphores should use the lock that already exists in the
> >    wait-queue as the semaphore spinlock.
> 
> Ok, that is what my generic code does.

Erm, spin_lock()?  What if up_read or up_write gets called from interrupt
context (is this allowed)?

If these are now allowed, then maybe we should either consider getting
the Stanford checker to check for this, or else we ought to do a debugging
if (in_interupt()) BUG(); thing.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


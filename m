Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbRADRiS>; Thu, 4 Jan 2001 12:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130309AbRADRiI>; Thu, 4 Jan 2001 12:38:08 -0500
Received: from dsl-206.169.4.82.wenet.com ([206.169.4.82]:58117 "EHLO
	phobos.illtel.denver.co.us") by vger.kernel.org with ESMTP
	id <S129830AbRADRht>; Thu, 4 Jan 2001 12:37:49 -0500
Date: Thu, 4 Jan 2001 09:39:45 -0800 (PST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <3A542D86.BADE2D36@innominate.de>
Message-ID: <Pine.LNX.4.20.0101040924280.18491-100000@phobos.illtel.denver.co.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Daniel Phillips wrote:

> >   A lot of applications always rely on their file i/o being done in some
> > manner that has atomic (from the application's point of view) operations
> > other than system calls -- heck, even make(1) does that.
> 
> Nobody is forcing you to hit the power switch in the middle of a build. 
> But now that you mention it, you've provided a good example of a broken
> application.  Make with its reliance on timestamps for determining build
> status is both painfully slow and unreliable.

  Actually I mean its reliance on files being deleted if the problem or
SIGTERM happened in the middle of build ing them.

>  What happens if you
> adjust your system clock?

  Don't adjust the system clock in the middle of the build. Adjusting
clock backward for more than a second is much more rare operation than a
shutdown.

>  That said, Tux2 can preserve the per-write
> atomicity quite easily, or better, make could take advantage of the new
> journal-oriented transaction api that's being cooked up and specify its
> requirement for atomicity in a precise way.

  I have already said that programs don't use syscalls as the only atomic
operations on files -- yes, it may be a good idea to add transactions API
on the top of this (and it will have a lot of uses), but then it should be
made in a way that its use will be easy to add to existing applications.

> Do you have any other examples of programs that would be hurt by sudden
> termination?  Certainly we'd consider a desktop gui broken if it failed
> to come up again just because you bailed out with the power switch
> instead of logging out nicely.

  Any application that writes multiple times over the same files and has
any data consistency requirements beyond the piece of data in the chunk
sent in one write().

-- 
Alex

----------------------------------------------------------------------
 Excellent.. now give users the option to cut your hair you hippie!
                                                  -- Anonymous Coward

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

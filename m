Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317427AbSFRObW>; Tue, 18 Jun 2002 10:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317429AbSFRObV>; Tue, 18 Jun 2002 10:31:21 -0400
Received: from waste.org ([209.173.204.2]:29569 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317427AbSFRObV>;
	Tue, 18 Jun 2002 10:31:21 -0400
Date: Tue, 18 Jun 2002 09:30:27 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@zip.com.au>
cc: Russell King <rmk@arm.linux.org.uk>,
       Martin Dalecki <dalecki@evision-ventures.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/19] writeback tunables
In-Reply-To: <3D0E52DD.4CE57058@zip.com.au>
Message-ID: <Pine.LNX.4.44.0206180921030.26335-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Andrew Morton wrote:

> Russell King wrote:
> >
> > On Mon, Jun 17, 2002 at 12:33:18PM +0200, Martin Dalecki wrote:
> > ...
> > > > +int dirty_expire_centisecs = 30 * 100;
> > > > +
> > >
> > > Blind guess - didn't the 100 wan't to be HZ?!
> >
> > The units are centiseconds (as the name suggests). 5 * 100 centiseconds = 5
> > seconds, so the dirty writeback timeout is 5 seconds.  Check the code a
> > little further and you'll see HZ gets factored into them on use.
> >
>
> Yup.  Sorry about the "_centisecs" thing.  That's a bit anal, but
> I tend to think that it's best to be really explicit about the
> units, make it a bit easier to use.  I don't know how many times
> I've had to peer in fs/buffer.c to remember what those dang numbers do.
>
> Possibly, "seconds" may be sufficiently high resolution for
> these things.  But I wasn't sure - maybe someone wants to
> run the kupdate function five times per second?  Dunno.

Possibly, we should just concede that anywhere where we're measuring time,
we'll eventually want to use a non-integer external representation just so
we're not building in obsolescense. With a couple simple wrappers like
atoif(".667",HZ)=67, this could be pretty painless.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


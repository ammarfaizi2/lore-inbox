Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261835AbRE2KzO>; Tue, 29 May 2001 06:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbRE2KzF>; Tue, 29 May 2001 06:55:05 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:29710 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261759AbRE2Kyu>; Tue, 29 May 2001 06:54:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Date: Tue, 29 May 2001 12:54:18 +0200
X-Mailer: KMail [version 1.2]
Cc: Edgar Toernig <froese@gmx.de>, Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <200105280126.f4S1QmFM017170@sleipnir.valparaiso.cl>
In-Reply-To: <200105280126.f4S1QmFM017170@sleipnir.valparaiso.cl>
MIME-Version: 1.0
Message-Id: <01052912541919.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 May 2001 03:26, Horst von Brand wrote:
> Daniel Phillips <phillips@bonn-fries.net> said:
> > On Sunday 27 May 2001 15:32, Edgar Toernig wrote:
>
> [...]
>
> > > you break UNIX fundamentals.  But I'm quite relieved now because
> > > I'm pretty sure that something like that will never go into the
> > > kernel.
> >
> > OK, I'll take that as "I couldn't find a piece of code that breaks,
> > so it's on to the legal issues".
>
> It boggles my (perhaps underdeveloped) mind to have things that are
> files _and_ directories at the same time.

They are not, the device file and the directory are different objects 
that have the same name.  In C, "foo" and "struct foo" can appear in 
the same scope but they are different objects.  This must have seemed 
to be a strange idea at first.  Here we have "foo" (a device) and 
"directory foo" (the device's properties).

When I first saw Linus mention the idea I did a double-take, I thought 
it was a strange idea and my first reaction was, it would break all 
kinds of things.  But when I started examining cases I was unable to 
find any real problems.  When I asked code examples of breakage none of 
the supplied examples survived scrutiny.  Then, when I looked through 
SUS I didn't find any prohibition.

> The last time this was
> discussed was for handling forks (a la Mac et al) in files, and it
> was shot down.

Do you have the subject line?  It might save us some time ;-)

I seem to recall that the fork idea died because it was thought to 
require changes to userspace programs such as tar and find.  The 
magicdev idea doesn't require such changes, none that I've seen so far.

> > SUS doesn't seem to have a lot to say about this.  The nearest
> > thing to a ruling I found was "The special filename dot refers to
> > the directory specified by its predecessor".  Which is not the same
> > thing as:
> >
> >    open("foo", O_RDONLY) == open ("foo/.", O_RDONLY)
>
> It says "foo" and "foo/." are the same _directory_, where "foo" is a
> directory as otherwise "foo/<something>" makes no sense, AFAICS. Is
> there any mention on a _file_ "bar" and going "bar/" or
> "bar/<something>"?

In SUS I didn't find anything, one way or the other.  I don't know 
about POSIX.

--
Daniel


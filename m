Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273539AbRIQIi6>; Mon, 17 Sep 2001 04:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273540AbRIQIis>; Mon, 17 Sep 2001 04:38:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10488 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273539AbRIQIih>;
	Mon, 17 Sep 2001 04:38:37 -0400
Date: Mon, 17 Sep 2001 04:38:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Aaron Lehmann <aaronl@vitelus.com>
cc: Ville Herva <vherva@mail.niksula.cs.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: Forced umount (was lazy umount)
In-Reply-To: <20010917000325.A25189@vitelus.com>
Message-ID: <Pine.GSO.4.21.0109170416340.20053-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Sep 2001, Aaron Lehmann wrote:

> On Mon, Sep 17, 2001 at 09:57:47AM +0300, Ville Herva wrote:
> > > Basically, I want a 'kill -KILL' for filesystems.
> > 
> > This gets my vote too...
> 
> <aol>Me too</aol>


Look at it that way: we have two actions that need to be done upon umount.
	1) detach it from the mountpoint(s)
	2) shut it down

For the latter we need to have no active IO on that fs _and_ nothing
that could initiate such IO.  We can separate #1 and #2, letting fs
shutdown happen when it's no longer busy.  That's what MNT_DETACH
does.

What you are asking for is different - you want fs-wide revoke().
That's all nice and dandy, but it's an independent problem and it
will take a _lot_ of work.  Including work in fs drivers.  It _is_
worth doing, but it's 2.5 stuff (along with normal revoke(2)).

IMNSHO we really should separate the stuff acting on mount tree from
the stuff acting on filesystems.  A lot of confusion comes from the
places where we don't do that - see the "per-mountpoint read-only"
thread couple of weeks ago for other examples.


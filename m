Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267830AbRGRFSQ>; Wed, 18 Jul 2001 01:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267831AbRGRFSG>; Wed, 18 Jul 2001 01:18:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:10503 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267830AbRGRFSA>; Wed, 18 Jul 2001 01:18:00 -0400
Date: Wed, 18 Jul 2001 00:46:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.33.0107172152300.1437-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0107180027120.8023-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Jul 2001, Linus Torvalds wrote:

> 
> On Tue, 17 Jul 2001, Marcelo Tosatti wrote:
> >
> > > A single-zone parameter just looks fundamentally broken.
> >
> > The "zone" parameter passed to swap_out() means "don't unmap pte's mapping
> > to pages belonging to not-under-shortage zones". It can (and it should) be
> > replaced by a "zone_specific" parameter.
> 
> Ahh.
> 
> In fact, it should be replaced by a single bit.
> 
> Passing in a "zone *" and then using it purely as a boolean makes no
> sense.

Right.

> But that still makes me ask: why do you have that (misnamed, and
> mis-typed) boolean there in the first place?

Because I thought about doing something like:

	/* Avoid touching pages from zones which
         * are not from the zone being scanned
	 */
	if (page->zone != zone)
		return;

But then I figured out that its stupid.

I ended up using the "zone_t *zone" as a boolean and forgot to change it
before sending the patch.

> Why not just unconditionally have the "zone_shortage(page->zone)"?

Because I tried to avoid strict perzone shortage handling, keeping the
global scanning to have _some_ "fair" aging between the zones.

The active/inactive dirty lists are shared by all zones, and page position
there is a method of page age indication.

So in most cases we are "fair" wrt list position and do global scanning.
Now if there is a real need, we do perzone scanning.

Comments? 


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262774AbREOPNc>; Tue, 15 May 2001 11:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262775AbREOPNW>; Tue, 15 May 2001 11:13:22 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:21510 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262774AbREOPNH>;
	Tue, 15 May 2001 11:13:07 -0400
Date: Tue, 15 May 2001 12:12:47 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap.c fixes
In-Reply-To: <Pine.LNX.4.21.0105142342040.23955-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105151210070.4671-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001, Linus Torvalds wrote:

> > > > +	if (PageActive(page))
> > > > +		SetPageReferenced(page);
> > > > +	else
> > > > +		activate_page(page);

> Now, please explain to me why it's not just a simple
> 
> 	SetPageReferenced(page);
> 
> and then just moving it lazily from one queue to another..

This might get us into problems when we think we have enough
inactive pages to take the next load spike, but we don't.

On the other hand, that's a theoretical situation and I don't
think we'll hit that in practice ... at least, not in workloads
we'd be able to deal nicely with in any way.

Just going with the simple version should work.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


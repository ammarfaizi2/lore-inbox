Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946429AbWJ0Lia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946429AbWJ0Lia (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946438AbWJ0Lia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:38:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10126 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1946436AbWJ0LiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:38:05 -0400
Date: Fri, 27 Oct 2006 13:37:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
Message-ID: <20061027113740.GB9729@elf.ucw.cz>
References: <20061024213402.GC5662@elf.ucw.cz> <1161728153.22729.22.camel@nigel.suspend2.net> <20061024221950.GB5851@elf.ucw.cz> <1161729027.22729.37.camel@nigel.suspend2.net> <20061025081135.GM5851@elf.ucw.cz> <1161764907.22729.86.camel@nigel.suspend2.net> <20061025084226.GN5851@elf.ucw.cz> <1161766865.22729.96.camel@nigel.suspend2.net> <20061025091022.GB7266@elf.ucw.cz> <1161770750.22729.117.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161770750.22729.117.camel@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > > And now, can you do same computation assuming the swap allocator goes
> > > > > > completely crazy, and free space is in 1-page chunks?
> > > > > 
> > > > > The worst case is 3 * sizeof(unsigned long) *
> > > > > number_of_swap_extents_allocated bytes.
> > > > 
> > > > Okay, so if we got 4GB of swap space, thats 1MB swap pages, worst case
> > > > is you have one extent per page, on x86-64 that's 24MB. +kmalloc
> > > > overhead, I assume?
> > > 
> > > Sounds right.
> > 
> > Ok, 24-50MB per 4GB of swap space is not _that_ bad...
> 
> Other way round: 12MB for x86, 24 for x86_64 is the worst case.
> Actually, come to think of it, that would be for 8GB of swap space. The
> worst case would require every page of swap to be alternately free and
> allocated, so for 4GB you'd only have 2GB of swap allocated = 1/2 the
> number of extents and half the memory requirements.

Ok, I was trying to do the ballpark estimate.

> > > You're not going to respond to the other bit of my reply? I was
> > > beginning to think you were being more reasonable this time. Oh well.
> > 
> > Rafael likes your code, and that's a big plus, but do you have to
> > insult me?!
> 
> Pavel, I never seek to insult you and I'm sorry that you felt insulted
> by my comment. In this case, I was expressing frustration at the fact
> that you seemed to be (in my opinion anyway) being unreasonable in
> completely ignoring and deleting my points about the likelihood of this
> worse case scenario, and instead focusing on calculating the

Well, deleting the points meant I mostly agree with them. But knowing
how bad worst case is is still interesting (I do not think future swap
allocator may not suddenly start making lots of small holes, or
something). Anyway, that patch is probably okay...

> How about if we just call it quits and try to be nice to each other?

Quits.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

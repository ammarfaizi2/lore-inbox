Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423186AbWJYKFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423186AbWJYKFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 06:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423183AbWJYKFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 06:05:52 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:33229 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1423186AbWJYKFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 06:05:51 -0400
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061025091022.GB7266@elf.ucw.cz>
References: <1161576857.3466.9.camel@nigel.suspend2.net>
	 <200610242208.34426.rjw@sisk.pl> <20061024213402.GC5662@elf.ucw.cz>
	 <1161728153.22729.22.camel@nigel.suspend2.net>
	 <20061024221950.GB5851@elf.ucw.cz>
	 <1161729027.22729.37.camel@nigel.suspend2.net>
	 <20061025081135.GM5851@elf.ucw.cz>
	 <1161764907.22729.86.camel@nigel.suspend2.net>
	 <20061025084226.GN5851@elf.ucw.cz>
	 <1161766865.22729.96.camel@nigel.suspend2.net>
	 <20061025091022.GB7266@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 20:05:50 +1000
Message-Id: <1161770750.22729.117.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2006-10-25 at 11:10 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > And now, can you do same computation assuming the swap allocator goes
> > > > > completely crazy, and free space is in 1-page chunks?
> > > > 
> > > > The worst case is 3 * sizeof(unsigned long) *
> > > > number_of_swap_extents_allocated bytes.
> > > 
> > > Okay, so if we got 4GB of swap space, thats 1MB swap pages, worst case
> > > is you have one extent per page, on x86-64 that's 24MB. +kmalloc
> > > overhead, I assume?
> > 
> > Sounds right.
> 
> Ok, 24-50MB per 4GB of swap space is not _that_ bad...

Other way round: 12MB for x86, 24 for x86_64 is the worst case.
Actually, come to think of it, that would be for 8GB of swap space. The
worst case would require every page of swap to be alternately free and
allocated, so for 4GB you'd only have 2GB of swap allocated = 1/2 the
number of extents and half the memory requirements.

> > > And you do linear walks over those extents, leading to O(n^2)
> > > algorithm, no? That has bitten us before...
> > 
> > We start from where we last added an extent on the chain by default.
> 
> ...but linear search through 24MB _is_ going to hurt.

If we did one, yes it would. But this will be O(1) since we start at the
last value, and get_swap_page goes through the space sequentially.

> > You're not going to respond to the other bit of my reply? I was
> > beginning to think you were being more reasonable this time. Oh well.
> 
> Rafael likes your code, and that's a big plus, but do you have to
> insult me?!

Pavel, I never seek to insult you and I'm sorry that you felt insulted
by my comment. In this case, I was expressing frustration at the fact
that you seemed to be (in my opinion anyway) being unreasonable in
completely ignoring and deleting my points about the likelihood of this
worse case scenario, and instead focusing on calculating the
requirements for such a worse case scenario, for a machine with at least
4 times the swapspace that most machines have today. I fully agree with
making things robust and considering worse case scenarios, and making
sure that patches are good and useful, but you seem to treat anything
that comes from me as if it's infected with the plague.

How about if we just call it quits and try to be nice to each other?

Regards,

Nigel


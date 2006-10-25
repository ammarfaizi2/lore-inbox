Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423143AbWJYJKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423143AbWJYJKk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 05:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423145AbWJYJKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 05:10:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14557 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1423143AbWJYJKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 05:10:39 -0400
Date: Wed, 25 Oct 2006 11:10:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
Message-ID: <20061025091022.GB7266@elf.ucw.cz>
References: <1161576857.3466.9.camel@nigel.suspend2.net> <200610242208.34426.rjw@sisk.pl> <20061024213402.GC5662@elf.ucw.cz> <1161728153.22729.22.camel@nigel.suspend2.net> <20061024221950.GB5851@elf.ucw.cz> <1161729027.22729.37.camel@nigel.suspend2.net> <20061025081135.GM5851@elf.ucw.cz> <1161764907.22729.86.camel@nigel.suspend2.net> <20061025084226.GN5851@elf.ucw.cz> <1161766865.22729.96.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161766865.22729.96.camel@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > And now, can you do same computation assuming the swap allocator goes
> > > > completely crazy, and free space is in 1-page chunks?
> > > 
> > > The worst case is 3 * sizeof(unsigned long) *
> > > number_of_swap_extents_allocated bytes.
> > 
> > Okay, so if we got 4GB of swap space, thats 1MB swap pages, worst case
> > is you have one extent per page, on x86-64 that's 24MB. +kmalloc
> > overhead, I assume?
> 
> Sounds right.

Ok, 24-50MB per 4GB of swap space is not _that_ bad...

> > And you do linear walks over those extents, leading to O(n^2)
> > algorithm, no? That has bitten us before...
> 
> We start from where we last added an extent on the chain by default.

...but linear search through 24MB _is_ going to hurt.

> You're not going to respond to the other bit of my reply? I was
> beginning to think you were being more reasonable this time. Oh well.

Rafael likes your code, and that's a big plus, but do you have to
insult me?!
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161238AbWJXVeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161238AbWJXVeO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161240AbWJXVeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:34:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13492 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161237AbWJXVeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:34:10 -0400
Date: Tue, 24 Oct 2006 23:34:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
Message-ID: <20061024213402.GC5662@elf.ucw.cz>
References: <1161576857.3466.9.camel@nigel.suspend2.net> <200610242208.34426.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610242208.34426.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Switch from bitmaps to using extents to record what swap is allocated;
> > they make more efficient use of memory, particularly where the allocated
> > storage is small and the swap space is large.
> 
> As I said before, I like the overall idea, but I have a bunch of
> comments.

Okay, if Rafael likes it... lets take a look.

First... what is the _worst case_ overhead? AFAICT extents are very
good at the best case, but tend to suck for the worst case...?

> > +#include <linux/suspend.h>
> > +#include "extent.h"
> > +
> > +/* suspend_get_extent
> > + *
> > + * Returns a free extent. May fail, returning NULL instead.
> > + */

Your comments are nice, and quite close to linuxdoc... Can we make
them proper linuxdoc?

> > +/* suspend_put_extent_chain.
> > + *
> > + * Frees a whole chain of extents.
> > + */
> > +void suspend_put_extent_chain(struct extent_chain *chain)
> 
> I'd call it suspend_free_all_extents().

This is actually important. As it does undocditional free(), it may
not be called "put".

> > +#ifndef EXTENT_H
> > +#define EXTENT_H
> > +
> > +struct extent {
> > +	unsigned long minimum, maximum;
> 
> Well, I'd use shorter names, but whatever.

Actually, minimum and 
	  maximum look too similar. start/end are really better names.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

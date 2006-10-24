Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161267AbWJXWPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161267AbWJXWPy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161265AbWJXWPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:15:54 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:45477 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161267AbWJXWPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:15:53 -0400
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061024213402.GC5662@elf.ucw.cz>
References: <1161576857.3466.9.camel@nigel.suspend2.net>
	 <200610242208.34426.rjw@sisk.pl>  <20061024213402.GC5662@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 08:15:53 +1000
Message-Id: <1161728153.22729.22.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2006-10-24 at 23:34 +0200, Pavel Machek wrote:
> Hi!
> 
> > > Switch from bitmaps to using extents to record what swap is allocated;
> > > they make more efficient use of memory, particularly where the allocated
> > > storage is small and the swap space is large.
> > 
> > As I said before, I like the overall idea, but I have a bunch of
> > comments.
> 
> Okay, if Rafael likes it... lets take a look.
> 
> First... what is the _worst case_ overhead? AFAICT extents are very
> good at the best case, but tend to suck for the worst case...?

That's right. In using this, we're relying on the fact that the swap
allocator tries to act sensibly. I've only seen worse case performance
when a user had two swap devices with the same priority (striped), but
that was a bug. :)

> > > +#include <linux/suspend.h>
> > > +#include "extent.h"
> > > +
> > > +/* suspend_get_extent
> > > + *
> > > + * Returns a free extent. May fail, returning NULL instead.
> > > + */
> 
> Your comments are nice, and quite close to linuxdoc... Can we make
> them proper linuxdoc?

Ok.

> > > +/* suspend_put_extent_chain.
> > > + *
> > > + * Frees a whole chain of extents.
> > > + */
> > > +void suspend_put_extent_chain(struct extent_chain *chain)
> > 
> > I'd call it suspend_free_all_extents().
> 
> This is actually important. As it does undocditional free(), it may
> not be called "put".

Ok.

> > > +#ifndef EXTENT_H
> > > +#define EXTENT_H
> > > +
> > > +struct extent {
> > > +	unsigned long minimum, maximum;
> > 
> > Well, I'd use shorter names, but whatever.
> 
> Actually, minimum and 
> 	  maximum look too similar. start/end are really better names.

Ok.

Thanks!

Nigel


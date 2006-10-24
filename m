Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422721AbWJXWUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422721AbWJXWUI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbWJXWUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:20:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20697 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422644AbWJXWUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:20:03 -0400
Date: Wed, 25 Oct 2006 00:19:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
Message-ID: <20061024221950.GB5851@elf.ucw.cz>
References: <1161576857.3466.9.camel@nigel.suspend2.net> <200610242208.34426.rjw@sisk.pl> <20061024213402.GC5662@elf.ucw.cz> <1161728153.22729.22.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161728153.22729.22.camel@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Switch from bitmaps to using extents to record what swap is allocated;
> > > > they make more efficient use of memory, particularly where the allocated
> > > > storage is small and the swap space is large.
> > > 
> > > As I said before, I like the overall idea, but I have a bunch of
> > > comments.
> > 
> > Okay, if Rafael likes it... lets take a look.
> > 
> > First... what is the _worst case_ overhead? AFAICT extents are very
> > good at the best case, but tend to suck for the worst case...?
> 
> That's right. In using this, we're relying on the fact that the swap
> allocator tries to act sensibly. I've only seen worse case performance
> when a user had two swap devices with the same priority (striped), but
> that was a bug. :)

Ok, but if the allocator somehow manages to stripe between two swap
devices, what happens?

IIRC original code was something like .1% overhead (8bytes per 4K, or
something?), bitmaps should be even better. If it is 1% in worst case,
that's probably okay, but it would be bad if it had overhead bigger
than 10times original code (worst case).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

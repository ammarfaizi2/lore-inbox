Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423102AbWJYILu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423102AbWJYILu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 04:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423106AbWJYILu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 04:11:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14734 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1423102AbWJYILt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 04:11:49 -0400
Date: Wed, 25 Oct 2006 10:11:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
Message-ID: <20061025081135.GM5851@elf.ucw.cz>
References: <1161576857.3466.9.camel@nigel.suspend2.net> <200610242208.34426.rjw@sisk.pl> <20061024213402.GC5662@elf.ucw.cz> <1161728153.22729.22.camel@nigel.suspend2.net> <20061024221950.GB5851@elf.ucw.cz> <1161729027.22729.37.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161729027.22729.37.camel@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > That's right. In using this, we're relying on the fact that the swap
> > > allocator tries to act sensibly. I've only seen worse case performance
> > > when a user had two swap devices with the same priority (striped), but
> > > that was a bug. :)
> > 
> > Ok, but if the allocator somehow manages to stripe between two swap
> > devices, what happens?
> > 
> > IIRC original code was something like .1% overhead (8bytes per 4K, or
> > something?), bitmaps should be even better. If it is 1% in worst case,
> > that's probably okay, but it would be bad if it had overhead bigger
> > than 10times original code (worst case).
> 
> With the code I have in Suspend2 (which is what I'm working towards),
> the value includes the swap_type, so there's no overlap. Assuming the
> swap allocator does it's normal thing and swap allocated is contiguous,
> you'll probably end up with two extents: one containing the swap
> allocated on the first device, and the other containing the swap
> allocated on the second device. So (with the current version), striping
> would use 6 * sizeof(unsigned long) instead of 3 * sizeof(unsigned
> long).

And now, can you do same computation assuming the swap allocator goes
completely crazy, and free space is in 1-page chunks?

In particular, how much swap space can we have before we run out of
low memory? What is the overhead compared to bitmaps?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

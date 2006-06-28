Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbWF1Wq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbWF1Wq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbWF1Wq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:46:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54726 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751645AbWF1Wqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:46:54 -0400
Date: Thu, 29 Jun 2006 00:44:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Greg KH <greg@kroah.com>, Jens Axboe <axboe@suse.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 0/9] Extents support.
Message-ID: <20060628224428.GC27526@elf.ucw.cz>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271858.21810.nigel@suspend2.net> <20060628211114.GC13397@elf.ucw.cz> <200606290825.50674.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606290825.50674.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > So I don't really see the future of suspend2 because of this...
> > >
> > > But what Rafael and Pavel are doing is really only moving the highest
> > > level of controlling logic to userspace (ok, and maybe compression and
> > > encryption too). Everything important (freezing other processes, atomic
> > > copy and the guts of the I/O) is still done by the kernel.
> >
> > Can you do the same and move compression/encryption to userspace, too?
> >
> > And actually that "highest level" covers >50% of suspend2 code. That
> > would be around 7K lines of code removed from kernel if you did the
> > same, and suspend2 patch would be half the size...
> 
> That's not true. The compression and encryption support add ~1000 lines, as 
> you pointed out the other day. If I moved compression and encryption support 
> to userspace, I'd remove 1000 lines and:
> 
> - add more code for getting the pages copied to and from userspace

No, if your main loop is already in userspace, you do not need to add
any more code. And you'd save way more than 1000 lines:

* encryption/compression can be removed

* but that means that writer plugins/filters can be removed

* if you do compress/encrypt in userspace, you can remove that ugly
netlink thingie, and just display progress in userspace, too

...and then, image writing can be moved to userspace...

* swapfile support

* partition support

* plus their plugin infrastructure.

> > > If we take the problem one step further, and begin to think about
> > > checkpointing, they're in even bigger trouble. I'll freely admit that I'd
> > > have to redesign the way I store data so that random parts of the image
> > > could be replaced, have hooks in mm to be able to learn what pages need
> > > have changed and would also need filesystem support to handle that part
> > > of the problem, but I'd at least be working in the right domain.
> >
> > Could you explain? I do not get the checkpointing remark.
> 
> Sure. Suspending to disk is a pretty similar problem to checkpointing, except 
> that you want to continue running afterwards, keep the image and modify it 
> from time to time based on the changes in memory (having a checkpointing 
> filesystem too, of course). My point is that modifying uswsusp to do 
> checkpointing would be far harder precisely because you've pushed the highest 
> level logic to userspace. It would be far more complicated, if not impossible 
> for you to make the adjustments to do checkpointing.

Aha, that's probably better done with Xen, anyway :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

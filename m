Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWF1Vgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWF1Vgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 17:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWF1Vga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 17:36:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31382 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751311AbWF1Vg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 17:36:29 -0400
Date: Wed, 28 Jun 2006 23:11:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Greg KH <greg@kroah.com>, Jens Axboe <axboe@suse.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 0/9] Extents support.
Message-ID: <20060628211114.GC13397@elf.ucw.cz>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <20060627075906.GK22071@suse.de> <20060627081252.GC7181@kroah.com> <200606271858.21810.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606271858.21810.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Now I haven't followed the suspend2 vs swsusp debate very closely, but
> > > it seems to me that your biggest problem with getting this merged is
> > > getting consensus on where exactly this is going. Nobody wants two
> > > different suspend modules in the kernel. So there are two options -
> > > suspend2 is deemed the way to go, and it gets merged and replaces
> > > swsusp. Or the other way around - people like swsusp more, and you are
> > > doomed to maintain suspend2 outside the tree.
> >
> > Actually, there's a third option that is looking like the way forward,
> > doing all of this from userspace and having no suspend-to-disk in the
> > kernel tree at all.
> >
> > Pavel and others have a working implementation and are slowly moving
> > toward adding all of the "bright and shiny" features that is in suspend2
> > to it (encryption, progress screens, abort by pressing a key, etc.) so
> > that there is no loss of functionality.
> >
> > So I don't really see the future of suspend2 because of this...
> 
> But what Rafael and Pavel are doing is really only moving the highest level of 
> controlling logic to userspace (ok, and maybe compression and encryption 
> too). Everything important (freezing other processes, atomic copy and the 
> guts of the I/O) is still done by the kernel.

Can you do the same and move compression/encryption to userspace, too?

And actually that "highest level" covers >50% of suspend2 code. That
would be around 7K lines of code removed from kernel if you did the
same, and suspend2 patch would be half the size...

> And there _is_ loss of functionality - uswsusp still doesn't support writing a 
> full image of memory, writing to multiple swap devices (partitions or files), 
> or writing to ordinary files. They're getting the low hanging fruit,
> but when 

That's userspace problem. Of course we are after low-hanging fruit,
first, but uswsusp design (AND CURRENT KERNEL PARTS) allow you to get
all the fruit with the right userspace.

> it comes to these parts of the problem, they're going to require either smoke 
> and very good mirrors (eg the swap prefetching trick), or simply refuse to 
> implement them.

:-) I like the mirrors idea. Anyway Rafael *did* get code for saving
whole memory at one point, but it looked quite dangerous to me. It was
~300 lines. I'm sure it can be resurrected.

> If we take the problem one step further, and begin to think about 
> checkpointing, they're in even bigger trouble. I'll freely admit that I'd 
> have to redesign the way I store data so that random parts of the image could 
> be replaced, have hooks in mm to be able to learn what pages need have 
> changed and would also need filesystem support to handle that part of the 
> problem, but I'd at least be working in the right domain.

Could you explain? I do not get the checkpointing remark.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

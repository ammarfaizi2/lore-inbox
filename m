Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbSKTTJl>; Wed, 20 Nov 2002 14:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSKTTJL>; Wed, 20 Nov 2002 14:09:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59319 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262631AbSKTTIJ>;
	Wed, 20 Nov 2002 14:08:09 -0500
Date: Wed, 20 Nov 2002 20:14:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Paul Larson <plars@linuxtestproject.org>
Cc: lkml <linux-kernel@vger.kernel.org>, davej@codemonkey.org.uk,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: writing to sysfs appears to hang
Message-ID: <20021120191451.GF4925@suse.de>
References: <1037401217.11295.145.camel@plars> <20021116004723.GB3153@beaverton.ibm.com> <20021119170205.GC11884@suse.de> <1037813063.24031.32.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037813063.24031.32.camel@plars>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20 2002, Paul Larson wrote:
> On Tue, 2002-11-19 at 11:02, Jens Axboe wrote:
> > This has been in the deadline-rbtree patches for some time (uses writes
> > to sysfs, too).
> > 
> > ===== fs/sysfs/inode.c 1.59 vs edited =====
> > --- 1.59/fs/sysfs/inode.c	Wed Oct 30 21:27:35 2002
> > +++ edited/fs/sysfs/inode.c	Fri Nov  8 14:33:59 2002
> > @@ -243,7 +243,7 @@
> >  	if (kobj && kobj->subsys)
> >  		ops = kobj->subsys->sysfs_ops;
> >  	if (!ops || !ops->store)
> > -		return 0;
> > +		return -EINVAL;
> >  
> >  	page = (char *)__get_free_page(GFP_KERNEL);
> >  	if (!page)
> 
> No effect, the behaviour is still the same for me.

strace the program then, what is happening? What I saw was a program
seeing write() return 0, assuming it didn't write anything, rewrite the
whole thing. Repeat.

I bet this wouldn't happen if just sysfs didn't allow write open of a
file that doesn't have any writeable bits. Smells like another sysfs
bug. Pat?

-- 
Jens Axboe


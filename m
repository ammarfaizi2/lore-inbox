Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSG3XQk>; Tue, 30 Jul 2002 19:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317389AbSG3XQk>; Tue, 30 Jul 2002 19:16:40 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:13062 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317365AbSG3XQj>;
	Tue, 30 Jul 2002 19:16:39 -0400
Date: Tue, 30 Jul 2002 16:18:41 -0700
From: Greg KH <greg@kroah.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
Message-ID: <20020730231841.GA17955@kroah.com>
References: <20020730225359.GA17826@kroah.com> <200207302312.g6UNC7Z10529@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207302312.g6UNC7Z10529@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 02 Jul 2002 22:15:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 05:12:07PM -0600, Richard Gooch wrote:
> Greg KH writes:
> > Hi,
> > 
> > When devfs came alone, it created devfs_[un]register_chrdev and
> > devfs_[un]register_blkdev, which required that all drivers be changed to
> > be compatible with devfs. This change has been bothering a lot of people
> > for quite some time :)
> > 
> > These two small changesets (patches to follow this email) fix that
> > problem by removing these functions, and having the original
> > [un]register_chrdev and [un]register_blkdev ask devfs if the operation
> > should be performed _if_ devfs is currently compiled into the kernel.
> > No functionality is changed, but the kernel code base is reduced, and we
> > are back to a common API.
> 
> Your patch misses the reason why I created those functions: some
> drivers had to always register with the major table. With your
> "fixups", those drivers will break when "devfs=only" is passed in. If
> you first fix the drivers so that they work without an entry in the
> major table, then your patch is safe to apply.

Ah, then this "feature" should be written down somewhere.  Which drivers
does this happen for?  And why penalize _all_ of the kernel drivers for
only the few that need this?

thanks,

greg k-h

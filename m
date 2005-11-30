Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVK3XHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVK3XHZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVK3XHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:07:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:39884 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751241AbVK3XHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:07:25 -0500
Date: Wed, 30 Nov 2005 14:11:53 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Updates to sysfs_create_subdir()
Message-ID: <20051130221153.GA16208@kroah.com>
References: <Pine.LNX.4.50.0511231336261.16769-100000@monsoon.he.net> <20051128204950.GC17740@kroah.com> <Pine.LNX.4.50.0511300759170.28582-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0511300759170.28582-100000@monsoon.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 09:05:41AM -0800, Patrick Mochel wrote:
> 
> On Mon, 28 Nov 2005, Greg KH wrote:
> 
> > On Wed, Nov 23, 2005 at 01:56:29PM -0800, Patrick Mochel wrote:
> > >
> > > The patch below addresses this issue by parsing the subdirectory name and
> > > creating any parent directories delineated by a '/'.
> >
> > Generally I never liked parsing stuff like this in the kernel (proc and
> > devfs both do this).  That being said, I do see the need to make subdirs
> > like this easier.
> 
> Heh, just because proc and devfs did it doesn't mean it's inherently
> evil..

I did not mean to imply that, just that putting parsers like this spread
around the kernel in different places isn't the best thing to have.

> > But what about cleanups?  If I create an attribute group "foo/baz/x/" and
> > then remove it, will the subdirectories get cleaned up too?  What about
> > if I had created a group "foo/baz/y/" after the "x" one?  Or just
> > "foo/baz"?
> 
> The patch I sent previously did not include a way to cleanup the
> subdirectories, but it's pretty straightforward and covered by this patch.
> Basically, it adds a new refcount to struct sysfs_dirent (->s_refs) that
> is incremented when a subdirectory is created and decremented when the
> subdirectory is removed. When it reaches 0, that directory itself can be
> removed.
> 
> Note that it's a bit hacky in sysfs_remove_group(), since we need the
> bottom-most dentry a priori. I'm not sure the best way to do this off the
> top of my head, and ideas?

Don't know, I'd ask Maneesh, as he knows this code quite well.

> If you're interested, I will break it up into 2-3 patches for application
> (I'd like to also move the sysfs_dirent declaration into fs/sysfs/sysfs.h,
> since they're really private and so that further modification of the
> declaration doesn't preclude a nearly-full recompile of the tree).

Thanks, breaking it up into logicial pieces is a good idea so we can see
what is happening easier.

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265665AbUBGBTi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 20:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUBGBTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 20:19:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:52698 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265665AbUBGBTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 20:19:34 -0500
Date: Fri, 6 Feb 2004 17:19:16 -0800
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: James Simmons <jsimmons@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fbdev sysfs support.
Message-ID: <20040207011916.GD4492@kroah.com>
References: <20040207005954.GB4492@kroah.com> <Pine.LNX.4.44.0402070100420.19559-100000@phoenix.infradead.org> <20040207011047.GR21151@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207011047.GR21151@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 01:10:48AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Sat, Feb 07, 2004 at 01:01:35AM +0000, James Simmons wrote:
> > +static void release_fb_info(struct class_device *class_dev)
> > +{
> > +	struct fb_info *info = to_fb_info(class_dev);
> > +
> > +	/* This doesn't harm */
> > +	fb_dealloc_cmap(&info->cmap);
> > +
> > +	kfree(info);
> > +}
> 
> So what has happens when we hit existing kfree() on fb_info while sysfs
> node is busy?

This function will not get called until the sysfs node stops being busy,
so it should all work properly.  But only if that fb_info structure was
allocated dynamically, unlike all of the current fb drivers (see my
other comment about this patch.)

So in that case, this will cause us to try to call kfree on a static
structure :(

thanks,

greg k-h

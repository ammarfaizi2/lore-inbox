Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbULUR2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbULUR2W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 12:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbULUR2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 12:28:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:2970 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261761AbULUR2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 12:28:00 -0500
Date: Tue, 21 Dec 2004 09:24:10 -0800
From: Greg KH <greg@kroah.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Al Hooton <al@hootons.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ioctl assignment strategy?
Message-ID: <20041221172410.GG1459@kroah.com>
References: <1103067067.2826.92.camel@chatsworth.hootons.org> <20041215004620.GA15850@kroah.com> <41C04FFA.6010407@nortelnetworks.com> <20041217234854.GA24506@kroah.com> <41C70DF2.80101@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C70DF2.80101@nortelnetworks.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 11:37:54AM -0600, Chris Friesen wrote:
> Greg KH wrote:
> 
> >Rethink the way you want to control your device.  Seriously, a lot of
> >ioctls can be broken down into single device files, single sysfs files,
> >or other such things (a whole new fs as a last resort too.)
> 
> Actually, my particular case is likely not a good example.  We've got a 
> misc char driver giving access to a lot of miscellaneous features we've 
> added to the kernel,.  We originally (a few years back) used new syscalls, 
> but then we started supporting a bunch more arches, and having to patch all 
> of them just to add syscall numbers sucked.
> 
> Some of it could easily be moved to /proc or /sys, but if you do it that 
> way, how do you handle returning unusual error values?  Other stuff 
> involves multiple stages of registration, then getting handles returned, 
> and doing new calls with those handles.  I don't see how this would tie 
> nicely into the read/write paradigm.

Multiple files?  One per type of action?  Without a full description of
what you are doing I don't really have a good answer.

> What's the big problem with ioctls anyways?  I mean, in a closed 
> environment where I'm writing both the userspace and the kernelspace side 
> of things.

ioctls are basically a simple way to add any kind of syscall to the
kernel.  They also have nasty 32/64 bit issues.  Because we want to have
well-defined syscalls that work on all platforms, and not any arbitrary
type of call, it is good to restrict ioctls.

See the other comments about this topic in the lkml archives.

thanks,

greg k-h

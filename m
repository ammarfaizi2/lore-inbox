Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVCVBA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVCVBA7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVCVAwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:52:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:63456 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262252AbVCVAtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:49:43 -0500
Date: Mon, 21 Mar 2005 16:49:36 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jonsmirl@gmail.com, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: current linus bk, error mounting root
Message-ID: <20050322004935.GB10270@kroah.com>
References: <9e47339105030909031486744f@mail.gmail.com> <20050321154131.30616ed0.akpm@osdl.org> <9e473391050321155735fc506d@mail.gmail.com> <20050321161925.76c37a7f.akpm@osdl.org> <20050322003807.GA10180@kroah.com> <20050321164318.04a5dc82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321164318.04a5dc82.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 04:43:18PM -0800, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > > I don't agree that this is a userspace issue.  It's just not sane for a
> > > driver to be in an unusable state for an arbitrary length of time after
> > > modprobe returns.
> > 
> > It is a userspace issue.  If you have a static /dev there are no
> > problems, right?  If you use udev, you need to wait for the device node
> > to show up, it will not be there right after modprobe returns.
> 
> OK, that's different.
> 
> (grumble, mutter)

Heh, the sound people went through the same grumblings a few months ago
:)

> It would be very convenient, tidy and sane if we _could_ arrange for
> modprobe to block until the device node appears though.  I think devfs can
> do that ;)

devfs _can_ do that, as it waits on the register block device to create
the node.  All udev can do is act apon the call to hotplug as fast as it
can (in the correct order).  The kernel issues the call and then
returns, causing modprobe to return.

The distros that use udev have already all worked out these issues with
their init scripts and such, so it shouldn't be an issue anymore.

Jon, what distro are you using?

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbULPVrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbULPVrP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 16:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbULPVrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 16:47:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:16537 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262034AbULPVqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 16:46:55 -0500
Date: Thu, 16 Dec 2004 13:46:19 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-rc2 start_udev very slow
Message-ID: <20041216214619.GA9827@kroah.com>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <200412162057.25244.andrew@walrond.org> <20041216211137.GA9475@kroah.com> <200412162120.33995.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412162120.33995.andrew@walrond.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 09:20:33PM +0000, Andrew Walrond wrote:
> On Thursday 16 Dec 2004 21:11, Greg KH wrote:
> >
> > Then I don't really know what to recommend.  As the udev startup logic
> > is very tightly tied to how the distro is set up, I recommend using
> > whatever they do, and ignore what I say :)
> 
> They is me; My distro is Rubyx :)

Heh, ok.  Then stick with what you are doing, as long as you rely on
udevstart to create your device nodes, and not try to do it with a bash
script (which is what the original start_udev did), you should be fine.

> > > Is that list of  'extra nodes not exported by sysfs likely to change?'
> >
> > What does that list contain?
> 
> make_extra_nodes () {
>         # there are a few things that sysfs does not export for us.
>         # these things go here (and remember to remove them in
>         # remove_extra_nodes()
>         #
>         # Thanks to Gentoo for the initial list of these.
>         ln -snf /proc/self/fd $udev_root/fd
>         ln -snf /proc/self/fd/0 $udev_root/stdin
>         ln -snf /proc/self/fd/1 $udev_root/stdout
>         ln -snf /proc/self/fd/2 $udev_root/stderr
>         ln -snf /proc/kcore $udev_root/core

Those aren't nodes, they are symlinks.  No way for udev to know about
them :)

>         mkdir $udev_root/pts
>         mkdir $udev_root/shm

Subdirs for mounting file systems on, again, no way udev can know about
them.

So, it looks like udev is really creating every device node you need.

thanks,

greg k-h

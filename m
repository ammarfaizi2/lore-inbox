Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264074AbTIBSWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbTIBSUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:20:51 -0400
Received: from mail.kroah.org ([65.200.24.183]:59589 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263840AbTIBSUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:20:34 -0400
Date: Tue, 2 Sep 2003 11:20:25 -0700
From: Greg KH <greg@kroah.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: devfs to be obsloted by udev?
Message-ID: <20030902182025.GA18397@kroah.com>
References: <3F54A4AC.1020709@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F54A4AC.1020709@wmich.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 10:09:48AM -0400, Ed Sweetman wrote:
> It appears that devfs is to be replaced by the use of udev in the not so 
> distant future.

Possibly.  There are some things that udev can not do that only devfs in
the kernel can do.  For those who need those things, devfs will be
required.

I'm just offering people a choice :)

> I'm not sure how it's supposed to replace a static /dev situaton
> seeing as how it is a userspace daemon.  Is it not supposed to replace
> /dev even when it's completed?

Yes.

Think of a userspace daemon using mknod and rm to manage device nodes
dynamically.

> I dont see the real benefit in having two directories that basically
> give the same info.

What "two directories"?  udev can handle /dev.  What other directory are
you talking about?

> Right now we have something like that with proc and sysfs although not
> everything in proc makes sense to be in sysfs and both are virtual
> fs's where as /dev is a static fs on the disk that takes up space and
> inodes and includes way too many files that a system may not use.

Then delete your /dev and use udev to manage it.

Well, don't do that today, we aren't quite yet there :)

> If udev is to take over the job of devfs, how will modules and drivers
> work that require device files to be present in order to work since
> undoubtedly the udev daemon will have to wait until the kernel is done
> booting before being run.

udev can run out of initramfs which is uncompressed before any busses
are probed.

For more details, please read my OLS 2003 paper about udev.

> I'm just not following how it is going to replace devfs and thus why 
> devfs is being abandoned as mentioned in akpm's patchset. Or as it 
> seems, already has been abandoned.

The devfs code base has been abandoned by its original
author/maintainer.  udev has nothing to do with that.

Hope this helps,

greg k-h
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, Sep 02, 2003 at 10:09:48AM -0400, Ed Sweetman wrote:
> It appears that devfs is to be replaced by the use of udev in the not so 
> distant future.

Possibly.  There are some things that udev can not do that only devfs in
the kernel can do.  For those who need those things, devfs will be
required.

I'm just offering people a choice :)

> I'm not sure how it's supposed to replace a static /dev situaton
> seeing as how it is a userspace daemon.  Is it not supposed to replace
> /dev even when it's completed?

Yes.

Think of a userspace daemon using mknod and rm to manage device nodes
dynamically.

> I dont see the real benefit in having two directories that basically
> give the same info.

What "two directories"?  udev can handle /dev.  What other directory are
you talking about?

> Right now we have something like that with proc and sysfs although not
> everything in proc makes sense to be in sysfs and both are virtual
> fs's where as /dev is a static fs on the disk that takes up space and
> inodes and includes way too many files that a system may not use.

Then delete your /dev and use udev to manage it.

Well, don't do that today, we aren't quite yet there :)

> If udev is to take over the job of devfs, how will modules and drivers
> work that require device files to be present in order to work since
> undoubtedly the udev daemon will have to wait until the kernel is done
> booting before being run.

udev can run out of initramfs which is uncompressed before any busses
are probed.

For more details, please read my OLS 2003 paper about udev.

> I'm just not following how it is going to replace devfs and thus why 
> devfs is being abandoned as mentioned in akpm's patchset. Or as it 
> seems, already has been abandoned.

The devfs code base has been abandoned by its original
author/maintainer.  udev has nothing to do with that.

Hope this helps,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbVCJQBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVCJQBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVCJQBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:01:23 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:22726 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262675AbVCJP7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 10:59:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=m5FqjJXf1knmrPFNxsGuwF6vQX8o8HMYTYr/5XkAZ0qR4AW9IlHI6tPFxRh3TLA8wAEQe5dtoocKM+KqfeZ5zlW2HaOX6a5XVNJrq+OLlbpxJXjMLQpvLrYiogFjwlUdC6Y0lzX4G/zN5bCDW0f3jkyn/NSByyHRKLqHBfkV/v8=
Message-ID: <9e47339105031007595b1e0cc3@mail.gmail.com>
Date: Thu, 10 Mar 2005 10:59:45 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: current linus bk, error mounting root
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050310154830.GB2578@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <422F2F7C.3010605@pobox.com> <422F5D0E.7020004@pobox.com>
	 <9e473391050309125118f2e979@mail.gmail.com>
	 <20050309210926.GZ28855@suse.de>
	 <9e473391050309171643733a12@mail.gmail.com>
	 <20050310075049.GA30243@suse.de>
	 <9e4733910503100658ff440e3@mail.gmail.com>
	 <20050310153151.GY2578@suse.de>
	 <9e473391050310074556aad6b0@mail.gmail.com>
	 <20050310154830.GB2578@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's what it is doing... looks like the first mount is failing

echo Creating root device
mkrootdev /dev/root
umount /sys
echo Mounting root filesystem
mount -o defaults --ro -t ext3 /dev/root /sysroot
mount -t tmpfs --bind /dev /sysroot/dev
echo Switching to new root
switchroot /sysroot
umount /initrd/dev



On Thu, 10 Mar 2005 16:48:31 +0100, Jens Axboe <axboe@suse.de> wrote:
> On Thu, Mar 10 2005, Jon Smirl wrote:
> > On Thu, 10 Mar 2005 16:31:51 +0100, Jens Axboe <axboe@suse.de> wrote:
> > > On Thu, Mar 10 2005, Jon Smirl wrote:
> > > > LABEL=/                 /                       ext3    defaults        1 1
> > > > label / is on /dev/sda6
> > > >
> > > > Creating root device
> > > > Mounting root filesystem
> > > > mount: error 6 mounting ext3
> > >
> > > if 6 is the errno, it looks like it is trying to open a device that does
> > > not exist (ENXIO). Can you up the verbosity of those commands, I'd like
> > > to see what it is doing exactly.
> >
> > Jeff, how can I up the verbosity? This is on Fedora Core 3 but before
> > user space is up. Is there some way to tell the boot ramdisk to
> > display more info?
> 
> Perhaps you can mount the initrd and change the script to echo the
> commands before executing them? Then boot with the modified initrd.
> 
> --
> Jens Axboe
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com

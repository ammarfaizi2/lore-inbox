Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264602AbTLWV7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 16:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbTLWV7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 16:59:35 -0500
Received: from mail.kroah.org ([65.200.24.183]:9447 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264602AbTLWV7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 16:59:19 -0500
Date: Tue, 23 Dec 2003 13:59:10 -0800
From: Greg KH <greg@kroah.com>
To: "Bradley W. Allen" <ULMO@Q.NET>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DevFS vs. udev
Message-ID: <20031223215910.GA15946@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <E1AYl4w-0007A5-R3@O.Q.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AYl4w-0007A5-R3@O.Q.NET>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 03:51:58AM -0800, Bradley W. Allen wrote:
> DevFS was written by an articulate person who solved a lot of
> problems.  udev sounds more like a thug who's smug about winning,
> not explaining himself, saying things like "oh, the other guy
> disappeared, so who cares, you have to use my code, too bad it sucks".

Huh?  I sound like a thug?  I might look like one at times, smell like
one lots of times, but I didn't think I typed like one...

> Just by what the udev people have said I have decided never to use it,
> and to return to DevFS.  Thank god for linux-kernel archives.
> 
> A few points:
> 
> *  User space is slow, causing all sorts of extra work for device
>    accesses.

What do you mean by this.  What is too slow for you?  Have you timed
udev vs. devfs?  Yes, udev-010 now takes a whole second to band-aid over
a race condition in the udev code, but that will be fixed up...

And that's only 1 second from inserting a device into the system.  Is
this a problem with some kind of hardware or real-time devices that you
are using?  Do you have to be able to access the device in the least
possible amount of time?  If so, what's your timing constraints you are
working with?

> *  Another layer of filesystem for udev to have to interact with
>    is also slow, especially if it has to be disk based with all sorts
>    of extra caches, and also if it's with buggy tmpfs code and layers.

What "extra layer of filesystem" are you talking about?  sysfs?  Hey,
sysfs isn't going away at all.  Reading from a ramfs filesystem is
_fast_, no disk accesses at all.

What do you mean by "buggy tmpfs code and layers"?  sysfs uses libfs and
is a ramfs-like filesystem.  It isn't tmpfs.  And if you've found some
bugs, people are interested in finding them.

> *  Most of the interesting devices I have now are character devices,
>    and have multiple potential /dev entries per device.  I've heard
>    that udev can't even handle that requirement!

Where did you hear this?  It isn't true.  I have a multi-port usb serial
device with 16 /dev entries for a single device.  Works just fine.

>    Udev has lots of other problems, like something called an anonymous
>    device, and it not being fully implemented, however, that's OK for
>    development.

What kind of device exactly are you talking about?

>    DevFS has been solid for over half a decade, so it belongs in
>    stable kernels.

5 years stability?  Hm, oh well, please check the lkml archives and the
udev FAQ for the reasons why devfs is broken and can not be fixed.

> *  Many times a broken record comes out with claims.  Here are a few:
>    "... there are still unfixable devfs bugs in the code." without
>    any examples, so I don't believe him (Greg K-H).  Others have looked
>    and not found that.

Heh, see the archives for where these claims were made by Al Viro and
backed up with real examples.

> *  Userspace is not the proper place for kernel device drivers or
>    anything they need to work.

What do you mean by this?  Userspace is where the device node lives, on
a filesystem, that's it.

> *  We do not need the same old maintainer for devfs.  We can create
>    new code, and maintain old code, as a group, ourselves.

Are you volunteering?

> *  Greg K-H (what that dash is for I can't imagine) claims that DevFS
>    is experimental and proof of concept; well, it has been in production
>    use for over half a decade, which in the life of Linux is pretty long.
>    It's certainly not just some experiment any more.

Where did I claim this?  And the '-' is part of my name, if you want you
can spell the whole thing out every time.

> *  Greg K-H refers to "hahahaha" and "the OLS paper" and "sysfs",
>    things that most Linux kernel compilers, linux-kernel readers, and
>    DevFS users (including lots of admins) have probably never ever
>    heard of except the bad attitude of the hahaha part.

Hm, sorry for trying to lend a bit of humor at times.  My 2003 udev
paper is well documented (try googling for it) and is contained in the
udev tarball.  sysfs is also well documented in a linux.conf.au paper by
it's author, Pat Mochel.

> I've spent two hours on this problem, and that's absurd; stable shouldn't
> be doing this sort of thing to us.

What problem is this?  Have you posted with questions on how to set up
udev properly for you?

> Yes, we know there are things that happen during transition from
> development to stable, but to have some terrorist hijack part of the
> kernel and destroy it right at the begin- ing of stable is simply
> criminal thinking.  Luckily, this is just software, so we can do what
> we want with it, but organizationally it is conceptually just as bad.

I welcome you as the new devfs maintainer.  I'm not forcing anyone to
not use devfs, just realize that there are problems with it, and it will
probably go away in the future.

thanks,

greg k-h

/me sighs...

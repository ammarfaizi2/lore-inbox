Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbTLWObJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 09:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265045AbTLWObJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 09:31:09 -0500
Received: from mail.cybertrails.com ([162.42.150.35]:24300 "EHLO
	mail10.cybertrails.com") by vger.kernel.org with ESMTP
	id S264942AbTLWObB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 09:31:01 -0500
Date: Tue, 23 Dec 2003 07:30:52 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: "Bradley W. Allen" <ULMO@q.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DevFS vs. udev
Message-Id: <20031223073052.5fc48b20.dickson@permanentmail.com>
In-Reply-To: <E1AYl4w-0007A5-R3@O.Q.NET>
References: <E1AYl4w-0007A5-R3@O.Q.NET>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003 03:51:58 -0800, Bradley W. Allen wrote:

> DevFS was written by an articulate person who solved a lot of
> problems.  udev sounds more like a thug who's smug about winning,
> not explaining himself, saying things like "oh, the other guy
> disappeared, so who cares, you have to use my code, too bad it sucks".
> 
> Just by what the udev people have said I have decided never to use it,
> and to return to DevFS.  Thank god for linux-kernel archives.

Nice piece of FUD you've written without really understanding what devfs
and udev do.  This devfs vs udev issue has become emotional, and it's
starting to slip into name calling.

Devfs had reached its design limits and the maintainer gave up on it,
mostly because the support was too painful for other kernel developers.
It's still in 2.6, just don't expect fixes for areas that don't (and
can't) work.

I use devfs for my router I threw together, but I fully expect to switch
to udev once all the missing /dev support is added in 2.6.1 or 2.6.2.

Devfs is deprecated.  This means it's still available but you should
consider moving to other options when available.  Obsolete means it
shouldn't be used.  Some 2.6 docs have confused these two terms WRT devfs.


> A few points:
> 
> *  User space is slow, causing all sorts of extra work for device
>    accesses.
> *  Another layer of filesystem for udev to have to interact with
>    is also slow, especially if it has to be disk based with all sorts
>    of extra caches, and also if it's with buggy tmpfs code and layers.

udev is not used for device access.  The /dev devices are no slower than a
static /dev directory or a devfs /dev directory.


> *  Most of the interesting devices I have now are character devices,
>    and have multiple potential /dev entries per device.  I've heard
>    that udev can't even handle that requirement!
>    Udev has lots of other problems, like something called an anonymous
>    device, and it not being fully implemented, however, that's OK for
>    development.  We're in 2.6.0, now, so that's not OK!  DevFS has been
>    solid for over half a decade, so it belongs in stable kernels.

Udev is not a finished or fully functional project in 2.6.0, but neither
is devfs (and, as you mentioned, devfs has had five years).


> *  Many times a broken record comes out with claims.  Here are a few:
>    "... there are still unfixable devfs bugs in the code." without
>    any examples, so I don't believe him (Greg K-H).  Others have looked
>    and not found that.

A large chunk of devfs code was removed during 2.5 development if I recall
correctly.  I believe is was mostly unused so I haven't missed it.

Perhaps you should depend on the hearsay of others.  Either listen to the
kernel developers or figure out the locking code within the kernel
yourself.


> *  Userspace is not the proper place for kernel device drivers or
>    anything they need to work.

Device drivers do not need /dev to function, only userspace needs these. 
Configuring userspace should be done in userspace, IMHO.


> *  We do not need the same old maintainer for devfs.  We can create
>    new code, and maintain old code, as a group, ourselves.

As I mentioned, devfs had reach limits in it's design and to push past
this would require added complexity to other areas of the kernel. 
Complexity that would make maintainability harder.

Designs that don't work are eventually replaced with those that do.


> *  Greg K-H (what that dash is for I can't imagine) claims that DevFS
>    is experimental and proof of concept; well, it has been in production
>    use for over half a decade, which in the life of Linux is pretty long.
>    It's certainly not just some experiment any more.

Careful, you're starting to drop into name calling.

Devfs has problems.  It's being replace during the life of the 2.6 kernel
with something that hopefully won't have as many problems.  This is the
norm for software development.


> *  Greg K-H refers to "hahahaha" and "the OLS paper" and "sysfs",
>    things that most Linux kernel compilers, linux-kernel readers, and
>    DevFS users (including lots of admins) have probably never ever
>    heard of except the bad attitude of the hahaha part.

So udev documentation is a bit scarce.  So don't use it.  Continue to use
devfs or a static /dev until you find documentation good enough for you to
understand or you find some else's example to copy.


> *  Someone named viro said "the latter had stayed, period" refering to
>    udev, which means absolutely nothing, but expected it to mean
>    something.

Reading http://kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ, I take
the part you quote as meaning: the unfixable bugs in devfs, since the
section was about devfs.


> *  Viro also said that devfs had been "shoved" into the tree, and
>    that it "had stayed around for many months".  It's been stable for
>    many *YEARS*, for most of a *DECADE*.
>
> I've spent two hours on this problem, and that's absurd; stable shouldn't
> be doing this sort of thing to us.  Yes, we know there are things that
> happen during transition from development to stable, but to have some
> terrorist hijack part of the kernel and destroy it right at the begin-
> ing of stable is simply criminal thinking.  Luckily, this is just
> software, so we can do what we want with it, but organizationally it
> is conceptually just as bad.

Getting closer and closer to name calling...

If you don't like udev, don't use it.  It's as simple as that for the
moment.  Since 2.6.0 shipped with devfs deprecated, it's conceivable,
although unlikely, that devfs could be removed once a udev-like project is
fully functional.

You did not mention how you're using devfs.  Your comments don't suggest a
lot of experience with it either.

	-Paul Dickson

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbTLWWBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 17:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbTLWWBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 17:01:41 -0500
Received: from peabody.ximian.com ([141.154.95.10]:22758 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S264925AbTLWWBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 17:01:33 -0500
Subject: Re: DEVFS is very good compared to UDEV
From: Rob Love <rml@ximian.com>
To: Jari Soderholm <Jari.Soderholm@edu.stadia.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <sfe8cdc2.027@mail2.edu.stadia.fi>
References: <sfe8cdc2.027@mail2.edu.stadia.fi>
Content-Type: text/plain
Message-Id: <1072216884.6987.52.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 23 Dec 2003 17:01:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-23 at 16:20, Jari Soderholm wrote:

(please use a mailer that wraps lines, in the future)

> I am quite advanced Linux user who has used DEVFS quite
> long time, and have also been a little suprised that it
> has been marked OBSOLETE in 2.6 kernel.

devfs is marked obsolete for more reasons that just the presence of
udev.  Devfs is also buggy, poorly designed, and unmaintained.

> DEVFS is a really simple to use, compile it into kernel and configure
> the programs to use DEVFS filenames and thats it.

udev, in time, we be even easier than this: just install it.  It will
use the historic kernel naming (FHS names) so you need not change your
programs, although a devfs-style naming policy is possible

> I think that it is very good that devicename files are out from the disk,
> one cannot delete those files, disk errors do not affect the, and searching
> device files is faster.

udev can store files on a tmpfs (or any other) mount, if so desired.

> Booting kernel is faster compared to UDEV.

Today, udev is not even involved in booting, so this cannot possible be
true.  If you mean running the udev initscript is slow, perhaps it is:
but eventually that will not be needed.

Also, udev is nascent and still under development.  It has not been
fine-tuned yet.

> And DEVFS has worked for years for me at least very well, I haven't
> had any problems with it.

Lucky you.  It is a mess.

> I do not understand some opinions that DEVFS uses memory.
> Compared to the size of applications people run in linux
> , the memory what kernel with DEVFS takes is practically
> nonexistent.

I never heard this argument, actually, and I agree it is not an
important one.

> UDEV otherwise is very complex for average user and it
> is definetly much slower , it has much greater chance
> for errors because very complicated scrips which seem 
> to need many different gnu commandline utilities.

The user will never have to do with the command line stuff.  And udev
does not involve any complicated scripts.

And, as I said, I do not yet buy the slower argument.

> It is quite funny that when DEVFS creates device files
> automagically and in the ram-memory, some people want
> to go backwards, and use shell scripts to 
> create those files on hard disk, and then it is technically better solution.

udev is not a shell script and, as I said, udev can use _anything_ as
its backing store -- whether that is a directory on your root partition,
an NFS mount, or a tmpfs mount.

> If one you look at the /sysfs-directory there are
> device filenames, (but not the actual devicefiles), so
> it does same thing that DEVFS, but actually much worce
> way, it created devicefilenames in the ram, but
> one cannot use them, because they are not devicefiles.

sysfs is a tree of the kernel's in-memory representation of devices.

We do _not_ want to put the device naming policy in the kernel. 
User-space should handle that.

> Why could you develop it so that UDEV could create those
> actual device files there also, then most linux
> users would not need those horrible scipts anymore.
> All that is then needed link from /sysfs to /dev dir.

This was proposed before, and certainly do-able.  Someone (Linus, I
think?) shot it down.

But this is not a huge step from current udev.  Is it that big a deal
whether the device nodes are created new or symlinked?  It is the same
solution, either way.

> In my option good operating system kernel should use disk and external
> programs little as possible.

In my opinion, good operating system kernels should be wise to correctly
delineate between what should be in user-space and what should be in the
kernel.

	Rob Love



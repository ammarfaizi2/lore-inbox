Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLLCYQ>; Mon, 11 Dec 2000 21:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbQLLCYJ>; Mon, 11 Dec 2000 21:24:09 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:8459 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129345AbQLLCXy>; Mon, 11 Dec 2000 21:23:54 -0500
Date: Mon, 11 Dec 2000 19:53:05 -0600
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: PATCH: linux-2.4.0-test12pre8/include/linux/module.h breaks sysklogd compilation
Message-ID: <20001211195305.B3199@cadcamlab.org>
In-Reply-To: <20001211145901.A8047@baldur.yggdrasil.com> <3A357BC4.AC568471@haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A357BC4.AC568471@haque.net>; from mhaque@haque.net on Mon, Dec 11, 2000 at 08:13:40PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Mohammad A. Haque]
> Wasn't there discussion that user space apps shouldn't include kernel
> headers?

Oh, it's been discussed, many times.  Here is my executive summary of
why nobody needs to use kernel headers in userspace programs, *EVER*:

Q: I want to #include <linux/foo.h> but I get compile errors, please
   apply this patch to foo.h.

A: Make a copy of foo.h, fix it up to compile properly in your
   application and ship it in your tarball.

Q: What if foo.h changes?  My copy will be out of date and my app will
   not work properly on new kernels.

A: This is exactly the same problem as userspace ABI drift.  And it has
   exactly the same solution: make sure userspace interfaces to kernel
   functionality are as stable as possible.  We really *do* try not to
   gratuitously break binaries ... except certain system utilities
   which are low-level enough to justify telling the user to upgrade
   (and that's a short list -- see Documentation/Changes.)

Q: What about new features?  What if foo.h gets some new ioctl
   definitions?  My copy won't have these and my app won't be able to
   use them.

A: So resync with the kernel copy, when the need arises.  Obviously
   your app won't magically be able to just use the new functionality
   without other changes on your part -- resyncing foo.h is just a
   small part of the changes you are already making anyway.

Q: I maintain a subsystem with tightly-coupled userspace and kernel
   components.

A: So maintain *your* header files however you wish, but just ship
   separate copies in your kernel patches and userspace tarballs.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269543AbRGaXaG>; Tue, 31 Jul 2001 19:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269536AbRGaX35>; Tue, 31 Jul 2001 19:29:57 -0400
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:9476 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269537AbRGaX3o>; Tue, 31 Jul 2001 19:29:44 -0400
Date: Tue, 31 Jul 2001 15:54:21 -0600
Message-Id: <200107312154.f6VLsLl00530@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kirk@braille.uwo.ca (Kirk Reiser), linux-kernel@vger.kernel.org
Subject: Re: my patches won't compile under 2.4.7
In-Reply-To: <E15PUnL-0002bA-00@the-village.bc.nu>
In-Reply-To: <x7itgglrmd.fsf@speech.braille.uwo.ca>
	<E15PUnL-0002bA-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox writes:
> > 
> > As of 2.4.7 my patches to the kernel won't compile.  It appears to be
> > something to do with devfs_fs_kernel.h being part of miscdevices.h.  I
> > have sifted through the code but have not been able to determine
> > exactly why they won't work any more.  Here is the error output from
> > my compile:

I don't see why you're pointing the finger devfs_fs_kernel.h. Other
miscdevice drivers compile fine.

> > gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586    -c -o speakup.o speakup.c
> > In file included from /usr/src/linux/include/linux/locks.h:8,
> >                  from /usr/src/linux/include/linux/devfs_fs_kernel.h:6,
> >                  from /usr/src/linux/include/linux/miscdevice.h:4,
> >                  from speakup.c:63:
> > /usr/src/linux/include/linux/pagemap.h:35: `currcons' undeclared here (not in a function)
> > /usr/src/linux/include/linux/pagemap.h:35: parse error before `.'
> > make[4]: *** [speakup.o] Error 1

Looking at my copy of include/linux/pagemap.h I see no instance of
"currcons" on line 35 or elsewhere.

> > I'm not sure even where to start trying to describe what I've looked
> > at and what I don't understand.  It appears that page_cache_alloc() is
> > now an inline function with an argument passed to it, where it used to
> > be a #define with no arguments.  I see that struct misc_device now has
> > a new member devfs_handle but the other drivers I've looked at rtc.c

This is not new. struct misc_device has had a "devfs_handle" field for
a long time. Since 2.3.46, in fact. So when you say above "since
2.4.7", I suspect you mean "after virgin 2.2.x". It would have helped
if you had specified this.

My guess is that your patch has some bad #define somewhere. Again, it
would have helped if you had sent the patch as well.

Anyway, I don't think this problem is even remotely related to devfs.
I suggest you post more complete information to the linux-kernel
mailing list. Then maybe someone there can help you.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

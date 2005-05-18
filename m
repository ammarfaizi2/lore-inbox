Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVERTdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVERTdN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 15:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVERTdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 15:33:13 -0400
Received: from alog0215.analogic.com ([208.224.220.230]:51625 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262299AbVERTc6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 15:32:58 -0400
Date: Wed, 18 May 2005 15:32:32 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Gilbert, John" <JGG@dolby.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Illegal use of reserved word in system.h
In-Reply-To: <2692A548B75777458914AC89297DD7DA08B0866E@bronze.dolby.net>
Message-ID: <Pine.LNX.4.61.0505181501410.19712@chaos.analogic.com>
References: <2692A548B75777458914AC89297DD7DA08B0866E@bronze.dolby.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The subject line is invalid. We don't make law here.
The correct word is invalid, not illegal. There should
not be any "illegal" strings in the kernel either although they
sometimes creep in...

grep of `strings vmlinux`....

IllegalLengthIndication 
Illegal request
<3>%s: Illegal value specified for power
Illegal mode for this track or incompatible medium
<6>tcp_parse_options: Illegal window scaling value %d >14 received.

One can't fix the "illegal request" because it's part of
the (wrong) standard for error number strings.

Now, if you want the names of structure members changed, you
are going to have to submit a patch. You will also have to
patch anything that accesses those member names in user-mode.
Nobody is going to do it for you.

The kernel headers are clean. If you don't like them, then
you can simply clean up your own copy to your own standards.
This is free software any you can't bully anybody into doing
your work for you.

It's also quite presumptuous of you that you think that you
can instruct any of the kernel developers on how to write
header files. In addition, any user-mode code that uses
kernel headers is broken by definition. There is no other
operating system except BSD that gives user mode code
access to kernel-headers. Somehow, people have been able
to write working code using those operating systems without
using kernel headers.

There are people who can instruct you in the proper methods
of interfacing with the kernel. There are even many books
that have been written. I suggest that if you have a driver
that requires access to kernel headers, when being accessed
by user-mode code, the driver is broken. Unix/linux provides
standard methods of interface to drivers. They include
open(), close(), read(), write(), mmap() and ioctl(). In
addition, there are various semaphores and signaling
mechanisms like poll(). If you are accessing devices
or kernel functions in other than these standard interfaces,
your code is broken beyond all repair.

Also kernel headers don't show if the system the SQL code
is running on is SMP aware and Ray was much better behaved.

On Wed, 18 May 2005, Gilbert, John wrote:

> Hello all,
>
> Sorry about the automatic disclaimer at the bottom of these emails, it's
> part of working here at Dolby. I'm sure it doesn't apply to this
> discussion.
>
> I had a few responses to this bug fix request (which I did mail to this
> list), none were what I was hoping for, namely "This will be fixed in
> the next release", so allow me to clarify.
>
> The problem: Linux kernel headers use C++ reserved words as variable
> names. This breaks builds of C++ code that include kernel headers.
>
> Examples: The use of "new" in the macro __cmpxchg in system.h. This hits
> MySQL which links into the kernel headers to determine if the platform
> is SMP aware or not (don't ask me why.)
> 	The use of "virtual" in the structure drm_buf_map in drm.h, used
> by drm_bufs.c. This hits C++ code that uses the DRI interface to lock
> with vertical retrace.
>
> The solution: rename these variables, keep C++ reserved words out of
> headers, make this practice part of the style guide.
>
> I'm not advocating writing parts of the kernel in C++, or cleaning out
> reserved words in the entire kernel. I know the one and only true
> language is C, but for Linux to achieve world domination it needs to be
> inclusive at running (and building) any software in whatever language.
>
> As to the comments stating that "Userspace code shouldn't include kernel
> headers", that's fine in the "Hello, World", but in the real world,
> applications need access to devices and system resources, which means
> communicating with the kernel with the proper ioctls, flags, system
> configuration, data structures, etc., which are kept in kernel headers.
> For this reason, breaking these apart from the application build
> environment is a really bad idea, no mater what Linus Torvalds has to
> say about it (see
> http://uwsg.iu.edu/hypermail/linux/kernel/0007.3/0587.html). It needs to
> be an fully integrated system for everything to run correctly.
>
> Besides, I don't have time to rewrite MySQL in C to make it "correct".
> I've got more important things to do. ;^)
>
> So please, keep your headers clean.
>
> John Gilbert
> jgg@dolby.com
>
> Ignore the sig.
> ###############
>
> -----------------------------------------
> This message (including any attachments) may contain confidential
> information intended for a specific individual and purpose.  If you are not
> the intended recipient, delete this message.  If you are not the intended
> recipient, disclosing, copying, distributing, or taking any action based on
> this message is strictly prohibited.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
.


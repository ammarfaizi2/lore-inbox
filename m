Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132609AbRDELxd>; Thu, 5 Apr 2001 07:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132767AbRDELxX>; Thu, 5 Apr 2001 07:53:23 -0400
Received: from [166.70.28.69] ([166.70.28.69]:1870 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S132609AbRDELxD>;
	Thu, 5 Apr 2001 07:53:03 -0400
To: "Miller, Brendan" <Brendan.Miller@Dialogic.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Proper way to release binary-only driver?
In-Reply-To: <EFC879D09684D211B9C20060972035B1D46A39@exchange2ca.sv.dialogic.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Apr 2001 05:50:55 -0600
In-Reply-To: "Miller, Brendan"'s message of "Thu, 5 Apr 2001 06:58:34 -0400"
Message-ID: <m1g0fnwoo0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Miller, Brendan" <Brendan.Miller@Dialogic.com> writes:

> I have the need to distribute a binary-only driver (no flames, please), but
> I am not certain how to build it so that it can be used on multiple kernel
> versions.  (Or is this impossible?)

It's possible but frowned on.  As a general rule any problem that occurs
in a system with a binary only driver, you will be called for support.  Because
there is no easy way for the normal kernel developers to rule out your
code is not doing something nasty.

> I didn't find any "HOWTO (or recommendation) for proper binary-only driver
> release etiquette", so if there are some preferred means, please let me
> know.
> 
> I specifically had issues with the whole MODVERSIONS thing.  I can include
> <linux/verion.h> and <linux/config.h> to get the right CONFIG_MODVERSIONS
> macro definitions, and then include <linux/modversions.h> as appropriate.
> The end result is a driver with symbols whose names are mangled to match the
> modversion-enabled mangling of a modversion-enabled kernel.  This is good if
> I release on the same kernel version.
> 
> Obviously, if I use a different kernel the module refuses to load.  My first
> guess was to get rid of the module-versioning stuff so that the symbols are
> not mangled, and this seems to work, except that I must use insmod -f module
> for kernels with a different version than what I built with.

MODVERSIONS doesn't mangle the structures/functions it includes a
checksum.  If the checksum is the same you are guaranteed the
interface is the same, otherwise something has changed.  So
MODVERSIONS is what you want if you want to go between kernels.

>  So, if there are guides that I didn't find, or ones on this list that
> someone things I should use, please let me know.  Or at least comment on my
> chosen way of doing things.  It's this sort of thing that reinforces a
> source form driver is the way to release stuff--then it can be built
> alongside the user's kernel tree...

The general recommendation (I have heard) is to include a bit of
source that provides a kernel abstraction layer that will stay the
same between kernels that your binary only driver can use, and to let
users compile that with different kernels.

But yes.  The source form driver is the recommended way to release
kernel code.   And I would highly encourage you to figure out how to
do a source release, under the GPL so your driver can be included in
the mainstream kernel. Without that your device will be at best only
semi supported under linux.

Binary only drivers also happen to have another big deficiency that
you haven't mentioned.  They don't have a prayer of working on
multiple cpu architectures.  And with x86-64 and ia64 just around the
corner this is likely to be a practical issue for a lot of people.

If what you are after is a way to release a driver that is not a
hassle to add to an already working system, you will find a more
receptive ear.  I have heard some talk, that it would be a good idea
to figure out how to standardize how to compile a kernel driver
outside the kernel tree, so it could be trivial enough that anyone
could do it.  To date there are enough people around who don't have
problems compiling their own kernel that this hasn't become a major
issue.

Eric

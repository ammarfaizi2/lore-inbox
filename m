Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSG3VjP>; Tue, 30 Jul 2002 17:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSG3VjO>; Tue, 30 Jul 2002 17:39:14 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:30927 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S316673AbSG3VjN>; Tue, 30 Jul 2002 17:39:13 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
Date: Wed, 31 Jul 2002 07:38:00 +1000
User-Agent: KMail/1.4.5
Cc: Vojtech Pavlik <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>,
       <linuxconsole-dev@lists.sourceforge.net>
References: <Pine.LNX.4.33.0207301417190.2051-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0207301417190.2051-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207310738.00566.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2002 07:20, Linus Torvalds wrote:
> On Tue, 30 Jul 2002, Greg KH wrote:
> > On Tue, Jul 30, 2002 at 03:23:42PM +0200, Vojtech Pavlik wrote:
> > > -#include <asm/types.h>
> > > +#include <stdint.h>
> >
> > Why?  I thought we were not including any glibc (or any other libc)
> > header files when building the kernel?
>
> Indeed. This is unacceptable.
Its a minor thinko - <linux/types.h> is the right definition.

> Especially as the standard types are total crap, and the u8 etc are a lot
> more readable. People should realize:
>
>  - the "int" is superfluous. Of _course_ it's an integer. If it was a
>    floating point number, it would be fp16/fp32/fp64/fp80/whatever.
>  - the "_t" is there only for namespace collisions, sane people can chose
>    to ignore it.
Sure, it is a convention that only a committee could love.
But it is at least widely understood by userspace programmers.

> What do you have left after you have removed the crap? Yup. u8, u16, etc.
Fine for internal to the kernel. Absolutely. Required knowledge to play
with the kernel.

> And if you want to share with user space, there's the long-accepted
> namespace collision avoidance of prepending two underscores.
This is where we disagree. __u8 requires the (userspace) programmer
to go off, find out that __u8 is really some wierd Linux-ism that he
can safely map to uint8_t, to use with the rest of the *standard* library
routines.

> Fix it, Vojtech.
Please don't be hasty.

This isn't about the kernel representation. It is about making ABIs as
easy as possible for userspace programmers to use. If there is an
ugly but standard way, and an almost-as-ugly and non-standard way,
I don't think that the standard way is too much to ask.

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.

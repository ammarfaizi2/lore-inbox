Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266256AbSKWAVc>; Fri, 22 Nov 2002 19:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266285AbSKWAVb>; Fri, 22 Nov 2002 19:21:31 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:30905 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266256AbSKWAV3>;
	Fri, 22 Nov 2002 19:21:29 -0500
Date: Sat, 23 Nov 2002 11:28:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, anton@samba.org, davem@redhat.com, ak@muc.de
Subject: Re: [PATCH] Beginnings of conpat 32 code cleanups
Message-Id: <20021123112814.0d315c56.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0211221141070.1440-100000@penguin.transmeta.com>
References: <20021122162312.32ff4bd3.sfr@canb.auug.org.au>
	<Pine.LNX.4.44.0211221141070.1440-100000@penguin.transmeta.com>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI Linus,

On Fri, 22 Nov 2002 11:47:27 -0800 (PST) Linus Torvalds <torvalds@transmeta.com> wrote:
>
> On Fri, 22 Nov 2002, Stephen Rothwell wrote:
> > 
> > This patch merely adds include/asm-generic/compat32.h which is the header
> > information that is common to all the 32 bit compatibility code across all
> > the architectures (except parisc as I don't pretend to understand that
> > :-)).
> 
> What kind of strange _crap_ is this?

Thanks for abusing me in public - its just what I needed after having my
attempts at reducing the mess in the arch dependent code ignored for so
long!

> 
> 	+typedef unsigned int           __kernel_size_t32;
> 	+typedef int                    __kernel_ssize_t32;
> 	+typedef int                    __kernel_time_t32;
> 	+typedef int                    __kernel_clock_t32;
> 	+typedef int                    __kernel_pid_t32;
> 	+typedef unsigned int           __kernel_ino_t32;
> 	+typedef int                    __kernel_daddr_t32;
> 	+typedef int                    __kernel_off_t32;
> 	+typedef unsigned int           __kernel_caddr_t32;
> 	+typedef long                   __kernel_loff_t32;

If you had bothered to look, you would have noticed that these are taken
straight from the compatibility code that already exists in all the 64
bit architectures that have 32 bit compatibility layers.  I am into doing
incremental changes that people can see easily are not harmful and then
doing better cleanups later.

> You're doing a compat layer, and then you're using various undefined types 
> that can be random sizes, and calling them xxx_t32.

I am copying what is already there, I am not inventing anything new, just tidying up the crap that has already been written.

> For christ sake, somebody is on drugs here.

Well if anyone, then aim at those who copied each other when creating
the code in the first place.

> If they are called "xxx_t32", then that means that you _know_ the size 
> already statically, and you should use "u32" or "s32" which are shorter 
> and clearer anyway. You should sure as hell not use some random C type 
> that can be different depending on compiler options etc, and then calling 
> it a "compat" library.

The _t32 refers to the fact that they are for the 32 bit compatibility layer
not that they are 32 bit types (you knew that didn't you?).

> Quite frankly, I don't see the point of this AT ALL. You're introducing 
> new types that cannot be sanely used directly anyway. What's the point?

I am not introducing anything, I am tidying up.  As I said the medium
term goal is to consolidate as much of the code as possible to stop people
from copying bugs and/or not having to fix them in every architecture
as we do now.

> Make your compat stuff use u32/s32/u64 directly, instead of making up ugly 
> new types that make no sense.

Once more I AM NOT MAKING ANYTHING UP.  I am consolidating existing
practise.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135395AbRDRWCU>; Wed, 18 Apr 2001 18:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135397AbRDRWCJ>; Wed, 18 Apr 2001 18:02:09 -0400
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:6665 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S135395AbRDRWB6>; Wed, 18 Apr 2001 18:01:58 -0400
Date: Wed, 18 Apr 2001 18:02:57 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: i386 cleanups
Message-ID: <20010418180257.A17877@munchkin.spectacle-pond.org>
In-Reply-To: <20010417232614.A4377@bug.ucw.cz> <Pine.LNX.4.31.0104171443060.1029-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104171443060.1029-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Apr 17, 2001 at 02:46:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 02:46:09PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 17 Apr 2001, Pavel Machek wrote:
> >
> > These are tiny cleanups you might like. sizes are "logically"
> > long.
> 
> No. Sizes are not "logical". They are whatever you decide they are, ie
> it's purely a complier convention.

Not purely a compiler convention, but an ABI requirement.  In particular, Linux
GCC adheres to the ABI specified in the System V UNIX Intel386 (tm) Processor
Supplement, and on page 6-66, in figure 6-70, the specification for stddef.h
says that:

	typedef int ptrdiff_t;
	typedef unsigned int size_t;
	typedef long wchar_t;

> At least earlier, size_t was defined as "unsigned int" in user mode, and
> doing anything else would make gcc complain about clashes with its
> compiled-in __builtin_size_t that it uses for the builtin prototypes (ie
> if you had a declaration for "void *memcpy(void *dest, const void *src,
> size_t n);" and your size_t didn't match the gcc builtin_size_t, you'd get
> a "redefined with different arguments" warning or something).

While, I grant that this is one area the ABI could have been improved upon
(alignment of floating point, and reservation of EBX as GOT pointers are other
sore spots), it is the ABI of record.  Yes, we could certainly choose a
different ABI for Linux, but it is probably too late for that in the case of
the x86.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482

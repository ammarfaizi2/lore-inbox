Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbULEAIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbULEAIL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 19:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbULEAIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 19:08:11 -0500
Received: from inx.pm.waw.pl ([195.116.170.20]:14277 "EHLO inx.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261206AbULEAH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 19:07:57 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	<1101828924.26071.172.camel@hades.cambridge.redhat.com>
	<Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org>
	<1101832116.26071.236.camel@hades.cambridge.redhat.com>
	<Pine.LNX.4.58.0411300846190.22796@ppc970.osdl.org>
	<1101837135.26071.380.camel@hades.cambridge.redhat.com>
	<Pine.LNX.4.58.0411301020160.22796@ppc970.osdl.org>
	<20041130224851.GH8040@waste.org>
	<Pine.LNX.4.58.0411301452180.22796@ppc970.osdl.org>
	<20041130232958.GW2460@waste.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 03 Dec 2004 02:03:29 +0100
In-Reply-To: <20041130232958.GW2460@waste.org> (Matt Mackall's message of
 "Tue, 30 Nov 2004 15:29:58 -0800")
Message-ID: <m3zn0wdwgu.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> It's my opinion that it will eventually be deemed beneficial to
> separate out everything that has a legitimate reason to be used by
> userspace.

That's quite obvious and the whole thread is all about just that.

> But I'm not suggesting getting there in one go,

As this is impossible, given du -s /usr/src/linux/include/*.

> what I'm
> suggesting is how to get there incrementally. To rehash:
>
> 1. create include/user and friends
> 2. when we run across a troublesome ABI definition:
>      create include/user/foo.h and move the definition there
>      make sure include/linux/foo.h includes it
>      userspace and kernel compile as before
>      send a patch

What _is_ a "troublesome ABI definition" and who would qualify it
as such?

> 3. repeat step 2 as often as useful

Who would do that?

> 4. add new user ABI always to include/user/

Who would watch that? How do you differentiate between a user API/ABI
and an internal kernel API, if you don't know the code in question
at all?

> 5. if at some point we find that all of userspace builds from
>    include/user/ without reference to include/linux/,

How can we find that? Compiling the Fedora Code 7 would not be enough.

> 7. drop any superfluous include/linux -> include/user includes (there
>    shouldn't be many)

Why not? Kernel "private" headers can and must include ABI headers
as the private .c files do.


This won't work. include/user won't work either. There can't be any
"transition periods" nor "instant switchovers".

I can see only one way to solve the problem - gradually, without
"transition periods" etc.

1. We leave existing include/linux and include/asm (and possibly
   asm-generic etc) in place.
2. A new directory(ies) such as include/kernel (internal kernel headers)
   is created.
3. Code authors, who (I hope) know their code move the things they
   know are kernel-internal to the new directory(ies).
4. Userspace is explicitly forbidden to include anything in the new
   directory. We can even use some #ifndef __KERNEL__ #error user
   breakage as a tip.

In a year or two we can probably begin hunting remnants of the
internals in include/linux and include/asm.

We can now consider anything in include/{linux,asm} which prevents
userspace compilation etc. a bug. But bugs must be fixed by people
who know how to fix them correctly.
-- 
Krzysztof Halasa

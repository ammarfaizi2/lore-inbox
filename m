Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSHYJx4>; Sun, 25 Aug 2002 05:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSHYJx4>; Sun, 25 Aug 2002 05:53:56 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:9361 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316659AbSHYJxz>;
	Sun, 25 Aug 2002 05:53:55 -0400
Date: Sun, 25 Aug 2002 19:57:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Consolidate include/asm/fcntl.h into include/linux/fcntl.h
Message-Id: <20020825195745.63ba6fb4.sfr@canb.auug.org.au>
In-Reply-To: <20020824213549.H29958@parcelfarce.linux.theplanet.co.uk>
References: <20020824213549.H29958@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On Sat, 24 Aug 2002 21:35:49 +0100 Matthew Wilcox <willy@debian.org> wrote:
>
> I think this is a bad idea -- when doing a new port, it's easier to fill
> in the bits with the current scheme rather than with your proposed scheme.

The point about nay new port is that it is likely to be exactly the same as
one of the current ports as far as these defines and structures are
concerned.  WIth the current scheme, you get exactly what happened with
PPC and PPC64 - i.e. they are identical with most of the other ports except
for a couple of defines which are only different because of an error.
There is no existing ABI that would be an excuse for them to be different.

With the new scheme, asm/fcntl.h consists of only the necessary
differences from the "norm" as defined by linux/fcntl.h.

Unjustified differences between the ports are a bad thing.  For one,
it make the library maintainers job much harder ...

The longer term intent of my consolidation efforts is to lessen the
problems of all the port maintainers trying to keep up with each other
when bugs are fixed in (more or less generic) code in one port (usually
i386 ...).  There are several bugs like this currently and I suspect
many that have not been discovered yet.

> There is one part which I like:
> 
> -/* for old implementation of bsd flock () */
> -#define F_EXLCK		4	/* or 3 */
> -#define F_SHLCK		8	/* or 4 */
> 
> All of these can go, nobody's been using them since kernel 2.0.  I took
> out the last vestiges of them from locks.c earlier in 2.5.  None of the
> BSDs have them either.

Wonderful, I will update my patch to remove them completely.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

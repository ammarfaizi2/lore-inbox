Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314339AbSESMQq>; Sun, 19 May 2002 08:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314351AbSESMQp>; Sun, 19 May 2002 08:16:45 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:43815 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S314339AbSESMQo>; Sun, 19 May 2002 08:16:44 -0400
Date: Sun, 19 May 2002 14:15:30 +0200 (CEST)
From: Rui Sousa <rui.sousa@laposte.net>
X-X-Sender: rsousa@localhost.localdomain
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
        <kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
In-Reply-To: <E179P70-0003dg-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0205191405120.18395-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 May 2002, Alan Cox wrote:

> Looking at 2.4.1x which has the same signal code
> 
> > arch/i386/kernel/signal.c:37:		return __copy_to_user(to, from, sizeof(siginfo_t));
> 
> not a bug
> > arch/sparc/kernel/signal.c:101:		return __copy_to_user(to, from, sizeof(siginfo_t));
> 
> Not a bug
> 
> > arch/alpha/kernel/signal.c:44:		return __copy_to_user(to, from, sizeof(siginfo_t));
> 
> Not a bug
> 

Hi,

Halfway this thread I got I bit confused...

copy_to/from_user() --> will return the number of bytes that were _not_ 
copied. If one does not care about partially successes just use:

if (copy_to/from_user())
	return -EFAULT;

__copy_to/from_user() --> the same as above, but can they actually return 
anything other than 0? My assembler is no good and I'm not able to see if
the macros __constant_copy_user(), __copy_user(), __constant_copy_user_zeroing(),
modify the size argument.

Rui Sousa


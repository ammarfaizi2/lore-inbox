Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276535AbRJGSQb>; Sun, 7 Oct 2001 14:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276558AbRJGSQV>; Sun, 7 Oct 2001 14:16:21 -0400
Received: from nsd.netnomics.com ([216.71.84.35]:44890 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S276535AbRJGSQG>; Sun, 7 Oct 2001 14:16:06 -0400
Date: Sun, 7 Oct 2001 13:16:19 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.11-pre4 remove spurious kernel recompiles
In-Reply-To: <20011007200522.E726@athlon.random>
Message-ID: <Pine.LNX.3.96.1011007131234.26881H-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Oct 2001, Andrea Arcangeli wrote:

> On Sun, Oct 07, 2001 at 08:25:42PM +1000, Keith Owens wrote:
> > in the top level Makefile forces a recompile of the entire kernel, for
> > no good reason.
> 
> this is a matter of taste but personally I believe that at least
> theorically recompiling the whole kernel if I add -g to CFLAGS, or if I
> change the EXTRAVERSION have lots of sense.

Correct.  I am amazed Keith missed this...  changing data in Makefile
can certainly affect the entire kernel compile, so it makes sense to
recompile the entire kernel when it changes.

If we want to change this, one must isolate the specific changes which
cause the entire kernel (or just init/main.c) to be recompiled, and
put those in a separate file.


> OTOH at the moment I
> wouldn't trust the buildsystem anyways, so I'd run a `make distclean`
> anyways in those cases :).

ditto :)  my kbuild script looks basically like:

make distclean && cp <kconfig dir>/rum .config && make oldconfig &&
make oldconfig && make -j3 dep && make -j3 && make modules && make boot

	Jeff




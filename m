Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276684AbRJHAHE>; Sun, 7 Oct 2001 20:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276716AbRJHAGy>; Sun, 7 Oct 2001 20:06:54 -0400
Received: from [195.223.140.107] ([195.223.140.107]:1016 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S276684AbRJHAGh>;
	Sun, 7 Oct 2001 20:06:37 -0400
Date: Mon, 8 Oct 2001 02:05:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.11-pre4 remove spurious kernel recompiles
Message-ID: <20011008020544.K726@athlon.random>
In-Reply-To: <Pine.LNX.3.96.1011007131234.26881H-100000@mandrakesoft.mandrakesoft.com> <27710.1002497346@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27710.1002497346@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Mon, Oct 08, 2001 at 09:29:06AM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 09:29:06AM +1000, Keith Owens wrote:
> On Sun, 7 Oct 2001 13:16:19 -0500 (CDT), 
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> >On Sun, 7 Oct 2001, Andrea Arcangeli wrote:
> >
> >> On Sun, Oct 07, 2001 at 08:25:42PM +1000, Keith Owens wrote:
> >> > in the top level Makefile forces a recompile of the entire kernel, for
> >> > no good reason.
> >> 
> >> this is a matter of taste but personally I believe that at least
> >> theorically recompiling the whole kernel if I add -g to CFLAGS, or if I
> >> change the EXTRAVERSION have lots of sense.
> >
> >Correct.  I am amazed Keith missed this...  changing data in Makefile
> >can certainly affect the entire kernel compile, so it makes sense to
> >recompile the entire kernel when it changes.
> 
> I did not miss it.  Changing cflags is detected by the
> .<object>.o.flags files.
> 
> ifeq (-D__KERNEL__ -I/build/kaos/2.4.11-pre4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586,$(strip $(subst $(comma),:,$(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_vt.o))))
> FILES_FLAGS_UP_TO_DATE += vt.o
> endif

Ok, so the point of all those .flags is to catch per-object cflags changes.

> kbuild already detects changes to flags, down to the level of
> per-object flags, there is no need to detect changes to the top level
> Makefile.  Especially when you can override flags and other fields on
> the make command line, that does not change Makefile but kbuild still
> detects the changes.

CFLAGS was only an example, think if I change CC or EXTRAVERSION, but, as
said in the earlier email, I doubt an EXTRAVERSION change would work
without a full distclean in between anyways.

Andrea

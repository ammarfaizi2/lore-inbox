Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129392AbQK1RNL>; Tue, 28 Nov 2000 12:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130119AbQK1RNB>; Tue, 28 Nov 2000 12:13:01 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:36105 "EHLO
        munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
        id <S130105AbQK1RMv>; Tue, 28 Nov 2000 12:12:51 -0500
Date: Tue, 28 Nov 2000 11:44:12 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andreas Schwab <schwab@suse.de>, Alexander Viro <viro@math.psu.edu>,
        kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001128114412.A18695@munchkin.spectacle-pond.org>
In-Reply-To: <Pine.GSO.4.21.0011272234550.7352-100000@weyl.math.psu.edu> <200011280955.eAS9t6I22393@hawking.suse.de> <20001128161612.B14675@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001128161612.B14675@athlon.random>; from andrea@suse.de on Tue, Nov 28, 2000 at 04:16:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 04:16:12PM +0100, Andrea Arcangeli wrote:
> On Tue, Nov 28, 2000 at 10:55:06AM +0100, Andreas Schwab wrote:
> > Alexander Viro <viro@math.psu.edu> writes:
> > 
> > |> On Tue, 28 Nov 2000, Andrea Arcangeli wrote:
> > |> 
> > |> > On Tue, Nov 28, 2000 at 12:10:33PM +0900, kumon@flab.fujitsu.co.jp wrote:
> > |> > > If you have two files:
> > |> > > test1.c:
> > |> > > int a,b,c;
> > |> > > 
> > |> > > test2.c:
> > |> > > int a,c;
> > |> > > 
> > |> > > Which is _stronger_?
> > |> > 
> > |> > Those won't link together as they aren't declared static.
> > |> 
> > |> Try it. They _will_ link together.
> > 
> > Not if you compile with -fno-common, which should actually be the default
> > some day, IMHO.
> 
> I thought -fno-common was the default behaviour indeed, and I agree it should
> become the default since current behaviour can lead to sublte bugs. (better I
> discovered this gcc "extension" this way than after some day of debugging :)
> 
> I'm all for gcc extensions when they're powerful and useful, but this
> one looks absolutely worthless. I don't see any advantage from the current
> behaviour (avoid an "extern" in some include file that we have/want to write
> anyways to write correct C code?), and at least in large project (like the
> kernel) where different part of the project are handled by different people
> using -fno-common is pretty much mandatory IMHO.

Umm, the original Ritchie C compiler on the PDP-11 and the Johnson 'Portable' C
compiler both had this extension, as well as every other C compiler under UNIX
(tm) I've ever used or read the documentation for.  It is also mentioned in the
standards as a common extension (I wrote the initial draft for this section in
the C89 standard).  When asked why the disconnect between what K&R said
(ref/def model) and what their compilers actually did (common model), the AT&T
representative at the time said that the ref/def model was put into K&R when
they tried to make a C compiler for their IBM mainframes, using the standard
linker, and discovered that linker would page align each common variable (CSECT
in IBM terminology IIRC).  The IBM linker is also the reason why the K&R and
the C89 standard had the rule that global names must be unique to 6 characters,
one case (which is another extension that just about everybody has and depends
on).

The default for C++ is -fno-common.

-- 
Michael Meissner, Red Hat, Inc.
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

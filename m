Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319087AbSIDHCZ>; Wed, 4 Sep 2002 03:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319088AbSIDHCY>; Wed, 4 Sep 2002 03:02:24 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41610 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S319087AbSIDHCX>;
	Wed, 4 Sep 2002 03:02:23 -0400
Date: Wed, 4 Sep 2002 03:06:53 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Xavier Bestel <xavier.bestel@free.fr>,
       Anton Altaparmakov <aia21@cantab.net>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <200209032344.g83NiEc29471@oboe.it.uc3m.es>
Message-ID: <Pine.GSO.4.21.0209040258480.7852-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Sep 2002, Peter T. Breuer wrote:

> "A month of sundays ago Xavier Bestel wrote:"
> [Charset ISO-8859-15 unsupported, filtering to ASCII...]
> > Le mer 04/09/2002 _ 00:42, Peter T. Breuer a _crit :
> > 
> > > Let's maintain a single bit in the superblock that says whether  any
> > > directory structure or whatever else we're worried about has been
> > > altered (ecch, well, it has to be a timestamp, never mind ..). Before
> > > every read we check this "bit" ondisk. If it's not set, we happily dive
> > > for our data where we expect to find it. Otherwise we go through the
> > > rigmarole you describe.
> > 
> > Won't work. You would need an atomic read-and-write operation for that
> 
> I'm proposing (elsewhere) that I be allowed to generate special block-layer
> requests from VFS, which act as "tags" to impose order on other requests
> at the shared disk resource. But ...

Get.  Real.

VFS has no sodding idea of notion of blocks, let alone ordering needed for
a particular filesystem.

As soon as you are starting to talk about "superblocks" (on-disk ones, that
is) - you can forget about generic layers.

As far as I'm concerned, the feature in question is fairly pointless for
the things it can be used for and hopeless for the things you want to
get.  Ergo, it's vetoed.

There is more to coherency and preserving fs structure than "don't cache
<something>".  And issues involved here clearly belong to filesystem -
generic code simply has not enough information _and_ the nature of the
solution deeply depends on fs in question.  IOW, your grand idea is
hopeless.  End of discussion.


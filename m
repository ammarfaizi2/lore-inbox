Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129514AbQKWDNS>; Wed, 22 Nov 2000 22:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132334AbQKWDNI>; Wed, 22 Nov 2000 22:13:08 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:29191 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S129514AbQKWDM6>; Wed, 22 Nov 2000 22:12:58 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14876.33838.105932.172701@wire.cadcamlab.org>
Date: Wed, 22 Nov 2000 20:42:54 -0600 (CST)
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-2.4.0-test11 crashed again; this time i send you the Oops-message
In-Reply-To: <20001122190747.K2918@wire.cadcamlab.org>
        <200011230158.eAN1wSr138515@saturn.cs.uml.edu>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Albert D. Cahalan]
> The infamous LINK_FIRST infrastructure was sort of half-way done.

I disagree: it could handle all cases I could see that we might
reasonably care about.  I challenge anyone to come up with a
non-pathological case that could not be taken care of with a single
LINK_FIRST and/or a single LINK_LAST.

The worst I can think of is something like "all PCI drivers must come
before all ISA drivers" which would require listing all of one set or
the other.  But when you see a case like that, it often means "this
directory really needs to be split", because you have two different
classes of things in a single directory.

> It would be best to cause drivers with an unspecified link order
> to move around a bit, so that errors may be discovered more quickly.

That was the plan -- in 2.5.  (The 2.4 version did not disturb any
order at all, unless you explicitly put a LINK_FIRST declaration in the
individual makefile.)  Now that LINK_FIRST is officially dead, none of
this will probably happen at all.

> LINK_FIRST is pretty coarse. One would want a topological sort, or at
> least LINK_0 through LINK_9 _without_ anything else.

Too complex, no easy upgrade path (read: too different from status
quo), very little benefit over LINK_FIRST + LINK_LAST.  For the
topological sort in particular I'm interestested in how it's even
possible to do in a non-intrusive and maintainable way.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

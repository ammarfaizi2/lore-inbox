Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317400AbSG1XWB>; Sun, 28 Jul 2002 19:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317401AbSG1XWB>; Sun, 28 Jul 2002 19:22:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3078 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317400AbSG1XWA>; Sun, 28 Jul 2002 19:22:00 -0400
Date: Sun, 28 Jul 2002 16:26:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Anton Altaparmakov <aia21@cantab.net>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@zip.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of   PAGE_{CACHE_,}{MASK,ALIGN}
In-Reply-To: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jul 2002, Anton Altaparmakov wrote:
>
> Why should I need to bother with index/offset? It is much more natural to
> work with bytes.

Two major reasons:
 - the page cache works with index/offset, and that should be your first
   priority, since the page cache is all that matters from a performance
   standpoint.
 - gcc is known to be broken with 64-bit stuff on 32-bit platforms, and
   minimizing the use of "long long" minimizes the risk of hitting bugs.

> Also the page cache limit of 32-bit index is IMO not good and needs to be
> removed.

Dream on. It's good, and it's not getting removed. The "struct page" is
size-critical, and also correctness-critical (see above on gcc issues).

We're not moving to a 64-bit index for the next few years. We're a lot
more likely to make PAGE_SIZE bigger, and generally praying that AMD's
x86-64 succeeds in the market, forcing Intel to make Yamhill their
standard platform. At which point we _could_ make things truly 64 bits
(the size pressure on "struct page" is largely due to HIGHMEM, and gcc
does fine on 64-bit platforms).

But that's certainly years away.

			Linus


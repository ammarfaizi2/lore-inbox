Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285472AbRL2UnO>; Sat, 29 Dec 2001 15:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285449AbRL2UnE>; Sat, 29 Dec 2001 15:43:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48902 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285453AbRL2Ums>; Sat, 29 Dec 2001 15:42:48 -0500
Date: Sat, 29 Dec 2001 12:40:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Alexander Viro <viro@math.psu.edu>,
        Bernhard Rosenkraenzer <bero@redhat.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exporting seq_* stuff
In-Reply-To: <3C2E2875.8E2EF36D@zip.com.au>
Message-ID: <Pine.LNX.4.33.0112291237370.30790-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Dec 2001, Andrew Morton wrote:
>
> Personally, I prefer to see the EXPORT_SYMBOL() near the
> definition of the thing being exported.  For functions, the
> convention I like is:

I'd rather have them in the same source-file, but not spread around in the
file. It's nice to see _what_ a file exports, without having to grep for
them.

HOWEVER, putting them in many different source-files makes compilation
slower, so I personally avoid that unless one source-file is clearly
important enough to do so. For core functionality where we clearly export
the functions to the rest of the kernel through a header file anyway, we
might as well keep the EXPORT_SYMBOL's central, and speed up kernel
builds that way.

> I'd propose that we drop the concept of EXPORT_OBJ by making all
> files eligible for exporting symbols, and that the janitors be given
> a mandate to scrap the ksyms files.
>
> Is this acceptable?

No. Check the speed of "make dep" with every single file exporting
objects. Not pretty.

		Linus


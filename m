Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316797AbSFDVhV>; Tue, 4 Jun 2002 17:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316828AbSFDVhU>; Tue, 4 Jun 2002 17:37:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17672 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316797AbSFDVhU>; Tue, 4 Jun 2002 17:37:20 -0400
Date: Tue, 4 Jun 2002 14:37:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink
In-Reply-To: <3CFD25A2.FCC7F66A@zip.com.au>
Message-ID: <Pine.LNX.4.44.0206041428080.983-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Jun 2002, Andrew Morton wrote:
>
> There's a patch at
> http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre10/ext3-reloc-page.patch
> which provides a simple `relocate page' ioctl for ext3 files.

That's a good start, but before even egtting that far there is some need
for a way to get a picture of the FS layout in a reasonably fs-independent
way.

Sure, bmap() actually does part of this (the "where are my blocks" part),
but right now there is no way to query the FS for the "where can I put
blocks" part.

You can do it with direct disk access and knowledge of the FS internals,
but it should not be all that hard to add some simple interface to get a
"block usage byte array" kind of thing (more efficient than doing bmap on
all files, _and_ can tell about blocks reserved for inodes, superblocks
and other special uses), which together with a user-level interface to
"preallocate" and your "relocate page" should actually make it possible to
make a fairly FS-independent defragmenter.

Add a nice graphical front-end, and you can make it a useful screen-saver.

			Linus


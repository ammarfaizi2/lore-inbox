Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315408AbSELWxj>; Sun, 12 May 2002 18:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315426AbSELWxi>; Sun, 12 May 2002 18:53:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:29919 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315408AbSELWxh>;
	Sun, 12 May 2002 18:53:37 -0400
Date: Sun, 12 May 2002 18:53:36 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Elladan <elladan@eskimo.com>, Jakob ?stergaard <jakob@unthought.net>,
        Kasper Dupont <kasperd@daimi.au.dk>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
In-Reply-To: <15582.59104.448855.21882@wombat.chubb.wattle.id.au>
Message-ID: <Pine.GSO.4.21.0205121848080.27629-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 May 2002, Peter Chubb wrote:

> This is why in SVr4, struct cred is cloned at open time, and passed
> down to each VFS operation.

That doesn't work for shared mappings over holes.  Unfortunately.
Yes, credentials cache a-la 4.4BSD would help in many cases, but
we have no reasonably credentials when kswapd writes a dirty page
on disk.  It _can_ cause allocations.  And many processes might've
touched that page until it finally got written out - which credentials
would you use?


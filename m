Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131571AbQLVCZK>; Thu, 21 Dec 2000 21:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131731AbQLVCZA>; Thu, 21 Dec 2000 21:25:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:11007 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131571AbQLVCYy>;
	Thu, 21 Dec 2000 21:24:54 -0500
Date: Thu, 21 Dec 2000 20:54:09 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <86820000.977441131@coffee>
Message-ID: <Pine.GSO.4.21.0012212048210.5877-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Dec 2000, Chris Mason wrote:

> Obvious bug, block_write_full_page zeros out the bits past the end of 
> file every time.  This should not be needed for normal file writes.

Unfortunately, it _is_ needed for pageout path. mmap() the last page
of file. Dirty the data past the EOF (MMU will not catch that access).
Let the pageout send the page to disk. You don't want to have the data
past EOF end up on the backstore.

Al, slowly getting back to life and sanity. Fsck the flu...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287353AbRL3HSd>; Sun, 30 Dec 2001 02:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287352AbRL3HSX>; Sun, 30 Dec 2001 02:18:23 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:63872 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287353AbRL3HSD>;
	Sun, 30 Dec 2001 02:18:03 -0500
Date: Sun, 30 Dec 2001 02:17:56 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        torrey.hoffman@myrio.com, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd
 kern   el panic woes
In-Reply-To: <3C2EB656.10B5FF26@zip.com.au>
Message-ID: <Pine.GSO.4.21.0112300153520.8523-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Dec 2001, Andrew Morton wrote:

> > Breakage related to failing allocation is indeed not new, but
> > that's a long story.  And no, "allocate on mmap()" is not a fix.
> 
> Yup.  But what *is* the fix?  (filemap_nopage?)

For ->writepage() - nothing.  It _is_ asynchronous and it _can_ fail.
Due to failing allocations, IO errors, whatever.

Now, the fs consistency stuff is a different story.  Fixes had been
in -ac since before 2.4.0 and I distinctly remember at least one of
3 area getting synced with -linus.  My fault - I assumed that the
whole patch went there at that point.  I'll try to dig the rest out.

2.4.9-ac* is probably a good starting point - they are in generic_file_write()
and in __block_write_full_page()


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbRLaAIb>; Sun, 30 Dec 2001 19:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285747AbRLaAIV>; Sun, 30 Dec 2001 19:08:21 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15430 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285720AbRLaAIJ>; Sun, 30 Dec 2001 19:08:09 -0500
Date: Mon, 31 Dec 2001 01:08:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, torrey.hoffman@myrio.com,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd kern el panic woes
Message-ID: <20011231010817.L1356@athlon.random>
In-Reply-To: <3C2EB208.B2BA7CBF@zip.com.au> <Pine.GSO.4.21.0112300129060.8523-100000@weyl.math.psu.edu> <3C2EB656.10B5FF26@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C2EB656.10B5FF26@zip.com.au>; from akpm@zip.com.au on Sat, Dec 29, 2001 at 10:38:14PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 10:38:14PM -0800, Andrew Morton wrote:
> Alexander Viro wrote:
> > 
> > On Sat, 29 Dec 2001, Andrew Morton wrote:
> > 
> > > Would it be necessary to preallocate the holes at mmap() time?  Mad
> > > hand-waving: Could we not perform the instantiation at pagefault time,
> > > and give the caller SIGBUS if we cannot allocate the blocks?  Or if
> > > there's an IO error, or quota exceeded.
> > 
> > Allocation at mmap() Is Not Going To Happen.  Consider it vetoed.
> > There are applications that use mmap() on large and very sparse
> > files.
> 
> I think Andrea was referring to simply reserving the necessary
> amount of disk space, rather than actually instantiating the
> blocks.  But even that would be a big problem for the applications

correct.

> which you describe.

Nod.

> 
> > > Question: can someone please define BH_New?  Its lifecycle seems
> > > very vague.  We never actually seem to *clear* it anywhere for
> > > ext2, and it appears that the kernel will keep on treating a
> > > clearly non-new buffer as "new" all the time.  ext3 explicitly
> > > clears BH_New in get_block(), if it finds the block was already
> > > present in the file.  I did this because we need the newness
> > > info for internal purposes.
> > 
> > It should be reset when we submit IO.
> 
> well...  It isn't.  And I'd like a chance to review/test any

see the other email, it's all right as far I can tell, it doesn't need
to be resetted ever. only mapped bh are bh_new so you will never care
about bh_new any longer because you will never need any further
get_block on the same bh.


> proposed changes in this area which are outside specific filesystems...
> 
> > Breakage related to failing allocation is indeed not new, but
> > that's a long story.  And no, "allocate on mmap()" is not a fix.
> 
> Yup.  But what *is* the fix?  (filemap_nopage?)
> 
> -


Andrea

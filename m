Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314981AbSENBgz>; Mon, 13 May 2002 21:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314984AbSENBgy>; Mon, 13 May 2002 21:36:54 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:32729 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314981AbSENBgx>; Mon, 13 May 2002 21:36:53 -0400
Date: Tue, 14 May 2002 02:36:50 +0100 (BST)
From: Anton Altaparmakov <aia21@cantab.net>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, axboe@suse.de, akpm@zip.com.au,
        martin@dalecki.de, neilb@cse.unsw.edu.au
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <15584.23204.925373.44968@wombat.chubb.wattle.id.au>
Message-ID: <Pine.SOL.3.96.1020514023250.22385B-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, Peter Chubb wrote:
> >>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:
> 
> Christoph> On Mon, May 13, 2002 at 08:28:30PM +1000, Peter Chubb
> Christoph> wrote:
> >> There's now a patch available against 2.5.15, and the BK repository
> >> has been updated to v2.5.15 as well:
> >> 
> >> http://www.gelato.unsw.edu.au/patches/2.5.15-largefile-patch
> >> bk://gelato.unsw.edu.au:2023/
> 
> Christoph> This looks really good, I'd like to see something like that
> Christoph> merged soon!  Some comments:
[snip]
> Christoph>  - why is the get_block block argument
> Christoph> a sector_t?  It presents a logical filesystem block which
> Christoph> usually is larger than the sector, not to mention that for
> Christoph> the usual blocksize == PAGE_SIZE case a ulong is enough as
> Christoph> that is the same size the pagecache limit triggers.
> 
> For filesystems that *can* handle logical filesystem blocks beyond the
> 2^32 limit (i.e., that use >32bit offsets in their on-disc format),
> the get_block() argument has to be > 32bits long.  At  the moment
> that's only JFS and XFS, but reiserfs version 4 looks as if it might
> go that way.  We'll need this especially when the pagecache limit is
> gone.

NTFS uses signed 64 bits for all offsets on disk, too. And yes at the
moment the pagecache limit is also a problem which we just ignore in the
hope that the kernel will have gone to 64 bits by the time devices grow
that large as to start using > 32 bits of blocks/pages...

> Besides, blocksize is not usually pagesize.  ext[23] uses 1k or 4k
> blocks depending on the size and expected use of the filesystem; alpha
> pagesize is usually 8k, for example.  The arm uses 4k, 16k or 32k
> pagesizes depending on the model.
> 
> So on 32-bit systems, ulong is not enough.  (in fact if you look at
> jfs, the first thing jfs_get_block does is convert the block number
> arg to a 64-bit number).

NTFS does that, too, but not quite immediately... (-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/


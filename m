Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135611AbREFAjA>; Sat, 5 May 2001 20:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135613AbREFAiv>; Sat, 5 May 2001 20:38:51 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:40308 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135611AbREFAig>; Sat, 5 May 2001 20:38:36 -0400
Date: Sun, 6 May 2001 02:37:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Jens Axboe <axboe@suse.de>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010506023723.A22850@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0105031017460.30346-100000@penguin.transmeta.com> <200105041140.NAA03391@cave.bitwizard.nl> <20010504135614.S16507@suse.de> <20010504172940.U3762@athlon.random> <20010505151808.A29451@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010505151808.A29451@metastasis.f00f.org>; from cw@f00f.org on Sat, May 05, 2001 at 03:18:08PM +1200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 03:18:08PM +1200, Chris Wedgwood wrote:
> On Fri, May 04, 2001 at 05:29:40PM +0200, Andrea Arcangeli wrote:
> 
>     once block_dev is in pagecache there will obviously be no-way to
>     share cache between the block device and the filesystem, because
>     all the caches will be in completly different address spaces.
> 
> Once we are at this point... will there be any use in having block
> devices? FreeBSD appears to have done without them completely about a

moving block_dev in pagecache won't change anything from userspace point
of view, it's a transparent change (if we ignore the total loss of
cache coherency between block_dev and fs metadata that it implies, but
as Linus said such loss of coherency will happen anyways eventually
because metadata will go into its address space too). Basically there
will still be a use for the block devices as far as there are fsck and
other userspace applications that want to use it.

Andrea SYNAPSE (very amusing movie ;)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136249AbREDL6O>; Fri, 4 May 2001 07:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136297AbREDL6E>; Fri, 4 May 2001 07:58:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20229 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136249AbREDL5u>;
	Fri, 4 May 2001 07:57:50 -0400
Date: Fri, 4 May 2001 13:56:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010504135614.S16507@suse.de>
In-Reply-To: <Pine.LNX.4.21.0105031017460.30346-100000@penguin.transmeta.com> <200105041140.NAA03391@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200105041140.NAA03391@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Fri, May 04, 2001 at 01:40:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04 2001, Rogier Wolff wrote:
> > On Thu, 3 May 2001, Alan Cox wrote:
> > > Ditto for some CD based stuff. You burn the important binaries to the front
> > > of the CD, then at boot dd 64Mb to /dev/null to prime the libraries and
> > > avoid a lot of seeking during boot up from the CD-ROM.
> > > 
> > > However I could do that from an initrd before mounting
> > 
> > Ehh. Doing that would be extremely stupid, and would slow down your boot
> > and nothing more.
> 
> Ehhh, Linus, Linearly reading my harddisk goes at 26Mb per second. By
> analyzing my boot process I determine that 50M of my disk is used
> during boot. I can then reshuffle my disk to have that 50M of data at
> the beginning and reading all that into 50M of cache, I can save
> thousands of 10ms seeks. Boot time would go from several tens of
> seconds to 2 seconds worth of DISK IO plus several seconds of pure CPU
> time.

Provided that the buffer cache and page cache are coherent, which they
are not. So at most you'll cache fs meta data by doing the dd trick,
which is hardly worth the effort.

Or you can rewrite block_read/write to use the page cache, in which case
you'd have more luck doing the above.

-- 
Jens Axboe

